################################################################################
#
# bootrr
#
################################################################################

BOOTRR_SITE = https://github.com/kernelci/bootrr.git
BOOTRR_VERSION = 5ba7f37eeac503ef9b5cba4a1060990384d5c32c
BOOTRR_SITE_METHOD = git
BOOTRR_LICENSE = LGPL-2.1+

define BOOTRR_INSTALL_TARGET_CMDS
	DESTDIR=$(TARGET_DIR)/opt/bootrr $(MAKE) -C $(@D) install
endef

$(eval $(generic-package))
