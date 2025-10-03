FROM alpine:latest AS builder

# --- Builder Stage ---
# Install build dependencies, clone, and compile POV-Ray
RUN apk add --update --no-cache \
	git \
	coreutils \
	build-base \
	autoconf \
	automake \
	bash \
	boost-dev \
	zlib-dev \
	libpng-dev \
	tiff-dev \
	sdl2-dev \
	imath-dev \
	openexr-dev && \
	git clone https://github.com/POV-Ray/povray.git && \
	cd /povray && \
	git checkout release/v3.8.0 && \
	cd /povray/unix && \
	./prebuild.sh && \
	cd /povray && \
	./configure \
		COMPILED_BY="Dockerfile" \
		LIBS="-lboost_system -lboost_thread" \
		CXXFLAGS="-std=c++17 -fno-finite-math-only -D_LARGEFILE64_SOURCE=1 -I/usr/include/OpenEXR -I/usr/include/Imath" \
		POVCONF=/etc/povray/3.8/povray.conf \
		--prefix=/usr/local \
		--sysconfdir=/etc && \
	make install DESTDIR=/povray/dist

# --- Final Stage ---
# Create a minimal final image with only runtime dependencies
FROM alpine:latest

RUN apk add --no-cache \
	boost zlib libpng tiff sdl2 imath openexr ffmpeg

# Copy the compiled POV-Ray binary and assets from the builder stage
COPY --from=builder /povray/dist/usr/local/bin/povray /usr/local/bin/povray
COPY --from=builder /povray/dist/usr/local/share/povray-3.8 /usr/local/share/povray-3.8
COPY --from=builder /povray/dist/etc/povray/3.8/povray.conf /usr/local/etc/povray/3.8/povray.conf
COPY --from=builder /povray/dist/etc/povray/3.8/povray.ini /usr/local/etc/povray/3.8/povray.ini

# Configure the default display gamma and library paths to match official binaries
RUN echo -e "\nDisplay_Gamma=sRGB" >> /usr/local/etc/povray/3.8/povray.conf

# Remove the default scenes to save space
RUN rm -rf /usr/local/share/povray-3.8/scenes

# Create directories for mounting source and output
RUN mkdir /source && mkdir /output

# Set the WORKDIR to /source (the directory containing the .POV source files should be mounted here)
WORKDIR /source
