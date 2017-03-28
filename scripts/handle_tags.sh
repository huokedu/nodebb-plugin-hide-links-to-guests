#!/bin/bash

major=$(cat package.json | tr -d '\n' | sed -r 's/.*"version": "([0-9]+).*/\1/')
minor=$(cat package.json | tr -d '\n' | sed -r 's/.*"version": "[0-9]+.([0-9]+).*([0-9]+).*/\1/')
version="$major.$minor"

tagname="v$major.$minor.0"

diffval=$(git diff HEAD^ HEAD)
if (echo "$diffval" | grep -q "+  \"version\": \""); then
    tmpver=$(echo "$diffval" | grep "\-  \"version\": \"" | sed -r 's/.*"version": "([0-9]+.[0-9]+).*([0-9]+).*/\1/')
    if [ "$version" != "$tmpver" ]; then
        echo "major or minor version changed ! Creating tag $tagname !"
        git tag -a "$tagname" -m "Auto tagging $tagname"
    fi
fi

exit 0
