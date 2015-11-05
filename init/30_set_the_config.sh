#!/bin/bash

mkdir -p /config/.minetest/games /config/.minetest/mods

if [ ! -f "/config/.minetest/main-config/minetest.conf" ]; then
mkdir -p /config/.minetest/main-config
cp /defaults/minetest.conf /config/.minetest/main-config/minetest.conf
fi

if [ ! -d "/config/.minetest/games/minimal" ]; then
cp -pr /defaults/games/* /config/.minetest/games/
fi

chown -R abc:abc /config/.minetest
