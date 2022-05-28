#!/bin/sh

source .env

sed -i -e "s/{DEVELOPMENT_TEAM}/$DEVELOPMENT_TEAM/g"  project.yml
mint run xcodegen