#! /bin/bash -x

( cd ~/gh; tar cvf - \
    KhronosGroup/glslang/known_good.json \
    KhronosGroup/Vulkan-Loader/scripts/known_good.json \
    KhronosGroup/Vulkan-Tools/scripts/known_good.json \
    KhronosGroup/Vulkan-ValidationLayers/scripts/known_good.json \
    LunarG/VulkanTools/scripts/known_good.json \
    LunarG/VulkanSamples/scripts/known_good.json \
) | tar xf -
