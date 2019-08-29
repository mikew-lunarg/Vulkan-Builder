#! /bin/bash -x
# LunarG_VulkanSamples

set -o errexit
set -o nounset

cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

INSTALL_DIR="${HOME}/VK_INSTALL"

#rm -rf BUILD
mkdir -p BUILD
cd BUILD

cp ../scripts/known_good.json .
git describe --long --tags --dirty > git_describe.txt

CMAKE="cmake --debug-output --trace-expand"
CMAKE="cmake"

# CMAKE_BUILD_TYPE : Debug | Release | RelWithDebInfo

$CMAKE \
    -DCMAKE_BUILD_TYPE="Debug" \
    -DUSE_CCACHE="ON" \
    -DCMAKE_INSTALL_PREFIX="$INSTALL_DIR" \
    -DVULKAN_HEADERS_INSTALL_DIR="$INSTALL_DIR" \
    -DVULKAN_LOADER_INSTALL_DIR="$INSTALL_DIR" \
    -DGLSLANG_INSTALL_DIR="$INSTALL_DIR" \
    ..

# ( cd ../..; tar zcvf BUILD-vtl.tgz VulkanSamples/BUILD )

make VERBOSE=1 -j4 install

# vim: set sw=4 ts=8 et ic ai:
