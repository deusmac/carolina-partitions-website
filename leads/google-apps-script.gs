/**
 * Carolina Partitions website leads -> Google Sheet + email to Jack.
 * Paste this whole file into the sheet's Extensions > Apps Script editor,
 * then Deploy > New deployment > Web app (Execute as: Me, Who has access: Anyone).
 */
const SHEET_NAME = 'Leads';
const NOTIFY = 'jmorgan@carolina-partitions.com';   // add more, comma separated
const HEADERS = ['Received', 'Name', 'I am a', 'Email', 'Phone', 'Preferred contact', 'Project details', 'Status'];
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

  if (!name || !project || !/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(email)) {
    return json_({ ok: false, error: 'missing or invalid fields' });
  }

  const lock = LockService.getScriptLock();
  lock.waitLock(10000);
  try {
    sheet_().appendRow([new Date(), name, role, email, phone, contact, project, 'New']);
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
      'All leads: ' + SpreadsheetApp.getActiveSpreadsheet().getUrl()
    ].join('\n')
  });

  return json_({ ok: true });
}

// Run once from the editor (select "setup", click Run) to create the header row.
function setup() { sheet_(); }

function sheet_() {
  const ss = SpreadsheetApp.getActiveSpreadsheet();
  let sh = ss.getSheetByName(SHEET_NAME);
  if (!sh) sh = ss.insertSheet(SHEET_NAME);
  if (sh.getLastRow() === 0) {
    sh.appendRow(HEADERS);
    sh.getRange(1, 1, 1, HEADERS.length).setFontWeight('bold').setBackground('#0A1F4A').setFontColor('#FFFFFF');
    sh.setFrozenRows(1);
    sh.setColumnWidth(7, 420);
  }
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
