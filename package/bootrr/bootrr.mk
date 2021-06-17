################################################################################
#
# bootrr
#
################################################################################

BOOTRR_SITE = https://github.com/kernelci/bootrr.git
BOOTRR_VERSION = f00862c8406f81ef62449b5c0267e010e3be3d3f
BOOTRR_SITE_METHOD = git
BOOTRR_LICENSE = LGPL-2.1+


BOOTRR_VERSION = staging.kernelci.org
BR_NO_CHECK_HASH_FOR += $(BOOTRR_SOURCE)

define BOOTRR_INSTALL_TARGET_CMDS
	DESTDIR=$(TARGET_DIR)/opt/bootrr $(MAKE) -C $(@D) install
endef

$(eval $(generic-package))
