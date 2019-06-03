################################################################################
#
# bootrr
#
################################################################################

BOOTRR_SITE = https://github.com/kernelci/bootrr.git
BOOTRR_VERSION = ea2a0f215327f99f90227a382bbdf2c6abe763f6
BOOTRR_SITE_METHOD = git
BOOTRR_LICENSE = LGPL-2.1+

define BOOTRR_INSTALL_TARGET_CMDS
	DESTDIR=$(TARGET_DIR)/opt/bootrr $(MAKE) -C $(@D) install
endef

$(eval $(generic-package))
