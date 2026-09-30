# usagg.com reference capture (reference only)

Captured 2026-10-01 with real Chrome (Playwright, `channel: chrome`). Desktop 1440x900, mobile 390x844 @2x. All numbers below were read from computed styles unless marked "visual estimate". Site is a WordPress + Divi theme-builder build. Do not copy their logo, text or photos; use this for structure, proportions, color logic and motion only.

Files in this folder: `desktop-full.png`, `mobile-full.png`, `desktop-01..08-*.png` (one 1440x900 viewport per section), `desktop-nav-dropdown-resources.png`, `desktop-nav-link-hover.png`, `desktop-button-before-hover.png`, `desktop-button-hover.png`, `desktop-header-scrolled-state.png`, `mobile-01-top.png`, `mobile-menu-open.png`, `page.html` (rendered DOM), and the raw dumps `_styles.json`, `_detail.json`, `_detail2.json`, `_detail3.json`, `_sections.json`, `_mobile.json`.

Note on the numbered shots: `desktop-01` is the nav bar state (first header section), `desktop-02` is the hero, and so on in page order. The sticky nav overlays the top of every viewport shot after the first.

## Global system

Colors (exact, from computed styles):

| Role | Value |
|---|---|
| Slate (primary dark, headings on light, top bar, buttons hover) | `#333F48` rgb(51,63,72) |
| Ink / deepest navy-slate (body text on light, dark section bg) | `#1A2228` rgb(26,34,40) |
| Card bg on dark sections | `#252F37` rgb(37,47,55) |
| Accent yellow (buttons, headline words, card top border, eyebrow triangle) | `#FFC72C` rgb(255,199,44) |
| Light gray section bg (News) | `#F4F5F5` rgb(244,245,245) |
| Hairline / light border, small caps text on dark | `#E7E8E9` rgb(231,232,233) |
| Mid gray (eyebrow on light, CAREERS text, stat divider lines) | `#636A71` rgb(99,106,113) |
| Footer body small text | `#CED1D4` rgb(206,209,212) |
| White | `#FFFFFF` |

Fonts (Google Fonts): **Nunito Sans** for headings and big numbers (weights 500, 700, 800, 900 loaded), **Open Sans** for nav, body and buttons (400, 500, 600). Everything uppercase except nav links and body paragraphs.

Content width: rows are max-width **1328px**, centered, with 56px side gutters at 1440 (16px section padding + the row auto margin). Every section is full-bleed background with a boxed 1328px row inside, except the hero and Applications rows, which are full width (100%) with 16px padding and position content on the same 56px / 48px left line.

Type scale (desktop):

- Eyebrow (small label above headings): Nunito Sans/Open Sans 700, 11-12px, letter-spacing 1.1px, uppercase, with a small yellow right-angle triangle bullet before the text. Color `#fff` on dark, `#636A71` on light.
- H1 (hero only, actually just the eyebrow line): Nunito Sans 900, 12px, letter-spacing 1.1px, uppercase, white.
- Hero rotator H2: Nunito Sans 500, 40px / 40px line-height, letter-spacing 0.64px, uppercase, white; the key word is `<strong>` Nunito Sans 900 in `#FFC72C`.
- Section H2 (Applications, Locations): Nunito Sans 900, 48px / 57.6px, uppercase, no letter-spacing. `#333F48` on white, `#FFC72C` on dark.
- Section H2 (Why customers choose us): Nunito Sans 900, 40px / 40px, uppercase, `#FFC72C`, centered.
- Card H2 ("Safety first" etc.): Nunito Sans 900, 30px / 30px, uppercase, white.
- Stat numbers: Nunito Sans 900, 48px / 48px, white. Stat labels: Nunito Sans 500, 12px uppercase, `#E7E8E9`.
- Body: Open Sans 400, 16px / 27.2px on the hero and Applications, 16px / 24px in cards, 14px / 23.8px elsewhere.
- News card titles: Open Sans 700, 22px / 26.4px (inside the image cards the big names are Nunito Sans 900 at roughly 44px, visual estimate).
- Footer column headings (H4): Open Sans 600, 14px, uppercase, white. Footer links: Open Sans 400, 14px, white (nav columns render bold-looking uppercase, visual estimate from screenshot).

Buttons (all: Open Sans 600, 16px, uppercase, padding 4.8px 16px, sharp corners, radius 0, 0.3s transition):

- Primary: bg `#FFC72C`, text `#1A2228`. Hover: bg `#333F48`, text `#FFC72C`.
- Secondary (outline): transparent bg, 1px `#E7E8E9` border, text white on dark (hero) or `#636A71` on light (CAREERS). Hover (on dark): bg `#636A71`, text stays white.
- Top bar links: Open Sans 600, 12px, uppercase, 0.2s transition.
- Footer legal links: Open Sans 500, 12px, letter-spacing 1.2px, uppercase, `#E7E8E9`.

Global spacing: sections use 48px, 54px, 56px or 64px vertical padding with 16px horizontal. Row gap between columns is 32px (or 5.5% in the Divi flex rows). No rounded corners, no heavy shadows anywhere: the look is flat, square, and geometric.

Shape language (the brand signature): everything diagonal is about a 55-60 degree slant, matching the parallelogram stripes in the logo. Used in the hero band, the Applications photo collage, thin angled hairlines in the hero and footer, and the outlined triangle. Nothing is rounded.

## Nav

Two stacked header bars, both full-width with 16px padding:

1. **Top utility bar**: height 40px, bg `#333F48`, padding 8px 16px. Right-aligned links "APPLY FOR CREDIT" (yellow `#FFC72C`) and "PAY MY BILL" (`#F4F5F5`), Open Sans 600 12px uppercase, ~32px apart.
2. **Main nav**: height 63px, bg white, 1328px row with a 3-column flex (272px logo / 768px menu / 224px buttons, 32px gaps).
   - Logo left, 272x20px wordmark image, left edge at x=56.
   - Menu in the middle column starts at x=420: About, Applications, Community, Locations, Products, Resources (with small chevron), News. Open Sans 600, 16px, `#333F48`, not uppercase, ~22px gaps. 0.4s ease-in-out color transition. No underline or pseudo-element on hover; the color stays `#333F48` (hover change is subtle/none).
   - Right column: CONTACT button (primary yellow, 106x37) then CAREERS button (outline, 1px `#E7E8E9`, text `#636A71`, 102x39), 16px apart, right edge at x=1384.
   - **Sticky behavior**: on scroll the top utility bar scrolls away and the main nav becomes `position: fixed; top: 0` at full width, staying white at 63px. Screenshot: `desktop-header-scrolled-state.png`.
   - **Dropdown** (Resources, opens on hover): white panel 240px wide, 16px vertical padding, 3px solid `#FFC72C` top border, shadow `0 2px 5px rgba(0,0,0,.1)`, radius 0, item text Open Sans 600 16px `#333F48`. Only one item ("Aggregate Calculator"). Screenshot: `desktop-nav-dropdown-resources.png`.
   - **Mobile** (390): top bar stays (yellow + light links, right aligned). Main bar is 69px tall, padding 16px, logo collapses to the icon mark only (95x32), hamburger (gray 3-line, 36px wide) on the right at x=332. Menu opens as a white right-aligned panel, about 224px wide (x=150-374 at 1x), with a 3px yellow top border, items right-aligned, Open Sans 600 20px / 26px, padding 16px, hairline dividers between items, and Aggregate Calculator promoted to a top-level item. Screenshot: `mobile-menu-open.png`.

## 1. Hero (section 2 in shots)

Section height 670px (at 1440x900), starts at y=103 under the two header bars. Full-bleed, row is 100% wide with 16px padding; content column is 1328px wide with the text block starting at x=56, vertically placed about 150px down from the hero top (text group top y=254, bottom y=622).

How it works exactly, layer by layer:

1. **Background video**: looping muted background video (`home_header_NEW.mp4` / `.webm`, about 1:02 long) covering the full 1440x670 area, object-fit cover. Content is an aerial of a gravel quarry with conveyors. A phone-specific background is swapped in on small screens.
2. **Overlay**: the row has `background: linear-gradient(135deg, rgba(51,63,72,.8) 45%, rgba(51,63,72,0) 70%, rgba(51,63,72,0) 100%)` on top of a flat `rgba(26,34,40,.5)` tint. So it is darkest at the left/top-left (slate at 80%) and fades to clear toward the right, leaving the right ~40% of the video visible.
3. **Left column (text group, 797px wide)**, top to bottom:
   - Eyebrow/H1 "THE MIDWEST'S PREMIER AGGREGATE SUPPLIER", 12px 900 caps, 1.1px tracking, white, with yellow triangle bullet, at x=72 (the triangle sits at x=56).
   - Rotating headline (H2, 40px): "**ENGINEERING** is our" where the first word is yellow 900 and "is our" is white 500. 7 lines stacked absolutely in one 37px-tall slot.
   - **Big word band**: an inline SVG (viewBox 641x114, rendered 797x142 at x=56, y=331). It is a solid yellow `#FFC72B` band with the word "STRENGTH" cut out of it (the letters show the dark video through; in the screenshot they read as dark slate on yellow). The **right end of the band is sliced at an angle**: the path runs `M640.8 0` (top-right) to `540.7 113.6` (bottom-right), i.e. the band's right edge leans like "/", about 49 degrees from horizontal (dx 100 over dy 113.6, so the cut leans ~48.6 degrees off vertical). Two thin yellow diagonal stripes sit right of the word inside the cut, echoing the logo. Left edge of the band is flush at x=56 (square). The word is static; it does not rotate.
   - Paragraph, white, Open Sans 16px / 27.2px, max width about 717px: "For 60 years, ... across the Midwest."
   - Two buttons 24px apart: VIEW OUR PRODUCTS (primary yellow 198x37) and FIND A QUARRY (outline 156x39).
4. **Right decoration**: one large image (943x553, at x=740, y=354) with slide-in-from-right animation (600ms): thin light angled hairlines forming a big parallelogram outline crossing the right side, plus a small outlined yellow triangle in the bottom-right (about 80px, at roughly x=1310-1390, y=550-640 in the hero shot). The hairlines lean the same "/" direction as the band cut.
5. The hero's H2 words rotate; everything else is static.

**Stat bar** directly below (section 3 in shots): height 118px, 24px vertical padding, bg `linear-gradient(90deg, #333F48 0%, #1A2228 100%)`. Three equal columns 394px wide with a 1px `#636A71` vertical divider on the right of columns 1 and 2 (dividers are 70px tall, inset from the bar edges). Each: number (Nunito Sans 900 48px white, centered) over label (Nunito Sans 500 12px uppercase `#E7E8E9`). Values: 60 / 100+ / 100%. The numbers were static when sampled (no count-up observed).

Mobile hero: section 734px tall, rotator H2 32px / 32px, the STRENGTH band SVG scales to 358x64 (full width minus gutters), eyebrow stays 12px, buttons stack full-width-ish, stats bar becomes 194px tall (stacked, 24px 16px padding), decorative diagonal hairlines move to the bottom of the section.

## 2. Applications (section 4 in shots)

Height 560px, white bg, padding 48px 16px, 2 layers:

- Left text column 704px wide starting x=48: eyebrow "APPLICATIONS" (11px 700 caps `#636A71` + yellow triangle), H2 48px/57.6px Nunito Sans 900 `#333F48`, two-line, then body 16px/27.2px `#1A2228` (max ~656px), then primary button "VIEW APPLICATIONS" (187x37). Text is vertically centered in the 560px.
- Right: a full-height image collage on the right half, cut into **three slanted parallelogram strips** (farm field / excavator / paver), each separated by a thin white gap, slanting "/" at roughly 55 degrees. It bleeds off the right edge and the top/bottom of the section. The left boundary of the collage is a diagonal that overlaps the text column with a faint white-to-transparent gradient so text stays readable (visual estimate). Collage slides in from the right on scroll.

## 3. Locations (section 5 in shots)

Height 560px, bg `#1A2228` with a background image (dark topographic map of Indiana with yellow dot markers and a dotted yellow state outline; image is on the left half). Padding 48px 16px. Content is on the **right half**: text column starts at x=736, 648px wide, vertically centered. Eyebrow "STATEWIDE NETWORK" (white), H2 "MORE LOCATIONS TO SERVE YOU" 48px/57.6px 900 `#FFC72C`, body white 16px/23.8px, primary button "FIND A QUARRY" (154x37). The column slides in from the right (`slideRight`, 600ms, 250ms delay). Map dots have soft halo rings (visual estimate: ~48px circles of yellow at ~20% alpha).

## 4. Why customers choose us (section 6 in shots)

Height 581px, bg `#1A2228`, padding 64px 16px. Centered intro: eyebrow "COMMUNITY ENGAGEMENT" (white, triangle), H2 40px 900 `#FFC72C` centered, then a centered 14px white paragraph about 664px wide. Below it a **4-column grid**: each card 308x256, gap 32px, bg `#252F37`, **4px solid `#FFC72C` top border**, padding 48px 24-32px, radius 0. Card H2 30px/30px Nunito Sans 900 white caps (wraps to two lines on some), body 16px/24px `#E7E8E9`. Cards: Safety First, Reliable Supply, Consistent Quality, Responsible Stewardship.

## 5. News (section 7 in shots)

Bg `#F4F5F5`, padding 54px 16px, height 680px. Row header: "NEWS" H2 (Nunito Sans 900, ~40px, `#333F48`) on the left, and two square **carousel arrows** on the right (48x52 yellow `#FFC72C` squares with dark triangle icons, 16px apart). Below: a horizontal carousel of 411x411 square cards with 32px gaps; the next card bleeds off the right edge and the previous one off the left (clipped at 5px inset). Cards are photos or branded "Rockstar" tiles (people in a circular crop over a yellow swoosh and slate band). Card hover: `transform` transition 0.2s ease-in-out (slight scale, visual estimate). Card padding 16px, titles are large Nunito caps over the image.

## 6. Footer (section 8 in shots)

Height 515px, bg `#1A2228` with a 60% `#1A2228` overlay on top of a background image of **diagonal slate bands and thin hairline diagonals** running "/" across the full width (same 55-60 degree slant as the rest of the site). Padding 56px 16px. Structure, 1328px row:

- Top strip: logo (white + yellow version of the wordmark, about 267px wide) at x=56.
- Main row, 3 columns 277 / 394 / 277 with 5.5% gaps:
  1. Left: "HEADQUARTERS" H4, underlined white address link (2 lines), "PHONE" H4, phone/fax lines, "SOCIAL" H4, then three 32x32 white-square icon buttons (Facebook circle, LinkedIn, Instagram) 16px apart.
  2. Middle: two link columns, uppercase bold white 14px: About, Applications, Community, Locations, Products, Utilimin | Resources, Aggregate Calculator, News, Apply for Credit, Careers, Contact Us; 38px row pitch.
  3. Right: circular parent-company badge (about 160px, yellow "H" mark in a ring of text) above a 12px `#CED1D4` paragraph (4 lines).
- Bottom row (24px top padding): left "© 2026 US Aggregates. All rights reserved." 12px `#E7E8E9`; right "PRIVACY POLICY" and "SITEMAP" 12px 500 caps, 1.2px tracking, 40px apart.

## Motion summary

- **Hero rotator**: 7 lines ("Infrastructure / Partnership / Safety / Reliability / Engineering / Teamwork / Community is our ...") cycle about every **5 seconds**. Each line is absolutely positioned; the active line is opacity 1, translateY(0); inactive lines are opacity 0, translateY(24px). Transition: `opacity 0.6s linear, transform 0.6s ease-out`. So a new line fades in while rising 24px, and the old one fades out.
- **Scroll reveals** (Divi `slideRight`): the hero right-side decoration image (600ms, 0ms delay) and the Locations text column (600ms, 250ms delay) slide in from the right when they enter the viewport. Applications collage uses the same slide-in (visual estimate).
- **Hover**: buttons 0.3s color/bg swap (yellow to slate with yellow text); outline buttons fill `#636A71`; nav links 0.4s ease-in-out color; news cards 0.2s transform; dropdown fades in (0.2s opacity).
- **Video**: background video loops continuously and plays when outside the viewport too.
- **Sticky nav**: top bar scrolls away, main nav pins at top:0.
- **Stats**: numbers did not count up when sampled.
- Everything else is static.

## Takeaways for the Carolina Partitions redesign (reference-only observations)

1. Two-tone palette: one deep slate, one near-black ink, one saturated accent (yellow). Accent is used sparingly for buttons, key words and top borders.
2. Square corners everywhere; geometry comes from a single diagonal angle reused in the hero band, image collage, hairlines and footer.
3. Hero formula: full-bleed moving background, dark gradient from the left, small eyebrow, rotating "X is our" line, one oversized word on a slanted yellow band, short paragraph, two buttons (1 solid, 1 outline).
4. Sticky white nav with a single solid CTA button plus a quiet outline button; thin utility bar above.
5. Alternating white / dark sections at fixed 560px heights, boxed 1328px content with generous 48-64px vertical padding.
