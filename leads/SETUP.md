# Website leads: Google Sheet setup (about 3 minutes, one time)

Every quote request from the website will:
- add a row to a Google Sheet called "Carolina Partitions Website Leads" (tab "Leads")
- email Jack at jmorgan@carolina-partitions.com, with Reply going straight to the customer

Only the owner of the Google account can create the sheet and approve the script, so these
steps have to be done while signed in to the Google account that should own the leads.

## Steps

1. The sheet already exists (link below). Open it, signed in as johnc.tiempo@gmail.com.
2. (nothing to rename)
3. Click Extensions, then Apps Script.
4. Delete everything in the editor and paste the full contents of `google-apps-script.gs`
   (in this folder, saved as google-apps-script.txt in OneDrive). Click the Save icon.
5. In the function dropdown at the top pick `setup`, click Run.
   Google asks for permission: Review permissions, pick your account, Advanced,
   "Go to (project name) (unsafe)", Allow. (It says unsafe only because the script is
   yours and not published by Google. It can only touch this one sheet and send the
   lead emails.) The sheet now has a "Leads" tab with a header row.
6. Click Deploy, then New deployment. Click the gear next to "Select type", choose Web app.
   - Description: Website leads
   - Execute as: Me
   - Who has access: Anyone
   Click Deploy, then copy the "Web app URL" (starts with https://script.google.com/macros/s/).
7. Send two links back to Claude:
   - the Web app URL from step 6
   - the sheet's link (from the browser address bar)

Claude then pastes the Web app URL into the website (`LEADS_URL` in index-v3.html),
runs a test submission, and saves the sheet link here.

## Links (filled in after setup)

- Leads sheet: https://docs.google.com/spreadsheets/d/11oe1XEzhJe5hY6DxnhYVedub2LSoAk3xviybsnaSuTc/edit (owner johnc.tiempo@gmail.com, created by Claude via the Google Drive connector)
- Web app URL: https://script.google.com/macros/s/AKfycbwYNTrmw5_wEzBCh35W6OGrQBdi7URQiIQ2jZa_a-v2uPDn1DIpqkconLUn1ALymyL2/exec

## Notes

- To email more people, edit `NOTIFY` at the top of the script (comma separated), then
  Deploy, Manage deployments, Edit, Version: New version, Deploy. The URL stays the same.
- The "Status" column starts as "New". Change it to Contacted, Bid sent, Won or Lost as you go.
- Bots that fill the hidden field are dropped. Text that starts with =, +, - or @ is stored
  as plain text so nothing in a lead can run as a spreadsheet formula.
- Google free accounts can send about 100 emails a day from a script, far more than needed.

## Update (2026-10-01): attachments on the quote form

The website form now accepts a "Link to plans" and up to 4 files (15 MB total; PDF, JPG, PNG,
DWG, ZIP, XLSX, DOCX). The script saves files to a private Drive folder
"Carolina Partitions Website Leads - Attachments" (one subfolder per request), adds the links
to new "Plans link" and "Attachments" columns, and attaches the files to Jack's email.

To turn it on (2 minutes, signed in as johnc.tiempo@gmail.com):
1. Open the leads sheet, Extensions, Apps Script.
2. Replace all the code with the new `google-apps-script.gs` and Save.
3. Pick "setup" and Run. Google asks for permission again (now including Drive). Allow.
4. Deploy, Manage deployments, pencil icon, Version: New version, Deploy.
   Keep the SAME deployment so the web app URL does not change.
Until this is done, the form still works, but attached files and the plans link are ignored.
