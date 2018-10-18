#! /bin/sh -x

mkdir KhronosGroup
cd KhronosGroup
git submodule add git@github.com:KhronosGroup/Vulkan-Headers.git
git submodule add git@github.com:KhronosGroup/Vulkan-Loader.git
git submodule add git@github.com:KhronosGroup/Vulkan-Tools.git
git submodule add git@github.com:KhronosGroup/Vulkan-ValidationLayers.git
git submodule add git@github.com:KhronosGroup/glslang.git
cd ..

mkdir LunarG
cd LunarG
git submodule add git@github.com:LunarG/VulkanTools.git
cd ..

