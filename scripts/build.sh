set -e

# This script provides a consistent way to build the GIF locally
# using the same Docker environment as the GitHub Actions workflow.

IMAGE_NAME="povray"

echo "--- Building Docker image: $IMAGE_NAME ---"
docker build -t "$IMAGE_NAME" .devcontainer

echo "--- Running gif generation script inside Docker ---"
docker run --rm -v "$PWD:/source" "$IMAGE_NAME" /bin/sh scripts/gif.sh
