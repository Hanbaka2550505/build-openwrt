#!/bin/bash
#========================================================================================================================
# https://github.com/ophub/amlogic-s9xxx-openwrt
# Description: Automatically Build OpenWrt
# Function: Diy script (After Update feeds, Modify the default IP, hostname, theme, add/remove software packages, etc.)
# Source code repository: https://github.com/immortalwrt/immortalwrt / Branch: master
#========================================================================================================================

# ------------------------------- Main source started -------------------------------
#
# 设置 root 密码（Change the empty password to 'password'）
sed -i 's/root:::0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.::0:99999:7:::/g' package/base-files/files/etc/shadow

# 修改版本号
sed -i "s|DISTRIB_REVISION='.*'|DISTRIB_REVISION='R$(date +%Y.%m.%d)'|g" package/base-files/files/etc/openwrt_release
# 修改主机名
echo "DISTRIB_SOURCECODE='XR30'" >>package/base-files/files/etc/openwrt_release

# Modify default IP（FROM 192.168.1.1 CHANGE TO 192.168.25.4）
sed -i 's/192.168.1.1/192.168.25.4/g' package/base-files/files/bin/config_generate
#
# ------------------------------- Main source ends -------------------------------

# ------------------------------- Other started -------------------------------
#
# 添加常用插件（推荐）
svn co https://github.com/kenzok8/openwrt-packages/tree/master/luci-app-lucky/luci-app-lucky package/luci-app-lucky
svn co 

# 默认主题
sed -i "s/luci-theme-bootstrap/luci-theme-argon/g" feeds/luci/collections/luci/Makefile
# Apply patch
# git apply ../config/patches/{0001*,0002*}.patch --directory=feeds/luci
#
# ------------------------------- Other ends -------------------------------
