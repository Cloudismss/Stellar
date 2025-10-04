set -e

# Ensure the script runs from the project root directory (one level up from 'scripts')
cd "$(dirname "$0")/.."

# Source the configuration file
source "scripts/build.conf"

echo "--- Cleaning up build artifacts ---"
rm -rf "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"

if [ "$BUILD_IMAGE" = "true" ]; then
  echo "--- Building Docker image: $IMAGE_NAME ---"
  docker build -t "$IMAGE_NAME" .devcontainer
else
  echo "--- Pulling Docker image: cloudisms/povray:latest ---"
  docker pull --platform=linux/amd64 cloudisms/povray:latest
  docker tag cloudisms/povray:latest "$IMAGE_NAME"
fi

echo "--- Running generation script inside Docker ---"
chmod +x "scripts/gif.sh" "scripts/png.sh"
docker run --rm -v "$PWD:/source" -v "$PWD/$OUTPUT_DIR:/output" -e OUTPUT_DIR="/output" "$IMAGE_NAME" /bin/sh -c '
  source scripts/build.conf
  if [ -f "$OUTPUT_FILE_NAME.ini" ]; then
    echo "--- Generating GIF ---"
    scripts/gif.sh
  fi
  if [ -f "$OUTPUT_FILE_NAME.pov" ]; then
    echo "--- Generating PNG ---"
    scripts/png.sh
  fi
'
