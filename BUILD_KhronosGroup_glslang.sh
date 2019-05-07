#! /bin/bash -x

# From https://github.com/mikew-lunarg/glslang/blob/fork_master/README.md
#       git clone git@github.com:KhronosGroup/glslang.git
#       git clone https://github.com/google/googletest.git External/googletest
#       ./update_glslang_sources.py

set -o errexit
set -o nounset

cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

./update_glslang_sources.py

INSTALL_DIR="${HOME}/VK_INSTALL"

#rm -rf BUILD
mkdir -p BUILD
cd BUILD

CMAKE="cmake --debug-output --trace-expand"
CMAKE="cmake"

# CMAKE_BUILD_TYPE : Debug | Release | RelWithDebInfo

$CMAKE \
    -DCMAKE_BUILD_TYPE="Debug" \
    -DUSE_CCACHE="ON" \
    -DCMAKE_INSTALL_PREFIX="$INSTALL_DIR" \
    .. \
    |& tee 000_CMAKE_LOG.txt

# (cd ../..; tar zcvf BUILD-glslang.tgz glslang/BUILD)

make VERBOSE=1 -j4 install |& tee 111_BUILD_LOG.txt

# vim: set sw=4 ts=8 et ic ai:
