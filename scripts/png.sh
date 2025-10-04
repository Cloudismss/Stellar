set -e
 
# Ensure the script runs from the project root directory (one level up from 'scripts')
cd "$(dirname "$0")/.."

# Source the configuration file
source "scripts/build.conf"
 
mkdir -p "$OUTPUT_DIR"

echo "--- Rendering with POV-Ray --- "
povray $OUTPUT_FILE_NAME.pov \
  $OUTPUT_W $OUTPUT_H \
  +FN \
  Output_File_Name=$OUTPUT_DIR/$OUTPUT_FILE_NAME

echo "--- $OUTPUT_DIR/$OUTPUT_FILE_NAME.png created ---"
