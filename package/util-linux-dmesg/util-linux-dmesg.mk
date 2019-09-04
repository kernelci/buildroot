################################################################################
#
# util-linux
#
################################################################################

UTIL_LINUX_DMESG_VERSION_MAJOR = 2.33
UTIL_LINUX_DMESG_VERSION = $(UTIL_LINUX_DMESG_VERSION_MAJOR)
UTIL_LINUX_DMESG_SOURCE = util-linux-$(UTIL_LINUX_DMESG_VERSION).tar.xz
UTIL_LINUX_DMESG_SITE = $(BR2_KERNEL_MIRROR)/linux/utils/util-linux/v$(UTIL_LINUX_DMESG_VERSION_MAJOR)

UTIL_LINUX_DMESG_CONF_OPTS += \
	--without-systemd \
	--disable-rpath \
	--disable-makeinstall-chown \

ifeq ($(BR2_PACKAGE_READLINE),y)
UTIL_LINUX_DMESG_CONF_OPTS += --with-readline
UTIL_LINUX_DMESG_LIBS += $(if $(BR2_STATIC_LIBS),-lcurses)
UTIL_LINUX_DMESG_DEPENDENCIES += readline
else
UTIL_LINUX_DMESG_CONF_OPTS += --without-readline
endif

define UTIL_LINUX_DMESG_BUILD_CMDS
	cd $(@D); \
	./autogen.sh; \
	$(TARGET_CONFIGURE_OPTS) \
	$(TARGET_CONFIGURE_ARGS) \
	$(UTIL_LINUX_DMESG_CONF_ENV) \
	./configure \
		--target=$(GNU_TARGET_NAME) \
		--host=$(GNU_TARGET_NAME) \
		--build=$(GNU_HOST_NAME); \
	$(TARGET_MAKE_ENV) $(MAKE) dmesg
endef

define UTIL_LINUX_DMESG_INSTALL_TARGET_CMDS
	install -m0755 $(@D)/dmesg $(TARGET_DIR)/bin/dmesg
endef

$(eval $(generic-package))
