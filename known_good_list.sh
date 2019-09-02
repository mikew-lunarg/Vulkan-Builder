#! /bin/bash

GH="/home/mikew/gits/github.com"

for i in \
    KhronosGroup/Vulkan-Loader \
    KhronosGroup/Vulkan-Tools \
    KhronosGroup/Vulkan-ValidationLayers \
    LunarG/VulkanSamples \
    LunarG/VulkanTools
do
    cd "${GH}/$i"
    echo -n -e "\n### $i "
    git describe --long --tags --dirty
    jq -M '.repos[] | "\(.name) \(.commit)"' < "scripts/known_good.json"
done

# vim: set sw=4 ts=8 et ic ai:
