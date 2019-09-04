#! /bin/bash -x
# KhronosGroup_Vulkan-ValidationLayers

#       git clone https://github.com/google/googletest.git external/googletest
#       ( cd external/googletest; git checkout tags/release-1.8.1 )

set -o errexit
set -o nounset

cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [ ! -d "external/googletest" ]
then
    git clone https://github.com/google/googletest.git external/googletest
    ( cd external/googletest; git checkout tags/release-1.8.1 )
fi

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
    -DGLSLANG_INSTALL_DIR="$INSTALL_DIR" \
    -DBUILD_LAYERS="ON" \
    -DBUILD_LAYER_SUPPORT_FILES="ON" \
    -DBUILD_TESTS="OFF" \
    -DINSTALL_TESTS="OFF" \
    ..

# ( cd ../..; tar zcvf BUILD-vvl.tgz Vulkan-ValidationLayers/BUILD )

# 'make install' copies artifacts to CMAKE_INSTALL_PREFIX
make VERBOSE=1 -j4 install


# delete unneeded layer_support_files; the remainder are needed.
cd "$INSTALL_DIR"
rm -f include/hash_util.h
rm -f include/hash_vk_types.h
rm -f include/vk_format_utils.cpp
rm -f include/vk_layer_config.cpp
rm -f include/vk_layer_extension_utils.cpp
rm -f include/vk_layer_utils.cpp
rm -f include/vk_safe_struct.cpp
rm -f include/vk_safe_struct.h


# validation layer tests ====================================================

echo "DISPLAY = ${DISPLAY:=:0}"
export DISPLAY

# Loader debugging message level: error, warn, info, debug, all
#export VK_LOADER_DEBUG="debug"
#export VK_LOADER_DEBUG="all"

#export VK_LAYER_PATH="${PWD}/layers"
#cd tests
#./vk_layer_validation_tests

#    --gtest_filter=VkLayerTest.ResolveImageTypeMismatch \

# vim: set sw=4 ts=8 et ic ai:
