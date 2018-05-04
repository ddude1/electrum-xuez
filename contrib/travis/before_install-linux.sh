#!/bin/bash

if [[ -z $TRAVIS_TAG ]]; then
  exit 0
fi

cd build

docker build -f Dockerfile-linux -t ddude1/electrum-xuez-release:Linux .
./python-xevan_hash-wine.sh
./python-trezor-wine.sh
docker build -f Dockerfile-wine -t ddude1/electrum-xuez-release:Wine .
