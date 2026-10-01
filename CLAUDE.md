# CLAUDE.md - Carolina Partitions Website

> Persistent project memory. Read this file FULLY before doing anything else.
> It reflects the complete current state of the project, not the original plan.
> Companion doctrine: `C:\Users\User\Desktop\CLAUDE CONTEXT\CLAUDE CODE\THINKING.md`
> (how to think, debug, and communicate). If you cannot access that file, the
> condensed rules in section 2 below are binding on their own.
>
> HOW TO USE THIS TEMPLATE: copy this file into the new project root as CLAUDE.md,
> fill in every [BRACKET], delete this paragraph, and commit it as the first commit.

---

## 0. COLD-START BRIEFING (keep this section current, newest truth wins)

**Every agent updates this section before ending a session.** A new agent must be able
to read only section 0 and know exactly where things stand. History lives in section 9.

- **Project:** Marketing website for Carolina Partitions LLC, a Greenville SC COMMERCIAL
  drywall, metal stud framing and acoustical ceilings contractor (no painting, no residential).
  Audience: GC project managers, owners/developers, architects. Owner and only public contact:
  Jack Morgan, (864) 505-0066, jmorgan@carolina-partitions.com, 16 Rutledge Ave, Greenville SC 29617.
- **THE CURRENT BUILD IS `index-v3.html`.** `index.html` (v1) and `index-v2.html` are superseded
  and still contain residential/old content; do not ship or edit them unless JC asks.
- **Where the work lives:** git repo `deusmac/carolina-partitions-website`, branch
  `claude/brave-shannon-ahcnb8` (JC also keeps a non-git copy on his desktop). Preview link
  (private artifact, republish index-v3.html to update): https://claude.ai/artifact/GZjVWdn9HPuvj8vh7uf15A
- **How v3 is built:** `python build/build_v3.py` (needs Pillow) turns
  `build/index-v3.template.html` into the single-file `index-v3.html` (every image base64,
  ~2.0MB) plus `og-image.jpg`. Template tokens: `__LOGO_BLUE__ __LOGO_WHITE__ __JACK__
  __FAVICON__` (from `build/base64-assets.json`) and `{{IMG path|width|quality|x0,y0,x1,y1}}`
  (crop fractions, resize, JPEG re-encode, EXIF rotation baked in). EDIT THE TEMPLATE, then
  rebuild; hand edits to index-v3.html are lost on the next build. Rebuild is byte-identical.
- **Design:** structure modeled on usagg.com (capture + exact measurements in
  `plan/usagg-ref/NOTES.md`), palette JC picked = "Option C" navy #0A1F4A / ink #06142F /
  card #0F2656 / sand #E6DAC3 / bronze #8A7148. Nunito Sans + Open Sans. Square corners, one
  diagonal angle. No orange anywhere, no yellow (JC chose sand over usagg yellow).
- **Page, top to bottom:** utility bar, sticky white nav (About, Services, Projects, Project
  Rock, Why Us, Contact, Call Jack); HERO = 5-slide crossfade synced with "<word> is our
  STANDARD" every 5.5s (Precision/Rock 09 arch, Safety/Rock 01 crew on lifts, Stability/Rock 04
  steel framing, Craftsmanship/Woodlands as 3 small tiles, Quality/RS 03), caption chip per
  slide, clickable progress dots; stats bar; Services (text + 3 slanted photo strips: RS 07,
  Rock 03, stock ceilings); Current projects (Woodlands at Furman tiles, Bedrock Veterinary
  Clinic stock, RS Spartanburg + 4-photo RS gallery); Featured project Project Rock (photo 10 +
  "What we build" grid of 01-08); Why (4 cards); Jack's career projects carousel (auto-drifts,
  loops by moving cards, pauses on hover/touch, arrows still work); About Jack (real headshot);
  Contact (Jack card + quote form); footer.
- **Image sizing (2026-10-01, JC: "images are so small"):** build now outputs WebP (about a
  third smaller than JPEG) and encodes every photo at or above its on-screen size. Project Rock
  grid = 3 columns with photo 01 spanning 2; RS gallery = 2x2; Woodlands upscaled 2x + sharpened
  (`|sharp2` token) and shown as 1 big + 2 stacked (hero and card); services strips cut tall
  from the full-size originals. HTML ~2.3MB. Measure rendered vs natural image sizes with
  Playwright before shipping; nothing should be upscaled by the browser.
- **Quote form = EMAIL FIRST (JC, 2026-10-01, after repeated failed Google tests):** pressing
  "Email My Quote Request" opens a prefilled email to jmorgan@ in the visitor's own mail app
  (mailto with subject + all fields; visitor attaches drawings and sends). A panel with an
  "Open the email to Jack" button + phone shows as fallback. The Google Sheet POST still fires in
  the background (fetch no-cors, credentials omit, keepalive) as a best-effort log; its success
  was never confirmed (JC's tests ran in the claude.ai preview, which blocks outbound form
  posts, and his Chrome's default Google account is a work account with Apps Script disabled;
  incognito showed the web app itself is public: "Script function not found: doGet").
  Do not reintroduce a form that depends only on the Google script.
- **Leads:** form POSTs to Google Apps Script web app
  https://script.google.com/macros/s/AKfycbwYNTrmw5_wEzBCh35W6OGrQBdi7URQiIQ2jZa_a-v2uPDn1DIpqkconLUn1ALymyL2/exec
  (`LEADS_URL` in the template) which appends to the Google Sheet "Carolina Partitions Website
  Leads" tab Leads (https://docs.google.com/spreadsheets/d/11oe1XEzhJe5hY6DxnhYVedub2LSoAk3xviybsnaSuTc/edit,
  owner johnc.tiempo@gmail.com) and emails Jack (reply-to = customer). Form also takes a
  "Link to plans" (folded into Project details); drawings are emailed to Jack directly (mailto
  link on the form), no file upload. Code `leads/google-apps-script.gs`, steps
  `leads/SETUP.md`; copies in JC's OneDrive folder "Carolina Partitions Website Leads".
- **Open items (as of 2026-10-01):**
  1. ATTACHMENTS DROPPED (JC, 2026-10-01: Google setup kept failing because his browser's
     default Google account is a work account with Apps Script disabled). The site now uses the
     ORIGINAL live deployment as is: the plans link is folded into "Project details" before
     sending, and the form tells visitors to email drawings to jmorgan@ (mailto link). No file
     upload field. `leads/setup-leads.ps1` + the attachments script remain in the repo if JC ever
     wants uploads; running it needs johnc.tiempo@gmail.com, not the work account.
  2. No real end-to-end test lead yet (the cloud sandbox cannot reach script.google.com).
  3. Real photos still needed: ceilings strip, Bedrock, higher-res Woodlands, all career
     projects. Stone Cottage is not on the site.
  4. Go-live: domain, Netlify upload of index.html (renamed from index-v3.html) + og-image.jpg,
     per `PUBLISHING.md` (rewritten for v3).
  5. Photo 01 at Project Rock shows a jobsite banner with 864-288-7663 / carolinapartitions.com,
     different from Jack's number; flagged to JC, left as is.
  6. RS Spartanburg photos are by Frank Costa, Heritage Paintworks: credit is in HTML comments
     only. Ask JC before adding a visible credit.
- **Verification that works in the cloud sandbox:** Playwright + preinstalled Chromium
  (`NODE_PATH=$(npm root -g)`), open index-v3.html via file://, `ignoreHTTPSErrors:true` so
  Google Fonts load through the proxy, route/mock script.google.com for form tests. Check:
  every data: image decodes, all imgs have alt, 0 page errors, no horizontal overflow at
  390/768/1024/1440/1920, and the guards (0 Brightline, 0 visible "paint", 0
  residential/homeowner, 0 em dashes, 0 emoji). The sandbox network blocks usagg, Pexels,
  Unsplash and Google script hosts; GitHub, npm, PyPI and Google Fonts work.
- **Landmines (current):**
  1. HARD RULE: zero "Brightline" anywhere, no Brightline photography, ever (legal/brand
     separation). Never pull anything but bare project names from Brightline documents.
  2. Never fabricate testimonials, license numbers, stats, or project scope. Captions say only
     what `brand-assets/README.md` supports (Project Rock = steel stud framing + OSB/plywood
     sheathing of walls, boulders, arch and cave; we do NOT claim the finished climbing
     surfaces). RS = "Interior build-out" only. Woodlands has no scope claim.
  3. COMMERCIAL ONLY and NO PAINTING. Any residential/homeowner/painting wording is a
     regression, including meta tags and JSON-LD. Grep the whole file, not just the visible card.
  4. Woodlands photos are 240x320: small tiles only, never hero-size or full-width.
  5. Single file: images base64 via the build; external requests only Google Fonts and the
     Apps Script endpoint. Keep an eye on size (2.0MB now).
  6. House copy style: no em dashes, no emojis, phone without a leading plus, SVG icons only.
  7. Metal studs only in framing imagery, never wood.
  8. Stock photos stay flagged `<!-- PLACEHOLDER -->` with a manifest line at the bottom.
  9. JC judges visually: show real screenshots before calling design work done, and for big
     choices (palette etc.) give him a side-by-side to pick from by eye.
  10. Older landmines about index.html/index-v2.html (`.diag` dividers, GSAP ScrollTrigger
      quirks, the GSAP marquee technique) are in section 9's Session 4/7 entries; v3 uses no GSAP.

## 1. Who you are working for

John Carlo Tiempo (JC), engr.jctiempo@gmail.com. Estimator and pre-construction manager at
Brightline Contracting, a commercial drywall, metal framing, and painting subcontractor in
Greenville, South Carolina. He works remotely from the Philippines (Asia/Manila). Strong
Python developer, pragmatic, ships tools for real construction workflows. His boss Jack
Morgan often reads the outputs on a phone. Full people-and-vendor context lives in
`C:\Users\User\Desktop\CLAUDE CONTEXT\CLAUDE.md`; read it when the task touches emails,
invoices, GCs, or company data.

**Style: act first, explain after.** JC grants initiative. Fix bugs and build improvements
without asking, within section 5 guardrails. No planning theater. Tight summaries.

## 2. The rules (condensed doctrine, binding for any model)

1. Understand before acting. Read this file fully. Read files before editing them.
2. Root cause before fix. Reproduce, isolate, prove the hypothesis, THEN fix. Never stack
   failed fixes; revert each failed attempt. Three strikes on a bug means write down what
   you learned here and regroup.
3. Plan before code for anything beyond a one-file change. Write the plan down.
4. Evidence before claims. Never say done or fixed without having run it and seen it work.
   Verify against real data when it exists.
5. Simplest thing that works. No speculative abstraction, dependencies, or config.
6. Git from minute one. Commit every working increment. Branch per feature.
7. Security ships with the feature. Every new route, query, or mutation gets its auth check
   and input validation the same day it is written. An endpoint without auth is a bug.
8. Instant UI feedback. Every user-facing write reacts immediately (optimistic update or
   loading state). Never a silent wait on a network round trip.
9. Cost discipline. Do not re-read specs already summarized here. Batch questions and
   parallel-run independent commands. No new MCP servers, plugins, or dependencies unless
   the task is impossible without them. Use cheap models or subagents for research and
   bulk work when the harness allows choosing.
10. Output conventions, everywhere, including code comments and product copy: no em dashes,
    no emojis, lists not tables in prose (tables inside app UIs are fine), phone numbers
    without a leading plus sign, plain professional tone in anything boss- or customer-facing.

## 3. Session protocol (this is how sessions get saved, do not skip)

**On start:**
1. Read this entire file.
2. If resume, memory, or checkpoint skills are available, use them. Otherwise section 0
   and section 9 ARE the memory.
3. State in one line what you are about to do, then do it.

**On end (mandatory, the session is not over until this is done):**
1. Update section 0 (cold-start briefing) to the new truth.
2. Add an entry to section 9 (changelog): date, what shipped, what broke, what is next.
3. Commit everything, including this file.
4. If checkpoint or memory-save skills are available, run them too.

## 4. Project specifics

- **Stack:** [languages, frameworks, backend, e.g. Node + Express + React + Google Sheets,
  or Python + single-file HTML, or Convex]
- **Data sources:** [sheets IDs, Drive folders, APIs, databases; note which are LIVE company
  data and therefore read-only for testing]
- **Key files:** [entry points, config, the 5 files that matter]
- **External services and keys:** [what needs an API key, where keys live; never hardcode
  keys, never commit .env]
- **Conventions in this codebase:** [naming, folder layout, patterns to copy]

## 5. Guardrails (do not cross without JC's explicit go-ahead)

- Never write to live company data (production sheets, real email sending, real Drive files)
  during testing. Stage or dry-run instead.
- Never delete or overwrite originals of anything (emails, PDFs, backups).
- Never commit secrets. Never export credentials embedded in workflow or config files.
- [Add project-specific ones: e.g. do not touch the billing module, do not email anyone]

## 6. Verification playbook

[Fill in as the project grows. Examples: `npm run build` must pass; `node scripts/smoke.js`
hits the real API read-only; open the app via the launcher and click through the main flow;
for UI work capture a screenshot. If build tools do not exist yet, minimum bar is: run the
program on a realistic input and paste the output into the session summary.]

## 7. Shipping for colleagues

Anything a non-developer will use gets, before it is called finished:
- A one-click launcher (bat, vbs, or shortcut) that just works.
- A short plain-English guide (one page, no jargon) next to it.
- A test on the smallest screen it will realistically be used on.

## 8. Backlog

Redesign phases (`plan/OPERATION-SAVE-WEBSITE.md`) -- ALL 8 SHIPPED 2026-07-11:
1. [done] Phase 0: harness + "before" screenshots into `plan/before/`
2. [done] Phase 1: cinematic footage (hero 6474176, band 6474185, both genuinely dramatic)
3. [done] Phase 2: global drama pass (`.diag` dividers, mega type, ghost headings)
4. [done] Phase 3: hero cinema (slow Ken Burns; approved structure untouched)
5. [done] Phase 4: services redesign (4 asymmetric numbered rows, 2x2 grid killed)
6. [done] Phase 5: projects stage (dark full-bleed band, radial glow, sector marquee)
7. [done] Phase 6: signature pinned "How we build" scroll-scrub section
8. [done] Phase 7: atmosphere polish (skyline dusk + stars, image reveal wipes, stats texture)
9. [done] Phase 8: QA gate + CLAUDE.md update + client handoff with anti-slop note

Now: client go-live (domain, Formspree, real photos per PUBLISHING.md), Lighthouse on live HTTPS.

---

## 9. SESSION CHANGELOG (newest first; never delete old entries)

### 2026-09-30 - Session 9 (cloud sandbox: contact update, redesign brief captured)
- Ran in a Claude Code cloud session on the git repo (branch `claude/brave-shannon-ahcnb8`),
  not on JC's desktop. The network policy blocked usagg.com, web.archive.org, Pexels and
  Unsplash (HTTP 403 at the proxy), so the reference site could not be studied and no new
  photos could be sourced. JC stopped the session to continue on his desktop app.
- Shipped: contact change. Only Jack Morgan's number (864) 505-0066 and
  jmorgan@carolina-partitions.com remain, in index.html, index-v2.html and PUBLISHING.md
  (nav, contact cards, footer, JSON-LD, form fallback messages, Formspree comments). The
  index.html contact card label now reads "Call Jack Morgan".
- Looked up JC's "ongoing projects" in Athena (read-only): Woodlands at Furman, Bedrock
  Veterinary Clinic (one project, not two), RS Spartanburg Remodel. See section 0 item 7.
- Diagnosed "looks compact": `--maxw:1200px` container in index.html.
- Later the same session: JC picked palette Option C (navy + sand). Built index-v3.html, see
  the UPDATE bullet in section 0. Screenshots in plan/v3-shots/.
- 2026-10-01: JC had another agent push `plan/usagg-ref/` (usagg capture) and `assets/stock/`
  (20 photos). Rebuilt index-v3.html on usagg's real structure (see section 0 LATEST). JC then
  said commercial only, no residential: removed the residential section and every homeowner
  mention from v3. Fixed a mobile horizontal-scroll bug (an unrevealed slide-in element 60px
  off-canvas in a section without overflow clipping; `main{overflow-x:clip}`).
- LEAD ROUTING (JC asked where quote requests go): today nowhere, the form is a placeholder.
  Recommended: Formspree free plan (50 submissions/month) on jmorgan@carolina-partitions.com,
  which emails Jack every request and keeps all leads in the Formspree dashboard (CSV export).
  For a live spreadsheet, either Formspree's Google Sheets plugin (paid plans) or a free Google
  Apps Script web app that appends each submission to a Google Sheet and emails Jack. Optional
  later: also log each lead into Athena as a "possible" project. Waiting on JC's pick.
- JC picked option 2 (Google Sheet). Built and wired it (see section 0 LEADS); waiting on his
  one-time Google setup. Also: RS job renamed "RS Spartanburg"; Woodlands sector label removed.
- Real photos from brand-assets/ embedded in index-v3.html (see section 0 REAL PHOTOS ADDED).
  v3 is single-file again (1.58MB). og-image.jpg added. Applied to v3, not v2, on purpose.
- Same day: hero became a 5-slide photo slideshow synced to the rotator word (JC wanted
  "safety is our standard, stability is our standard" with changing project photos, including
  Woodlands); career carousel now auto-scrolls; quote form got a plans link + file attachments
  (script saves to Drive, attaches to Jack's email). HTML grew to 2.0MB.
- Housekeeping: build script + template moved into `build/` (rebuild verified byte-identical),
  PUBLISHING.md rewritten for v3 (two-file Netlify upload, Google Sheet leads, attachments
  update), section 0 of this file rewritten as a single current-state briefing.

### 2026-07-23 - Session 8 (index-v2.html: Project Rock, painting service dropped entirely)
- Same-day continuation, right after Session 7. JC clarified "The Rock" left open at the end
  of Session 7: it's projectROCK, an indoor rock-climbing gym (confirmed by opening
  projectrock.com; that specific site documents an Oakland Park, FL location, but JC said
  "he did the one on Greenville" and directly confirmed Jack built that Greenville location,
  which this agent has no way to independently verify but trusted the same way Session 7
  trusted JC's direct claim about the Brightline "highlighted projects" list, he has ground
  truth about his own trade/colleagues that this agent doesn't). Added "Project Rock" as the
  17th project card in the `#projTrack` marquee (sector: Recreation, a new chip added to the
  sector-chip row for it) using a Pexels indoor-climbing-wall detail shot (6674132, portrait
  crop, fits the tall card nicely). JC also specifically asked for it to be "a highlight in
  one of the pics shown on the main top page," so retargeted hero slide 2 (previously a
  generic "view the work behind the name" slide over a stock office-lobby photo) to spotlight
  it by name: kicker "Featured project," title "Project Rock, Greenville," sub "Full interior
  build-out for the indoor climbing gym," new photo (5384632, landscape gym-training shot).
  CTA still points to `#projects` since the full entry lives in the marquee.
- JC: "we are not gonna do painting anymore, we don't do that shit anymore." Removed
  painting as a service line everywhere on `index-v2.html`, not just the obvious services
  card. Full sweep (`grep -i "paint"`) found and fixed 7 separate spots: the Painting service
  card itself (services grid dropped from 4 columns to the CSS default 3, since `.card-grid`
  is already `repeat(3,1fr)` without a modifier class, so no new CSS was even needed, just
  removing the now-unnecessary `.four` modifier), the meta description, the OG description,
  the Twitter description, the JSON-LD `description` field, the JSON-LD `knowsAbout` array
  entry, the footer NAP blurb, and one residential-section bullet ("Interior and exterior
  painting"). LESSON: a "we don't offer X anymore" instruction touches meta tags and
  structured data (JSON-LD), not just the visible service card, always grep the whole file
  for the service name rather than only editing the obvious card.
- Guards re-ran green: 0 Brightline, 0 "paint" (case-insensitive) anywhere in the file, 0 em
  dashes, 0 emoji, 208KB, 0 console errors, tag-balance clean, all 31 image URLs (added 2 for
  Project Rock, removed 2 now-unused painting photos) verified HTTP 200. Confirmed via DOM
  inspection: services grid now shows exactly 3 cards, the marquee track has 34 children (17
  originals x2 for the loop, Project Rock included), hero slide 2's title/sub read exactly as
  above. Same caveat as Session 7 still applies: Browser pane could not screenshot this
  session either, nothing has been visually confirmed by an agent yet.
- Next: same as end of Session 7, hand off to a design agent for a real visual review (this
  agent still could not screenshot all session), plus usual go-live tasks (domain, Formspree
  ID, real photos).

### 2026-07-23 - Session 7 (index-v2.html: infinite projects marquee, 16 projects, Brightline doc)
- Continuation of the same day's work, later in the session, after JC reviewed Session 6's
  color pass and gave one round of feedback (see below), then asked for three more things:
  (1) rebuild Recent Projects as a big, seamless, infinite-scrolling carousel with
  hover-controlled speed; (2) pull "all the projects" out of an uploaded PDF, believing they
  were all Jack's; (3) add a project called "The Rock."
- FEEDBACK ON SESSION 6'S COLOR PASS (apply going forward): JC looked at a screenshot of the
  live navy/orange combo and said flatly "I really don't like this shade of blue... darker
  navy... remove any trace of orangey color... find a more complementary color... that's the
  color of the last company we've had and we hate it." This is a full reversal of the
  Direction-3 clay-orange choice baked into `index.html` and into `index-v2.html` sessions
  1-6, it is NOT a request to tune the existing palette, it's a rejection of the hue itself,
  for a brand-emotional reason (resemblance to a hated former company), not a taste nitpick.
  Checked the client's actual real logo file (`CAROLINA PARTITIONS LOGO.png`) first and
  confirmed it's pure navy + white, no orange in it anywhere, so there was no real brand
  constraint being violated by dropping orange, it was purely this agent's earlier color
  system choice. Built an interactive color-swatch comparison widget (via the visualize tool,
  NOT the broken Browser pane) showing 4 non-orange candidate accents against the darker navy
  (brass/gold, warm taupe, steel gray-blue, deep wine) side by side with the rejected
  original, and had JC pick by eye instead of guessing again from text descriptions. He picked
  "B: darker navy + warm taupe" without hesitation. LESSON: when a color decision is high-
  stakes (whole-site accent, already rejected once) and the client is clearly unable/unwilling
  to evaluate from adjectives alone, build an actual visual picker instead of describing more
  hex codes in prose. The visualize/show_widget tool works even when the Browser pane's
  screenshot tool is broken, since it's a completely different rendering path.
- Implemented the taupe swap thoroughly, not just a variable-value substitution: taupe
  (`#A9906F`) is lighter than the old clay-orange, so every spot that had WHITE text sitting
  on a clay-colored background (buttons, card title bars, chips on hover, the founder badge,
  the footer copyright bar) needed to flip to a new dark warm ink (`--on-clay: #2E2414`) or it
  would have gone low-contrast/illegible. Conversely, every spot using clay as TEXT color
  against a white/off-white background (nav hover links, the why-section numerals and bold
  word, residential icons/eyebrow, form focus/required-asterisk colors) got bumped to
  `--clay-deep` (a darker shade) instead of the base tone, for the same contrast reason.
  Recomputed real WCAG luminance/contrast ratios by hand for a couple of the riskiest cases
  (white on base taupe was only ~3:1, fails normal-text AA) rather than eyeballing it.
- Caught two literal leftover `rgba(193,85,46,...)` (the OLD orange, hardcoded instead of
  referencing the CSS variable) still sitting in the Session 6 atmosphere-glow edits for the
  founder and why-us sections, an earlier pass had used raw hex instead of `var(--clay)`,
  so simply changing the root variable didn't touch them. JC's ask was "remove ANY trace," so
  this got a dedicated `grep` sweep afterward and both leftovers were fixed. LESSON: when a
  color system change is this literal ("remove every trace"), grep the whole file for the OLD
  hex/rgb triplet as a final check, don't trust that variable-based edits caught everything;
  any place a value was inlined rather than referencing the variable will silently survive a
  root-variable change.
- Also darkened `.weave` (the shared dark-navy background used by the projects/stats/contact
  sections) from a fairly saturated `#0A1F52`/`#10306E` pairing down to `#060F26`/`#0E1F45`,
  which is what JC's screenshot was actually complaining about ("this shade of blue... doesn't
  fit"). `--navy`/`--navy-deep` (used for small text/icon elements like nav links and the
  hero-rail) were darkened more modestly for overall cohesion, not because they were part of
  the complaint.
- PROJECTS CAROUSEL: replaced the static `.card-grid` of `.dcard` project cards inside
  `#projects` with a full-bleed `#projMarquee`/`#projTrack` infinite GSAP loop. Cards are now
  `min(74vh,660px)` tall (vs. the old grid's small square-ish cards) so 2-3 are visible at a
  time, creating the "almost captures the whole screen" feel JC asked for. Technique: clone
  the track's children once at init and append the clone back onto the same track, animate
  `x` from 0 to `-originalWidth` with `repeat:-1, ease:"none"`, so the loop point is seamless
  (see landmine 12). Cursor X position over the marquee drives `loopTween.timeScale()`, left
  half of the marquee slows toward 0.15x, right half speeds toward 3.2x, resets to 1x on
  mouse-leave, never fully stops (matches "flows infinitely... hover to make it faster or
  slower"). Falls back to plain native `overflow-x:auto` horizontal scroll on touch, reduced-
  motion, or if GSAP didn't load. A small `.proj-marquee-hint` caption ("move your cursor left
  or right...") is gated to `(hover:hover) and (pointer:fine)` only, same pattern as an
  existing hint element in `index.html`'s carousel from an earlier session.
- BRIGHTLINE DOCUMENT: JC uploaded `BL Sales Profile.pdf` and said "most I think all the
  projects here are made by jack so please include all of them." Extracted the text with
  `pdftotext -layout` (this machine has `pdftotext` bundled with Git but not `pdftoppm`/other
  poppler utilities, so the ~144-page PDF's mostly-photo pages could not be rendered to check
  for captions baked into images; text extraction only pulled ~180 lines total). The document
  is confirmed to be BRIGHTLINE CONTRACTING's own company profile (their phone, email,
  address, tagline, JC's actual employer, and per section 1 Jack Morgan is also his boss
  there). This directly implicates landmine 1 (zero Brightline anywhere, ever, legal/brand-
  separation). The document's own text distinguishes "MAJOR CAREER PROJECTS" personally
  attributed to Jack L Morgan (all 6 of which were already on the site, nothing new there)
  from a separate "HIGHLIGHTED PROJECTS" list attributed to the company generally, not to Jack
  by name. JC directly asserted these are Jack's too, and as someone who actually works at
  this company he has ground truth this agent doesn't, so that assertion was trusted rather
  than second-guessed. Added all 10 as new project entries using ONLY the bare name +
  location text from the document (Drygoods, Stanton Optical, Rack Room Shoes, Five Forks
  Shopping Center, Walgreens, Inverness Assisted Living, Carolina Oaks Dental Care, Holmes
  Memorial Church, Holmes Bible College, Comfort Suites), never touched Brightline's actual
  photography, logo, or contact info from the PDF. Sourced 10 new representative Pexels stock
  photos (one per new project, verified HTTP 200 each) matching each project's general
  business type; rejected several search results along the way for being too identifiable/
  landmark-y (e.g. Princeton/Marquette university buildings for the small Holmes Bible
  College, giant Frankfurt/Taipei mega-malls for the small Five Forks Shopping Center) since
  that would misrepresent scale and risk looking dishonest even under "representative stock"
  labeling.
- "THE ROCK", searched the extracted PDF text thoroughly (`grep -i "rock"`), zero matches.
  Asked JC directly via AskUserQuestion rather than guess; he confirmed it's a separate
  project not in this document but has not yet supplied its name/location/sector. NOT added.
  Whoever picks this up next: do not fabricate this entry, wait for JC's actual answer.
- Guards re-ran green after all changes: 0 Brightline mentions, 0 em dashes, 0 emoji, 208KB,
  0 console errors, tag-balance clean, all 32 image URLs in the file (22 original + 10 new)
  verified HTTP 200. Verified the marquee's GSAP tween exists (`gsap.getTweensOf`) and that
  simulated mousemove events actually change `timeScale()` (0.32x hovering left edge, 2.76x
  hovering right edge, resets to 1.00x on mouseleave) since the Browser pane still could not
  screenshot this session (see the caveat in section 0, nothing was visually confirmed).
- JC asked for this file (CLAUDE.md) to be updated thoroughly so a different design agent can
  give `index-v2.html` a final review/polish pass with full context. Section 0 above has been
  rewritten accordingly; a fresh agent should be able to read only section 0 and pick this up
  cold.
- Next: (1) get "The Rock" project details from JC and add it. (2) hand off to a design
  agent for final review, give them this file plus a note that the Browser pane in THIS
  session could not screenshot, so nothing has been visually verified by an agent yet, only
  structurally. (3) usual go-live tasks remain (domain, Formspree ID, real photos).

### 2026-07-23 - Session 6 (index-v2.html: color depth, richer imagery, fluid 3D motion)
- Client (JC, frustrated): "still looks fucking ugly... don't like the color combinations...
  need fluid 3D animations, something that pops but not too much... more pictures, the current
  pictures of acoustical is not that great." Confirmed via file mtimes that `index-v2.html`
  (last touched 2026-07-22 22:35) is "the latest session" being reviewed, not `index.html`.
  Read the full file structurally (base64 image blobs collapsed to `[LONG LINE]` markers via
  awk so the CSS/HTML/JS could be read without blowing the context budget on inline photo data).
- Diagnosed the real color complaint: the `.founder` section used a flat neutral gray radial
  gradient (chosen in session 5 to blend with Jack's photo backdrop) with zero brand color in
  it, so the page's color system visibly broke down at that section; clay was also doing 100%
  of every accent job everywhere (buttons, corner triangles, chip hovers, numbers, quote mark)
  with no tonal variation, which reads flat/repetitive rather than rich. Fix: layered a clay
  radial glow + a navy diagonal wash ON TOP OF the existing gray base gradient in `.founder`
  (kept the original gray layer intact underneath so the seamless blend with Jack's real photo
  backdrop is not broken), and added matching low-opacity clay/navy corner glows as atmosphere
  behind the previously flat-white `#services` and `.why` sections so brand color now threads
  through every section instead of disappearing in the light/gray ones.
- Diagnosed the acoustical-ceiling complaint precisely: it had exactly ONE stock photo
  (32263478) and that same photo was reused in two places on the page (hero slide 3 and the
  services card), which reads as thin/repetitive up close. Sourced additional real Pexels
  stock via the established harvest-and-verify-with-curl technique (search pages scraped for
  `images.pexels.com/photos/{id}/` via `javascript_tool`, every chosen URL confirmed HTTP 200
  before use; see [[stock-asset-sourcing-pexels-browser]]). Rejected several ceiling-search
  results whose alt text mentioned wood elements (landmine: metal-only, never wood) or were
  abstract/skylight shots that don't read as a real acoustical grid. Added a second alt photo
  (crossfade on hover, reusing the `.ph img.alt` pattern the projects cards already had) to the
  Acoustical Ceilings, Commercial Drywall, and Painting service cards: 12471772 (acoustical),
  6474308 (drywall), 6764282 (painting). Could not find a safe non-wood alt for Metal Framing,
  left it single-photo. All new + existing image URLs re-verified 200 in a final sweep (23
  total).
- Built the "fluid 3D" animation the client asked for, gated to fine-pointer/no-reduced-motion
  only (`matchMedia("(hover:hover) and (pointer:fine)")`), on top of the existing GSAP: (1) a
  per-card 3D tilt + moving glare on every `.dcard` (services and projects) that follows the
  cursor via `perspective()/rotateX/rotateY` on mousemove and springs back with a GSAP
  `elastic.out` on mouseleave; (2) magnetic buttons (`.btn` nudges toward the cursor within its
  own bounds); (3) cursor-driven parallax on the hero's disc+wedge collage on top of its
  existing idle drift (applied to the parent `.collage` wrapper, not the same disc/wedge
  elements the idle drift already tweens, specifically to avoid the landmine 11 GSAP overwrite
  conflict where two tweens on the same element/property can silently kill one of them).
  Deliberately did NOT add more than these three (card tilt, magnetic buttons, hero parallax)
  given the client's own "not too much" caveat.
- VERIFICATION LIMITATION (be honest about this in the next session): the in-app Browser pane
  tool would not composite frames all session (`screenshot` errored "the Browser pane is not
  displayed" on every attempt, including immediately after a fresh edit and after a
  cache-busting reload), so nothing in this session was visually confirmed by screenshot. What
  WAS verified: 0 console errors on load; DOM tag-balance count (section/div/article/header/
  footer/form all open=close); every image URL in the file returns HTTP 200 (23/23); the
  founder gradient's 3 layers are actually present in computed style (first read was stale
  browser cache from before the edit, confirmed by a cache-busted `?v=2` reload); mobile
  viewport (375-582px) shows no horizontal overflow and the hamburger/nav-side breakpoint
  swap still fires correctly; the tilt/glare JS logic runs without throwing when manually
  invoked (the headless harness itself reports as a non-fine pointer, so the real mousemove
  listeners correctly never attach in this environment, same as they correctly wouldn't on a
  touch device). JC should open `index-v2.html` directly and confirm it actually looks right
  before this is called done.
- Guards re-ran green: 0 Brightline, 0 em dashes, 0 emoji-range characters, 199KB (well under
  budget). Asset license manifest comment updated with the 3 new photo IDs and their Pexels
  URLs, per landmine 6 (every asset needs a license line).
- Next: JC visually reviews this pass. If colors/animation still miss the mark, the next
  session should get an actual screenshot-capable verification path (this session's Browser
  pane could not composite) before iterating further, since guessing blind a second time is
  how the round-2/round-3 mismatches happened before.

### 2026-07-22 - Session 5 (index-v2.html: alternate version modeled on client reference)
- Client: "create another separate version of my current website and use this as a reference
  [spectruminteriors-sc.com], with all my branding, photos, contents everything." Studied the
  live reference headlessly (gstack browse; had to install the Playwright headless shell and
  junction chromium_headless_shell-1208 -> 1228 to unbreak the daemon). Reference language:
  black nav w/ centered logo + split menu, Bebas-style condensed uppercase type, hero photo
  slider with geometric collage (red disc + dark wedge, corner triangle), "HAVE A PROJECT"
  band, floating featured-project card, dark textured project cards with red corner triangles
  + red title bars, founder portrait on a dark gradient with a giant quote mark, black footer
  with a full-width red copyright bar.
- Built `index-v2.html` (188KB, single file) mapping that language onto the LOCKED Direction 3
  palette: navy-deep #06183F plays the reference's black, clay #C1552E plays its red, Barlow
  Condensed plays Bebas. All existing content carried over verbatim: hero video 6474176,
  4 services, all 11 project photos (6 cards, 5 used as hover-crossfade alts), stats, why
  steps, Jack's embedded real headshot + About copy (restyled as the founder-statement
  section, NOT a fabricated quote), residential, full quote form, NAP, JSON-LD, manifest.
  Base64 blobs (logo, favicon, Jack) were injected by a Node build script from index.html
  rather than retyped (template + `__TOKEN__` substitution, script in session scratchpad).
- Motion: 3-slide autoplaying crossfade hero (6.5s hold, arrows/dots, Ken Burns per slide,
  CSS-class-driven so it needs no GSAP), IntersectionObserver reveals, GSAP counters +
  collage drift + magnetic clay buttons. Reduced motion: autoplay off, video hidden,
  reveals visible. Corner triangles use linear-gradient hard stops (landmine 10 respected);
  no fromTo-linked ScrollTriggers anywhere (landmine 11 respected).
- QA: 0 console errors at 1440, 768, 375 (fresh checks); slider advance verified via DOM;
  all 30 reveals fire on scroll; guards all green (0 Brightline, 0 em dashes, 0 emoji-range
  chars, 22 placeholder flags, 188KB). Screenshots in session scratchpad. index.html was NOT
  modified. Known harness quirk reconfirmed: full-page screenshots taken right after a fast
  programmatic scroll can catch reveal/lazy content unfired; scroll through, wait, re-shoot.
- CLIENT REJECTED the first v2 pass ("not at all close, where are the pictures, where is
  Jack's picture, looks cheap"). Two root causes found and fixed in a full rebuild:
  (1) FIDELITY: the first pass kept Barlow + navy bands, which reads nothing like the
  reference. Rebuilt with the reference's actual DNA: Bebas Neue display + Open Sans body,
  pure black nav (#0D0D0F), charcoal crosshatch weave bands (inline SVG data-URI texture,
  no external request), stamped text-shadow headings, compact letterspaced clay buttons,
  floating featured-project card overlapping its photo, double clay corner triangles on
  every card photo, founder section on a radial studio-gray gradient that matches the
  backdrop of Jack's real headshot, black footer + full-width clay copyright bar + legal
  row. Clay #C1552E stays in the red role, navy only in logo/rail (palette lock intact).
  (2) BLANK CONTENT: scroll-reveal styling could leave sections invisible (this is what
  the client actually saw: empty founder/stats/contact bands). Fix: reveal styling only
  arms when html.js is set, IO threshold 0, plus DOUBLE failsafe (load+1.8s and hard 6s
  timeout) that force-reveals everything; counters are plain rAF with a setTimeout that
  guarantees the final number (GSAP counter had shown 0 in a full-page capture). Verified:
  31/31 reveals fire with NO scrolling, counters land 37/45/8, Jack + residential images
  confirmed loaded via naturalWidth checks. Guards re-ran green (0/0/0, 22 placeholders,
  186KB). LESSON: for a "make it look like X" request, clone X's typography and surface
  treatments literally on the first pass; brand-system substitution reads as "cheap".
- ROUND 3 (client feedback on the rebuild): (a) Featured Project section removed entirely
  (client: bloat). (b) Founder section enlarged to reference scale: photo min(100%,620px),
  min-height 820px, quote clamp 16-21px. (c) Hero video replaced with the Peace Center
  auditorium photo 27926553 (client: video "not good"); og/twitter/JSON-LD images updated
  to match. (d) Scroll parallax added (hero media scale 1.14 + translateY, founder/resi
  photos gentle drift; rAF-throttled scroll listener, gated off under reduced motion).
  (e) Charcoal crosshatch weave REPLACED (client: too identical to the reference) with a
  deep-navy blueprint-grid texture (#0A1F52 + fine/coarse grid lines + radial glow, pure
  CSS). (f) Nav flipped to WHITE with the client's ORIGINAL BLUE LOGO (root
  "CAROLINA PARTITIONS LOGO.png", injected as a new __LOGO_BLUE_B64__ token by the build
  script); navy links, navy hamburger; footer keeps the reversed logo on black. Mobile
  re-verified at 375 (hero, cards, founder, form) plus 768 and 1440; 0 console errors;
  guards green (0/0/0, 21 placeholders, 195KB). Build script now also reads the blue PNG.
- Next: client re-reviews index-v2.html. Go-live tasks unchanged (domain, Formspree ID,
  real photos).

### 2026-07-11 - Session 4 (Operation Save Website: full execution, all 8 phases)
- Client: "execute all of this. Do whatever it takes... make sure it's an amazing looking
  website." Ran the full approved plan end to end in one session, phase by phase, verifying
  visually (screenshot + console check) between each before moving on, per the plan's rule.
- Phase 1 (footage): sourced via the Pexels-through-browser technique (MCP key still 401).
  Hero is now Pexels 6474176 (a moody LED drywall-sander glowing in a dim room, genuinely
  cinematic, replaces a static "man standing" clip). Mid-band is 6474185 (a tradesman actively
  sanding, replaces a flat texture close-up). Both verified landscape 1920x1080, HTTP 200.
- Phase 2 (drama pass): added `--step6` mega type scale and a `.ghost` watermark-heading
  utility (Services/Projects/Greenville now have giant low-opacity text behind the headline).
  Built a diagonal-divider system for 5 major section seams. FIRST ATTEMPT (clip-path on the
  earlier section + negative-margin overlap on the later one) silently failed after real
  debugging (verified computed clip-path was correct, verified DOM hit-testing put the
  "covering" section on top, red-test-background never bled through, even an exaggerated 40%
  cut showed the wrong color underneath). Root cause never fully isolated; abandoned the
  technique rather than keep burning time on it. REPLACED with a much simpler, bulletproof
  `.diag` standalone divider: a small div between two sections using
  `linear-gradient(to bottom right, colorA 49.7%, colorB 50.3%)` for a hard-stop diagonal
  split. Zero stacking/clip-path risk, worked first try, used for all 5 seams. Lesson saved to
  CLAUDE.md landmine #10.
- Phase 3 (hero cinema): added a 20s yoyo Ken Burns scale (1.0 to 1.06) on the hero video via
  GSAP, gated behind hasGSAP/reduced-motion. Approved hero anatomy (seam, BUILD, rotating word,
  entrance timeline) intentionally untouched.
- Phase 4 (services): replaced the 2x2 identical-card grid with 4 asymmetric editorial rows
  (`.svc-row`), each with a giant index numeral (01 to 04), Drywall (01) as an oversized
  feature row. Kills the "four identical cards" anti-slop pattern the original build brief
  banned. Mobile: numerals shrink, media stacks full width below the text.
- Phase 5 (projects stage): moved the existing 3D coverflow carousel (mechanism untouched,
  client already approved it) onto a full-bleed `var(--navy-deep)` band with a ghost
  "PROJECTS" watermark and a radial clay glow centered under the stage. Converted the static
  sector-chip row into a seamless GSAP marquee (duplicate-content loop, pauses on hover,
  correctly falls back to a normal wrapped row under reduced motion or when JS/GSAP is
  unavailable, verified both states explicitly).
- Phase 6 (signature moment, the new centerpiece): built a pinned ScrollTrigger sequence for
  the "How we build" section (`.why-step`, `.why-dots`). Pins the section, scrubs through 3
  steps (Owner walks the job / Priced and scheduled right / Clean paperwork) with clip-path
  wipe transitions and a progress-dot indicator. Gated off (falls back to the original plain
  3-column always-visible grid) when `window.innerWidth < 760 || innerHeight < 560` or
  reduced-motion, verified both the pinned desktop path and every fallback explicitly by
  scrubbing to 10/50/90 percent progress and checking the DOM/computed styles at each point.
- Phase 7 (atmosphere): skyline background is now a dusk gradient (`#040f28` to `#1f2f57`)
  with a warm clay radial glow at the horizon and 10 small twinkling star spans (CSS
  `@keyframes`, disabled under reduced motion). Skyline parallax depths slowed (6/11/17 to
  4/8/12). About and Residential photos now wipe open via clip-path on scroll instead of a
  plain fade. Stats bar got a faint repeating-linear-gradient "blueprint grid" texture behind
  the cells. SECOND real bug found and fixed the same way as the divider one: the image-wipe
  ScrollTrigger (built with the `fromTo(el,{},{},{scrollTrigger:{...}})` shorthand) reported
  `progress:1` yet the visual clip-path never updated; direct inspection showed the
  ScrollTrigger instance had actually vanished from `ScrollTrigger.getAll()` after an unrelated
  manual `gsap.to()` debug call touched the same element/property earlier in the session,
  which GSAP's default `overwrite:"auto"` apparently used to kill the whole linked instance,
  not just the conflicting tween. Fixed by switching to a plain `ScrollTrigger.create({trigger,
  onEnter, onLeaveBack})` that calls `gsap.to()` itself inside the callbacks, decoupling the
  trigger from any fromTo linkage. Lesson saved to CLAUDE.md landmine #11.
- Phase 8 (QA gate): full guard sweep all green (0 Brightline, 0 em dashes, 0 emoji-range
  characters via a Node unicode-category scan, 21 placeholders, file size 216KB, well under
  the 1.5MB budget). Zero console errors confirmed fresh at all 5 required breakpoints (360,
  768, 1024, 1440, 1920). Reduced-motion fallback re-verified for every new phase 6/7 feature.
  Before screenshots in `plan/before/`, after screenshots in `plan/after/` (16 each, desktop +
  mobile, matching filenames for direct comparison).
- index.html grew from 204KB to 216KB (well inside budget). No hard rules violated at any
  point; no client-approved element (hero anatomy, palette, carousel mechanism, Jack's photo,
  real logo) was regressed, verified against `plan/AUDIT.md`'s do-not-regress list throughout.

### 2026-07-11 - Session 3 (design audit + Operation Save Website plan)
- Client verdict on v1: "so dull, so boring... nowhere near usagg... I'm looking for animations
  and great looking pictures." Supplied `Claude-Design-Masterclass-Summary.pdf` and asked for a
  full audit plus an execution-ready plan another agent could follow, saved in its own folder.
- Read the PDF. Transferable methodology adopted: design system first (DESIGN.md), anchor to
  named references studied live, hard constraints/negatives stated up front, one change per
  phase with visual verification between, explicit mobile passes, never redraw the real logo.
  Flagged honestly: "Claude Design" itself is a separate Anthropic web product (claude.ai paid
  plans), not installable in this CLI environment; no new installs were needed.
- Audited every section against this week's desktop + mobile screenshots. Diagnosis: correct
  anatomy, zero adrenaline. Critical issues: static hero footage (Pexels 6474251, a man standing
  still) and a too-light value rhythm (all dark moments clustered in the page's second half).
  High: flat horizontal section seams (diagonal motif only used twice), type scale capped at
  ~3.1rem (usagg uses mega type), services = four identical cards (banned AI-slop pattern),
  monotone motion (one fade-up pattern everywhere). Full table in `plan/AUDIT.md`.
- Created `plan/` folder (client-approved via plan mode): OPERATION-SAVE-WEBSITE.md (mission,
  read-first list, 11 hard constraints, 8 verified phases, verification quirks appendix,
  definition of done), DESIGN.md (locked palette + expanded type scale with --step6 and ghost
  type spec, motion spec table, imagery art direction accept/reject bar, component specs, logo
  rules, reference library, anti-slop checklist), AUDIT.md (per-section severity table plus the
  do-not-regress list of client-approved elements).
- Key decisions baked into the plan: palette stays Direction 3 (client chose it; dullness is a
  value-contrast problem, not a hue problem); hero anatomy and carousel mechanism stay (client
  approved them; only their footage/stage change); footage replacement is Phase 1 because no
  CSS can fix boring video.
- index.html untouched this session. Execution starts on JC's go, next agent enters at
  `plan/OPERATION-SAVE-WEBSITE.md`.

### 2026-07-11 - Session 2 (Jack's real headshot + final QA pass)
- Resumed via /resume after a session interruption; verified prior work (hero rebuild, clay
  palette, metal framing images, 3D carousel) was all intact and complete before starting new work.
- Client: "the Jack Morgan headshot is already in this folder [assets]." Found
  `assets\JACK MORGAN HEAD SHOT.jpeg` (1120x1553, 214KB). Resized to 700px wide, recompressed to
  quality 82 (~55KB), base64-embedded in the About section, replacing the Pexels stock portrait
  (8293699) that had stood in as a placeholder since session 1. This was the one item that had
  been blocked across two prior sessions (client's chat-pasted image was never retrievable as a
  file from clipboard or disk); saving it to the assets folder directly finally unblocked it.
  Placeholder count dropped 22 -> 21.
- Client: "make this look like an awesome awesome looking website." Ran a full visual QA pass,
  desktop (1440px) and mobile (390px), every major section, plus a fresh console-error check
  (0 errors across the whole site). Found and fixed one real bug: the carousel's "hover left or
  right to pan" hint was showing unconditionally, including on touch devices where hover doesn't
  apply; scoped `.carousel__hint` to only display when `.carousel.is-live` (i.e. only on
  fine-pointer/hover-capable devices where the live 3D carousel is actually running).
  One false-alarm during QA, noted for future sessions: pausing `gsap.globalTimeline` to try to
  get a stable full-page screenshot froze the rotating hero headline mid-fade, which looked like
  a broken overlapping-text bug in a screenshot. It was a testing artifact, not a real bug,
  a fresh page load rendered correctly. See section 0 "How to verify changes" for the fix
  (viewport screenshots per section, not full-page, don't pause gsap.globalTimeline for this).
- Re-ran all hard-rule guards after changes: 0 "Brightline", 0 em dashes, file size 204KB
  (well under the 1.5MB budget even with a real embedded photo).
- No open blockers remain. Everything left is client-side go-live work (domain, Formspree,
  remaining real photos) documented in PUBLISHING.md.

### 2026-07-09 - Session 1 (iteration 3: palette + 3D carousel)
- Client: "the color orange... the current color combination I don't like." Switched to brand
  Direction 3 (Upstate Modern): --accent #C1552E clay, --cta #B14A26, --bg #FAF8F4 warm off-white.
  Updated the token block plus every hardcoded orange (button/icon shadow rgba values, skyline
  eyebrow tint -> var(--accent-tint)). No safety orange remains.
- Client: "I don't like the projects view, only one picture each, make them a scrollable 3D
  carousel in constant motion, pan on hover." Replaced the .proj-grid with a live coverflow
  carousel (`.carousel` / `.carousel__track` / `.pcard`; JS `initCarousel` inside the
  hasGSAP && !reduce block). Seamless GSAP loop on a duplicated track, per-frame coverflow
  (rotateY/scale/z by distance from centre), hover-x drives loop.timeScale (pan). Enriched to 11
  project images (added alts 33126401, 3124079, 33812023, 33688145, 3904922; skipped a retail alt
  that showed a third-party store sign). Touch + reduced-motion => native horizontal scroll
  (CSS overflow-x:auto default; JS only upgrades on fine pointers). Verified 0 JS errors, reduced
  motion falls back correctly, mobile checked.
- Jack's headshot STILL not obtainable as a file (clipboard empty again, nothing recent on disk).
  It remains the one open item; needs him to save it to `assets\jack-morgan.jpg`.
- Interrupted mid-build once (carousel HTML was in, CSS/JS were not); resumed and completed.

### 2026-07-09 - Session 1 (later iterations, after client feedback)
- Client said the first hero looked "generic," then that the second attempt "looks elementary /
  sloppy" and did not match usagg.com. Fix that worked: opened the REAL usagg.com in the browser
  and studied the actual hero, then rebuilt to match it faithfully. usagg hero = video left,
  yellow block right with a NEAR-VERTICAL seam, giant word STRENGTH in near-black CHARCOAL
  STRADDLING the seam (left letters ghosted over the video, right letters bold over the block),
  with the rotating phrase OVERLAPPING the giant word, plus a diagonal notch at bottom-right.
  Ours now mirrors this: giant "BUILD" in --navy-deep (#06183F, near-black) centred on the seam
  so it straddles, orange panel with a ~7% slant (near vertical), rotating "PRECISION/CRAFT/
  SCHEDULE/INTEGRITY is how we [BUILD]", corner notch stripes. Earlier version had a steep
  diagonal panel and an isolated loud royal-navy BUILD fully inside the block = the "elementary"
  look. Lesson saved to memory [[jc-wants-reference-matched-motion]].
- Client: "we do NOT do wood framing, we need metal." The framing feature band used a wood-framed
  interior (Pexels 33405084). Replaced with real light-gauge METAL studs + Knauf compound
  (Pexels 29301863). Metal Framing service card is Pexels 5493677 (fastening a metal stud, also
  metal). Good dramatic metal-stud "wall being built" stock is scarce on Pexels; 29301863 is
  accurate and clearly metal but is a materials-on-site shot, not cinematic. Swap when real
  photos arrive (flagged placeholder).
- Mobile hero reworked: dropped the orange wedge; now clean full-bleed video with the headline
  stacked PRECISION / IS HOW WE / BUILD. (a mobile-only `.hero__buildmobile` span; the desktop
  `.hero__giant` and `.hero__panel` are hidden under 980px).
- Client asked again for "Framer / primer motion." Held the line: it needs a React build (breaks
  single-file); delivered GSAP + CSS 3D (hero entrance timeline, per-letter reveal, 3D mouse
  parallax, card tilt, magnetic CTA, photo/ken-burns parallax). Verified: 0 JS errors, reduced
  motion honored, desktop + mobile checked.
- STILL BLOCKED: Jack's real headshot. Client pasted it in chat but it is not on the clipboard or
  anywhere on disk (searched Downloads, Desktop, Pictures, AppData, temp, Claude app cache). Must
  have him SAVE it to `assets\jack-morgan.jpg`, then embed as base64 in the About block.

### 2026-07-09 - Session 1
- Shipped: full single-file website (`index.html`, 114KB) plus `PUBLISHING.md`. Ran the
  mandatory Phase 1 interview; client picked Brand Direction 2 (Jobsite Commercial): brand
  navy #09245F + Barlow Condensed/Barlow + safety-orange (#EA580C decor, #C2410C CTAs for AA).
  Client logo used as-is (client rejected a redrawn monogram); embedded as base64, plus a
  reversed-white variant for dark bars and a favicon cropped from it.
- Content locked from client: contact 16 Rutledge Ave, Greenville SC 29617, (864) 263-7451,
  admin@carolina-partitions.com; domain carolina-partitions.com; painting = equal billing;
  licensed and insured (no number); testimonials = placeholder only; quote form to
  bids@carolina-partitions.com via Formspree; imagery = Pexels stock, flagged placeholders.
- Assets: hero + mid videos and 12 photos sourced from Pexels (API key was 401; harvested URLs
  via headless browser and verified each returns 200). License manifest in an HTML comment.
- Sections built: nav, video hero (rotating headline), trust counters, services grid, why/3
  pillars, mid video band, projects (Founder's Career Highlights, honestly labeled), about Jack,
  residential, Greenville skyline parallax (original SVG with Liberty Bridge nod), contact form,
  footer. GSAP core + ScrollTrigger only. JSON-LD GeneralContractor, OG/Twitter, semantic HTML.
- QA passed: 0 "Brightline", 0 em dashes, 16 placeholder flags, 0 console errors, responsive
  360/1440, mobile hamburger, reduced-motion verified (video hidden, poster shown, headline
  resolved, reveals shown, counters final), form fallback shows guidance until Formspree ID added.
- Learned: playwright blocks file://; serve on localhost:8799. Viewport screenshots hit a
  scroll-reset quirk here; use element-target or scroll-through-then-fullPage. Fixed two bugs:
  `.mobile-wrap` showed on desktop (added base `display:none`), contact card label/value ran
  together (added `display:block`). Mobile nav CTA made compact.
- Next: client does go-live (domain, Formspree, real photos). Lighthouse not run in this offline
  harness (would be run on the live HTTPS site); non-video payload is 114KB, well under the
  1.5MB budget.
