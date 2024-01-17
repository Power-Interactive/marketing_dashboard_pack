#!/usr/bin/bash

while read -r F; do

    mv $F ${F%.*}.sql

done < <(find ./view  -mindepth 1 -maxdepth 1 -type f -name "*.bak")

while read -r F; do

    mv $F ${F%.*}.sql

done < <(find ./function  -mindepth 1 -maxdepth 1 -type f -name "*.bak")


