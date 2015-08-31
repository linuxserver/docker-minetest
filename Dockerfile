# set base os
FROM linuxserver/baseimage

MAINTAINER Mark Burford <sparklyballs@gmail.com>

# Set correct environment variables
ENV DEBIAN_FRONTEND=noninteractive HOME="/root" TERM=xterm LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8 \

MINETEST_SUBGAME_PATH="/config/.minetest/games" \

configOPTS="-DENABLE_GETTEXT=TRUE \
-DENABLE_SOUND=FALSE \
-DENABLE_LUAJIT=TRUE \
-DENABLE_CURL=TRUE \
-DENABLE_REDIS=TRUE \
-DENABLE_GETTEXT=TRUE \
-DENABLE_SYSTEM_GMP=TRUE \
-DENABLE_LEVELDB=TRUE \
-DRUN_IN_PLACE=FALSE \
-DBUILD_SERVER=TRUE " \

buildDeps="build-essential \
git-core \
gettext \
cmake \
doxygen \
libirrlicht-dev \
libjpeg-dev \
libxxf86vm-dev \
libogg-dev \
libvorbis-dev \
libopenal-dev \
zlib1g-dev \
libgmp-dev \
libpng12-dev \
libgl1-mesa-dev \
libhiredis-dev" \

buildDepsPerm="libbz2-dev \
libleveldb-dev \
luajit \
libluajit-5.1-dev \
libsqlite3-dev \
libcurl4-gnutls-dev \
libfreetype6-dev \
libjsoncpp-dev" \

runtimeDeps="libhiredis0.10"

# Set the locale
RUN locale-gen en_US.UTF-8 && \

# update apt and install build dependencies
apt-get update -qq && \
apt-get install \
--no-install-recommends \
$buildDepsPerm \
$buildDeps -qy && \

# clone minitest git repository
cd /tmp && \
git clone --depth 1 https://github.com/minetest/minetest.git && \
cd /tmp/minetest && \
cp minetest.conf.example /defaults/minetest.conf && \

# build and configure minitest
cmake . \
$configOPTS && \
make && \
make install && \

# copy games to temporary folder 
mkdir -p /defaults/games && \
cp -pr  /usr/local/share/minetest/games/* /defaults/games/ && \

# fetch additional game from git
git clone --depth 1 https://github.com/minetest/minetest_game.git /defaults/games/minetest && \

# clean build dependencies
apt-get purge --remove \
$buildDeps -qy && \
apt-get autoremove -y && \

# install runtime dependencies
apt-get install \
--no-install-recommends \
$buildDepsPerm \
$runtimeDeps -qy && \

#clean up
cd / && \
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# add some files 
ADD init/ /etc/my_init.d/
RUN chmod -v +x /etc/service/*/run /etc/my_init.d/*.sh && \

# give user abc a home folder
usermod -d /config abc

# set volume
VOLUME /config/.minetest

# expose port
EXPOSE 30000

