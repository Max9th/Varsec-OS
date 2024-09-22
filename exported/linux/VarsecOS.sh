#!/bin/sh
echo -ne '\033c\033]0;Vasec OS\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/VarsecOS.x86_64" "$@"
