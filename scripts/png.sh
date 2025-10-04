set -e
 
# Ensure the script runs from the project root directory (one level up from 'scripts')
cd "$(dirname "$0")/.."

# Source the configuration file to get FILE_NAME
source "scripts/build.conf"
 
echo "--- Rendering with POV-Ray --- "
povray $FILE_NAME.pov \
  $OUTPUT_W $OUTPUT_H \
  +FN \
  Output_File_Name=$FILE_NAME

echo "--- $FILE_NAME.png created ---"
