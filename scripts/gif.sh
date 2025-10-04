set -e

# Ensure the script runs from the project root directory (one level up from 'scripts')
cd "$(dirname "$0")/.."
 
echo "--- Rendering with POV-Ray --- "
povray $FILE_NAME.ini \
  +W800 +H600 \
  +FN \
  Output_File_Name=images/$FILE_NAME-

echo "--- Generating gif with ffmpeg---"
ffmpeg -y -framerate 24 -i images/$FILE_NAME-%02d.png -filter_complex "[0:v] palettegen [p]; [0:v][p] paletteuse" $FILE_NAME.gif

echo "--- $FILE_NAME.gif created ---"
