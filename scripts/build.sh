set -e

# Source the configuration file
source "$(dirname "$0")/build.conf"

echo "--- Cleaning up build artifacts ---"
mkdir -p images
rm -f images/*.png
rm -f *.png
rm -f *.gif

if [ "$BUILD_IMAGE" = "true" ]; then
  echo "--- Building Docker image: $IMAGE_NAME ---"
  docker build -t "$IMAGE_NAME" .devcontainer
else
  echo "--- Pulling Docker image: cloudisms/povray:latest ---"
  docker pull --platform=linux/amd64 cloudisms/povray:latest
  docker tag cloudisms/povray:latest "$IMAGE_NAME"
fi

echo "--- Running generation script inside Docker ---"
chmod +x "$(dirname "$0")/gif.sh" "$(dirname "$0")/png.sh"
docker run --rm -v "$PWD:/source" "$IMAGE_NAME" /bin/sh -c '
  if ls *.ini >/dev/null 2>&1; then
    echo "--- generating GIF ---"
    scripts/gif.sh
  else
    echo "--- generating PNG ---"
    scripts/png.sh
  fi
'
