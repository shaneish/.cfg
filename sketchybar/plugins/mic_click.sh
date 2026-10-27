#!/bin/bash
# this script shamelessly ganked from Ducky6944 on github:
#    https://github.com/FelixKratz/SketchyBar/discussions/12

MIC_VOLUME=$(osascript -e 'input volume of (get volume settings)')

if [[ $MIC_VOLUME -lt 100 ]]; then
  osascript -e 'set volume input volume 100'
  sketchybar -m --set mic icon=" $(osascript -e 'input volume of (get volume settings)')"
elif [[ $MIC_VOLUME -gt 0 ]]; then
  osascript -e 'set volume input volume 0'
  sketchybar -m --set mic icon=" $(osascript -e 'input volume of (get volume settings)')"
fi
