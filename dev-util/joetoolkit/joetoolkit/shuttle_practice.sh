#!/bin/sh
# Copyright 2025-2026 Joseph Brendler
# SPDX-License-Identifier: GPL-3.0-or-later
#
# shuttle_practice.sh - demonstrate shuttlecock animation using joetoo header tools

# shellcheck source=/usr/sbin/script_header_joetoo.shellcheck_var_stub
# shellcheck source=/usr/sbin/script_header_joetoo.shellcheck_func_stub
. /home/joe/joetoo-upstream/dev-util/script_header_joetoo/script_header_joetoo

PN=${0##*/}   #  like =$(basename $0) but w/o subshell and function call

BUILD=$(date +%Y%m%d)

[ -z "$verbosity" ] && verbosity="${notice}"  # assign default if null; allow calling program to dictate

_dh_cock="${BRon}-*-${Boff}"
_dh_wait=30   # milliseconds
_dh_cycles=2
_dh_i=0


# create room in case the cursor is at the bottom of the screen (newline twice then up 1)
printf "\n\n"; CUU 1

separator "$(hostname)" "${PN}-${BUILD}"

message "hello"

HCU
# complete 2 cycles of move to the right and back to the left
_dh_cycle=0
while [ $_dh_cycle -lt "$_dh_cycles" ]; do
  # return to left margin (resets every thing (more important in second+ cycle)
  printf "\r"
  j_msg "-${notice}" -p -n "shuttle zone: [                    ]"
  # return to start of shuttle-zone
  CUB 21
  #draw the shuttlecock
  printf "%s" "${_dh_cock}"; milli_sleep "${_dh_wait}"; CUB 3
  # note: starting cursor location (col the NEXT print goes into) is [ + 4
  _dh_i=0
  while [ $_dh_i -lt 17 ]; do     # 21 - 4 = 17 is collision with ]
  # shift shuttle right
    printf "%s" " ${_dh_cock}"; milli_sleep "${_dh_wait}"; CUB 3
     _dh_i=$((_dh_i + 1))
  done
  # note: cursor location was on top of ] after last shuttlecock print,
  #    but we then did CUB 3 as in every iteration of the prior loop
  #    so - to initialize properly for the next loop we need to more
  #    to the position each of its iterations will end at, and
  #    because its first act is CUB 5, we need to CUF 4 to get to ]+1
  CUF 4
  while [ $_dh_i -gt 0 ]; do     # should be same # of steps to get back
  # shift shuttle right
    CUB 5; printf "%s" "${_dh_cock} "; milli_sleep "${_dh_wait}"
     _dh_i=$((_dh_i - 1))
  done
  _dh_cycle=$((_dh_cycle + 1))
done
SCU
# emit newline to move current line up and ensure it stays visible
printf "\n"

echo "PN: $PN"
PN2=$(basename "$0"); echo "PN2: $PN2"
