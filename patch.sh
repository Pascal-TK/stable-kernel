#!/bin/bash
#
# Copyright (c) 2009-2012 Robert Nelson <robertcnelson@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# Split out, so build_kernel.sh and build_deb.sh can share..

echo "Starting patch.sh"

function git_add {
git add .
git commit -a -m 'testing patchset'
}

function bugs_trivial {
echo "bugs and trivial stuff"

patch -s -p1 < "${DIR}/patches/trivial/0001-kbuild-deb-pkg-set-host-machine-after-dpkg-gencontro.patch"

#should fix gcc-4.6 ehci problems..
#Safe to remove?
#Maverick: gcc-4.4: ehci=okay
#Natty: gcc-4.5: ehci=okay
#Oneiric: gcc-4.6: ehci=okay
#Precise armel: gcc-4.6: ehci=okay
#Precise armhf: gcc-4.6: ehci=?
#Squeeze: gcc-4.4: ehci=okay
#Wheezy: gcc-4.6: ehci=okay
#Sid armel: gcc-4.6: ehci=?
#Sid armhf: gcc-4.6: ehci=?
#patch -s -p1 < "${DIR}/patches/trivial/0001-USB-ehci-use-packed-aligned-4-instead-of-removing-th.patch"
}

function cpufreq {
echo "[git] omap-cpufreq"
git pull git://github.com/RobertCNelson/linux.git omap_cpufreq_v3.2-rc4
}

function micrel {
echo "[git] Micrel KZ8851 patches for: zippy2"
#original from:
#ftp://www.micrel.com/ethernet/8851/beagle_zippy_patches.tar.gz 137 KB 04/10/2010 12:26:00 AM
git pull git://github.com/RobertCNelson/linux.git micrel_ks8851_v3.2-rc3
}

function beagle {
echo "[git] Board Patches for: BeagleBoard"
git pull git://github.com/RobertCNelson/linux.git omap_beagle_expansion_v3.2-rc3
patch -s -p1 < "${DIR}/patches/beagle/ulcd/0001-beagle-ulcd-fix-tsc2007-touchreen.patch"

patch -s -p1 < "${DIR}/patches/arago-project/0001-omap3-Increase-limit-on-bootarg-mpurate.patch"
patch -s -p1 < "${DIR}/patches/display/0001-meego-modedb-add-Toshiba-LTA070B220F-800x480-support.patch"

patch -s -p1 < "${DIR}/patches/beagle/0001-ASoC-omap-add-MODULE_ALIAS-to-mcbsp-and-pcm-drivers.patch"
patch -s -p1 < "${DIR}/patches/beagle/0001-ASoC-omap-convert-per-board-modules-to-platform-driv.patch"
patch -s -p1 < "${DIR}/patches/beagle/0001-beagleboard-reinstate-usage-of-hi-speed-PLL-divider.patch"
}

function dspbridge {
echo "[git] dspbridge"
git pull git://github.com/RobertCNelson/linux.git dspbridge_v3.2-rc3
}

function omapdrm {
echo "[git] testing omapdrm"
echo "[git] pulling cma_v17"
git pull git://github.com/RobertCNelson/linux.git cma_v17_v3.2-rc2
echo "[git] pulling drm driver"
git pull git://github.com/RobertCNelson/linux.git omapdrm_v3.2-rc3
}

function sakoman {
echo "sakoman's patches"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0006-OMAP-DSS2-add-bootarg-for-selecting-svideo-or-compos.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0007-video-add-timings-for-hd720.patch"

patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0025-omap-mmc-Adjust-dto-to-eliminate-timeout-errors.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0026-OMAP-Overo-Add-support-for-spidev.patch"
}

function musb {
echo "musb patches"
patch -s -p1 < "${DIR}/patches/musb/0001-default-to-fifo-mode-5-for-old-musb-beagles.patch"
}

function devkit8000 {
echo "devkit8000"
patch -s -p1 < "${DIR}/patches/devkit8000/0001-arm-omap-devkit8000-for-lcd-use-samsung_lte_panel-2.6.37-git10.patch"
}

function touchbook {
echo "touchbook patches"
patch -s -p1 < "${DIR}/patches/touchbook/0001-omap3-touchbook-remove-mmc-gpio_wp.patch"
patch -s -p1 < "${DIR}/patches/touchbook/0002-omap3-touchbook-drop-u-boot-readonly.patch"
}

function omap4 {
echo "omap4 related patches"
patch -s -p1 < "${DIR}/patches/panda/0001-panda-fix-wl12xx-regulator.patch"
}

function fixes {
echo "cherry pick fixes"
git am "${DIR}/patches/fixes/0001-ARM-OMAP-AM3517-3505-fix-crash-on-boot-due-to-incorr.patch"
git am "${DIR}/patches/fixes/0001-ARM-OMAP4-hwmod-Don-t-wait-for-the-idle-status-if-mo.patch"
git am "${DIR}/patches/fixes/0001-ARM-OMAP4-clock-Add-CPU-local-timer-clock-node.patch"
git am "${DIR}/patches/fixes/0001-ARM-OMAP3-hwmod-data-disable-multiblock-reads-on-MMC.patch"
git am "${DIR}/patches/fixes/0001-OMAP-HWMOD-add-es3plus-to-am36xx-am35xx.patch"
}

function sgx {
echo "merge in ti sgx modules"
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-Merge-TI-3.01.00.02-Kernel-Modules.patch"
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-enable-driver-building.patch"

#3.01.00.06
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-Merge-TI-3.01.00.06-into-TI-3.01.00.02.patch"

#3.01.00.07 'the first wget-able release!!'
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-Merge-TI-3.01.00.07-into-TI-3.01.00.06.patch"

#4.00.00.01 adds ti8168 support, drops bc_cat.c patch
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-Merge-TI-4.00.00.01-into-TI-3.01.00.07.patch"

#4.03.00.01
#Note: git am has problems with this patch...
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-Merge-TI-4.03.00.01-into-TI-4.00.00.01.patch"

#4.03.00.02 (main *.bin drops omap4)
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-Merge-TI-4.03.00.02-into-TI-4.03.00.01.patch"

#4.05.00.03
patch -s -p1 < "${DIR}/patches/sgx/0001-TI-SGX-Merge-4.05.00.03-into-4.03.00.02.patch"

#4.03.00.02
#drop with 4.05.00.03
#patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-TI-4.03.00.02-2.6.32-PSP.patch"

#4.03.00.02 + 2.6.38-merge (2.6.37-git5)
#drop with 4.05.00.03
#patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-TI-4.03.00.02-2.6.38-merge-AUTOCONF_INCLUD.patch"

#4.03.00.02 + 2.6.38-rc3
#drop with 4.05.00.03
#patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-TI-4.03.00.02-2.6.38-rc3-_console_sem-to-c.patch"

#4.03.00.01
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-TI-4.03.00.01-add-outer_cache.clean_all.patch"

#4.03.00.02
#omap3 doesn't work on omap3630
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-TI-4.03.00.02-use-omap3630-as-TI_PLATFORM.patch"

#4.03.00.02 + 2.6.39 (2.6.38-git2)
#drop with 4.05.00.03
#patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-TI-4.03.00.02-2.6.39-rc-SPIN_LOCK_UNLOCKED.patch"

#4.03.00.02 + 2.6.40 (2.6.39-git11)
#drop with 4.05.00.03
#patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-TI-4.03.00.02-2.6.40-display.h-to-omapdss..patch"

#with v3.0-git16
#drivers/staging/omap3-sgx/services4/3rdparty/dc_omapfb3_linux/omaplfb_linux.c:324:15: error: ‘OMAP_DSS_UPDATE_AUTO’ undeclared (first use in this function)
#drivers/staging/omap3-sgx/services4/3rdparty/dc_omapfb3_linux/omaplfb_linux.c:327:15: error: ‘OMAP_DSS_UPDATE_MANUAL’ undeclared (first use in this function)
#drivers/staging/omap3-sgx/services4/3rdparty/dc_omapfb3_linux/omaplfb_linux.c:330:15: error: ‘OMAP_DSS_UPDATE_DISABLED’ undeclared (first use in this function)
#drivers/staging/omap3-sgx/services4/3rdparty/dc_omapfb3_linux/omaplfb_linux.c:337:16: error: ‘struct omap_dss_driver’ has no member named ‘set_update_mode’
#drivers/staging/omap3-sgx/services4/3rdparty/dc_omapfb3_linux/omaplfb_linux.c:312:28: warning: unused variable ‘eDSSMode’
#make[4]: *** [drivers/staging/omap3-sgx/services4/3rdparty/dc_omapfb3_linux/omaplfb_linux.o] Error 1
#make[3]: *** [drivers/staging/omap3-sgx/services4/3rdparty/dc_omapfb3_linux] Error 2
#make[2]: *** [drivers/staging/omap3-sgx] Error 2
#for <3.2
#patch -s -p1 < "${DIR}/patches/sgx/0001-Revert-OMAP-DSS2-remove-update_mode-from-omapdss.patch"
#for >3.2
patch -s -p1 < "${DIR}/patches/sgx/0001-Revert-OMAP-DSS2-remove-update_mode-from-omapdss-v3.2.patch"

}

bugs_trivial

#patches in git
cpufreq
micrel
beagle
dspbridge
#omapdrm

#work in progress

#external tree's
sakoman
musb

#random board patches
devkit8000
touchbook

#omap4/dvfs still needs more testing..
omap4

fixes

#no chance of being pushed ever tree's
sgx

echo "patch.sh ran successful"

