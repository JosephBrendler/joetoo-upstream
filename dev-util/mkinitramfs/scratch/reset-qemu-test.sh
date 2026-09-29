#!/bin/bash
# Copyright 2025-2026 Joseph Brendler
# SPDX-License-Identifier: GPL-3.0-or-later
#

source /usr/sbin/script_header_joetoo

base="/home/joe/myUtilities/dev-util/mkinitramfs/scratch"

notice_msg_n "moving to ${base}"
cd "${base}"
handle_result $? "$PWD" "$PWD"

[ -z "$base" ] && { error_msg "error: base is unset"; exit 1; }

find ./ -type d -iname 'initramfs*' -exec rm -rf {} \;

find ./boot -type f -delete
find ./boot -type l -delete
