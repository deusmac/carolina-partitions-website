# CAROLINA PARTITIONS — Website Build Brief
### Complete instructions for the coding agent
**Client:** Carolina Partitions LLC, Greenville, South Carolina
**Prepared:** July 2026 · **Owner of this brief:** John (JC Tiempo)
**Read this entire document before writing a single line of code.**

---

## 0. YOUR ROLE AND THE STANDARD YOU'RE HELD TO

You are acting as a senior brand designer + creative developer — the kind whose agency would charge $15,000–30,000 for this site. You are building the public face of a re-launched commercial drywall contractor. The bar is: a general contractor's project manager lands on this site to check us out before awarding a $150,000 subcontract, and within 10 seconds concludes *"these people are serious."* Simultaneously, a Greenville homeowner lands on it and feels welcome, not intimidated.

You have creative authority over layout, motion, and visual details. You do NOT have authority over facts, claims, brand identity direction, or scope — those are locked in this brief or resolved in the interview phase (Section 1).

**Final deliverable (non-negotiable):**
1. **ONE single, complete, self-contained HTML file** — all CSS and JavaScript inline or embedded. No build step, no framework runtime, no external CSS/JS files. External requests are allowed ONLY for: Google Fonts, hosted stock video files, and the form endpoint. The file must open perfectly from a double-click on a local machine.
2. **A `PUBLISHING.md` instruction file** — plain-language, step-by-step instructions for a non-developer to put this file live on a custom domain (see Section 10 for exactly what it must cover).

---

## 1. PHASE ONE — INTERVIEW THE CLIENT FIRST (MANDATORY)

Do not start designing. Ask the client (John) these questions **one at a time**, and keep asking follow-ups until you are confident you have everything. If an answer is vague, push for specifics. Only when you can answer "yes" to *"could I build this site with zero further input?"* do you proceed.

**Required questions (ask all of these):**

1. **Logo & brand assets.** "Send me the existing Carolina Partitions logo and letterhead files. I will design a refreshed identity inspired by them — you approve the refresh before I build." (The client has confirmed the brand should be REFRESHED, not copied as-is. Propose 2–3 palette/logo-treatment directions derived from the old identity and get sign-off.)
2. **Contact details.** "Confirm the exact phone, email, and address to publish. Public listings show (864) 263-7451 / admin@carolina-partitions.com / 16 Rutledge Ave, Greenville, SC 29617 — are these current, or do you have a new number/email/address?" **Do not publish unverified contact info.**
3. **Domain.** "What domain will this live on? (e.g., carolina-partitions.com, carolinapartitions.com — is it already owned?)" This affects the publishing instructions.
4. **Project photos.** "Do you have real photos of past projects (Best Buy, the Hobby, Woodlands, Stone Cottage, or Jack's career projects)? Real photos always beat stock. Send everything; I'll pick." If none exist, use stock per Section 6 and clearly mark each as `<!-- PLACEHOLDER: replace with real project photo -->`.
5. **Service area.** "Confirm the service radius to state: Greenville / Spartanburg / Anderson / Upstate SC? Anything beyond?"
6. **Painting.** "Painting is confirmed as an offered service — should it get equal billing with drywall/framing/acoustical, or be listed as a supporting service?" (Client has said include it; weight is their call.)
7. **Licensing/insurance lines.** "What can I truthfully print? 'Licensed and insured' requires both to be current. Give me exact license wording if any." **Never print a compliance claim the client hasn't confirmed.**
8. **Testimonials.** "Do you have any real, attributable quotes from GCs or clients? I will not fabricate testimonials — if none exist, the site ships without a testimonial section, replaced by the project gallery."
9. **Form destination.** "What email should quote requests go to?"
10. **Anything to avoid.** "Any companies, projects, or names that must NOT appear on this site?" (Also see the hard rule in Section 2.)

---

## 2. HARD RULES — VIOLATIONS ARE BUILD FAILURES

1. **Zero mention of Brightline** — not the name, not "our parent company," not links to brightlinepainting.net or brightlinecontracting.net, not shared photography, not copied text. Carolina Partitions is a fully standalone, family-owned company. This is a strict legal/brand requirement. (You may privately study Brightline's site as a *quality* benchmark only.)
2. **No fabricated facts.** No invented testimonials, no made-up client names, no fake statistics, no "award-winning" claims, no invented years-in-business. Every claim traces to Section 4's approved content or the client's interview answers.
3. **Honest project attribution.** Jack's career highlights (Cabela's, Peace Center, Gatlinburg Aquarium, etc.) predate Carolina Partitions. Present them as **"Founder's Career Highlights — projects led by Jack Morgan across 37+ years"**, never as "Carolina Partitions projects." Carolina-entity work and sector experience are presented separately.
4. **No dark patterns**: no fake urgency, no fake review counts, no countdown timers.
5. **Single HTML file** discipline per Section 0.
6. Placeholder content of any kind must be wrapped in an HTML comment flag so the client can find every instance: `<!-- PLACEHOLDER -->`.

---

## 3. POSITIONING & AUDIENCE (LOCKED — DO NOT REINTERPRET)

**Primary audience:** project managers and superintendents at Upstate SC commercial GCs evaluating Carolina for negotiated interior packages ($30K–$250K). They skim: capability, track record, scope list, responsiveness signal, contact.
**Secondary audience:** Upstate homeowners and small-property owners needing drywall/framing/ceiling/painting work. They need warmth, clarity, and an easy "get a quote" path.

**The balance the client asked for, verbatim in spirit:** *appeal to small-scale homeowners WITHOUT looking like a small-scale contractor.* Translation: the site's visual weight, portfolio, and language project commercial-grade capability; the navigation and CTAs make residential customers feel explicitly served. A "Residential" service path exists and is friendly; the overall aesthetic is big-league.

**Positioning line (use as the thematic north star, adapt wording freely):**
> *The drywall and interiors contractor Upstate GCs have trusted for decades — small enough that the owner walks your job, seasoned enough to hit the number.*

**One claim the site must communicate over and over:** finished right, on schedule, clean paperwork. Reliability is the brand.

---

## 4. APPROVED CONTENT INVENTORY (the facts you may build with)

### Company
- Legal name: **Carolina Partitions LLC** — family-owned, Greenville, South Carolina. Entity founded 2018; being re-launched 2026.
- Team experience: **45+ years combined**; founder **Jack Morgan, 37+ years** in the trade, born and raised in Greenville, started at age 16.
- Tagline candidates (pick/refine one in the brand proposal): "Discover the Difference" (Carolina's historical line — preferred starting point); or craft an original alternative around reliability/finish quality.
- Sectors served: retail, industrial, healthcare, office, religious facilities, multifamily, hospitality, education — plus residential.
- Values: quality workmanship, integrity, on-time completion, clean close-out.

### Services (exactly these — do not add scopes)
| Service | Notes for copy |
|---|---|
| **Drywall / Gypsum Wall Assemblies** | Core trade. Hanging, finishing, Level 1–5 finishes, repair. Commercial & residential. |
| **Metal Stud Framing** | Light-gauge framing, partitions, soffits, furring. |
| **Acoustical Ceilings** | Grid & tile, specialty ceilings. |
| **Painting** | Interior/exterior, commercial & residential (weight per interview Q6). |
| Supporting mentions allowed: insulation within wall assemblies, drywall repair, popcorn ceiling removal (residential-friendly). | |

### Founder's Career Highlights (label per Hard Rule 3)
- (6) Cabela's stores — Charlotte, Greenville, Acworth, Ft. Mill, Garner, Augusta
- Peace Center, Greenville SC (original construction and remodel) — Greenville's landmark performing-arts center; feature this prominently, it is a hometown credibility anchor
- Gatlinburg Aquarium — Gatlinburg, TN
- Spartanburg Regional Medical Office Building — Spartanburg, SC
- Poinsett Plaza — Greenville, SC
- Captain's Quarters — Myrtle Beach, SC

### Contact (VERIFY in interview before publishing — see Q2)
- Phone: (864) 263-7451 · Email: admin@carolina-partitions.com · Greenville, SC 29617
- Service area: Greenville, Spartanburg, Anderson & Upstate SC (confirm Q5)

### Voice & copy rules
- Confident, plainspoken, tradesman-honest. Short sentences. No corporate filler ("solutions," "synergy"), no exclamation marks, no "we pride ourselves."
- GC-facing sections may use trade language (scopes, schedules, close-out). Homeowner-facing sections translate it ("walls that look perfect under any light").
- Write ALL copy yourself to final quality. No lorem ipsum anywhere.
- **House style for all on-page copy (the client's standing rule): no em dashes (use commas, periods, or parentheses instead), no emojis anywhere in the UI, and write the phone number without a leading plus sign. Use SVG icons only, never emoji icons. This applies to visible text, alt text, and code comments.**

---

## 5. DESIGN DIRECTION

### 5.1 The style target
The client's #1 reference is **usagg.com** (US Aggregates). Study it. What to take from it — rebuilt in Carolina's own branding, never copied:
- **Full-bleed background video hero** with a slow, cinematic loop and a dark gradient overlay.
- **Rotating hero headline**: a fixed sentence stem with a cycling word — theirs is "Safety Is Our / Teamwork Is Our / Reliability Is Our → STRENGTH." Build Carolina's own version, e.g. cycling **"Precision / Craft / Schedule / Integrity"** resolving into **"…Is How We Build."** (Write a better one if you can.)
- **Diagonal accent stripes / angled section dividers** as a recurring geometric motif.
- **Icon-driven services grid** with hover states and short blurbs → anchor links.
- **Scroll-triggered reveals** on every section (fade+rise, staggered children).
- **A second full-bleed video section** mid-page (culture/craft moment).

Secondary references — take the *feel*, not layouts: **harperconstruction.com** (institutional gravitas, big project photography), **bhdesignbuild.com** (refined typography, whitespace), **candmhomebuilders.com** (residential warmth).

### 5.2 The Greenville skyline element (client specifically requested — required)
Jack and John love the Greenville, SC skyline. Include a signature **custom SVG skyline silhouette of downtown Greenville** — recognizable elements: the Landmark/One City Plaza towers, Bank of America tower, the Westin Poinsett, and ideally a stylized nod to the Liberty Bridge at Falls Park (its curved suspension form is iconic and instantly "Greenville"). Uses:
- As a **parallax silhouette band** in the footer or a "Proudly Greenville" section — layered SVG (2–3 depth layers) shifting subtly on scroll.
- Optionally echoed as a thin decorative divider motif elsewhere.
- Draw it yourself as original SVG art in the brand palette. Do not trace a copyrighted photo or copy an existing vector product.

### 5.3 Brand system (you propose, client approves — interview Q1)
- Derive 2–3 refreshed directions from the old Carolina logo/letterhead the client sends. Anchor expectations: an Carolina-blue/steel palette with a single warm accent tends to fit; but let the real assets decide. Deliver: palette (CSS custom properties), type pairing, logo treatment (refined wordmark acceptable if original logo is low-res).
- Typography via Google Fonts: a characterful display face for headlines (e.g., a strong condensed or slab — think Archivo Expanded, Oswald, or Fraunces depending on direction) + a clean humanist body face (e.g., Inter, Source Sans 3). Max two families.
- Design tokens: define ALL colors/spacing/type-scale as CSS variables at the top of the file so the client can retheme easily.

**Default token set (use this as the starting anchor unless the client's real logo/letterhead in Q1 pulls a different direction). This is a vetted, on-industry system, not generic AI defaults:**

Palette (industrial steel with a single safety-orange accent):
- `--color-primary: #64748B` (steel slate)
- `--color-secondary: #94A3B8` (lighter steel)
- `--color-accent: #EA580C` (safety orange, contrast-tuned, used only for CTAs and key highlights)
- `--color-background: #F8FAFC` (near white)
- `--color-foreground: #334155` (body text, passes 4.5:1 on the background)
- `--color-muted: #EBF0F5`, `--color-border: #E2E8F0`
- Deep base for hero overlay and footer: near-black steel `#1E293B`.
- Provide a full dark variant of every token. The hero and mid-page video bands read as dark by default.

Typography (free, Google-hosted, two families max, satisfies the "characterful condensed display" instinct above):
- Display/headlines: **Barlow Condensed** (500/600/700). Industrial, condensed, reads commercial-grade at large sizes.
- Body/UI: **Barlow** (300/400/500/600). Same family, humanist, clean, keeps you to one type system.
- Import: `@import url('https://fonts.googleapis.com/css2?family=Barlow+Condensed:wght@500;600;700&family=Barlow:wght@300;400;500;600;700&display=swap');`
- If brand approval leans refined/editorial rather than industrial, an approved alternate is Bodoni Moda (display) + Jost (body). Never exceed two families.

Hard "do not" for the visual system (anti-slop): no AI purple/pink gradients, no flat 2D-only card grids with no depth, no low-quality or watermarked imagery, no emoji standing in for icons.

### 5.4 Motion design specification
- Library: **GSAP + ScrollTrigger via CDN** (or equally capable, but GSAP is the default choice). Everything else vanilla JS.
- Hero: video fade-in; headline words cycle with a masked slide/flip every ~2.5s; scroll cue.
- Sections: `ScrollTrigger` reveals — opacity 0→1, translateY 40→0, 0.08s stagger on children. Once, not scrub (except parallax layers).
- Counters: animated count-up on stats (years, sectors, projects) when scrolled into view.
- Portfolio cards: hover lift + image scale 1.05, smooth.
- Skyline: scroll parallax at 2–3 speeds.
- Nav: transparent over hero → solid with shadow after 80px scroll; smooth-scroll anchors.
- **Restraint rule:** motion supports content; nothing bounces, spins, or autoplays audio. Every animation ≤ 0.8s. Honor `prefers-reduced-motion: reduce` by disabling all non-essential motion and video autoplay.

**Concrete motion implementation notes (bake these in so the animation is smooth and premium, not janky):**

- **License landmine, important: use only free GSAP.** GSAP core and ScrollTrigger are free. Do NOT use SplitText, MorphSVG, or any other GSAP Club/paid plugin. The single-file deliverable must ship with zero paid dependencies. For the rotating hero headline and any per-word effect, use a small vanilla span-swap plus CSS transforms, not SplitText.
- **Rotating hero headline (free approach):** render the cycling words as stacked spans inside a fixed-height, `overflow: hidden` mask; every ~2.5s translateY the current word out and the next in with a GSAP tween (`power3.inOut`, ~0.5s). Resolve to the fixed final word ("...Is How We Build") and stop. No paid plugin needed.
- **Scroll reveals (use this exact pattern):** `gsap.from(el, { opacity: 0, y: 12, duration: 0.35, ease: 'power1.out', scrollTrigger: { trigger: el, start: 'top 90%', toggleActions: 'play none none reverse' } });` Keep y small (8 to 16px) so it reads as a confident fade, not a slide. Stagger children ~0.08s.
- **Skyline parallax (signature moment):** batch 2 to 3 SVG depth layers under one ScrollTrigger, `scrub: 0.5`, vary speed per layer (`yPercent` roughly -6 / -10 / -14, background slowest). Wrap in `overflow: hidden`. Put `will-change: transform` only on the moving layers. Never parallax text.
- **Counters:** count-up on the trust-bar stats when scrolled into view, once, ~1.2s, ease-out. Under reduced-motion, render the final number instantly.
- **prefers-reduced-motion:** when reduce is set, reveals render final-state, the hero video is replaced by its poster, and the headline shows the resolved final line with no cycling.

**Pick three signature moments and make them flawless, rather than animating everything equally.** Recommended: (1) the hero headline resolve, (2) the Greenville skyline parallax band, (3) one tactile hover on the project cards (lift plus 1.05 image scale, 200ms, ease-out). Everything else is quiet scroll-reveal support. This is how a high-end site reads as "cool": a few perfect moments, not constant motion.

### 5.5 The anti-slop standard (how to actually hit the quality bar)

The single biggest risk is that this comes back looking like a generic AI-generated template. Guard against it:

- **If you (the coding agent) have design skills installed, use them.** In particular: `ui-ux-pro-max` for design-system tokens, palette, font pairings, and per-stack UX rules (run its `search.py --design-system` and `--domain gsap` / `--domain ux`); `frontend-design` and `design-taste-frontend` for distinctive, non-templated layout; `design-motion-principles` or `motion-design` for animation quality; and run `impeccable` as a final audit pass to catch anti-patterns before delivery. If you do not have these skills, the concrete tokens, fonts, and motion snippets already baked into Sections 5.3 and 5.4 stand on their own. Follow them directly.
- **Slop tells to avoid on sight:** centered-everything single-column layouts, three identical rounded cards each with a thin-line icon and one sentence, purple/blue gradient hero, glassmorphism used for no reason, uniform section rhythm with no hero moment, stock handshake photos, exclamation-heavy copy. If a section looks like every other AI landing page, redesign it.
- **What "premium" actually means here:** real typographic hierarchy (a genuine display scale, not everything at 18px), generous and intentional whitespace, one confident accent color used sparingly, asymmetry and depth where it earns attention, photography-forward sections, and the three signature motion moments landing perfectly. Study the usagg.com reference for restraint, not decoration.
- **Ship an audit note in the handoff:** list the specific choices that keep this off the AI-slop path (the token system, the type scale, the three signature moments, the anti-patterns you deliberately avoided).

---

## 6. VIDEO & IMAGERY SOURCING

Custom brand videos don't exist yet, so source **free, commercially-licensed stock** that reads as premium:
- Sources (all free for commercial use, no attribution required — but record the license/URL of every asset in a comment block at the bottom of the HTML): **Pexels Videos, Coverr, Mixkit, Pixabay Video**.
- Search terms that find the right footage: *"drywall installation," "drywall taping," "construction interior," "metal stud framing," "construction worker slow motion," "commercial construction site," "putty knife wall," "painter roller wall," "construction timelapse interior."*
- Selection bar: slow, deliberate camera movement; clean modern jobsites; workers with PPE; interior trades (NOT excavators/cranes — we are interiors). Warm or neutral grade. 10–30s loops. Compress/serve at ≤ 1080p; use the CDN-hosted mp4 URL or instruct the client to self-host (note in PUBLISHING.md).
- Hero video: `autoplay muted loop playsinline` + **poster image fallback** + static image replacement under `prefers-reduced-motion` and on data-saver.
- Photos: same sources (Pexels/Unsplash/Pixabay); every stock image gets the `<!-- PLACEHOLDER: replace with real project photo -->` flag. Real project photos from interview Q4 always win.

---

## 7. SITE STRUCTURE (single page, anchored sections)

One long-scroll page with anchor navigation (matches the single-file deliverable). Order:

1. **Nav** — logo left; anchors: Services, Projects, About, Residential, Contact; phone number + "Request a Quote" button right (always visible).
2. **Hero** — full-bleed video, rotating headline, subline (*"Commercial drywall, framing & interiors — Greenville, SC"*), dual CTAs: **"Request a Quote"** (primary) and **"See Our Work"**.
3. **Trust bar** — animated stats: 37+ years founder experience · 45+ years team experience · 8 sectors served · Greenville born & raised.
4. **Services** — icon grid (usagg-style) for Drywall, Metal Framing, Acoustical Ceilings, Painting; each expands or anchors to a short detail block with commercial + residential framing.
5. **Why Carolina / The Difference** — three pillars: *The owner walks your job* · *Priced right, built right, finished on time* · *Clean paperwork, clean close-out*. This is the positioning section; write it tight.
6. **Mid-page video band** — craft close-ups (taping, finishing), one strong statement line over it.
7. **Projects** — "Founder's Career Highlights" gallery: cards for Peace Center, Cabela's (×6), Gatlinburg Aquarium, Spartanburg Regional MOB, Poinsett Plaza, Captain's Quarters, labeled honestly per Hard Rule 3; sector-experience strip (retail, healthcare, office, religious, multifamily, industrial, hospitality, education).
8. **About / Jack** — Jack Morgan's story: Greenville native, in the trade since 16, 37 years, family-owned company. Human, warm, brief. Photo placeholder.
9. **Residential section** — explicitly welcoming: drywall repair, popcorn ceiling removal, painting, "no job too small — built to the same commercial standard." Own CTA.
10. **Greenville skyline band** — the parallax SVG skyline + "Proudly built in Greenville, South Carolina" + service-area list.
11. **Contact / Quote form** — name, email, phone, "I am a…" (GC/Business | Homeowner), project description, preferred contact. Static-site form endpoint: **Formspree** (default; free tier) or Netlify Forms if deployed there — implement Formspree and document both in PUBLISHING.md. Also show phone + email prominently (many GCs just call).
12. **Footer** — logo, NAP (name/address/phone), service areas, anchor links, © Carolina Partitions LLC 2026.

---

## 8. TECHNICAL REQUIREMENTS

- Semantic HTML5; single file per Section 0. GSAP/ScrollTrigger from cdnjs/jsDelivr.
- **Responsive**: flawless at 360px, 768px, 1024px, 1440px, 1920px. Mobile nav = accessible hamburger. Test hero video on mobile (playsinline; fallback poster).
- **Performance budget**: Lighthouse ≥ 90 performance / ≥ 95 accessibility & SEO / ≥ 95 best practices (desktop). Lazy-load all below-fold media; `font-display: swap`; poster images; total non-video payload < 1.5 MB.
- **Accessibility (WCAG 2.1 AA)**: contrast ≥ 4.5:1 body text; visible focus states; alt text on every image; form labels + error states; keyboard-navigable nav and gallery; `prefers-reduced-motion` honored.
- **SEO / Local SEO**: title *"Carolina Partitions | Commercial Drywall, Framing & Acoustical Ceilings | Greenville, SC"*; meta description; OpenGraph + Twitter cards; JSON-LD `LocalBusiness` (a `GeneralContractor` subtype) with verified NAP, geo, service area, `sameAs` for LinkedIn/Facebook; h1 exactly once; descriptive anchor headings containing service + geography keywords naturally.
- Favicon: inline SVG (monogram from the refreshed logo).
- No console errors; no mixed-content; every external asset HTTPS.

---

## 9. QA CHECKLIST (run before delivery; include the completed checklist in your handoff message)

- [ ] Interview complete; all 10 questions answered and reflected in the build
- [ ] Brand refresh proposed and client-approved before final build
- [ ] Zero occurrences of the string "Brightline" anywhere in the file (search it)
- [ ] All claims traceable to Section 4 or interview answers; project labels honest
- [ ] Every placeholder flagged with `<!-- PLACEHOLDER -->`; count reported to client
- [ ] Asset license manifest present in HTML comment (source URL + license per video/photo)
- [ ] Works from double-click locally (file://) — including graceful form fallback message
- [ ] Responsive at all five breakpoints; hero video behaves on iPhone Safari
- [ ] `prefers-reduced-motion` verified
- [ ] Lighthouse scores meet Section 8 budget — report the numbers
- [ ] Form tested end-to-end to the client's email
- [ ] Rotating headline, skyline parallax, scroll reveals, and counters all functioning
- [ ] Zero paid dependencies: no GSAP Club/paid plugins (SplitText, MorphSVG, etc.); GSAP core + ScrollTrigger only
- [ ] On-page copy follows house style: no em dashes, no emojis, phone number without a leading plus sign, SVG icons only
- [ ] Anti-slop audit note included in handoff (token system, type scale, three signature moments, patterns avoided)

---

## 10. PUBLISHING.md — WHAT IT MUST CONTAIN

Written for a non-developer (Jack or John), plain language, numbered steps, ~2 pages:

1. **What you have**: one HTML file; what it is; how to preview it locally.
2. **Buy/confirm the domain**: registrar walkthrough (Namecheap or Cloudflare Registrar), typical cost (~$10–12/yr), privacy protection on.
3. **Host it free — two options, both step-by-step**:
   - **Option A (recommended): Netlify Drop** — drag-and-drop the file (renamed `index.html`), then connect the custom domain: add domain in Netlify → set the two DNS records at the registrar (exact record types/values explained) → HTTPS auto-provisions. Include what "DNS propagation" means and the 5min–48h wait.
   - **Option B: Cloudflare Pages or Vercel** — equivalent steps, briefer.
4. **Activate the quote form**: create the free Formspree account, get the endpoint ID, where in the HTML to paste it (point to the marked line), test it.
5. **Replacing placeholders later**: how to find every `<!-- PLACEHOLDER -->`, swap a stock photo for a real one, and re-upload (drag-and-drop again = redeploy).
6. **Email on the domain (optional next step)**: pointer that admin@ addresses need mail hosting (e.g., Microsoft 365 already planned) — DNS MX records set at the same registrar.
7. **Checklist for go-live day** and a troubleshooting box (site not loading? form not sending? video not playing on phone?).

---

## 11. HANDOFF FORMAT

Deliver back to the client:
1. `index.html` (the complete site)
2. `PUBLISHING.md`
3. A short summary message: brand decisions made, placeholder count and locations, Lighthouse scores, the completed QA checklist, and the top 3 things the client should replace with real content first (almost certainly: project photos, Jack's portrait, and any interim contact details).

Build something Jack will want to show off. The company is being reborn — the website should look like it never left.

*— End of brief —*
