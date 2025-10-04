set -e

# Ensure the script runs from the project root directory (one level up from 'scripts')
cd "$(dirname "$0")/.."

# Source the configuration file
source "scripts/build.conf"
 
mkdir -p "$OUTPUT_DIR/images"

echo "--- Rendering with POV-Ray --- "
povray $OUTPUT_FILE_NAME.ini \
  $OUTPUT_W $OUTPUT_H \
  +FN \
  Output_File_Name=$OUTPUT_DIR/images/$OUTPUT_FILE_NAME-

echo "--- Generating gif with ffmpeg---"
ffmpeg -y -framerate 24 -i $OUTPUT_DIR/images/$OUTPUT_FILE_NAME-%02d.png -filter_complex "[0:v] palettegen [p]; [0:v][p] paletteuse" $OUTPUT_DIR/$OUTPUT_FILE_NAME.gif

echo "--- $OUTPUT_DIR/$OUTPUT_FILE_NAME.gif created ---"
