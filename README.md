![https://linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)

The [LinuxServer.io](https://linuxserver.io) team brings you another container release featuring easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io](https://forum.linuxserver.io)
* [IRC](https://www.linuxserver.io/irc/) on freenode at `#linuxserver.io`
* [Podcast](https://www.linuxserver.io/podcast/) covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

# lsiodev/minetest
![](https://raw.githubusercontent.com/linuxserver/beta-templates/master/lsiodev/img/minetest-icon.png)

Minetest is a near-infinite-world block sandbox game and a game engine, inspired by InfiniMiner, Minecraft, and the like. [Minetest](http://www.minetest.net/)

## Usage

```
docker create --name=minetest -v <path to data>:/config/.minetest \
-e PGID=<gid> -e PUID=<uid> -e TZ=<timezone> \
-p 30000:30000/udp lsiodev/minetest
```

**Parameters**

* `-p 30000/udp` - the port(s)
* `-v /config/.minetest` - where minetest stores config files and maps etc.
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation
* `-e TZ` for Timezone setting, eg Europe/London

It is based on phusion-baseimage with ssh removed, for shell access whilst the container is running do `docker exec -it minetest /bin/bash`.


### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application 

You can find the world maps, mods folder and config files in /config/.minetest.


## Logs and shell
* To monitor the logs of the container in realtime `docker logs -f minetest`.
* Shell access whilst the container is running: `docker exec -it minetest /bin/bash`



## Versions
+ **27.02.2016:** Bump to latest version.
+ **19.02.2016:** Change port to UDP, thanks to slashopt for pointing this out.
+ **15.02.2016:** Make minetest app a service.
+ **01-02-2016:** Add lua-socket dependency.
+ **06.11.2015:** Initial Release. 

