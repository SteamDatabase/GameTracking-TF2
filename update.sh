#!/bin/bash

cd "${0%/*}"
. ../common.sh

echo "Processing TF2..."

ProcessDepot ".dylib"
ProcessVPK

while IFS= read -r -d '' file
do
	/home/steamdb/EntityLumpDumper/EntityLumpDumper/bin/Release/EntityLumpDumper "$file"
done <   <(find "tf/maps/" -type f -name "*.bsp" -print0)

FixUCS2

CreateCommit "$(grep "PatchVersion=" tf/steam.inf | grep -o '[0-9\.]*')" "$1"
