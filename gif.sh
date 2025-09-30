ffmpeg -i images/Stellar%02d.png -vf "palettegen" images/palette.png
ffmpeg -framerate 24 -i images/Stellar%02d.png -i images/palette.png  -filter_complex "paletteuse" Stellar.gif
