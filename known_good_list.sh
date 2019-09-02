#! /bin/bash

GH="/home/mikew/gits/github.com"

for i in \
    KhronosGroup/Vulkan-Loader \
    KhronosGroup/Vulkan-Tools \
    KhronosGroup/Vulkan-ValidationLayers \
    LunarG/VulkanSamples \
    LunarG/VulkanTools
do
    echo -e "\n# $i"
    KNOWN_GOOD_FILE="${GH}/$i/scripts/known_good.json"
    jq -M '.repos[] | "\(.name) \(.commit)"' < "$KNOWN_GOOD_FILE" | sort
done

# vim: set sw=4 ts=8 et ic ai:
