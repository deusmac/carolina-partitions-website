"""AI 4x upscale of the tiny Woodlands at Furman photos (240x320) with Real-ESRGAN x4plus.

Writes brand-assets/woodlands-at-furman-interiors/hd/<name>-4x.jpg (960x1280). The originals
are never touched. Needs torch, numpy, Pillow and the model weights:
  https://github.com/xinntao/Real-ESRGAN/releases/download/v0.1.0/RealESRGAN_x4plus.pth
Usage: python build/upscale_woodlands.py path/to/RealESRGAN_x4plus.pth
Run once; the build only reads the hd/ files.
"""
import os, sys
import numpy as np
import torch
from torch import nn
from torch.nn import functional as F
from PIL import Image, ImageOps

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SRC = os.path.join(ROOT, 'brand-assets', 'woodlands-at-furman-interiors')
OUT = os.path.join(SRC, 'hd')


class RDB5(nn.Module):
    def __init__(self, nf=64, gc=32):
        super().__init__()
        self.conv1 = nn.Conv2d(nf, gc, 3, 1, 1)
        self.conv2 = nn.Conv2d(nf + gc, gc, 3, 1, 1)
        self.conv3 = nn.Conv2d(nf + 2 * gc, gc, 3, 1, 1)
        self.conv4 = nn.Conv2d(nf + 3 * gc, gc, 3, 1, 1)
        self.conv5 = nn.Conv2d(nf + 4 * gc, nf, 3, 1, 1)
        self.lrelu = nn.LeakyReLU(0.2, True)

    def forward(self, x):
        x1 = self.lrelu(self.conv1(x))
        x2 = self.lrelu(self.conv2(torch.cat((x, x1), 1)))
        x3 = self.lrelu(self.conv3(torch.cat((x, x1, x2), 1)))
        x4 = self.lrelu(self.conv4(torch.cat((x, x1, x2, x3), 1)))
        x5 = self.conv5(torch.cat((x, x1, x2, x3, x4), 1))
        return x5 * 0.2 + x


class RRDB(nn.Module):
    def __init__(self, nf):
        super().__init__()
        self.rdb1, self.rdb2, self.rdb3 = RDB5(nf), RDB5(nf), RDB5(nf)

    def forward(self, x):
        return self.rdb3(self.rdb2(self.rdb1(x))) * 0.2 + x


class RRDBNet(nn.Module):
    def __init__(self, nf=64, nb=23):
        super().__init__()
        self.conv_first = nn.Conv2d(3, nf, 3, 1, 1)
        self.body = nn.Sequential(*[RRDB(nf) for _ in range(nb)])
        self.conv_body = nn.Conv2d(nf, nf, 3, 1, 1)
        self.conv_up1 = nn.Conv2d(nf, nf, 3, 1, 1)
        self.conv_up2 = nn.Conv2d(nf, nf, 3, 1, 1)
        self.conv_hr = nn.Conv2d(nf, nf, 3, 1, 1)
        self.conv_last = nn.Conv2d(nf, 3, 3, 1, 1)
        self.lrelu = nn.LeakyReLU(0.2, True)

    def forward(self, x):
        feat = self.conv_first(x)
        feat = feat + self.conv_body(self.body(feat))
        feat = self.lrelu(self.conv_up1(F.interpolate(feat, scale_factor=2, mode='nearest')))
        feat = self.lrelu(self.conv_up2(F.interpolate(feat, scale_factor=2, mode='nearest')))
        return self.conv_last(self.lrelu(self.conv_hr(feat)))


def main(weights):
    net = RRDBNet()
    sd = torch.load(weights, map_location='cpu')
    net.load_state_dict(sd.get('params_ema', sd.get('params', sd)), strict=True)
    net.eval()
    torch.set_num_threads(os.cpu_count() or 4)
    os.makedirs(OUT, exist_ok=True)
    for name in sorted(os.listdir(SRC)):
        if not name.endswith('.jpg'):
            continue
        im = ImageOps.exif_transpose(Image.open(os.path.join(SRC, name))).convert('RGB')
        x = torch.from_numpy(np.asarray(im, dtype=np.float32) / 255).permute(2, 0, 1)[None]
        with torch.no_grad():
            y = net(x).clamp(0, 1)[0].permute(1, 2, 0).numpy()
        out = Image.fromarray((y * 255).round().astype(np.uint8))
        dst = os.path.join(OUT, name[:-4] + '-4x.jpg')
        out.save(dst, quality=92, optimize=True)
        print(name, im.size, '->', out.size)


if __name__ == '__main__':
    main(sys.argv[1])
