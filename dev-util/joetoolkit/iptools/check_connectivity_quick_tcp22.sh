#!/bin/bash
# Copyright 2009-2026 Joseph Brendler
# SPDX-License-Identifier: GPL-3.0-or-later

source /usr/sbin/script_header_joetoo

PN=${0##*/}   # basename

user="joe"
dns="elrond"
domain="brendler"
jobs="$(nproc)"   # concurrency limit

usage() { j_msg "-${err}" "usage: $PN [-[4|6]] [<target>]"; exit 1; }

# to do: convert to either /dev/tcp or nc -zv, include -P --parallel flag

# if needed for clients, use indexed array to receive data from dns
declare -a hosts_file_lines

# use associative array of targets (hostnames) keyed on ip addresses
# (note: ea ip has one host name, but any hostname may have 1+ ips)
declare -A targets

# generalize for clients as well as router

if [[ "$(hostname)" == "$dns" ]]; then
    # read each hosts file
    for x in /etc/hosts.d/[12]*; do
        # populate targets array with hosts file data
        while read -r ip host rest; do
            [[ -z "$ip" || "$ip" == \#* ]] && continue # Skip empty/comments
            targets["$ip"]="$host"
        done < "$x"
    done
else
    # use user's ssh to get hosts file lines from dns into indexed array
    # (get 14_*/16_*/20_* files; exclude slow piggies likely non-ssh) (skip empty/comments; dont incl filename prefix)
    readarray -t hosts_file_lines < <(ssh -q "${user}@${dns}.${domain}" grep -vh "^${W0}#" /etc/hosts.d/[12]* | sed "/^${W0}$/d")
    # transfer data to associative array
    for line in "${hosts_file_lines[@]}"; do
        read -r ip host rest <<< "$line"
        targets["$ip"]="$host"
    done
fi
#report
j_msg "-${notice}" -p "ingested: [${#targets[@]}]"

# use /dev/tcp to test-connect to each target on port 22 (ssh)
# (background each task to effectively do this in parallel)
_job_count=0   # track and limit concurrency
{ for ip in "${!targets[@]}"; do (
      host="${targets[$ip]}"
      { timeout 1 bash -c "</dev/tcp/${ip}/22" && \
        echo -e "${ip} (${host}) is ${BGon}Up${Boff}" || \
        echo -e "${ip} (${host}) is ${BRon}Down${Boff}" ;
      } 2>/dev/null &
  ) ; if (( ++_jp_count % "$jobs" == 0 )); then wait -n; fi ;   # limit job concurrency
  done; wait;   # wait to ensure parallel jobs are done
} | sed "/^${W0}$/d"   # strip whitespace-only (blank) lines from output
