# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2024 <grapenskrskr@gmail.com>

include $(TOPDIR)/rules.mk

PKG_NAME:=clean-ipt
PKG_RELEASE:=1

PKG_LICENSE:=GPL-2.0-only

include $(INCLUDE_DIR)/package.mk

define Package/clean-ipt
  SECTION:=net
  CATEGORY:=Network
  TITLE:=For cleaning up iptables rule mixups
  DEPENDS:=+firewall4
  PKGARCH:=all
endef

define Build/Compile
endef

define Package/clean-ipt/install
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_BIN) ./files/clean-ipt.sh $(1)/etc/
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/clean-ipt $(1)/etc/uci-defaults/
endef

define Package/clean-ipt/postinst
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || sed -i '/clean-ipt/d' /etc/crontabs/root
[ -n "$${IPKG_INSTROOT}" ] || echo "0/5 * * * * /etc/clean-ipt.sh" >> /etc/crontabs/root
[ -n "$${IPKG_INSTROOT}" ] || crontab /etc/crontabs/root
endef

$(eval $(call BuildPackage,clean-ipt))
