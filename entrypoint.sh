#!/usr/bin/env bash
set -e

if [ -z "$1" ]; then
	cat <<EOF
This is a docker image with tools to analyze APKs.

Get the help script with:
	docker run --rm $DEDROID helper > /usr/local/bin/dedroid

Or just use the shell freely:
	docker run --rm -v PATH_TO_APK_DIR:/work -ti $DEDROID sh

Check out https://github.com/fopina/docker-dedroid/blob/master/README.md for more info.
EOF
elif [ "$1" == "helper" ]; then
	cat <<EOF
#!/bin/bash

IMAGE=$DEDROID

EOF
	cat /helper.tmpl
else
	exec "$@"
fi