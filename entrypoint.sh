#!/usr/bin/env bash
set -e

IMAGE="fopina/dedroid:v2"

if [ -z "$1" ]; then
	cat <<EOF
This is a docker image with tools to analyze APKs.

Get the help script with:
	docker run --rm fopina/dedroid helper > helper.sh

Or just use the shell freely:
	docker run --rm -v PATH_TO_APK_DIR:/work -ti fopina/dedroid sh

Check https://github.com/fopina/docker-dedroid/blob/master/README.md for more info.
EOF
elif [ "$1" == "helper" ]; then
	cat /helper.tmpl
else
	exec "$@"
fi