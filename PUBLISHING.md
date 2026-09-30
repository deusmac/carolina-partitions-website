# Putting the Carolina Partitions Website Online

A plain-language, step-by-step guide. No coding needed. Follow it top to bottom and your
site will be live on carolina-partitions.com with a working quote form. Budget about one
hour, plus waiting time for the domain to connect.

If you get stuck, the Troubleshooting box at the bottom covers the common issues.

---

## 1. What you have

- **index.html** is the entire website in one file. Everything (design, photos, the video
  hero, the quote form) is built in.
- **To preview it on your computer right now:** double-click `index.html`. It opens in your
  web browser and works, including the video and animations. The quote form will show a note
  saying it is not connected yet. That is normal until Step 4.
- The other files in the folder (`assets`, `brand-directions.html`, the brief) are references.
  You only need to publish **index.html**.

Two things to know before you go live:
- The photos and the two background videos are professional stock images, placed as
  stand-ins. Step 5 explains how to swap in real Carolina Partitions job photos later.
- The quote form needs a free account to actually deliver emails. That is Step 4.

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

Hosting is where the file actually lives on the internet. Both options below are free and
give you automatic HTTPS (the padlock in the browser). Option A is the easiest.

### Option A (recommended): Netlify Drop

1. Rename a copy of the site file to exactly **index.html** if it is not already named that.
2. Go to **app.netlify.com/drop**.
3. Drag the `index.html` file onto the page. In a few seconds you get a live web address
   that looks like `random-name-12345.netlify.app`. Your site is already online at that
   temporary address. Test it.
4. Create a free Netlify account when prompted (so the site stays up and you can manage it).
5. Connect your real domain:
   - In your site's Netlify dashboard, go to **Domain settings**, then **Add a domain**, and
     type `carolina-partitions.com`.
   - Netlify will show you the DNS records to create. You will set these at your registrar
     (from Step 2). Typically two records:
     - An **A record**: Host/Name `@`, Value `75.2.60.5` (Netlify shows you the exact value).
     - A **CNAME record**: Host/Name `www`, Value `your-site-name.netlify.app`.
   - Log in to your registrar, find **DNS settings** or **Manage DNS**, and add those two
     records exactly as Netlify lists them. Save.
6. Back in Netlify, click **Verify** or **Check DNS**. Then turn on **HTTPS** (Netlify calls
   it "Provision certificate"). It is automatic once the domain connects.

**About "DNS propagation":** after you save the records, the internet needs time to notice
the change. This can take 5 minutes or up to 48 hours (usually under an hour). During that
window the domain may not load yet. That is normal. Wait and check again.

### Option B: Cloudflare Pages or Vercel

Same idea, slightly different buttons.
- **Cloudflare Pages** (pages.cloudflare.com): create a project, upload `index.html`, then
  add your domain under the project's **Custom domains** tab. If your domain is registered at
  Cloudflare, the DNS is set for you automatically.
- **Vercel** (vercel.com): create a new project, drag the file in or upload it, then add the
  domain under **Settings, Domains** and follow the two DNS records it shows you.

Pick one host. Do not use two at once.

---

## 4. Turn on the quote form

The form uses **Formspree**, a free service that emails you each quote request. Quote requests
should go to **jmorgan@carolina-partitions.com**.

1. Go to **formspree.io** and create a free account using **jmorgan@carolina-partitions.com**
   (or forward Formspree's emails to that address, see note below).
2. Click **New Form**. Name it "Carolina Partitions Quote". Formspree gives you an endpoint
   that looks like `https://formspree.io/f/abcdwxyz`. The part after `/f/` is your form ID.
3. Open **index.html** in any plain text editor (Notepad works). Use **Find** to search for:
   **YOUR_FORM_ID**
   You will find this line near the quote form:
   `action="https://formspree.io/f/YOUR_FORM_ID"`
   Replace `YOUR_FORM_ID` with your real form ID so it reads, for example:
   `action="https://formspree.io/f/abcdwxyz"`
   Save the file.
4. Re-upload the updated `index.html` to your host (in Netlify, drag the new file onto the
   site again, that redeploys it).
5. Test it: open the live site, fill in the quote form, and submit. The first time, Formspree
   sends a confirmation email to activate the form. Click the link in that email once. After
   that, every submission arrives in your inbox.

Note on the destination: Formspree delivers to the email on the Formspree account. If you
created the account with a different email, add or change the recipient to
**jmorgan@carolina-partitions.com** in the Formspree form settings.

---

## 5. Replacing the stock photos later (recommended)

Every stock image and both videos are marked in the file so you can find them. When you have
real Carolina Partitions job photos or a real portrait of Jack:

1. Open **index.html** in a text editor and use **Find** to search for:
   **PLACEHOLDER**
   Each hit sits right next to the image it belongs to.
2. To swap a photo, you have two easy options:
   - **Simplest:** upload your real photo to the same host, then change that image's web
     address in the file to point to your photo.
   - Or use a free image host and paste its link.
3. Save the file and re-upload it to your host (drag it onto Netlify again to redeploy).
4. Start with the three that matter most: real project photos, a real portrait of Jack, and
   any updated contact details.

The project names (Peace Center, Cabela's, and so on) are Jack's real career highlights. The
images next to them are representative stand-ins until your real photos go in.

---

## 6. Email on the domain (optional, do it when ready)

Publishing the website does **not** create email addresses. To send and receive from
**jmorgan@carolina-partitions.com**, you need mail hosting (Microsoft 365 is a
common choice and may already be planned).

- Once you have a mail plan, that provider gives you **MX records** (plus a couple of others).
- You add those records at the **same registrar** where you set the website DNS in Step 3.
- Website records and email records live side by side and do not interfere with each other.

Until email hosting is set up, the form in Step 4 still works because Formspree handles
delivery on its own.

---

## 7. Go-live day checklist and troubleshooting

**Go-live checklist:**
- [ ] Domain purchased and privacy turned on
- [ ] index.html uploaded to Netlify (or your chosen host)
- [ ] Custom domain added and the two DNS records set at the registrar
- [ ] HTTPS padlock shows on carolina-partitions.com
- [ ] Formspree form ID pasted into the file and the file re-uploaded
- [ ] Confirmation email from Formspree clicked
- [ ] Test quote submitted and received at jmorgan@carolina-partitions.com
- [ ] Opened the live site on a phone and clicked through it once

**Troubleshooting:**
- **The domain will not load.** DNS is probably still propagating. Wait up to a few hours and
  try again. Double-check the two records at the registrar match what the host showed you.
- **The form does not send.** Make sure you replaced `YOUR_FORM_ID` with your real ID, saved,
  and re-uploaded the file. Then confirm you clicked the activation link Formspree emailed you.
- **The video does not play on a phone.** The hero shows a still image instead of video on
  some phones and on slow connections, and for visitors who have "reduce motion" turned on.
  That is intended and looks fine. If nothing loads at all, re-upload the file and refresh.
- **A photo looks wrong or you want to change it.** See Step 5.
- **You need to make any text change.** Edit index.html in a text editor, save, and drag the
  file onto Netlify again to redeploy. Every re-upload replaces the live site in seconds.

That is everything. Once the padlock shows and a test quote lands in your inbox, you are live.
