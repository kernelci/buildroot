################################################################################
#
# bootrr
#
################################################################################

BOOTRR_SITE = https://github.com/kernelci/bootrr.git
BOOTRR_VERSION = e0a316de59153ecd4373b14063b0280505ce6e2e
BOOTRR_SITE_METHOD = git
BOOTRR_LICENSE = LGPL-2.1+

define BOOTRR_INSTALL_TARGET_CMDS
	DESTDIR=$(TARGET_DIR)/opt/bootrr $(MAKE) -C $(@D) install
endef

$(eval $(generic-package))
