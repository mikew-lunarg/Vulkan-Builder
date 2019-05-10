#! /bin/bash -x

set -o errexit

source "${HOME}/vksdk/setup-env.sh"

export VK_LAYER_PATH="${VULKAN_SDK}/etc/explicit_layer.d"
export VK_INSTANCE_LAYERS="VK_LAYER_LUNARG_device_simulation"

#export VK_DEVSIM_FILENAME="${HOME}/vt/tests/devsim_test1.json"
#export VK_DEVSIM_DEBUG_ENABLE="1"
#export VK_DEVSIM_EXIT_ON_ERROR="1"

vkjson_info | less

jq -S '{properties,features,memory,queues}' device_simulation_layer_test_1.json

#DevSim 1.2.0 : jq -S '{properties,features,memory,queues,formats}' device_simulation_layer_test_1.json

# vim: set sw=4 ts=8 et ic ai:
