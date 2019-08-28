#! /bin/bash
# http://mew.cx/ 2019-03-20
# Main script for totally-clean build of all Vulkan repos

set -o nounset

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd -P )"
cd "$SCRIPT_DIR"

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
    OWNER="${1}"
    REPO="${2}"
    cd "/home/mikew/gits/github.com/${OWNER}/${REPO}"
    cp "$SCRIPT_DIR/repo_tools/${OWNER}/${REPO}/000_BUILD.sh" "."
    describe_repo >> "$DESC_FILE"
    echo -e "\n\n\nBUILD $(pwd -P) ========================================================\n"
    rm -rf BUILD/

    time "./000_BUILD.sh" "$INSTALL_DIR"

    find "$INSTALL_DIR" -type f > "$INSTALL_DIR/manifest_${REPO}"
}

# Make it so ################################################################

(echo "START ${BASH_SOURCE[0]}"; date; echo; describe_repo) >> "$DESC_FILE"

cp "setup-env.sh" "$INSTALL_DIR"

build_repo KhronosGroup glslang
build_repo KhronosGroup Vulkan-Headers
build_repo KhronosGroup Vulkan-Loader
build_repo KhronosGroup Vulkan-Tools
build_repo KhronosGroup Vulkan-ValidationLayers
build_repo LunarG VulkanTools

(echo "FINISH ${BASH_SOURCE[0]}"; date) >> "$DESC_FILE"

echo -e "\n${BASH_SOURCE[0]} completed successfully"
date

# vim: set et sw=4 ts=8 ic ai:
