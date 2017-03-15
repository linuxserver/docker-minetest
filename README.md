[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/irc/
[podcasturl]: https://www.linuxserver.io/podcast/
[appurl]: http://www.minetest.net/
[hub]: https://hub.docker.com/r/linuxserver/minetest/

[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)][linuxserverurl]

The [LinuxServer.io][linuxserverurl] team brings you another container release featuring easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io][forumurl]
* [IRC][ircurl] on freenode at `#linuxserver.io`
* [Podcast][podcasturl] covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

# linuxserver/minetest
[![](https://images.microbadger.com/badges/version/linuxserver/minetest.svg)](https://microbadger.com/images/linuxserver/minetest "Get your own version badge on microbadger.com")[![](https://images.microbadger.com/badges/image/linuxserver/minetest.svg)](http://microbadger.com/images/linuxserver/minetest "Get your own image badge on microbadger.com")[![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/minetest.svg)][hub][![Docker Stars](https://img.shields.io/docker/stars/linuxserver/minetest.svg)][hub][![Build Status](http://jenkins.linuxserver.io:8080/buildStatus/icon?job=Dockers/LinuxServer.io/linuxserver-minetest)](http://jenkins.linuxserver.io:8080/job/Dockers/job/LinuxServer.io/job/linuxserver-minetest/)

[Minetest][appurl] (server) is a near-infinite-world block sandbox game and a game engine, inspired by InfiniMiner, Minecraft, and the like.

[![minetest](https://raw.githubusercontent.com/linuxserver/beta-templates/master/lsiodev/img/minetest-icon.png)][appurl]

## Usage

```
docker create \
  --name=minetest \
  -v <path to data>:/config/.minetest \
  -e PGID=<gid> -e PUID=<uid>  \
  -p 30000:30000/udp
  linuxserver/minetest
```

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`



* `-p 30000/udp` - the port(s)
* `-v /config/.minetest` - where minetest stores config files and maps etc.
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it minetest /bin/bash`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application

You can find the world maps, mods folder and config files in /config/.minetest.

## Info

* Shell access whilst the container is running: `docker exec -it minetest /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f minetest`

* container version number 

`docker inspect -f '{{ index .Config.Labels "build_version" }}' minetest`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/minetest`

## Versions

+ **14.02.2017:** Rebase to alpine 3.5.
+ **25.11.2016:** Rebase to alpine linux, move to main repo.
+ **27.02.2016:** Bump to latest version.
+ **19.02.2016:** Change port to UDP, thanks to slashopt for pointing this out.
+ **15.02.2016:** Make minetest app a service.
+ **01-02-2016:** Add lua-socket dependency.
+ **06.11.2015:** Initial Release. 
