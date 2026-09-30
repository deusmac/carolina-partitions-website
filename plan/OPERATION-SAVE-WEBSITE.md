# OPERATION SAVE WEBSITE - Master Redesign Brief

> Execution brief for the agent performing the Carolina Partitions redesign.
> Written 2026-07-11 after a full design audit. Read this file top to bottom
> before writing a single line of code. Companion files: `DESIGN.md` (the
> design system, the visual source of truth) and `AUDIT.md` (why each change
> exists). The plan follows the Claude Design Masterclass methodology:
> design system first, references not adjectives, negatives up front,
> one change per phase, verify visually between phases.

---

## 1. Mission and standard

You are acting as a senior brand designer and creative developer whose agency
would charge 15,000 to 30,000 dollars for this site. The bar:

- A general contractor's project manager lands on the site and within
  10 seconds concludes "these people are serious."
- The site holds its own next to awwwards-level motion sites, not just next
  to other contractor sites.
- The client's one-line verdict target: "this looks awesome."

The client's number one structural reference is usagg.com. The current site
already copies its hero structure. What is missing is its drama: cinematic
footage, dark and bold value rhythm, diagonal cuts everywhere, mega type.
That gap is what this operation closes.

## 2. Read-first list (in order, before any code)

1. Project `CLAUDE.md`, sections 0 (state), 2 (rules), 9 (history). The
   changelog explains every client decision to date. Do not re-litigate them.
2. `plan/DESIGN.md`. Every visual choice you make must trace to it.
3. `plan/AUDIT.md`. Explains the intent behind each phase below.
4. Open https://usagg.com/ in the browser and study, live: the hero seam,
   how every section edge is cut diagonally, the value rhythm (dark, color
   block, full-bleed photo), and the mega type. Do not skip this step.

## 3. Hard constraints (negatives up front, violations are build failures)

1. Zero occurrences of the string "Brightline" anywhere, ever. No shared
   photography with any Brightline property. Legal requirement.
2. ONE self-contained HTML file. External requests allowed only for:
   Google Fonts, stock CDN media (videos/images), the Formspree endpoint,
   and the GSAP CDN. Must open perfectly from a file:// double-click.
3. Free GSAP core + ScrollTrigger only. No SplitText, no MorphSVG, no paid
   plugins, no React, no Framer Motion (client asks for "Framer motion"
   periodically; the answer is GSAP + CSS 3D, already explained to him).
4. The client's real logo (`assets/logo-white.png`, `assets/logo-navy.png`)
   is used exactly as-is. Never redraw, regenerate, trace, or recolor it.
5. Jack Morgan's embedded headshot (base64 in the About section) stays.
6. No fabricated facts, testimonials, license numbers, or claims. Project
   labels stay honest: "Founder's Career Highlights, projects led by Jack
   Morgan," never "Carolina Partitions projects."
7. House style in ALL output including comments and docs: no em dashes,
   no emojis, phone numbers without a leading plus, SVG icons only.
8. Every stock asset keeps/gets an `<!-- PLACEHOLDER -->` flag and a license
   line in the manifest comment at the bottom of index.html.
9. Non-video payload stays under 1.5MB. Current file is ~204KB; the budget
   is not an excuse to bloat.
10. `prefers-reduced-motion` must remain fully honored: video hidden with
    poster shown, reveals rendered final-state, counters instant, carousel
    degrades to native horizontal scroll. Zero console errors at all times.
11. Palette is LOCKED to Direction 3 (see DESIGN.md). Fix dullness with
    value contrast and drama, never with new hues.
12. No dark patterns: no fake urgency, no fake review counts, no countdown
    timers (original build brief hard rule 4).

## 4. Phased execution

One concern per phase. Each phase ends with: screenshot the affected
section at desktop 1440 and mobile 390, compare against DESIGN.md, fix
regressions, and only then continue. Never stack a new phase on an
unverified one. If a phase fails twice, revert it cleanly before retrying
(never stack failed attempts).

### Phase 0 - Harness and baseline
- Serve the project: `node /tmp/serve.js "<projectdir>"` on port 8799
  (playwright blocks file://). Write the serve script if missing; see
  CLAUDE.md section 0 for the known pattern.
- Capture "before" screenshots of every major section, desktop 1440 and
  mobile 390, into `plan/before/`. These anchor the final before/after.

### Phase 1 - Cinematic footage sourcing (highest impact, do first)
- Goal: replace the two boring clips. Hero is currently Pexels 6474251
  (man standing still, no cinema). Mid-band is 34572297 (flat texture).
- Hunt Pexels, Coverr, Mixkit, and Pixabay Video for:
  - HERO: a dramatic interior-trades loop. Ideal: slow motion drywall
    taping/sanding with raking light and visible dust, or an interior
    build-out timelapse, or a slow dolly through a framed-out commercial
    interior. Landscape, 1080p, 10 to 30 seconds.
  - MID-BAND: a second craft close-up loop with motion (mud being pulled,
    a sander throwing dust in light).
- Selection bar and rejection list are in DESIGN.md section "Imagery art
  direction." Metal studs only, never wood framing. No excavators/cranes.
- Verify every candidate URL returns HTTP 200, view actual frames (download
  poster/thumbnail and look at it) before committing. Record license URL
  for each asset in the manifest comment.
- Swap the hero and band sources and posters. Keep `autoplay muted loop
  playsinline` + poster + reduced-motion fallback wiring intact.

### Phase 2 - Global drama pass (value rhythm, dividers, mega type)
- Re-sequence value rhythm so dark moments are distributed through the
  whole page, target rhythm top to bottom:
  dark (hero) > dark (stats) > LIGHT (services) > dark (framing band) >
  dark (how-we-build) > dark full-bleed (projects, changes in Phase 5) >
  LIGHT (about) > LIGHT (residential) > dark (skyline) > LIGHT (contact) >
  dark (footer).
- Add diagonal section dividers: a reusable `.cut-top` / `.cut-bottom`
  clip-path (about 3.5deg) applied so each major band transition is a
  diagonal cut, per usagg. Spec in DESIGN.md.
- Push section headers to the new `--step6` mega scale (see DESIGN.md
  typography). Headers should feel like usagg, not like a brochure.
- Add ghost watermark words behind key sections (SERVICES, PROJECTS,
  GREENVILLE): uppercase Barlow Condensed, 10 to 14vw, 4 to 6 percent
  opacity, absolutely positioned behind content, `aria-hidden="true"`,
  clipped by the section's `overflow:hidden`.

### Phase 3 - Hero cinema
- Drop in the Phase 1 hero footage.
- Add a very slow Ken Burns scale on the video element: 1.0 to 1.06 over
  about 20s, alternating, GSAP tween, disabled under reduced motion.
- DO NOT touch the approved hero structure: near-vertical seam, clay
  panel, giant near-black BUILD straddling the seam, rotating word
  (PRECISION/CRAFT/SCHEDULE/INTEGRITY), corner notch, entrance timeline,
  3D mouse parallax, mobile stacked variant. Those are client-approved.

### Phase 4 - Services redesign (kill the 2x2 identical grid)
- Replace the four identical cards with an asymmetric editorial layout:
  numbered rows 01 to 04, giant index numerals (--step6, ghost-tinted),
  service name in mega type, short blurb, and a photo that expands or
  reveals on hover (clip-path or width expansion, 0.5s power3.inOut).
  Feature Drywall (the core trade) with the largest row.
- Keep the existing four service photos unless Phase 1 hunting surfaced
  obviously better ones. Keep "Commercial & Residential" tags.
- Mobile: rows stack cleanly, numerals scale down, no hover dependency
  (photos visible by default on touch).

### Phase 5 - Projects stage upgrade
- Move the existing 3D coverflow carousel (mechanism is client-approved,
  do not rebuild it) onto a full-bleed deep-navy band with a ghost
  PROJECTS watermark and clay accents. Cards should pop against dark.
- Add a soft glow/reflection under the center card (CSS, cheap).
- Convert the static sector-chip strip into a slow continuous marquee
  (GSAP loop, duplicate content technique, pause on hover, static row
  under reduced motion).
- Keep the honest-labeling disclaimer text visible on the dark bg
  (adjust its color for contrast).

### Phase 6 - Signature scroll moment: "How we build" (centerpiece)
- Replace/restyle the current Why pillars section as a pinned, scrubbed
  3-step sequence: 01 FRAME (plumb and square) > 02 HANG AND FINISH
  (Level 5 under any light) > 03 CLOSE OUT (clean paperwork, clean site).
- ScrollTrigger: pin the section, scrub about 0.6, steps transition with
  clip-path wipes and number swaps as the user scrolls through.
- Reuse the three pillar copy blocks (already client-approved words).
- Reduced motion and mobile-short-viewport fallback: unpinned, three
  stacked steps, fully readable. Test the pin math at 768px height.
- This is one of the three signature moments (DESIGN.md motion doctrine);
  it must be flawless before moving on.

### Phase 7 - Atmosphere polish
- Skyline band: dusk gradient (deep navy to warm horizon glow at the
  skyline line), a few subtle stars (tiny SVG circles, slow twinkle,
  static under reduced motion), slightly slower parallax speeds.
- About and Residential photos: clip-path reveal wipes on scroll-in
  (inset 100 percent to 0, 0.9s power3.inOut) instead of plain fades.
- Stats bar: diagonal top edge (cut-top), faint blueprint-grid texture
  (repeating-linear-gradient, about 4 percent white) behind the cells.
- Nav: keep behavior; verify contrast against the new hero footage.

### Phase 8 - QA gate and handoff (mandatory, the operation is not done
without this)
- Guards: `grep -io brightline index.html | wc -l` must be 0; em dash
  count 0; report placeholder count; file size reported (non-video budget
  under 1.5MB); zero console errors on a fresh load.
- Reduced-motion pass: emulate and verify every fallback listed in
  constraint 10.
- Responsive pass at 360, 768, 1024, 1440, 1920. Mobile is not optional;
  the client checks his phone.
- Before/after screenshot pairs for every changed section into
  `plan/after/`, compared side by side.
- Update project `CLAUDE.md`: section 0 cold-start briefing to the new
  truth, changelog entry with what shipped/learned/next.
- Handoff summary to the client: what changed per phase, the anti-slop
  audit note (type scale, value rhythm, signature moments, patterns
  avoided), placeholder count, and the reminder that real project photos
  will beat stock everywhere they exist.

## 5. Verification quirks (read before debugging "bugs")

- playwright blocks file://. Serve on localhost:8799.
- The projects carousel runs a continuous `gsap.ticker` callback that
  `gsap.globalTimeline.pause()` does NOT stop. fullPage screenshots can
  therefore time out waiting for "stable." Use per-section viewport
  screenshots, or element-target screenshots.
- Do not pause `gsap.globalTimeline` to stabilize screenshots: it freezes
  the rotating hero word mid-fade and produces a fake "overlapping text"
  bug in the capture. A fresh page load renders correctly.
- Viewport screenshots in this harness sometimes fire after a scroll
  reset. Scroll through the page first (fires the reveals), then target
  the section you need.
- The Pexels MCP key returns 401 in this environment. Harvest asset URLs
  by driving the headless browser over pexels.com search pages and verify
  each URL with curl. The pattern is documented in auto-memory
  (stock-asset-sourcing-pexels-browser) and CLAUDE.md section 9.

## 6. Definition of done

All eight phases verified, all guards green, before/after pairs captured,
CLAUDE.md updated, handoff summary written. The client should be able to
double-click index.html and immediately see a dramatically bolder,
motion-rich site that still opens instantly, still passes every hard rule,
and still runs from one file.
