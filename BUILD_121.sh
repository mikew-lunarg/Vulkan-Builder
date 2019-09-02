#! /bin/bash -x

./888_CLEAN_all.sh

ivr git ru
ivr git rbmm
ivr git co "_v1.1.121"

./000_BUILD_all.sh

