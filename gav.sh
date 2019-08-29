#! /bin/bash
# Execute a command in each of the listed Vulkan GitHub repos.
# http://mew.cx/


for i in \
    KhronosGroup/glslang \
    KhronosGroup/Vulkan-Headers \
    KhronosGroup/Vulkan-Loader \
    KhronosGroup/Vulkan-Tools \
    KhronosGroup/Vulkan-ValidationLayers \
    LunarG/VulkanSamples \
    LunarG/VulkanTools
do
    cd "/home/mikew/gits/github.com/$i"
    echo -e "\n{ \"$i\""
    eval "$@"
    echo -e "} \$?=$?\n"
done

# vim: set sw=4 ts=8 et ic ai:
