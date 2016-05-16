#
# Copyright (C) 2015-2016 WANGFUYU
#
#
include $(TOPDIR)/rules.mk

PKG_NAME:=libcyassl2
PKG_VERSION:=3.3.0
PKG_RELEASE:=1

PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

PKG_FIXUP:=autoreconf

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/ -rf
endef

define Package/libcyassl2
  SECTION:=libs
  SUBMENU:=Libraries
  CATEGORY:=WANGFUYU Proprietary Software
  TITLE:=CyaSSL library 3.3.0
  DEPENDS:=+libpthread +librt
endef

define Package/libcyassl2/description
CyaSSL is an SSL library optimized for small footprint, both on disk and for
memory use.
endef

TARGET_CFLAGS += $(FPIC)

	
define Build/Configure
	$(call Build/Configure/Default, \
	--disable-fastmath \
	--enable-opensslextra \
	--enable-dtls	\
	)
endef
	
define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/* $(1)/usr/include/

	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libcyassl.{so*,la} $(1)/usr/lib/
endef

define Package/libcyassl2/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libcyassl.so* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,libcyassl2))
