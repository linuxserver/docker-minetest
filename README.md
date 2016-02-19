![https://linuxserver.io](http://www.linuxserver.io/wp-content/uploads/2015/06/linuxserver_medium.png)

The [LinuxServer.io](https://www.linuxserver.io/) team brings you another quality container release featuring dependency update on startup, easy user mapping and community support. Be sure to checkout our [forums](https://forum.linuxserver.io/index.php) or for real-time support our [IRC](https://www.linuxserver.io/index.php/irc/) on freenode at `#linuxserver.io`.

# lsiodev/minetest

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

**TL;DR** - The `PGID` and `PUID` values set the user / group you'd like your container to 'run as' to the host OS. This can be a user you've created or even root (not recommended).

Part of what makes our containers work so well is by allowing you to specify your own `PUID` and `PGID`. This avoids nasty permissions errors with relation to data volumes (`-v` flags). When an application is installed on the host OS it is normally added to the common group called users, Docker apps due to the nature of the technology can't be added to this group. So we added this feature to let you easily choose when running your containers.

## Setting up the application 

You can find the world maps, mods folder and config files in /config/.minetest.


## Updates

* Update dependencies to the latest version simply `docker restart minetest`.
* To monitor the logs of the container in realtime `docker logs -f minetest`.



## Versions
+ **19.02.2016:** Change port to UDP, thanks to slashopt for pointing this out.
+ **15.02.2016:** Make minetest app a service.
+ **01-02-2016:** Add lua-socket dependency.
+ **06.11.2015:** Initial Release. 

