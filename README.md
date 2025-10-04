# Stellar

A raytraced Computer Graphics animation built in [POV-Ray](https://www.povray.org/) with GitHub Actions support

![Stellar](./Stellar.gif)

# Project Template

This project is meant to serve as a template for automating POV-Ray build processes via local installations of POV-Ray, Docker, or GitHub Actions.

## Step 1 - Configuration

- If building via Docker in Step 2, choose whether or not to build the `Dockerfile` by setting the variable in `scripts/build.conf`
- Change the `FILE_NAME` to determine the output file name in `scripts/build.conf`

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
