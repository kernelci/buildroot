################################################################################
#
# ca-certificates
#
################################################################################

CA_CERTIFICATES_VERSION = 20260816+nmu1
CA_CERTIFICATES_SOURCE = ca-certificates_$(CA_CERTIFICATES_VERSION).tar.xz
CA_CERTIFICATES_SITE = https://deb.debian.org/debian/pool/main/c/ca-certificates
CA_CERTIFICATES_DEPENDENCIES = host-openssl host-python3
HOST_CA_CERTIFICATES_DEPENDENCIES = host-openssl host-python3
CA_CERTIFICATES_LICENSE = GPL-2.0+ (script), MPL-2.0 (data)
CA_CERTIFICATES_LICENSE_FILES = debian/copyright

define CA_CERTIFICATES_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) clean all
endef

define CA_CERTIFICATES_INSTALL_TARGET_CMDS
	rm -rf $(TARGET_DIR)/usr/share/ca-certificates/mozilla
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/share/ca-certificates
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/etc/ssl/certs
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) install DESTDIR=$(TARGET_DIR)
	rm -f $(TARGET_DIR)/usr/sbin/update-ca-certificates
endef

define CA_CERTIFICATES_GEN_BUNDLE
	# Remove any existing certificates under /etc/ssl/certs
	rm -f $(TARGET_DIR)/etc/ssl/certs/*

	# Create symlinks to certificates under /etc/ssl/certs
	# and generate the bundle
	cd $(TARGET_DIR) ;\
	for i in `find usr/share/ca-certificates -name "*.crt" | LC_COLLATE=C sort` ; do \
		ln -sf ../../../$$i etc/ssl/certs/`basename $${i} .crt`.pem ;\
		cat $$i ;\
	done >$(BUILD_DIR)/ca-certificates.crt

	# Create symlinks to the certificates by their hash values
	$(HOST_DIR)/bin/c_rehash $(TARGET_DIR)/etc/ssl/certs

	# Install the certificates bundle
	$(INSTALL) -D -m 644 $(BUILD_DIR)/ca-certificates.crt \
		$(TARGET_DIR)/etc/ssl/certs/ca-certificates.crt
endef
CA_CERTIFICATES_TARGET_FINALIZE_HOOKS += CA_CERTIFICATES_GEN_BUNDLE

define HOST_CA_CERTIFICATES_BUILD_CMDS
	$(HOST_MAKE_ENV) $(MAKE) -C $(@D) clean all
endef

define HOST_CA_CERTIFICATES_INSTALL_CMDS
	rm -rf $(HOST_DIR)/share/ca-certificates/mozilla
	# Remove the misplaced certificates left by older host package installs.
	# check-package ignore DoNotInstallToHostdirUsr
	rm -rf $(HOST_DIR)/usr/share/ca-certificates/mozilla
	$(INSTALL) -d -m 0755 $(HOST_DIR)/share/ca-certificates
	$(INSTALL) -d -m 0755 $(HOST_DIR)/etc/ssl/certs
	$(HOST_MAKE_ENV) $(MAKE) -C $(@D) install DESTDIR=$(HOST_DIR) \
		CERTSDIR=/share/ca-certificates SBINDIR=/sbin
	rm -f $(HOST_DIR)/sbin/update-ca-certificates
	# Remove any existing certificates under /etc/ssl/certs
	rm -f $(HOST_DIR)/etc/ssl/certs/*

	# Create symlinks to certificates under /etc/ssl/certs
	# and generate the bundle
	cd $(HOST_DIR) ;\
	for i in `find share/ca-certificates -name "*.crt" | LC_COLLATE=C sort` ; do \
		ln -sf ../../../$$i etc/ssl/certs/`basename $${i} .crt`.pem ;\
		cat $$i ;\
	done >$(BUILD_DIR)/ca-certificates.crt

	# Create symlinks to the certificates by their hash values
	$(HOST_DIR)/bin/c_rehash $(HOST_DIR)/etc/ssl/certs

	# Install the certificates bundle
	$(INSTALL) -D -m 644 $(BUILD_DIR)/ca-certificates.crt \
		$(HOST_DIR)/etc/ssl/certs/ca-certificates.crt
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
