#!/bin/bash

filename="./README.md"
major=$(cat package.json | tr -d '\n' | sed -r 's/.*"version": "([0-9]+).*/\1/')
minor=$(cat package.json | tr -d '\n' | sed -r 's/.*"version": "[0-9]+.([0-9]+).*([0-9]+).*/\1/')
version="$major.$minor"
tagname=$(git describe --abbrev=0 --tags 2> /dev/null)
if (( $? )) ; then
    build=$(git rev-list HEAD | wc -l | tr -d '\n' | tr -d ' ')
else
    build=$(git rev-list  "$tagname..HEAD" --count)
fi
build=$(($build+1))

diffval=$(git diff HEAD^)
if (echo "$diffval" | grep -q "+  \"version\": \""); then
    tmpver=$(echo "$diffval" | grep "\-  \"version\": \"" | sed -r 's/.*"version": "([0-9]+.[0-9]+).*([0-9]+).*/\1/')
    if [ "$version" != "$tmpver" ]; then
        build="0"
    fi
fi

buildd="${build}_"
sed -i "s/_Current repository version : .*_/_Current repository version : v$major.$minor.$buildd/" README.md
sed -i "s/  \"version\": \".*\",/  \"version\": \"$major.$minor.$build\",/" package.json
git add README.md package.json

echo "Detected version: $major.$minor.$build"

exit 0
