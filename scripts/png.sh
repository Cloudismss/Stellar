set -e
 
# Ensure the script runs from the project root directory (one level up from 'scripts')
cd "$(dirname "$0")/.."
 
echo "--- Rendering with POV-Ray --- "
povray $FILE_NAME.pov \
  +W800 +H600 \
  +FN \
  Output_File_Name=$FILE_NAME

echo "--- $FILE_NAME.png created ---"
