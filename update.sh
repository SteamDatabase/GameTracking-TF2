#!/bin/bash

cd "${0%/*}"
. ../common.sh

echo "Processing TF2..."

ProcessDepot ".dylib"
ProcessVPK

while IFS= read -r -d '' file
do
	# https://github.com/xPaw/EntityLumpDumper
	/home/steamdb/EntityLumpDumper/EntityLumpDumper/bin/Release/linux-x64/publish/EntityLumpDumper "$file"
done <   <(find "tf/maps/" -type f -name "*.bsp" -print0)

while IFS= read -r -d '' file
do
	# https://github.com/foobarhl/vice_standalone
	# build: g++ -o bin/vice src/*.cpp
	/home/steamdb/vice_standalone/bin/vice -d -x .txt -k E2NcUkG2 "$file"
done <   <(find "tf/tf2_misc_dir/scripts/playerclasses/" "tf/tf2_misc_dir/scripts/" -maxdepth 1 -type f -name "*.ctx" -print0)

FixUCS2

CreateCommit "$(grep "PatchVersion=" tf/steam.inf | grep -o '[0-9\.]*')" "$1"
