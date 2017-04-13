#!/bin/bash

cd "${0%/*}"
. ../common.sh

echo "Processing TF2..."

ProcessDepot ".dylib"
ProcessVPK

mono ../.support/SourceDecompiler/Decompiler.exe -i "tf/tf2_misc_dir.vpk" -o "tf/tf2_misc_dir/"

echo "Fixing UCS-2"

while IFS= read -r -d '' file
do
        if ! file --mime "$file" | grep "charset=utf-16le"
        then
                continue
        fi

        temp_file=$(mktemp)
        iconv -t UTF-8 -f UCS-2 -o "$temp_file" "$file" &&
        mv -f "$temp_file" "$file"
done <   <(find . -name "*.txt" -type f -print0)

if ! [[ $1 = "no-git" ]]; then
	CreateCommit "$(grep "PatchVersion=" tf/steam.inf | grep -o '[0-9\.]*')"
fi
