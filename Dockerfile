FROM lsiobase/alpine:3.7

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs"

# environment variables
ENV HOME="/config" \
MINETEST_SUBGAME_PATH="/config/.minetest/games"

# build variables
ARG LDFLAGS="-lintl"

RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache --virtual=build-dependencies \
	bzip2-dev \
	cmake \
	curl-dev \
	doxygen \
	g++ \
	gcc \
	gettext-dev \
	git \
	gmp-dev \
	hiredis-dev \
	icu-dev \
	irrlicht-dev \
	libjpeg-turbo-dev \
	libogg-dev \
	libpng-dev \
	libressl-dev \
	libtool \
	libvorbis-dev \
	luajit-dev \
	make \
	mesa-dev \
	openal-soft-dev \
	python-dev \
	sqlite-dev && \
 apk add --no-cache --virtual=build-dependencies \
	--repository http://nl.alpinelinux.org/alpine/edge/testing \
	leveldb-dev && \
 echo "**** install runtime packages ****" && \
 apk add --no-cache \
	curl \
	gmp \
	hiredis \
	libgcc \
	libintl \
	libstdc++ \
	luajit \
	lua-socket \
	sqlite \
	sqlite-libs && \
 apk add --no-cache \
	--repository http://nl.alpinelinux.org/alpine/edge/testing \
	leveldb && \
 echo "**** compile spatialindex ****" && \
 git clone https://github.com/libspatialindex/libspatialindex /tmp/spatialindex && \
 cd /tmp/spatialindex && \
 cmake . \
	-DCMAKE_INSTALL_PREFIX=/usr && \
 echo "**** attempt to set number of cores available for make to use ****" && \
 set -ex && \
 CPU_CORES=$( < /proc/cpuinfo grep -c processor ) || echo "failed cpu look up" && \
 if echo $CPU_CORES | grep -E  -q '^[0-9]+$'; then \
	: ;\
 if [ "$CPU_CORES" -gt 7 ]; then \
	CPU_CORES=$(( CPU_CORES  - 3 )); \
 elif [ "$CPU_CORES" -gt 5 ]; then \
	CPU_CORES=$(( CPU_CORES  - 2 )); \
 elif [ "$CPU_CORES" -gt 3 ]; then \
	CPU_CORES=$(( CPU_CORES  - 1 )); fi \
 else CPU_CORES="1"; fi && \
 make -j $CPU_CORES && \
 make install && \
 echo "**** compile minetestserver ****" && \
 git clone --depth 1 https://github.com/minetest/minetest.git /tmp/minetest && \
 cp /tmp/minetest//minetest.conf.example /defaults/minetest.conf && \
 cd /tmp/minetest && \
 cmake . \
	-DBUILD_CLIENT=0 \
	-DBUILD_SERVER=1 \
	-DCMAKE_INSTALL_PREFIX=/usr \
	-DCUSTOM_BINDIR=/usr/bin \
	-DCUSTOM_DOCDIR="/usr/share/doc/minetest" \
	-DCUSTOM_SHAREDIR="/usr/share/minetest" \
	-DENABLE_CURL=1 \
	-DENABLE_LEVELDB=1 \
	-DENABLE_LUAJIT=1 \
	-DENABLE_REDIS=1 \
	-DENABLE_SOUND=0 \
	-DENABLE_SYSTEM_GMP=1 \
	-DRUN_IN_PLACE=0 && \
 make -j $CPU_CORES && \
 set +ex && \
 make install && \
 echo "**** copy games to temporary folder ****" && \
 mkdir -p \
	/defaults/games && \
 cp -pr  /usr/share/minetest/games/* /defaults/games/ && \
 echo "**** fetch additional game from git ****" && \
 git clone --depth 1 https://github.com/minetest/minetest_game.git /defaults/games/minetest && \
 echo "**** cleanup ****" && \
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/tmp/*

# add local files
COPY root /

# ports and volumes
EXPOSE 30000/udp
VOLUME /config/.minetest
