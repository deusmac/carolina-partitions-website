# AUDIT.md - Why the current site reads dull (2026-07-11)

> Full design audit of index.html as of 2026-07-11, based on complete
> desktop (1440) and mobile (390) screenshot passes of every section.
> This file explains INTENT so the executing agent understands why each
> phase of OPERATION-SAVE-WEBSITE.md exists, not just what to do.
> Client verdict driving this audit: "so dull, so boring... nowhere near
> the US Aggregates website... I'm looking for animations and great
> looking pictures."

## The one-paragraph diagnosis

The site is structurally correct (it copies usagg's hero anatomy, has a
3D carousel, real brand assets, clean QA) but it is emotionally flat.
The footage is static, the page spends most of its scroll on warm
off-white with identical section skeletons, the display type never gets
big enough to feel confident, the diagonal brand motif appears twice
instead of everywhere, and the motion vocabulary is one uniform fade-up.
usagg feels dramatic because of value contrast, mega type, diagonal
cuts, and moving footage; we currently have the anatomy without the
adrenaline.

## Per-section findings

| # | Section | Severity | Finding | Fixed in phase |
|---|---------|----------|---------|----------------|
| 1 | Hero footage | CRITICAL | Pexels 6474251 is a locked-off shot of a man standing still. Zero motion energy. The single biggest dullness contributor; no CSS fixes boring footage. | 1, 3 |
| 2 | Mid-band footage | HIGH | 34572297 is a flat wall-texture close-up. Reads as a gray rectangle at band size. | 1 |
| 3 | Page value rhythm | CRITICAL | Services, About, Residential, Contact are all light-on-off-white with near-identical eyebrow+h2+grid skeletons. All dark moments cluster in the page's second half. Long light runs = the "brochure" feel. | 2 |
| 4 | Section transitions | HIGH | Every band meets the next at a flat horizontal seam. usagg cuts nearly every edge diagonally; the diagonal is also Carolina's hero motif, so its absence elsewhere reads inconsistent. | 2 |
| 5 | Type scale | HIGH | Section headers cap around 3.1rem. usagg headers are mega-scale. Nothing mid-page has display-level presence; no ghost/watermark type exists. | 2 |
| 6 | Services grid | HIGH | Four identical rounded cards with icon+blurb: the exact "AI slop" pattern the original build brief bans. Photos are accurate but the presentation is template-grade. | 4 |
| 7 | Projects stage | MEDIUM | The 3D coverflow itself is good (client-approved) but floats on plain off-white; cards would pop on deep navy. Sector chips sit in a static row. | 5 |
| 8 | Why pillars | MEDIUM | Three near-identical bordered cards on navy. Copy is good (client-approved), presentation is inert. Best candidate for the site's missing scroll-storytelling moment. | 6 |
| 9 | Stats bar | LOW | Rebuilt with count-ups and bigger numerals, but still four flat cells with a straight top edge and no texture. | 7 |
| 10 | Skyline band | LOW | Signature SVG works, but flat navy sky. A dusk gradient, faint stars, and slower parallax would make it a poster moment. | 7 |
| 11 | About/Residential photos | LOW | Enter with the same generic fade as everything else. Clip-path reveal wipes would give them editorial weight. | 7 |
| 12 | Motion vocabulary | HIGH | One pattern (fade-up 0.5s) is used for every reveal on the page. Monotone motion reads as no motion. Needs choreography variety plus one pinned scrubbed centerpiece. | 2, 6 |

## What is explicitly GOOD and must not regress

- Hero anatomy: near-vertical seam, clay panel, giant near-black BUILD
  straddling the seam, rotating word, corner notch, entrance timeline,
  3D mouse parallax. Client approved this after three iterations against
  the live usagg site. Only its FOOTAGE and ambient motion change.
- Mobile hero: clean full-bleed video with stacked PRECISION / IS HOW WE /
  BUILD headline. Client approved.
- Direction 3 clay palette on brand navy. Client chose it after rejecting
  safety orange. LOCKED. Add drama with value, not hue.
- 3D coverflow carousel mechanism (loop, coverflow math, hover-pan,
  touch fallback). Client asked for exactly this. Only its STAGE changes.
- Jack Morgan's real embedded headshot and the real untouched logo.
- All hard rules: zero Brightline, honest project labels, single file,
  free GSAP, house copy style, reduced-motion support, 0 console errors.

## History worth knowing (from CLAUDE.md changelog)

- The client rejected a first hero as "generic," a second as "elementary
  and sloppy." What finally worked: opening the real usagg.com and
  matching its actual geometry. Lesson: match references literally,
  study them live, never work from memory of them.
- The client rejected an AI-redrawn logo. Real assets only.
- The client asked for wood-free framing imagery (metal studs only) and
  it was fixed once already; do not reintroduce wood via new stock.
- "Framer Motion" comes up repeatedly; the standing answer is GSAP +
  CSS 3D inside the single-file constraint.
