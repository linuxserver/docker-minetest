#!/bin/bash

# predefine some variables
world_part="--world "
world_set=$world

# set world_string variable to use user-defined world or default world.
if [ -z "$world" ]; then
world_string=" "
else
world_string=$world_part$world_set
fi
exec /sbin/setuser abc minetestserver $world_string --config /config/.minetest/main-config/minetest.conf --port 30000

