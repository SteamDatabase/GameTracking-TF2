#!/bin/bash

cd "${0%/*}"
. ../common.sh

echo "Processing TF2..."

ProcessDepot ".dylib"
ProcessVPK
FixUCS2

CreateCommit "$(grep "PatchVersion=" tf/steam.inf | grep -o '[0-9\.]*')" "$1"
