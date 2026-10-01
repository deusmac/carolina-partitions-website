# Carolina Partitions website leads: one-time setup.
# Run it on your PC:  right-click this file > Run with PowerShell
#   (or: powershell -ExecutionPolicy Bypass -File setup-leads.ps1)
# What it does:
#   1. installs Google's Apps Script tool (clasp) if needed
#   2. has you sign in to Google once (browser opens, click Allow)
#   3. creates the leads script in your Google account and publishes it as a web app
#   4. opens the web app once so you can click Allow (this also sets up the sheet columns)
#   5. sends ONE test quote request with a small PDF (Jack gets one email marked TEST)
#   6. prints the new web app address and copies it to your clipboard: paste it to Claude
$ErrorActionPreference = 'Stop'
function Step($t) { Write-Host ""; Write-Host "== $t" -ForegroundColor Cyan }

Step "Checking Node.js"
if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
  Write-Host "Node.js is not installed. Installing it now (needs winget, built into Windows 10/11)..."
  winget install -e --id OpenJS.NodeJS.LTS --accept-source-agreements --accept-package-agreements
  Write-Host "Node.js installed. CLOSE this window and run the script again." -ForegroundColor Yellow
  Read-Host "Press Enter to close"; exit
}
$clasp = 'npx -y @google/clasp@2.4.2'

Step "Turn on the Apps Script API (one switch)"
Write-Host "A browser tab will open. If it says you do not have access, click 'Sign in with a different account' and pick johnc.tiempo@gmail.com (your work Google account has Apps Script turned off). Then set 'Google Apps Script API' to ON and come back here."
Start-Process "https://script.google.com/home/usersettings?authuser=johnc.tiempo@gmail.com"
Read-Host "Press Enter when the switch is ON"

Step "Sign in to Google (johnc.tiempo@gmail.com)"
Write-Host "A browser tab will open. Pick johnc.tiempo@gmail.com and click Allow."
cmd /c "$clasp login"

$dir = Join-Path $env:TEMP ("cp-leads-" + (Get-Date -Format 'yyyyMMddHHmmss'))
New-Item -ItemType Directory -Path $dir | Out-Null
Set-Location $dir

Step "Creating the leads script in your Google account"
cmd /c "$clasp create --type standalone --title ""Carolina Partitions Website Leads"""
if (-not (Test-Path (Join-Path $dir '.clasp.json'))) { throw "clasp create failed. Make sure the Apps Script API switch is ON, then run again." }

$code = @'
/**
 * Carolina Partitions website leads -> Google Sheet + email to Jack (with attachments).
 * Standalone script tied to the leads sheet by ID. Installed by leads/setup-leads.ps1
 * (or by hand: Deploy > New deployment > Web app, Execute as: Me, Who has access: Anyone).
 * Needs only Sheets + send-mail permission. Attachments go to Jack's email, not Drive.
 */
const SHEET_ID = '11oe1XEzhJe5hY6DxnhYVedub2LSoAk3xviybsnaSuTc';  // Carolina Partitions Website Leads
const SHEET_NAME = 'Leads';
const NOTIFY = 'jmorgan@carolina-partitions.com';   // add more, comma separated
const HEADERS = ['Received', 'Name', 'I am a', 'Email', 'Phone', 'Preferred contact', 'Project details', 'Status', 'Plans link', 'Attachments'];
const MAX_FILES = 4;
const MAX_BYTES = 15 * 1024 * 1024;   // 15 MB total per request
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

  const files = saveFiles_(p);

  const lock = LockService.getScriptLock();
  lock.waitLock(10000);
  try {
    sheet_().appendRow([new Date(), name, role, email, phone, contact, project, 'New', plansLink,
      files.names.length ? files.names.join('\n') + '\n(attached to the email to Jack)' : '']);
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
      'Attachments: ' + (files.names.length ? files.names.join(', ') + ' (attached)' : 'none'),
      files.skipped.length ? 'Not saved (wrong type or over the size limit): ' + files.skipped.join(', ') : '',
      '',
      'All leads: ' + ss_().getUrl()
    ].join('\n'),
    attachments: files.blobs
  });

  return json_({ ok: true });
}

// Run once (from the editor, or by opening the web app URL as the owner) to set the header row.
function setup() { sheet_(); }

// Opening the web app URL in a browser as the owner authorizes the script and runs setup.
function doGet() {
  setup();
  return HtmlService.createHtmlOutput('<p style="font:16px sans-serif">Carolina Partitions leads: setup done. You can close this tab.</p>');
}

// Files arrive as base64 fields file1_name/file1_data ... file4_*. Type is decided by the
// file extension (whitelist), never by what the browser claims. They are attached to the
// email to Jack; the sheet records the file names.
function saveFiles_(p) {
  const out = { names: [], blobs: [], skipped: [], bytes: 0 };
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
    out.names.push(safe);
    out.blobs.push(Utilities.newBlob(bytes, MIME[ext], safe));
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
'@
$manifest = @'
{
  "timeZone": "America/New_York",
  "exceptionLogging": "STACKDRIVER",
  "runtimeVersion": "V8",
  "webapp": { "executeAs": "USER_DEPLOYING", "access": "ANYONE_ANONYMOUS" },
  "oauthScopes": [
    "https://www.googleapis.com/auth/spreadsheets",
    "https://www.googleapis.com/auth/script.send_mail"
  ]
}
'@
Get-ChildItem $dir -Filter *.js | Remove-Item
Get-ChildItem $dir -Filter *.gs | Remove-Item
[IO.File]::WriteAllText((Join-Path $dir 'Code.js'), $code)
[IO.File]::WriteAllText((Join-Path $dir 'appsscript.json'), $manifest)

Step "Uploading the code and publishing the web app"
cmd /c "$clasp push -f"
$out = (cmd /c "$clasp deploy --description ""Website leads"" 2>&1") -join "`n"
Write-Host $out
$m = [regex]::Match($out, 'AKfyc[\w-]+')
if (-not $m.Success) { throw "Could not read the deployment ID from clasp. Copy everything above and send it to Claude." }
$url = "https://script.google.com/macros/s/$($m.Value)/exec"

Step "Approve the web app (one time)"
Write-Host "A browser tab will open. Click Review permissions, pick johnc.tiempo@gmail.com,"
Write-Host "Advanced, 'Go to Carolina Partitions Website Leads (unsafe)', Allow."
Write-Host "You should then see: 'Carolina Partitions leads: setup done.'"
Start-Process ($url + "?authuser=johnc.tiempo@gmail.com")
Read-Host "Press Enter after you see 'setup done'"

Step "Sending one test quote request (with a small PDF)"
$pdf = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("%PDF-1.4`n% Carolina Partitions setup test file`n"))
$body = @{
  name = 'TEST from setup script, delete me'; i_am_a = 'General Contractor'
  email = 'johnc.tiempo@gmail.com'; phone = ''; preferred_contact = 'Email'
  project = 'Automatic setup test. Safe to delete this row.'
  plans_link = 'https://example.com/test-plans'
  file1_name = 'setup-test.pdf'; file1_data = $pdf
}
try {
  $r = Invoke-RestMethod -Uri $url -Method Post -Body $body
  Write-Host "Response: $($r | ConvertTo-Json -Compress)"
} catch { Write-Host "Test request returned: $($_.Exception.Message)" -ForegroundColor Yellow }

Set-Clipboard -Value $url
$url | Out-File -FilePath (Join-Path ([Environment]::GetFolderPath('Desktop')) 'carolina-partitions-leads-url.txt') -Encoding ascii
Step "DONE"
Write-Host "New web app address (already copied to your clipboard and saved to your Desktop):" -ForegroundColor Green
Write-Host $url -ForegroundColor Green
Write-Host "Paste it to Claude. Claude puts it in the website and checks the test row in the sheet."
Read-Host "Press Enter to close"
