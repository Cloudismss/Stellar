# Stellar

A raytraced Computer Graphics animation built in [POV-Ray](https://www.povray.org/) with GitHub Actions support

![Stellar](./Stellar.gif)

# Project Template

This project is meant to serve as a template for automating POV-Ray build processes via local installations of POV-Ray, Docker, or GitHub Actions.

## Step 1 - Configuration - `scripts/build.conf`

- Change the `FILE_NAME` variable to set the output file name
- Adjust the output resolution using `OUTPUT_W` and `OUTPUT_H`
- If utilitzing the Docker option in Step 2:
  - Choose whether or not to build the provided `Dockerfile` by setting the `BUILD_IMAGE` variable
  - Optionally set the name of the docker image to be built with `IMAGE_NAME`

## Step 2 (Option A) - Building Locally with Docker

- Install Docker
- `chmod +x scripts/build.sh`
- `scripts/build.sh`

## Step 2 (Option B) - Builing Locally with POV-Ray

- Optionally build and run a VSCode or GitHub Codespace container using the provided `devcontainer.json`
- `chmod +x scripts/gif.sh scripts/png.sh`
- `scripts/gif.sh` to generate a .gif from an .ini file
- `scripts/png.sh` to generate a .png from a .pov file

## Step 3 (Optional) - Enable GitHub Actions

- Activate Actions on your GitHub Repository `Actions` page
