#!/bin/sh

printf "Create xdg standard directories, if needed"
mkdir -p "$HOME"/.cache
mkdir -p "$HOME"/.config
mkdir -p "$HOME"/.local/share
