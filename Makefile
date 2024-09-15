# SPDX-License-Identifier: GPL-2.0-only
# # Copyright (C) 2024 <grapenskrskr@gmail.com>

include $(TOPDIR)/rules.mk

PKG_NAME:=clean-iptables
PKG_RELEASE:=1

PKG_LICENSE:=GPL-2.0-only

include $(INCLUDE_DIR)/package.mk

define Package/clean-iptables
  SECTION:=net
  CATEGORY:=Network
  TITLE:=For cleaning up iptables rule mixups
  DEPENDS:=+firewall4
  PKGARCH:=all
endef

define Build/Compile
endef

define Package/clean-iptables/install
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_BIN) ./files/clean-iptables.sh $(1)/etc/

  $(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/clean-iptables $(1)/etc/uci-defaults/clean-iptables
endef

define Package/clean-iptables/postinst
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || sed -i '/clean-iptables/d' /etc/crontabs/root
[ -n "$${IPKG_INSTROOT}" ] || echo "0 3 * * * /etc/clean-iptables.sh" >> /etc/crontabs/root
[ -n "$${IPKG_INSTROOT}" ] || crontab /etc/crontabs/root
endef

$(eval $(call BuildPackage,clean-iptables))