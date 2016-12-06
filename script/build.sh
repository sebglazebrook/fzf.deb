#!/bin/bash -u

VERSION_NUMBER=${1}

docker build -t fzf-debian-pkg-builder .

CONTAINER_ID=$(docker create -e VERSION_NUMBER="$VERSION_NUMBER" fzf-debian-pkg-builder)

docker start -ai ${CONTAINER_ID}

docker cp ${CONTAINER_ID}:/tmp/fzf_${VERSION_NUMBER}.deb .

mkdir -p releases/$VERSION_NUMBER/ && mv fzf_${VERSION_NUMBER}.deb releases/$VERSION_NUMBER/
