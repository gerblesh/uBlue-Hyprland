#!/usr/bin/env bash

default_cache_home=~/.cache
cache_home="${XDG_CACHE_HOME:-$default_cache_home}"
mkdir -p "$cache_home"
data_file="$cache_home/emoji-menu.json"

if ! [ -f "$data_file" ]; then
    curl -o "$data_file" -L "https://github.com/github/gemoji/raw/master/db/emoji.json"
fi

filter='.[] | (.emoji + " " + .description + " (" + (.aliases | join(", ")) + ")")'
sel="$(jq -r "$filter" <"$data_file" | fuzzel --dmenu --prompt " Select Emoji:  " | cut -d ' ' -f 1 | tr -d '\n')"
if [ -n "$sel" ]; then
    wl-copy "$sel"
    wtype "$sel"
fi
