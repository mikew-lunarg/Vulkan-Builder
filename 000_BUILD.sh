#! /bin/bash
# http://mew.cx/ 2019-03-20

set -o nounset

cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
START_DIR="$(pwd -P)"

INSTALL_DIR="${HOME}/VK_INSTALL"
[ ! -e "$INSTALL_DIR" ] || { echo "you must delete $INSTALL_DIR first"; exit 1; }
mkdir -p "$INSTALL_DIR"

DESC_FILE="$INSTALL_DIR/repo_descriptions.txt"

describe_repo() {
    pwd -P
    git describe --long --tags --dirty
    git remote -v
    echo
}

build_repo() {
    cd "/home/mikew/gits/github.com/${1}/${2}"
    build_script="BUILD_${1}_${2}.sh"
    cp "${START_DIR}/${build_script}" "."
    echo -e "\n\n\nBUILD $(pwd -P) ========================================================\n"
    describe_repo >> "$DESC_FILE"
    rm -rf BUILD/
    time "./${build_script}"
}

# Make it so ################################################################

(echo "START ${BASH_SOURCE[0]}"; date; echo; describe_repo) >> "$DESC_FILE"

build_repo KhronosGroup glslang
build_repo KhronosGroup Vulkan-Headers
build_repo KhronosGroup Vulkan-Loader
build_repo KhronosGroup Vulkan-Tools
build_repo KhronosGroup Vulkan-ValidationLayers
build_repo LunarG VulkanTools
#build_repo LunarG VulkanSamples

(echo "FINISH ${BASH_SOURCE[0]}"; date) >> "$DESC_FILE"

# vim: set et sw=4 ts=8 ic ai:
