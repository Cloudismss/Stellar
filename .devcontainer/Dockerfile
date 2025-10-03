FROM alpine:latest AS builder

# --- Builder Stage ---
# Install build dependencies, clone, and compile POV-Ray in a single layer
# Use a virtual package to make cleanup easy
RUN apk add --no-cache --virtual .build-deps \
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
	git clone --depth 1 --branch release/v3.7.0 https://github.com/POV-Ray/povray.git /povray && \
	cd /povray/unix && \
	./prebuild.sh && \
	cd /povray && \
	./configure \
		COMPILED_BY="Dockerfile" \
		LIBS="-lboost_system -lboost_thread" \
		CXXFLAGS="-std=c++17 -fno-finite-math-only -D_LARGEFILE64_SOURCE=1 -I/usr/include/OpenEXR -I/usr/include/Imath" \
		POVCONF=/etc/povray/3.7/povray.conf \
		--prefix=/usr/local \
		--sysconfdir=/etc && \
	make install DESTDIR=/povray/dist && \
	apk del .build-deps && \
	rm -rf /var/cache/apk/*

# --- Final Stage ---
# Create a minimal final image with only runtime dependencies
FROM alpine:latest

# Copy the compiled POV-Ray binary and assets from the builder stage
COPY --from=builder /povray/dist/ /

RUN apk add --no-cache --virtual .runtime-deps \
	# Add runtime dependencies
	boost zlib libpng tiff sdl2 imath openexr ffmpeg && \
	# Configure the default display gamma
	echo -e "\nDisplay_Gamma=sRGB" >> /etc/povray/3.7/povray.conf && \
	# Remove the default scenes to save space
	rm -rf /usr/local/share/povray-3.7/scenes && \
	# Create directories for mounting source and output
	mkdir /source && mkdir /output && \
	# Clean up apk cache
	rm -rf /var/cache/apk/*

# Set the WORKDIR to /source (the directory containing the .POV source files should be mounted here)
WORKDIR /source
