#!/bin/bash

if [[ $TRAVIS_PYTHON_VERSION != 3.4 ]]; then
  exit 0
fi

if [[ -z $TRAVIS_TAG ]]; then
  exit 0
fi

cd build

BUILD_REPO_URL=https://github.com/ddude1/electrum-xuez.git
git clone --branch $TRAVIS_TAG $BUILD_REPO_URL electrum-xuez

docker run --rm \
    -v $(pwd):/opt \
    -w /opt/electrum-xuez \
    -t zebralucky/electrum-xuez-winebuild:Linux /opt/build_linux.sh

export WINEARCH=win32
export WINEPREFIX=/root/.wine-32
export PYHOME=$WINEPREFIX/drive_c/Python34

docker run --rm \
    -e WINEARCH=$WINEARCH \
    -e WINEPREFIX=$WINEPREFIX \
    -e PYHOME=$PYHOME \
    -v $(pwd):/opt \
    -v $(pwd)/electrum-xuez/:$WINEPREFIX/drive_c/electrum-xuez \
    -w /opt/electrum-xuez \
    -t zebralucky/electrum-xuez-winebuild:Wine /opt/build_wine.sh

export WINEARCH=win64
export WINEPREFIX=/root/.wine-64
export PYHOME=$WINEPREFIX/drive_c/Python34

docker run --rm \
    -e WINEARCH=$WINEARCH \
    -e WINEPREFIX=$WINEPREFIX \
    -e PYHOME=$PYHOME \
    -v $(pwd):/opt \
    -v $(pwd)/electrum-xuez/:$WINEPREFIX/drive_c/electrum-xuez \
    -w /opt/electrum-xuez \
    -t zebralucky/electrum-xuez-winebuild:Wine /opt/build_wine.sh
