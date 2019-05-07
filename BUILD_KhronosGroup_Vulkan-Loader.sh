#! /bin/bash -x

set -o errexit
set -o nounset

cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

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
    -DVULKAN_HEADERS_INSTALL_DIR="$INSTALL_DIR" \
    .. \
    |& tee 000_CMAKE_LOG.txt

# ( cd ../..; tar zcvf BUILD-vl.tgz Vulkan-Loader/BUILD )

make VERBOSE=1 -j install |& tee 111_BUILD_LOG.txt

# vim: set sw=4 ts=8 et ic ai:
