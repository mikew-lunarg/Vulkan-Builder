#! /bin/bash
# http://mew.cx/ 2019-03-20

set -o errexit
set -o nounset
set -o physical

KHRONOS_REPO_DIR="$HOME/gits/github.com/KhronosGroup/"

echo "FETCH glslang ==============================================================="
cd "$KHRONOS_REPO_DIR/glslang"
rm -rf External/
git remote update --prune
git checkout .
git checkout master
git rebase origin/master
git checkout mikew_master
git rebase origin/master
#git clone https://github.com/google/googletest.git External/googletest
./update_glslang_sources.py

echo "FETCH Vulkan-Headers ========================================================"
cd "$KHRONOS_REPO_DIR/Vulkan-Headers"
git remote update --prune
git checkout .
git checkout master
git rebase origin/master
git checkout mikew_master
git rebase origin/master

echo "FETCH Vulkan-Loader ========================================================="
cd "$KHRONOS_REPO_DIR/Vulkan-Loader"
git remote update --prune
git checkout .
git checkout master
git rebase origin/master
git checkout mikew_master
git rebase origin/master

echo "FETCH Vulkan-Tools =========================================================="
cd "$KHRONOS_REPO_DIR/Vulkan-Tools"
git remote update --prune
git checkout .
git checkout master
git rebase origin/master
git checkout mikew_master
git rebase origin/master

echo "FETCH Vulkan-ValidationLayers ==============================================="
cd "$KHRONOS_REPO_DIR/Vulkan-ValidationLayers"
rm -rf external/
git remote update --prune
git checkout .
git checkout master
git rebase origin/master
git checkout mikew_master
git rebase origin/master
git clone https://github.com/google/googletest.git external/googletest
( cd external/googletest; git checkout tags/release-1.8.1 )

echo "SUCCESS ====================================================================="

# vim: set et sw=4 ts=8 ic ai:
