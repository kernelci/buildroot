################################################################################
#
# bootrr
#
################################################################################

BOOTRR_SITE = https://github.com/kernelci/bootrr.git
BOOTRR_VERSION = 3ae9fd5dffc667fa96012892ea08532bc6877276
BOOTRR_SITE_METHOD = git
BOOTRR_LICENSE = LGPL-2.1+


BOOTRR_VERSION = staging.kernelci.org
BR_NO_CHECK_HASH_FOR += $(BOOTRR_SOURCE)

define BOOTRR_INSTALL_TARGET_CMDS
	DESTDIR=$(TARGET_DIR)/opt/bootrr $(MAKE) -C $(@D) install
endef

$(eval $(generic-package))
