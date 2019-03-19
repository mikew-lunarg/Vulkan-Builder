#! /bin/bash
# http://mew.cx/ 2019-03-20

set -o errexit
set -o nounset
set -o physical

cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

INSTALL_DIR="${HOME}/VK_INSTALL"
[ -e "$INSTALL_DIR" ] && ( echo "must delete $INSTALL_DIR first"; exit 1 )
mkdir -p "$INSTALL_DIR"


describe_repo() {
    pwd -P
    git describe --long --tags --dirty
    git remote -v
    echo
}

build_repo() {
    cd "$1"
    echo
    echo
    echo "BUILD $(pwd -P) ========================================================"
    echo
    describe_repo >> "$INSTALL_DIR/source.txt"
    rm -rf BUILD/
    time ./000_BUILD.sh "$INSTALL_DIR"
}


echo "START ${BASH_SOURCE[0]}" >> "$INSTALL_DIR/source.txt"
date >> "$INSTALL_DIR/source.txt"
echo >> "$INSTALL_DIR/source.txt"
describe_repo >> "$INSTALL_DIR/source.txt"

build_repo "$HOME/gits/github.com/KhronosGroup/glslang"
build_repo "$HOME/gits/github.com/KhronosGroup/Vulkan-Headers"
build_repo "$HOME/gits/github.com/KhronosGroup/Vulkan-Loader"
build_repo "$HOME/gits/github.com/KhronosGroup/Vulkan-Tools"
build_repo "$HOME/gits/github.com/KhronosGroup/Vulkan-ValidationLayers"
build_repo "$HOME/gits/github.com/LunarG/VulkanTools"

echo "FINISH ${BASH_SOURCE[0]}" >> "$INSTALL_DIR/source.txt"
date >> "$INSTALL_DIR/source.txt"

# vim: set et sw=4 ts=8 ic ai:
