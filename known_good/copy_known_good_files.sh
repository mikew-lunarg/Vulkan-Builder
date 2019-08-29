#! /bin/bash

cd ~/gh
for i in \
    KhronosGroup/Vulkan-Headers/scripts/known_good.json \
    KhronosGroup/Vulkan-Loader/scripts/known_good.json \
    KhronosGroup/Vulkan-Tools/scripts/known_good.json \
    KhronosGroup/Vulkan-ValidationLayers/scripts/known_good.json \
    LunarG/VulkanSamples/scripts/known_good.json \
    LunarG/VulkanTools/scripts/known_good.json
do
    echo -e "\t$i"
    jq -M '.repos[] | "\(.name) \(.commit)"' < "$i"
    echo
done

# vim: set sw=4 ts=8 et ic ai:
