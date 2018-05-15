#!/bin/bash
BUILD_REPO_URL=https://github.com/ddude1/electrum-xuez.git

cd build

if [[ -z $TRAVIS_TAG ]]; then
  exit 0
else
  git clone --branch $TRAVIS_TAG $BUILD_REPO_URL electrum-xuez
fi

cd electrum-xuez

export PY36BINDIR=/Library/Frameworks/Python.framework/Versions/3.6/bin/
export PATH=$PATH:$PY36BINDIR
source ./contrib/travis/electrum_xuez_version_env.sh;
echo wine build version is $ELECTRUM_XUEZ_VERSION

sudo pip3 install -r contrib/requirements.txt
sudo pip3 install \
    x11_hash>=1.4 \
    btchip-python==0.1.24 \
    keepkey==4.0.2 \
    trezor==0.7.16

sudo pip3 install git+git://github.com/ddude1/Xevan_in_Python.git	

pyrcc5 icons.qrc -o gui/qt/icons_rc.py

cp contrib/osx.spec .
cp contrib/pyi_runtimehook.py .
cp contrib/pyi_tctl_runtimehook.py .

pyinstaller \
    -y \
    --name electrum-xuez-$ELECTRUM_XUEZ_VERSION.bin \
    osx.spec

sudo hdiutil create -fs HFS+ -volname "Electrum-XUEZ" \
    -srcfolder dist/Electrum-XUEZ.app \
    dist/electrum-xuez-$ELECTRUM_XUEZ_VERSION-macosx.dmg
