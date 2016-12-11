#!/bin/bash

cd "${0%/*}"
. ../common.sh

echo "Processing TF2..."

ProcessDepot ".dylib"
ProcessVPK

mono ../.support/SourceDecompiler/Decompiler.exe -i "tf/tf2_misc_dir.vpk" -o "tf/tf2_misc_dir/"

#iconv -t UTF-8 -f UCS-2 -o "tf/tf/resource/tf_english_utf8.txt" "tf/tf/resource/tf_english.txt"

if ! [[ $1 = "no-git" ]]; then
	CreateCommit "$(grep "PatchVersion=" tf/steam.inf | grep -o '[0-9\.]*')"
fi
