set -e

# Ensure the script runs from the project root directory (one level up from 'scripts')
cd "$(dirname "$0")/.."

echo "--- Cleaning up build artifacts ---"
mkdir -p images
rm -f images/*.png
rm -f Stellar.gif

echo "--- Rendering with POV-Ray --- "
docker run --rm \
  -v "$PWD:/source" \
  -v "$PWD/images:/output" \
  local/povray:latest \
  /source/Stellar.ini \
  +W800 +H600 \
  +FN \
  Output_File_Name=/output/Stellar-

echo "--- Generating gif with ffmpeg---"
ffmpeg -y -framerate 24 -i images/Stellar-%02d.png -filter_complex "[0:v] palettegen [p]; [0:v][p] paletteuse" Stellar.gif

echo "--- Stellar.gif created ---"
