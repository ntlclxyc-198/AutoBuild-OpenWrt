#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate
#sed -i 's/interfaces/#interfaces/' package/network/services/samba36/files/smb.conf.template
#sed -i 's/MOSQUITTO_LWS:libwebsockets-openssl/MOSQUITTO_LWS:libwebsockets-full/' feeds/packages/net/mosquitto/Makefile
sed -i "20s/REJECT/ACCEPT/g" package/network/config/firewall/files/firewall.config
sed -i "$a config rule\n\toption name 'Open Samba WAN'\n	option src 'wan'\n	option proto 'tcp udp'\n	option dest_port '137 138 139 445'\n	option target 'ACCEPT'\nconfig redirect\n	option name 'wan samba'\n	option src 'wan'\n	option src_dport '137 138 139 445'\n	option dest 'lan'\n	option proto 'tcp udp'" package/network/config/firewall/files/firewall.config
sed -i "s/interfaces\s=\s|INTERFACES|/#interfaces\s=\s|INTERFACES|/g"  package/network/services/samba36/files/smb.conf.template
sed -i "s/option\sInterface\s*'lan'/#option Interface 'lan'/g"  package/network/services/dropbear/files/dropbear.config
sed -i 	"s/'@lan'/'@lan @wan'/g" feeds/packages/utils/ttyd/files/ttyd.config
sed -i 	"s/MOSQUITTO_LWS:libwebsockets-openssl/MOSQUITTO_LWS:libwebsockets-full/g" feeds/packages/net/mosquitto/Makefile
sed -i 	"s/sed\s-i\s's\/root::0:0:99999:7:::/#sed -i 's\/root::0:0:99999:7:::/g" package/lean/default-settings/files/zzz-default-settings
