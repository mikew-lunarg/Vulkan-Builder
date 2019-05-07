#! /bin/bash -x
# KhronosGroup_Vulkan-ValidationLayers

#       git clone https://github.com/google/googletest.git external/googletest
#       ( cd external/googletest; git checkout tags/release-1.8.1 )

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
    -DGLSLANG_INSTALL_DIR="$INSTALL_DIR" \
    -DBUILD_LAYERS="ON" \
    -DBUILD_LAYER_SUPPORT_FILES="ON" \
    -DBUILD_TESTS="ON" \
    -DINSTALL_TESTS="ON" \
    .. \
    |& tee 000_CMAKE_LOG.txt

# ( cd ../..; tar zcvf BUILD-vvl.tgz Vulkan-ValidationLayers/BUILD )

make VERBOSE=1 -j4 install |& tee 111_BUILD_LOG.txt


# portability setup =========================================================

# portability build products:
#    BUILD/layers/VkLayer_portability_validation.json
#    BUILD/layers/libVkLayer_portability_validation.so

# Prepend named layers to vkCreateInstance's ppEnabledLayerNames list.
# Delimited list: Linux colon-delimited; Windows semicolon-delimited
#export VK_INSTANCE_LAYERS="VK_LAYER_LUNARG_portability_validation"

# validation layer tests ====================================================

# error, warn, info, debug, all
#export VK_LOADER_DEBUG="debug"
#export VK_LOADER_DEBUG="all"

cd tests
echo "DISPLAY = ${DISPLAY:=:0}"
export DISPLAY

VK_LAYER_PATH="../layers" \
    ./vk_layer_validation_tests \
    |& tee ../222_TEST_LOG.txt

#    --gtest_filter=VkLayerTest.ResolveImageTypeMismatch \

# vim: set sw=4 ts=8 et ic ai:
