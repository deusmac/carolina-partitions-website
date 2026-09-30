# DESIGN.md - Carolina Partitions Design System

> The visual source of truth for the redesign. Every color, size, easing,
> and image choice must trace back to this file. Built per the Claude
> Design Masterclass method: the design system comes first, and all assets
> are generated against it. If a phase's output contradicts this file,
> the phase is wrong, not the file (unless the client says otherwise).

---

## 1. Brand palette (LOCKED, Direction 3 "Upstate Modern")

The client explicitly rejected safety orange and chose this palette.
Do not introduce new hues. Dullness is fixed with VALUE CONTRAST
(more deep-navy real estate, clay used hotter and sparser), never
with new colors.

Core tokens (already in index.html `:root`, the code is the canonical copy):

- `--navy: #09245F` brand navy, sampled from the client's real logo
- `--navy-deep: #06183F` near-black navy, hero giant word, dark bands
- `--navy-mid: #0d2a63` hover states on navy
- `--accent: #C1552E` clay/terracotta, decorative accents, hovers
- `--cta: #B14A26` deeper clay, filled buttons (white text passes AA)
- `--cta-hover: #953C1E`
- `--accent-tint: #E0916E` lighter clay for text/accents on dark bands
- `--bg: #FAF8F4` warm off-white page background
- `--surface: #FFFFFF`, `--muted: #F1ECE4`, `--border: #E7E0D5`
- `--fg: #3A3A44`, `--fg-strong: #1E1B18`, `--fg-soft: #6B6357`
- A full dark-variant token set exists under `:root[data-theme="dark"]`.

Value-rhythm rule for the page (top to bottom): dark, dark, light, dark,
dark, dark full-bleed, light, light, dark, light, dark. Long light runs
are what made v1 feel dull; never allow more than two consecutive
light sections.

Contrast floors: body text 4.5:1 minimum; white on `--cta` passes AA;
`--accent-tint` (not raw clay) for small text on navy.

## 2. Typography (family LOCKED, scale EXPANDED)

- Display: Barlow Condensed 500/600/700. Body/UI: Barlow 300 to 700.
  Google Fonts, `font-display: swap`. Never add a third family.
- Existing scale --step-1 through --step5 stays.
- NEW: add `--step6: clamp(4.5rem, 10vw, 9rem)` for mega section headers
  and the services index numerals.
- Ghost/watermark type: uppercase Barlow Condensed 700, 10 to 14vw,
  4 to 6 percent opacity of the section's foreground color, positioned
  behind content, `aria-hidden="true"`, parent has `overflow:hidden`.
- Section headers use --step6 on desktop; hierarchy check: a header must
  read from across the room, a usagg trait, not a brochure trait.

## 3. Motion spec (GSAP core + ScrollTrigger only)

Doctrine: THREE signature moments executed flawlessly, everything else
quiet support. Signature moments: (1) hero entrance + rotating word,
(2) pinned "How we build" scrub section, (3) 3D projects carousel.

| Pattern | Values |
|---|---|
| Scroll reveal (default) | opacity 0>1, y 14>0, 0.5s, power2.out, stagger 0.08, once |
| Image reveal wipe | clip-path inset(0 100% 0 0) > inset(0), 0.9s, power3.inOut, once |
| Pinned scrub (How we build) | ScrollTrigger pin, scrub 0.6, steps wipe via clip-path |
| Hover (buttons, cards) | 0.2s, ease-out; card tilt max +/-8deg rotateX/Y; magnetic CTA x0.3/y0.4 |
| Counters | 1.6s count-up, power2.out, once, tabular-nums |
| Hero Ken Burns | video scale 1.0>1.06, ~20s, yoyo repeat, linear |
| Carousel loop | ~55px/s continuous; hover-x maps to timeScale -2.1..+2.9 |
| Marquee | slow continuous x-loop, duplicate-content technique, pause on hover |
| Skyline parallax | 3 layers, yPercent -6/-10/-14, scrub 0.5 |

Restraint rules: nothing bounces or spins; no animation over 0.9s except
scrubbed/looped ambience; never parallax text; `will-change` only on
actively moving layers.

Reduced motion (`prefers-reduced-motion: reduce`): videos hidden with
posters shown, reveals final-state, counters instant, carousel and
marquee become native scroll / static rows, pin disabled (stacked
steps), Ken Burns off. This is already wired; preserve it.

## 4. Imagery art direction (the selection bar)

ACCEPT only if it hits at least two:
- Dramatic light: raking light, low-key shadows, dust visible in beams
- Visible motion or depth: slow motion, dolly, timelapse, strong leading lines
- Real interior trades with PPE: taping, sanding, metal framing, grid ceilings
- Warm or neutral grade that harmonizes with navy + clay

REJECT on sight:
- Wood framing of any kind (client hard rule: metal studs only)
- Excavators, cranes, exteriors-only earthwork (wrong trade)
- Flat corporate stock: staged handshakes, thumbs up, hardhat-pointing-at-laptop
- Cool/teal clinical grades that fight the palette; watermarks; low resolution

Sources (free commercial use, record the license URL per asset in the
index.html manifest comment): Pexels, Coverr, Mixkit, Pixabay Video.
Real client photos, when they arrive, always beat stock and replace the
nearest placeholder.

## 5. Component specs

- **Primary button**: filled --cta, white text, Barlow Condensed 600
  uppercase, 15px/26px padding, radius 9px, magnetic on fine pointers,
  translateY(-2px) on hover.
- **Ghost button**: transparent, 2px rgba-white border on dark (navy
  border on light), fills subtly on hover.
- **Card**: radius 14 to 16px, layered shadow (see --shadow tokens),
  3D tilt on fine pointers, image scale 1.05 to 1.07 on hover.
- **Section divider**: diagonal clip-path cut of about 3.5deg on band
  edges (`.cut-top` / `.cut-bottom` utilities). Every major band
  transition gets one; straight seams read flat.
- **Ghost heading**: per typography section above.
- **Marquee**: single row, duplicated content, seamless GSAP x-loop.
- **Carousel card (.pcard)**: 3:4, radius 16px, sector chip in clay,
  bottom gradient scrim, glow/reflection under the centered card.
- **Diagonal stripe accent**: repeating-linear-gradient at -56deg, used
  as small corner/notch accents, never as a full-section wallpaper.

## 6. Logo and portrait rules

- Use `assets/logo-white.png` (dark bands) and `assets/logo-navy.png`
  (light surfaces) exactly as-is, embedded base64. Never redraw,
  regenerate, auto-trace, or recolor the mark. (Masterclass warning +
  the client explicitly rejected a redrawn logo once already.)
- Favicon is cropped from the real mark; keep it.
- Jack Morgan's real headshot is embedded base64 in the About section;
  keep it and keep its 4:5 crop and badge.

## 7. Reference library

Structural primary:
- usagg.com: hero seam, straddling mega word, diagonal cuts on every
  section, dark/color/photo value rhythm. Copy the STRUCTURE and ENERGY
  in Carolina's own brand, never the literal assets.

Secondary (take the feel, not layouts):
- harperconstruction.com: institutional gravitas, big project photography
- bhdesignbuild.com: refined typography, whitespace discipline
- candmhomebuilders.com: residential warmth

Motion-quality benchmarks (from the masterclass): motionsites.ai,
godly.website, awwwards.com. The bar: would this section look at home
there? If a section looks like a generic AI landing page, redesign it.

## 8. Anti-slop checklist (run mentally on every section)

- No four-identical-cards grids
- No centered-everything single-column rhythm
- No purple/pink gradients, no glassmorphism-for-no-reason
- Real typographic hierarchy (mega headers, not everything 18px)
- One confident accent used sparingly (clay), generous whitespace
- Asymmetry and overlap where it earns attention
- Photography-forward, dramatic value contrast
- Three signature motion moments perfect, the rest quiet
