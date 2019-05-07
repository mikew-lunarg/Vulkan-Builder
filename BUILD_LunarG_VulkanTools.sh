#! /bin/bash -x
# LunarG_VulkanTools

set -o errexit
set -o nounset

cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

INSTALL_DIR="${HOME}/VK_INSTALL"

./update_external_sources.sh

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
    -DVULKAN_LOADER_INSTALL_DIR="$INSTALL_DIR" \
    -DVULKAN_VALIDATIONLAYERS_INSTALL_DIR="$INSTALL_DIR" \
    -DBUILD_TESTS="ON" \
    -DBUILD_VKTRACE="ON" \
    -DBUILD_VLF="ON" \
    -DBUILD_VIA="ON" \
    .. \
    |& tee 000_CMAKE_LOG.txt

# ( cd ../..; tar zcvf BUILD-vtl.tgz VulkanTools/BUILD )

make VERBOSE=1 -j install |& tee 111_BUILD_LOG.txt

# vim: set sw=4 ts=8 et ic ai:
