#!/bin/bash
# Copyright 2009-2026 Joseph Brendler
# SPDX-License-Identifier: GPL-3.0-or-later

# reset_locale.sh - reset locale related environment

source /usr/sbin/script_header_joetoo

PN=${0##*/}   # like =$(basename $0), without subshell and function call

if [ -f /etc/joetoolkit/BUILD ]; then . /etc/joetoolkit/BUILD; else BUILD="0.0.1"; fi

[ -z "$verbosity" ] && verbosity="${notice}"
#----[ variables ]-------------------------------------------------------------------------
#----[ variables ]-------------------------------------------------------------------------
#----[ main script ]-----------------------------------------------------------------------
checkroot

separator "${PN}-${BUILD}" "(starting)"
j_msg "-${notice}" -p -M "$idx_rocket" "Launching $PN ..."
locale-gen
eselect locale set en_US.UTF-8
. /etc/profile
locale
printf ' %s ' "$(emoji_safe $flag_chequered)"
msg="${BYon}Now you need to run ${BWon}->${BGon} . /etc/profile ${BWon}<-${BYon} in your own shell${Boff}"
j_msg "-${notice}" -mp "$msg"
