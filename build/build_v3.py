"""Build index-v3.html (single file) from build/index-v3.template.html.

Run from the repo root:  python build/build_v3.py
Needs Pillow (pip install pillow).

Template tokens:
  __FAVICON__ __LOGO_BLUE__ __LOGO_WHITE__ __JACK__   base64 data URIs from build/base64-assets.json
  {{IMG path|width|quality|x0,y0,x1,y1[|sharpN]}}      photo, cropped by fractions, resized to width,
                                                       re-encoded as WebP and embedded as base64;
                                                       sharpN upscales N times + sharpens (tiny originals)
Also writes og-image.jpg (1200x630, Project Rock arch) for social link previews.
"""
import base64, io, json, os, re, sys
from PIL import Image, ImageFilter, ImageOps

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
os.chdir(ROOT)
t = open('build/index-v3.template.html', encoding='utf-8').read()
for k, v in json.load(open('build/base64-assets.json')).items():
    t = t.replace('__%s__' % k, v)

sizes = []
def emb(m):
    parts = m.group(1).split('|')
    path, w, q, crop = parts[:4]
    w, q = int(w), int(q)
    sharp = int(parts[4][5:]) if len(parts) > 4 and parts[4].startswith('sharp') else 0
    x0, y0, x1, y1 = map(float, crop.split(','))
    im = ImageOps.exif_transpose(Image.open(path)).convert('RGB')   # bakes in phone rotation
    W, H = im.size
    im = im.crop((int(x0 * W), int(y0 * H), int(x1 * W), int(y1 * H)))
    if sharp:   # tiny originals (Woodlands 240x320): upscale, then sharpen so they hold up larger
        im = im.resize((im.width * sharp, im.height * sharp), Image.LANCZOS)
        im = im.filter(ImageFilter.UnsharpMask(radius=1.6, percent=90, threshold=2))
    if im.width > w:
        im = im.resize((w, round(im.height * w / im.width)), Image.LANCZOS)
    b = io.BytesIO()
    im.save(b, 'WEBP', quality=q, method=6)   # WebP: about a third smaller than JPEG, all current browsers
    sizes.append((len(b.getvalue()), path))
    if os.environ.get('SIZES'): print('%4dKB %dx%d %s' % (len(b.getvalue())//1024, im.width, im.height, os.path.basename(path)))
    return 'data:image/webp;base64,' + base64.b64encode(b.getvalue()).decode()

t = re.sub(r'\{\{IMG ([^}]+)\}\}', emb, t)
if '{{IMG' in t or re.search(r'__[A-Z_]+__', t):
    sys.exit('unreplaced token left in output')
open('index-v3.html', 'w', encoding='utf-8').write(t)

im = ImageOps.exif_transpose(Image.open('brand-assets/project-rock-climbing-gym/project-rock-09-finished-boulder-arch.jpg')).convert('RGB')
W, H = im.size; ch = round(W * 630 / 1200); top = round(H * 0.30)
im.crop((0, top, W, top + ch)).resize((1200, 630), Image.LANCZOS).save('og-image.jpg', quality=80, optimize=True)

print('%d images, %d KB raw, index-v3.html %d KB' % (len(sizes), sum(s for s, _ in sizes) // 1024, len(t.encode()) // 1024))
