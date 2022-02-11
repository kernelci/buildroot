################################################################################
#
# bootrr
#
################################################################################

BOOTRR_SITE = https://github.com/kernelci/bootrr.git
BOOTRR_VERSION = eb40eaeda023fbf313a25165887b3338ff73c93b
BOOTRR_SITE_METHOD = git
BOOTRR_LICENSE = LGPL-2.1+

define BOOTRR_INSTALL_TARGET_CMDS
	DESTDIR=$(TARGET_DIR)/opt/bootrr $(MAKE) -C $(@D) install
endef

$(eval $(generic-package))
