#!/bin/bash
# Copyright 2014-2026 Joseph Brendler
# SPDX-License-Identifier: GPL-3.0-or-later
#
# I used to do this by hacking into my router and digging out the wan ip
# version 1 (2014) used python request, supplying username and password for
#   the router admin page (I don't like storing pwds,
#   and routers evolved to defeat this with script-based login pages)
#
# version 2 (2019) used shhpass --
#   sshpass -p"${p}" ssh -o "${opts}" ${user}@${ip} "${rcmd}" | cut -d',' -f4 | uniq
#
# version 3 (2023) exploits the trick that the speedtest utility reports
#   the local router's wan ip
#
# I've identified two ways to parse the results
# (1) speedtest --csv | cut -d',' -f11
# (2) speedtest --json | jq -r '.client.ip'
#
# version3, method 2 relies on app-misc/jq as well as
#                    net-analyzer/speedtest-cli
#  but it should be more stable
#speedtest --json | jq -r '.client.ip'
#
#
# note - it is also possible to do this with neofetch, fastfetch, etc - example --
# fastfetch --logo-type none -s PublicIp  ==>  Public IP: 123.456.789.123 (Fairfax, US)
# (speedtest may be more reliable, fastfetch may be more private, faster)
#
# note - curl ipify is considered best practice:
curl -s https://api.ipify.org
#
# and for MINIMAL privacy "leakage" - dig works
# dig +short myip.opendns.com @resolver1.opendns.com
# but that wont work for me because I have shorewall block DNS-bypass to upstream
