#! /bin/bash -x
# http://mew.cx/ 2019-07-03
# Full clean of all Vulkan repos

set -o nounset

INSTALL_DIR="${HOME}/VK_INSTALL"

clean_repo() {
    cd "/home/mikew/gits/github.com/${1}/${2}"
    rm -f "000_BUILD.sh"
    rm -rf BUILD/
}

# Make it so ################################################################

clean_repo KhronosGroup glslang
clean_repo KhronosGroup Vulkan-Headers
clean_repo KhronosGroup Vulkan-Loader
clean_repo KhronosGroup Vulkan-Tools
clean_repo KhronosGroup Vulkan-ValidationLayers
clean_repo LunarG VulkanTools
clean_repo LunarG VulkanSamples
rm -rf "$INSTALL_DIR"

# vim: set et sw=4 ts=8 ic ai:
