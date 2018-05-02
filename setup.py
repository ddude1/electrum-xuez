#!/usr/bin/env python2

# python setup.py sdist --format=zip,gztar

from setuptools import setup
import os
import sys
import platform
import imp
import argparse

version = imp.load_source('version', 'lib/version.py')

if sys.version_info[:3] < (2, 7, 0):
    sys.exit("Error: Electrum-XUEZ requires Python version >= 2.7.0...")

data_files = []

if platform.system() in ['Linux', 'FreeBSD', 'DragonFly']:
    parser = argparse.ArgumentParser()
    parser.add_argument('--root=', dest='root_path', metavar='dir', default='/')
    opts, _ = parser.parse_known_args(sys.argv[1:])
    usr_share = os.path.join(sys.prefix, "share")
    if not os.access(opts.root_path + usr_share, os.W_OK) and \
       not os.access(opts.root_path, os.W_OK):
        if 'XDG_DATA_HOME' in os.environ.keys():
            usr_share = os.environ['XDG_DATA_HOME']
        else:
            usr_share = os.path.expanduser('~/.local/share')
    data_files += [
        (os.path.join(usr_share, 'applications/'), ['electrum-xuez.desktop']),
        (os.path.join(usr_share, 'pixmaps/'), ['icons/electrum-xuez.png'])
    ]

setup(
    name="Electrum-XUEZ",
    version=version.ELECTRUM_VERSION,
    install_requires=[
        'pyaes',
        'ecdsa>=0.9',
        'pbkdf2',
        'requests',
        'qrcode',
        'protobuf',
        'dnspython',
        'jsonrpclib',
        'PySocks>=1.6.6',
        'trezor>=0.6.3',
        'x11_hash>=1.4',
    ],
    dependency_links=[
        'git+https://github.com/akhavr/x11_hash@1.4#egg=x11_hash-1.4',
        'git+https://github.com/electrum-xuez/python-trezor@v0.6.13#egg=trezor',
    ],
    packages=[
        'electrum_xuez',
        'electrum_xuez_gui',
        'electrum_xuez_gui.qt',
        'electrum_xuez_plugins',
        'electrum_xuez_plugins.audio_modem',
        'electrum_xuez_plugins.cosigner_pool',
        'electrum_xuez_plugins.email_requests',
        'electrum_xuez_plugins.hw_wallet',
        'electrum_xuez_plugins.keepkey',
        'electrum_xuez_plugins.labels',
        'electrum_xuez_plugins.ledger',
        'electrum_xuez_plugins.trezor',
        'electrum_xuez_plugins.digitalbitbox',
        'electrum_xuez_plugins.virtualkeyboard',
    ],
    package_dir={
        'electrum_xuez': 'lib',
        'electrum_xuez_gui': 'gui',
        'electrum_xuez_plugins': 'plugins',
    },
    package_data={
        'electrum_xuez': [
            'currencies.json',
            'www/index.html',
            'wordlist/*.txt',
            'locale/*/LC_MESSAGES/electrum.mo',
        ]
    },
    scripts=['electrum-xuez'],
    data_files=data_files,
    description="Lightweight Xuezpay Wallet",
    author="akhavr",
    license="MIT License",
    url="https://electrum-xuez.org",
    long_description="""Lightweight Xuezpay Wallet"""
)
