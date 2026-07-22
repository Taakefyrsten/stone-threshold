# Stone Fraction

Single-page, no-build web tool for eyeballing stone content in a tray photo in a
few seconds, on a phone. Everything runs in the browser — no upload, no server.

**Live:** https://taakefyrsten.github.io/stone-threshold/

## Flow

1. **Photo** — take one with the phone camera or pick from the roll.
2. **Crop** — drag a box around just the material (tap once = whole photo).
   Leave the tray rim and foil out if you can; the background class handles the rest.
3. **Threshold** — two sliders split the crop by brightness into three bands:
   background, soil, stone. Original is on the left, the classified view on the
   right, both updating live while you drag.
4. **Read** — stone % and soil % are computed over material pixels only
   (background excluded), plus a bar and a colour-coded histogram showing where
   the two cuts sit in the brightness distribution.

**Auto** sets both thresholds with 2-level Otsu (exhaustive search over the
crop histogram). Usually within a nudge of right; the sliders are for the nudge.

**Background is the bright band** flips the band order for white-tray or foil
setups (dark = soil, mid = stone, bright = background). Default assumes a dark
background, soil mid, stone brightest.

**Overlay** toggles between a 55 % colour wash over the photo (you can still see
the texture) and flat class colours (easier to judge boundaries).

## Notes / limits

Brightness-only split at 1024 px working resolution (crop resampled to 560 px so
sliders stay instant). Wet soil, hard shadow, and light-coloured crumb get
misclassified. It's area fraction in a 2D projection, not mass or volume.
Triage tool for "is this worth hand-picking", not a measurement.

## Deploy

```
./deploy.sh <github-username> <repo-name>
```

Needs `gh` authenticated (`gh auth login`). Creates the repo, pushes, enables
Pages. Then add the URL to the phone home screen (Safari share sheet → "Add to
Home Screen") so it opens fullscreen like an app.
