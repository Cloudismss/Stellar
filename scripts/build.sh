set -e

# This script provides a consistent way to build the GIF locally
# using the same Docker environment as the GitHub Actions workflow.

IMAGE_NAME="povray"
FILE_NAME="Stellar"

# Source the configuration file
source "$(dirname "$0")/build.conf"

echo "--- Cleaning up build artifacts ---"
rm -f images/*.png
rm -f $FILE_NAME.png
rm -f $FILE_NAME.gif

if [ "$BuildImage" = "true" ]; then
  echo "--- Building Docker image: $IMAGE_NAME ---"
  docker build -t "$IMAGE_NAME" .devcontainer
else
  echo "--- Pulling Docker image: cloudisms/povray:latest ---"
  docker pull cloudisms/povray:latest
  docker tag cloudisms/povray:latest "$IMAGE_NAME"
fi

echo "--- Running generation script inside Docker ---"
# Ensure the scripts are executable
chmod +x "$(dirname "$0")/gif.sh" "$(dirname "$0")/png.sh"
docker run --rm --user "$(id -u):$(id -g)" -v "$PWD:/source" -e FILE_NAME="$FILE_NAME" "$IMAGE_NAME" /bin/sh -c '
  if ls *.ini >/dev/null 2>&1; then
    echo "--- generating GIF ---"
    scripts/gif.sh
  else
    echo "--- generating PNG ---"
    scripts/png.sh
  fi
'
