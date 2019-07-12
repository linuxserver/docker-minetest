[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)](https://linuxserver.io)

The [LinuxServer.io](https://linuxserver.io) team brings you another container release featuring :-

 * regular and timely application updates
 * easy user mappings (PGID, PUID)
 * custom base image with s6 overlay
 * weekly base OS updates with common layers across the entire LinuxServer.io ecosystem to minimise space usage, down time and bandwidth
 * regular security updates

Find us at:
* [Discord](https://discord.gg/YWrKVTn) - realtime support / chat with the community and the team.
* [IRC](https://irc.linuxserver.io) - on freenode at `#linuxserver.io`. Our primary support channel is Discord.
* [Blog](https://blog.linuxserver.io) - all the things you can do with our containers including How-To guides, opinions and much more!

# [linuxserver/minetest](https://github.com/linuxserver/docker-minetest)
[![](https://img.shields.io/discord/354974912613449730.svg?logo=discord&label=LSIO%20Discord&style=flat-square)](https://discord.gg/YWrKVTn)
[![](https://images.microbadger.com/badges/version/linuxserver/minetest.svg)](https://microbadger.com/images/linuxserver/minetest "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/linuxserver/minetest.svg)](https://microbadger.com/images/linuxserver/minetest "Get your own version badge on microbadger.com")
![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/minetest.svg)
![Docker Stars](https://img.shields.io/docker/stars/linuxserver/minetest.svg)
[![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Pipeline-Builders/docker-minetest/master)](https://ci.linuxserver.io/job/Docker-Pipeline-Builders/job/docker-minetest/job/master/)
[![](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/minetest/latest/badge.svg)](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/minetest/latest/index.html)

[Minetest](http://www.minetest.net/) (server) is a near-infinite-world block sandbox game and a game engine, inspired by InfiniMiner, Minecraft, and the like.

[![minetest](https://raw.githubusercontent.com/linuxserver/beta-templates/master/lsiodev/img/minetest-icon.png)](http://www.minetest.net/)

## Supported Architectures

Our images support multiple architectures such as `x86-64`, `arm64` and `armhf`. We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list) and our announcement [here](https://blog.linuxserver.io/2019/02/21/the-lsio-pipeline-project/). 

Simply pulling `linuxserver/minetest` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

| Architecture | Tag |
| :----: | --- |
| x86-64 | amd64-latest |
| arm64 | arm64v8-latest |
| armhf | arm32v7-latest |


## Usage

Here are some example snippets to help you get started creating a container.

### docker

```
docker create \
  --name=minetest \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -e CLI_ARGS="--gameid minetest" `#optional` \
  -p 30000:30000/udp \
  -v <path to data>:/config/.minetest \
  --restart unless-stopped \
  linuxserver/minetest
```


### docker-compose

Compatible with docker-compose v2 schemas.

```
---
version: "2"
services:
  minetest:
    image: linuxserver/minetest
    container_name: minetest
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
      - CLI_ARGS="--gameid minetest" #optional
    volumes:
      - <path to data>:/config/.minetest
    ports:
      - 30000:30000/udp
    restart: unless-stopped
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 30000/udp` | Port Minetest listens on. |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e TZ=Europe/London` | Specify a timezone to use EG Europe/London. |
| `-e CLI_ARGS="--gameid minetest"` | Optionally specify any [CLI variables](https://wiki.minetest.net/Command_line) you want to launch the app with |
| `-v /config/.minetest` | Where minetest stores config files and maps etc. |

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```


&nbsp;
## Application Setup

You can find the world maps, mods folder and config files in /config/.minetest.

Client and server must be the same version, please browse the tags here to pull the appropriate version for your server:

https://hub.docker.com/r/linuxserver/minetest/tags



## Support Info

* Shell access whilst the container is running: `docker exec -it minetest /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f minetest`
* container version number 
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' minetest`
* image version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/minetest`

## Updating Info

Most of our images are static, versioned, and require an image update and container recreation to update the app inside. With some exceptions (ie. nextcloud, plex), we do not recommend or support updating apps inside the container. Please consult the [Application Setup](#application-setup) section above to see if it is recommended for the image.  
  
Below are the instructions for updating containers:  
  
### Via Docker Run/Create
* Update the image: `docker pull linuxserver/minetest`
* Stop the running container: `docker stop minetest`
* Delete the container: `docker rm minetest`
* Recreate a new container with the same docker create parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* Start the new container: `docker start minetest`
* You can also remove the old dangling images: `docker image prune`

### Via Docker Compose
* Update all images: `docker-compose pull`
  * or update a single image: `docker-compose pull minetest`
* Let compose update all containers as necessary: `docker-compose up -d`
  * or update a single container: `docker-compose up -d minetest`
* You can also remove the old dangling images: `docker image prune`

### Via Watchtower auto-updater (especially useful if you don't remember the original parameters)
* Pull the latest image at its tag and replace it with the same env variables in one run:
  ```
  docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  containrrr/watchtower \
  --run-once minetest
  ```

**Note:** We do not endorse the use of Watchtower as a solution to automated updates of existing Docker containers. In fact we generally discourage automated updates. However, this is a useful tool for one-time manual updates of containers where you have forgotten the original parameters. In the long term, we highly recommend using Docker Compose.

* You can also remove the old dangling images: `docker image prune`

## Building locally

If you want to make local modifications to these images for development purposes or just to customize the logic: 
```
git clone https://github.com/linuxserver/docker-minetest.git
cd docker-minetest
docker build \
  --no-cache \
  --pull \
  -t linuxserver/minetest:latest .
```

The ARM variants can be built on x86_64 hardware using `multiarch/qemu-user-static`
```
docker run --rm --privileged multiarch/qemu-user-static:register --reset
```

Once registered you can define the dockerfile to use with `-f Dockerfile.aarch64`.

## Versions

* **12.07.19:** - Bugfix to support multiple CLI variables.
* **28.06.19:** - Rebasing to alpine 3.10.
* **03.06.19:** - Adding custom cli vars to options.
* **23.03.19:** - Switching to new Base images, shift to arm32v7 tag.
* **04.03.19:** - Rebase to alpine 3.9 to compile 5.0.0 minetest with new build args.
* **14.01.19:** - Add pipeline logic and multi arch.
* **08.08.18:** - Rebase to alpine 3.8, build from latest release tag instead of master.
* **03.01.18:** - Deprecate cpu_core routine lack of scaling.
* **08.12.17:** - Rebase to alpine 3.7.
* **30.11.17:** - Use cpu core counting routine to speed up build time.
* **26.05.17:** - Rebase to alpine 3.6.
* **14.02.17:** - Rebase to alpine 3.5.
* **25.11.16:** - Rebase to alpine linux, move to main repo.
* **27.02.16:** - Bump to latest version.
* **19.02.16:** - Change port to UDP, thanks to slashopt for pointing this out.
* **15.02.16:** - Make minetest app a service.
* **01.02.16:** - Add lua-socket dependency.
* **06.11.15:** - Initial Release.
