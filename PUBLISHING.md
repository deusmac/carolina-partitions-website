# Putting the Carolina Partitions Website Online

A plain-language, step-by-step guide. No coding needed. Follow it top to bottom and the site
will be live on carolina-partitions.com with a working quote form. Budget about one hour,
plus waiting time for the domain to connect.

If you get stuck, the Troubleshooting box at the bottom covers the common issues.

---

## 1. What you have

- **index-v3.html** is the current website, all in one file. Every photo, the logo, Jack's
  photo, the animations and the quote form are built in. (`index.html` and `index-v2.html`
  are older versions. Do not publish those.)
- **og-image.jpg** is the preview picture that shows when someone shares the website link
  in a text, email or on social media. Publish it next to the website file.
- **To preview it on your computer right now:** double-click `index-v3.html`. It opens in
  your web browser and works, including the quote form.
- The other files and folders (`brand-assets`, `assets`, `plan`, `build`, `leads`) are
  working files. You do not publish them.

Two things to know before you go live:
- Project Rock, RS Spartanburg and Woodlands at Furman use real Carolina Partitions photos.
  The other photos (Bedrock, the ceilings strip, and Jack's past projects) are professional
  stock images placed as stand-ins. Step 5 explains how to swap in real photos.
- The quote form is already connected to the Google Sheet. Step 4 covers the one-time
  update that turns on file attachments.

---

## 2. Buy or confirm the domain

You want **carolina-partitions.com**.

1. Go to a domain registrar. **Namecheap** (namecheap.com) or **Cloudflare Registrar**
   (dash.cloudflare.com) are both good and cheap.
2. Search for **carolina-partitions.com**.
   - If it is available, add it to the cart. A .com is usually 10 to 12 dollars per year.
   - If you already own it, skip to Step 3 and just log in to wherever you bought it.
3. During checkout, turn **ON** the free "domain privacy" or "WhoisGuard" option. This keeps
   your personal details off public listings.
4. Finish the purchase. Keep the login for the registrar handy. You will set two small
   records there in Step 3.

---

## 3. Host it for free and connect the domain

Hosting is where the files actually live on the internet. Both options below are free and
give you automatic HTTPS (the padlock in the browser). Option A is the easiest.

### Option A (recommended): Netlify Drop

1. Make a new, empty folder on your desktop called **carolina-partitions-site**.
2. Copy two files into it:
   - `index-v3.html`, then **rename the copy to exactly `index.html`**
   - `og-image.jpg`
3. Go to **app.netlify.com/drop** and drag the whole **carolina-partitions-site** folder onto
   the page. In a few seconds you get a live web address that looks like
   `random-name-12345.netlify.app`. The site is already online at that temporary address.
   Open it and click through it.
4. Create a free Netlify account when prompted (so the site stays up and you can manage it).
5. Connect your real domain:
   - In the site's Netlify dashboard, go to **Domain settings**, then **Add a domain**, and
     type `carolina-partitions.com`.
   - Netlify shows the DNS records to create at your registrar (from Step 2). Typically two:
     - An **A record**: Host/Name `@`, Value as Netlify shows it.
     - A **CNAME record**: Host/Name `www`, Value `your-site-name.netlify.app`.
   - Log in to your registrar, find **DNS settings** or **Manage DNS**, and add those two
     records exactly as Netlify lists them. Save.
6. Back in Netlify, click **Verify** or **Check DNS**, then turn on **HTTPS** (Netlify calls
   it "Provision certificate"). It is automatic once the domain connects.

**About "DNS propagation":** after you save the records, the internet needs time to notice
the change. This can take 5 minutes or up to 48 hours (usually under an hour). During that
window the domain may not load yet. That is normal. Wait and check again.

### Option B: Cloudflare Pages or Vercel

Same idea, slightly different buttons. Upload the same folder from Option A (with
`index.html` and `og-image.jpg` inside).
- **Cloudflare Pages** (pages.cloudflare.com): create a project, upload the folder, then add
  the domain under the project's **Custom domains** tab.
- **Vercel** (vercel.com): create a new project, upload the folder, then add the domain under
  **Settings, Domains** and follow the two DNS records it shows you.

Pick one host. Do not use two at once.

---

## 4. The quote form (already connected)

Every quote request from the website already:
- adds a row to the Google Sheet **Carolina Partitions Website Leads** (tab "Leads"),
  https://docs.google.com/spreadsheets/d/11oe1XEzhJe5hY6DxnhYVedub2LSoAk3xviybsnaSuTc/edit
- emails Jack at **jmorgan@carolina-partitions.com**, and hitting Reply goes straight to the
  customer.

**One-time update to turn on attachments and the plans link** (2 minutes, signed in to Google
as johnc.tiempo@gmail.com). Full steps are in `leads/SETUP.md` and in the OneDrive folder
"Carolina Partitions Website Leads":
1. Open the leads sheet, then **Extensions**, then **Apps Script**.
2. Replace all the code with the new `google-apps-script.gs` and Save.
3. Pick **setup** and click **Run**. Allow the new Google Drive permission.
4. **Deploy**, **Manage deployments**, pencil icon, Version **New version**, **Deploy**.
   Keep the same deployment so the web address stays the same.

Until that is done the form still works, but attached files and plan links are ignored.

**Test it** after the site is live: fill in the quote form with "TEST, delete me", attach a
small PDF, and submit. A new row should appear in the Leads tab and Jack should get the email
with the PDF attached. Delete the test row afterward.

---

## 5. Replacing the stock photos later

The easiest way: drop the real photos into the `brand-assets` folder (one folder per project,
like the existing ones) with a short note in `brand-assets/README.md` about what each photo
shows, then ask Claude to swap them in. Claude resizes and embeds them, keeps the file a
reasonable size, and rebuilds the page with `build/build_v3.py`.

Every stand-in photo is marked **PLACEHOLDER** inside the file, so it is easy to see what is
still stock. The ones that still need real photos:
- the Ceilings strip in the Services section
- Bedrock Veterinary Clinic
- higher-resolution Woodlands at Furman photos (the current ones are very small)
- Jack's past projects: Peace Center, Spartanburg Regional MOB, Poinsett Plaza, Carolina Oaks
  Dental Care, Cabela's, Inverness Assisted Living, Gatlinburg Aquarium, Captain's Quarters

After any change, re-upload the new `index.html` to your host (drag the folder onto Netlify
again to redeploy).

---

## 6. Email on the domain (optional, do it when ready)

Publishing the website does **not** create email addresses. To send and receive from
**jmorgan@carolina-partitions.com**, you need mail hosting (Microsoft 365 is a common choice
and may already be in place).

- The mail provider gives you **MX records** (plus a couple of others).
- You add those at the **same registrar** where you set the website DNS in Step 3.
- Website records and email records live side by side and do not interfere with each other.

---

## 7. Go-live day checklist and troubleshooting

**Go-live checklist:**
- [ ] Domain purchased and privacy turned on
- [ ] Folder with `index.html` (renamed from index-v3.html) and `og-image.jpg` uploaded
- [ ] Custom domain added and the two DNS records set at the registrar
- [ ] HTTPS padlock shows on carolina-partitions.com
- [ ] Attachments update done in Apps Script (Step 4)
- [ ] Test quote with a small PDF submitted, row appears in the sheet, Jack got the email
- [ ] Opened the live site on a phone and clicked through it once
- [ ] Shared the link in a text to yourself and the Project Rock preview picture shows

**Troubleshooting:**
- **The domain will not load.** DNS is probably still propagating. Wait up to a few hours and
  try again. Double-check the two records at the registrar match what the host showed you.
- **The form says "almost ready".** The file is an old copy. Re-upload the latest
  index-v3.html (renamed to index.html).
- **No row appears in the sheet.** Open the Apps Script, click **Executions** on the left and
  look at the latest run for an error. Most often the Deploy step was skipped after an edit.
- **Attachments do not arrive.** Do the one-time update in Step 4. Files over 15 MB in total
  are refused by the form; ask for a Dropbox or Google Drive link instead.
- **The link preview shows no picture.** Make sure `og-image.jpg` was uploaded next to
  `index.html`. Social apps cache previews, so new shares can take a day to update.
- **You need to make a text change.** Ask Claude, or edit the file in a text editor, save, and
  drag the folder onto Netlify again. Every re-upload replaces the live site in seconds.

That is everything. Once the padlock shows and a test quote lands in the sheet, you are live.
