#! /bin/bash
# Print known_good references for each repo

GH="/home/mikew/gits/github.com"

for i in \
    KhronosGroup/Vulkan-Loader \
    KhronosGroup/Vulkan-ValidationLayers \
    KhronosGroup/Vulkan-Tools \
    LunarG/VulkanSamples \
    LunarG/VulkanTools
do
    cd "${GH}/$i"
    echo -n -e "\n### $i "
    git describe --long --tags --dirty
    jq -M '.repos[] | "\(.name) \(.commit)"' < "scripts/known_good.json"
done

# vim: set sw=4 ts=8 et ic ai:
