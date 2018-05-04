Electrum-XUEZ - Lightweight Xuez client
=====================================

::

  Licence: MIT Licence
  Author: Thomas Voegtlin
  Language: Python
  Homepage: https://electrum-xuez.org/


.. image:: https://travis-ci.org/akhavr/electrum-xuez.svg?branch=develop
    :target: https://travis-ci.org/akhavr/electrum-xuez
    :alt: Build Status





Getting started
===============

Electrum-XUEZ is a pure python application. If you want to use the
Qt interface, install the Qt dependencies::

    sudo apt-get install python-qt4

If you downloaded the official package (tar.gz), you can run
Electrum-XUEZ from its root directory, without installing it on your
system; all the python dependencies are included in the 'packages'
directory. To run Electrum-XUEZ from its root directory, just do::

    ./electrum-xuez

You can also install Electrum-XUEZ on your system, by running this command::

    python setup.py install

This will download and install the Python dependencies used by
Electrum-XUEZ, instead of using the 'packages' directory.

If you cloned the git repository, you need to compile extra files
before you can run Electrum-XUEZ. Read the next section, "Development
Version".



Development version
===================

Check out the code from Github::

    git clone https://github.com/akhavr/electrum-xuez
    cd electrum-xuez

Run install (this should install dependencies)::

    python setup.py install

Compile the icons file for Qt::

    sudo apt-get install pyqt4-dev-tools
    pyrcc4 icons.qrc -o gui/qt/icons_rc.py

Compile the protobuf description file::

    sudo apt-get install protobuf-compiler
    protoc --proto_path=lib/ --python_out=lib/ lib/paymentrequest.proto

Create translations (optional)::

    sudo apt-get install python-pycurl gettext
    ./contrib/make_locale




Creating Binaries
=================


To create binaries, create the 'packages' directory::

    ./contrib/make_packages

This directory contains the python dependencies used by Electrum.

Mac OS X
--------

::

    # On MacPorts installs:
    sudo python setup-release.py py2app

    # On Homebrew installs:
    ARCHFLAGS="-arch i386 -arch x86_64" sudo python setup-release.py py2app --includes sip

    sudo hdiutil create -fs HFS+ -volname "Electrum" -srcfolder dist/Electrum.app dist/electrum-VERSION-macosx.dmg

Windows
-------

See `contrib/build-wine/README` file.


Android
-------

See `gui/kivy/Readme.txt` file.