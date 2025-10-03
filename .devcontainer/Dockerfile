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
	./bootstrap && \
	./configure \
		COMPILED_BY="Dockerfile" \
		LIBS="-lboost_system -lboost_thread" \
		POVCONF=/etc/povray/3.8/povray.conf \
		--prefix=/usr \
		--sysconfdir=/etc && \
	make CXXFLAGS+='-std=c++11 -DBOOST_BIND_GLOBAL_PLACEHOLDERS=1 -D_LARGEFILE64_SOURCE=1 -I/usr/include/OpenEXR -I/usr/include/Imath' && \
	make install DESTDIR=/povray/dist

# --- Final Stage ---
# Create a minimal final image with only runtime dependencies
FROM alpine:latest

RUN apk add --no-cache \
	boost zlib libpng tiff sdl2 imath openexr ffmpeg

# Copy the compiled POV-Ray binary and assets from the builder stage
COPY --from=builder /povray/dist/usr/bin/povray /usr/bin/povray
COPY --from=builder /povray/dist/usr/share/povray-3.8 /usr/share/povray-3.8
COPY --from=builder /povray/dist/etc/povray/3.8/povray.conf /etc/povray/3.8/povray.conf
COPY --from=builder /povray/dist/etc/povray/3.8/povray.ini /etc/povray/3.8/povray.ini

# Configure the default display gamma and library paths to match official binaries
RUN sed -i 's|;Display_Gamma=sRGB|Display_Gamma=sRGB|' /etc/povray/3.8/povray.conf && \
    sed -i 's|;Library_Path=/usr/local/share/povray-3.8|Library_Path=/usr/share/povray-3.8|' /etc/povray/3.8/povray.conf

# Remove the default scenes to save space
RUN rm -rf /usr/share/povray-3.8/scenes

# Create directories for mounting source and output
RUN mkdir /source && mkdir /output

# Set the WORKDIR to /source (the directory containing the .POV source files should be mounted here)
WORKDIR /source
