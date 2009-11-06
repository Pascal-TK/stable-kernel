#!/bin/bash

KERNEL_REL=2.6.29
#Stable Kernel
#STABLE_PATCH=
#KERNEL_PATCH=${KERNEL_REL}.${STABLE_PATCH}
#DL_PATCH=patch-${KERNEL_PATCH}
BUILD=x45.2
##RC Kernel
#RC_PATCH=rc4
#KERNEL_PATCH=2.6.32-${RC_PATCH}
#DL_PATCH=testing/patch-${KERNEL_PATCH}
#BUILD=${RC_PATCH}.1

GIT=58cf2f1

PV=1.3.13.1607

#USB patches is board specific
BOARD=beagleboard

BUILDREV=1.0
DISTRO=jaunty

export KERNEL_REL STABLE_PATCH KERNEL_PATCH DL_PATCH BUILD GIT BOARD PV BUILDREV DISTRO
