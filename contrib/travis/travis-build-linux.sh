#!/bin/bash
BUILD_REPO_URL=https://github.com/akhavr/electrum-xuez.git

cd build

if [[ -z $TRAVIS_TAG ]]; then
  exit 0
else
  git clone --branch $TRAVIS_TAG $BUILD_REPO_URL electrum-xuez
fi

docker run --rm -v $(pwd):/opt -w /opt/electrum-xuez -t akhavr/electrum-xuez-release:Linux /opt/build_linux.sh
docker run --rm -v $(pwd):/opt -v $(pwd)/electrum-xuez/:/root/.wine/drive_c/electrum -w /opt/electrum-xuez -t akhavr/electrum-xuez-release:Wine /opt/build_wine.sh
