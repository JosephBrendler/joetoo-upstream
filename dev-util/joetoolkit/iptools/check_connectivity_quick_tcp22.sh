#!/bin/bash
# Copyright 2009-2026 Joseph Brendler
# SPDX-License-Identifier: GPL-3.0-or-later

source /usr/sbin/script_header_joetoo

PN=${0##*/}   # basename

_fam=""
_action=(ping)

usage() { j_msg -${err} "usage: $PN [-[4|6]] [<target>]"; exit 1; }

# to do: convert to either /dev/tcp or nc -zv, include -P --parallel flag

# use associative array of targets (hostnames) keyed on ip addresses
# (note: ea ip has one host name, but any hostname may have 1+ ips)
declare -A targets

# read each hosts file
for x in /etc/hosts.d/*; do
    # populate targets array with hosts file data
    while read -r ip host rest; do
        [[ -z "$ip" || "$ip" == \#* ]] && continue # Skip empty/comments
        targets["$ip"]="$host"
    done < "$x"
done

#report
j_msg -$notice -p "ingested: [${#targets[@]}]"

# use /dev/tcp to test-connect to each target on port 22 (ssh)
# (background each task to effectively do this in parallel)
{ for ip in "${!targets[@]}"; do (
      host="${targets[$ip]}"
      { timeout 1 bash -c "</dev/tcp/${ip}/22" && \
        echo -e "${ip} (${host}) is ${BGon}Up${Boff}" || \
        echo -e "${ip} (${host}) is ${BRon}Down${Boff}" ;
      } 2>/dev/null &
  ) ; done; wait;      # wait to ensure parallel jobs are done
} | sed "/^${W0}$/d"   # strip whitespace-only (blank) lines from output
