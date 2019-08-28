#! /bin/bash
# http://mew.cx/ 2019-03-20
# Main script for totally-clean build of all Vulkan repos

set -o nounset

SCRIPT_NAME="${BASH_SOURCE[0]}"
SCRIPT_DIR="$(cd "$(dirname "$SCRIPT_NAME}")" >/dev/null 2>&1 && pwd -P)"
cd "$SCRIPT_DIR"

INSTALL_DIR="${HOME}/VK_INSTALL"
[ ! -e "$INSTALL_DIR" ] || { echo "Installation directory \"$INSTALL_DIR\" already exists.  exiting."; exit 1; }

INFO_DIR="$INSTALL_DIR/info"
DESC_FILE="$INFO_DIR/repo_descriptions.txt"

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

    BUILD_SCRIPT="000_BUILD_${OWNER}_${REPO}.sh"
    cp "$SCRIPT_DIR/repo_tools/$BUILD_SCRIPT" "."
    cp "$SCRIPT_DIR/repo_tools/$BUILD_SCRIPT" "$INFO_DIR"

    describe_repo >> "$DESC_FILE"
    echo -e "\n\n\nBUILD $(pwd -P) ========================================================\n"
    rm -rf BUILD/

    time "./$BUILD_SCRIPT" "$INSTALL_DIR"

    find "$INSTALL_DIR" -type f | sort > "$INFO_DIR/999_manifest_${OWNER}_${REPO}.txt"
}

# Make it so ################################################################

mkdir -p "$INSTALL_DIR"
mkdir -p "$INFO_DIR"
cp "setup-env.sh" "$INFO_DIR"
(pwd; echo -e "\nSTART ${SCRIPT_NAME}"; date; echo; describe_repo) >> "$DESC_FILE"

build_repo KhronosGroup glslang
build_repo KhronosGroup Vulkan-Headers
build_repo KhronosGroup Vulkan-Loader
build_repo KhronosGroup Vulkan-Tools
build_repo KhronosGroup Vulkan-ValidationLayers
build_repo LunarG VulkanSamples
build_repo LunarG VulkanTools

(echo "FINISH ${SCRIPT_NAME}"; date) >> "$DESC_FILE"

echo -e "\n${SCRIPT_NAME} completed successfully"
date

# vim: set et sw=4 ts=8 ic ai:
