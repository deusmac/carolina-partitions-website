/**
 * Carolina Partitions website leads -> Google Sheet + email to Jack.
 * Standalone script tied to the leads sheet by ID.
 * Deploy > New deployment > Web app (Execute as: Me, Who has access: Anyone).
 */
const SHEET_ID = '11oe1XEzhJe5hY6DxnhYVedub2LSoAk3xviybsnaSuTc';  // Carolina Partitions Website Leads
const SHEET_NAME = 'Leads';
const NOTIFY = 'jmorgan@carolina-partitions.com';   // add more, comma separated
const HEADERS = ['Received', 'Name', 'I am a', 'Email', 'Phone', 'Preferred contact', 'Project details', 'Status', 'Plans link', 'Attachments'];
const FOLDER_NAME = 'Carolina Partitions Website Leads - Attachments';   // private Drive folder, created on first upload
const MAX_FILES = 4;
const MAX_BYTES = 15 * 1024 * 1024;   // 15 MB total per request
const MAIL_ATTACH_MAX = 20 * 1024 * 1024;   // above this, the email gets links only
const MIME = { pdf: 'application/pdf', jpg: 'image/jpeg', jpeg: 'image/jpeg', png: 'image/png',
  dwg: 'application/acad', zip: 'application/zip',
  xlsx: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
  docx: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' };
const ROLES = ['General Contractor', 'Owner / Developer', 'Architect / Designer', 'Other business'];
const CONTACTS = ['Email', 'Phone call', 'Text message'];

function doPost(e) {
  const p = (e && e.parameter) || {};
  if (p._gotcha) return json_({ ok: true });              // honeypot: silently drop bots

  const name = clean_(p.name, 120);
  const email = clean_(p.email, 200);
  const phone = clean_(p.phone, 40);
  const project = clean_(p.project, 4000);
  const role = ROLES.indexOf(p.i_am_a) >= 0 ? p.i_am_a : 'Other business';
  const contact = CONTACTS.indexOf(p.preferred_contact) >= 0 ? p.preferred_contact : 'Email';
  const plansLink = /^https:\/\/[^\s"'<>]{4,490}$/.test(String(p.plans_link || '').trim()) ? String(p.plans_link).trim() : '';

  if (!name || !project || !/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(email)) {
    return json_({ ok: false, error: 'missing or invalid fields' });
  }

  const files = saveFiles_(p, name);

  const lock = LockService.getScriptLock();
  lock.waitLock(10000);
  try {
    sheet_().appendRow([new Date(), name, role, email, phone, contact, project, 'New', plansLink,
      files.links.join('\n')]);
  } finally {
    lock.releaseLock();
  }

  MailApp.sendEmail({
    to: NOTIFY,
    replyTo: email,
    subject: 'New website quote request: ' + name,
    body: [
      'New quote request from carolina-partitions.com',
      '',
      'Name: ' + name,
      'I am a: ' + role,
      'Email: ' + email,
      'Phone: ' + (phone || 'not given'),
      'Preferred contact: ' + contact,
      '',
      'Project details:',
      project,
      '',
      'Plans link: ' + (plansLink || 'none'),
      'Attachments: ' + (files.links.length ? '\n' + files.links.join('\n') : 'none'),
      files.skipped.length ? 'Not saved (wrong type or over the size limit): ' + files.skipped.join(', ') : '',
      '',
      'All leads: ' + ss_().getUrl()
    ].join('\n'),
    attachments: files.bytes <= MAIL_ATTACH_MAX ? files.blobs : []
  });

  return json_({ ok: true });
}

// Run once from the editor (select "setup", click Run) to create the header row.
function setup() { sheet_(); }

// Files arrive as base64 fields file1_name/file1_data ... file4_*. Type is decided by the
// file extension (whitelist), never by what the browser claims. Saved privately to Drive.
function saveFiles_(p, leadName) {
  const out = { links: [], blobs: [], skipped: [], bytes: 0 };
  let folder = null;
  for (let i = 1; i <= MAX_FILES; i++) {
    const rawName = String(p['file' + i + '_name'] || '');
    const data = String(p['file' + i + '_data'] || '');
    if (!rawName || !data) continue;
    const safe = rawName.replace(/[^\w.\- ]/g, '_').slice(-120);
    const ext = (safe.split('.').pop() || '').toLowerCase();
    if (!MIME[ext]) { out.skipped.push(safe); continue; }
    let bytes;
    try { bytes = Utilities.base64Decode(data); } catch (err) { out.skipped.push(safe); continue; }
    if (out.bytes + bytes.length > MAX_BYTES) { out.skipped.push(safe); continue; }
    out.bytes += bytes.length;
    const blob = Utilities.newBlob(bytes, MIME[ext], safe);
    if (!folder) {
      const it = DriveApp.getFoldersByName(FOLDER_NAME);
      const root = it.hasNext() ? it.next() : DriveApp.createFolder(FOLDER_NAME);
      folder = root.createFolder(Utilities.formatDate(new Date(), 'America/New_York', 'yyyy-MM-dd HHmm') + ' ' + leadName.replace(/[^\w\- ]/g, '').slice(0, 60));
    }
    out.links.push(folder.createFile(blob).getUrl());
    out.blobs.push(blob);
  }
  return out;
}

function ss_() { return SpreadsheetApp.openById(SHEET_ID); }

function sheet_() {
  const ss = ss_();
  let sh = ss.getSheetByName(SHEET_NAME);
  if (!sh) { sh = ss.getSheets()[0]; sh.setName(SHEET_NAME); }
  // Header row is rewritten every time, so new columns appear without touching existing leads.
  sh.getRange(1, 1, 1, HEADERS.length).setValues([HEADERS])
    .setFontWeight('bold').setBackground('#0A1F4A').setFontColor('#FFFFFF');
  sh.setFrozenRows(1);
  sh.setColumnWidth(7, 420);
  return sh;
}

// Trim, cap length, and stop spreadsheet formula injection (=, +, -, @ at the start).
function clean_(v, max) {
  let s = String(v || '').trim().slice(0, max);
  if (/^[=+\-@]/.test(s)) s = "'" + s;
  return s;
}

function json_(obj) {
  return ContentService.createTextOutput(JSON.stringify(obj)).setMimeType(ContentService.MimeType.JSON);
}
