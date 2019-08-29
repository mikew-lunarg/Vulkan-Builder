#! /bin/bash -x
# KhronosGroup_glslang

# From https://github.com/mikew-lunarg/glslang/blob/fork_master/README.md
#       git clone git@github.com:KhronosGroup/glslang.git
#       git clone https://github.com/google/googletest.git External/googletest
#       ./update_glslang_sources.py

set -o errexit
set -o nounset

cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [ ! -d "External/googletest" ]
then
    git clone https://github.com/google/googletest.git External/googletest
fi

./update_glslang_sources.py

INSTALL_DIR="${HOME}/VK_INSTALL"

#rm -rf BUILD
mkdir -p BUILD
cd BUILD

cp ../known_good.json .
git describe --long --tags --dirty > git_describe.txt

CMAKE="cmake --debug-output --trace-expand"
CMAKE="cmake"

# CMAKE_BUILD_TYPE : Debug | Release | RelWithDebInfo

$CMAKE \
    -DCMAKE_BUILD_TYPE="Debug" \
    -DUSE_CCACHE="ON" \
    -DCMAKE_INSTALL_PREFIX="$INSTALL_DIR" \
    ..

# (cd ../..; tar zcvf BUILD-glslang.tgz glslang/BUILD)

make VERBOSE=1 -j4 install

# vim: set sw=4 ts=8 et ic ai:
