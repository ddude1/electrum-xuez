test -d xevan_hash || git clone https://github.com/ddude1/Xevan_in_Python.git
(cd xevan_in_Python; git checkout 0.2)

cat  > ./.build-xevan_hash.sh <<EOF
cd /opt/xevan_hash; wine python setup.py build
EOF

docker run --rm -t --privileged -v $(pwd):/opt \
       -e WINEPREFIX="/wine/wine-py2.7.8-32" \
       ogrisel/python-winbuilder \
       sh /opt/.build-xevan_hash.sh
