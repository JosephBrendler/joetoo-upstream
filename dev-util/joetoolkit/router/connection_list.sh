#!/bin/bash
# Copyright 2016-2026 Joseph Brendler
# SPDX-License-Identifier: GPL-3.0-or-later
# based on former connection_now_list.sh

source /usr/sbin/script_header_joetoo
source /usr/sbin/script_header_joetoo_router

#-----[ local variables ]-------------------------------------------------------------

PN=${0##*/}   # basename

#BUILD=0.0.001a
if [ -f /etc/joetoolkit/BUILD ]; then . /etc/joetoolkit/BUILD; else BUILD=0.0.001b; fi

#conntrackFile=/proc/net/ip_conntrack
conntrackFile=/proc/net/nf_conntrack

#---[ main script ]--------------------------------------------------------------------

current_connection_filter() {
  cat ${conntrackFile} | \
    grep -v "sport=53" | \
    grep -v "dst=192.168" | \
    grep -v "dst=fd62" | \
    cut -d'=' -f3 | \
    cut -d' ' -f1
}

#---[ main script ]--------------------------------------------------------------------
separator "$(hostname)" "${PN}-${BUILD}"
checkroot

j_msg -${notice} -p "current connections"
# use script_header_joetoo_router functions to complete the task
ingest_ip_array current_connection_filter
identify_ip_hits
