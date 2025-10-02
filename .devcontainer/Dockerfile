FROM ubuntu:latest

# Install dependencies
RUN apt-get update && \
    apt-get -y install --no-install-recommends git ffmpeg

# Build POV-Ray
RUN apt-get -y install build-essential autoconf libboost-dev libboost-date-time-dev libboost-thread-dev zlib1g-dev libpng-dev libjpeg8-dev libtiff5-dev libopenexr-dev && \
    mkdir build && \
    cd build && \
    git config --global http.sslverify false && \
    git clone --branch latest-stable --single-branch https://github.com/POV-Ray/povray.git && \
    cd povray/unix/ && \
    chmod +x prebuild.sh && \
    ./prebuild.sh && \
    cd ../ && \
    ./configure COMPILED_BY="Dockerfile" && \
    make && \
    make install && \
    cd ../

# Cleanup
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /source /output

WORKDIR /source
