FROM linuxserver/baseimage

MAINTAINER Sparklyballs <sparklyballs@linuxserver.io>


ENV APTLIST="libbz2-dev lua-socket libleveldb-dev luajit libluajit-5.1-dev libsqlite3-dev \
libcurl4-gnutls-dev libfreetype6-dev libhiredis0.10 libjsoncpp-dev"

ENV BUILD_APTLIST="build-essential git-core gettext cmake doxygen libirrlicht-dev libjpeg-dev libxxf86vm-dev libogg-dev libvorbis-dev libopenal-dev zlib1g-dev libgmp-dev libpng12-dev libgl1-mesa-dev libhiredis-dev"

# Set environment variables
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8 MINETEST_SUBGAME_PATH="/config/.minetest/games"

ENV configOPTS="-DENABLE_GETTEXT=TRUE \
-DENABLE_SOUND=FALSE \
-DENABLE_LUAJIT=TRUE \
-DENABLE_CURL=TRUE \
-DENABLE_REDIS=TRUE \
-DENABLE_GETTEXT=TRUE \
-DENABLE_SYSTEM_GMP=TRUE \
-DENABLE_LEVELDB=TRUE \
-DRUN_IN_PLACE=FALSE \
-DBUILD_SERVER=TRUE "


# Set the locale
RUN locale-gen en_US.UTF-8 && \

# update apt and install build dependencies
apt-get update -q && \
apt-get install \
--no-install-recommends \
$APTLIST \
$BUILD_APTLIST -qy && \

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
$BUILD_APTLIST -qy && \
apt-get autoremove -y && \

# install runtime dependencies (makes sure we haven't deleted needed packages with removal above)
apt-get install \
--no-install-recommends \
$APTLIST -qy && \

#clean up
cd / && \
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# add some files
ADD services/ /etc/service/
ADD init/ /etc/my_init.d/
RUN chmod -v +x /etc/service/*/run /etc/my_init.d/*.sh

# set volume
VOLUME /config/.minetest

# expose port
EXPOSE 30000

