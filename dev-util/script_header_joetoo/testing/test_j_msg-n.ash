#!/bin/sh
# Copyright 2014-2026 Joseph Brendler
# SPDX-License-Identifier: GPL-3.0-or-later

# test_j_msg-n.ash v0.1.0

script_header_installed_dir=/home/joe/joetoo-upstream/dev-util/script_header_joetoo

echo -n "sourcing test header"
source "${script_header_installed_dir}/script_header_joetoo"
right_status $? "$notice"

_verbosity="${1:-"${notice}"}"

#-----[ variables ]------------------------------------------------------------------------------------
PN=${0##*/}
_long_msg="This is a very long message designed to trigger the smart_wrap_n layout engine within j_msg -n."
_long_msg="${_long_msg} It should start at column three and every subsequent wrapped line should also align"
_long_msg="${_long_msg} perfectly at column three to create a clean text block."

#-----[ execution ]------------------------------------------------------------------------------------
separator "${PN}" "(1 - announce pending action)"

# case 1: short statement, silent action, and right_status on same line
verbosity="$_verbosity" j_msg "-${notice}" -p -n "Sourcing unicode header silently..."
source "${script_header_installed_dir}/script_header_joetoo_unicode" > /dev/null 2>&1
right_status $? "${notice}"  # right_status generates a newline

verbosity="$_verbosity" j_msg "-${notice}" -p -n "Sourcing unicode head a, b, c, d, & e"
source "${script_header_installed_dir}/script_header_joetoo_unicode" > /dev/null 2>&1
right_status $? "${notice}"   # right_status generates a newline

verbosity="$_verbosity" j_msg "-${notice}" -p -n "Sourcing unicode head a, b, c, d, e"
source "${script_header_installed_dir}/script_header_joetoo_unicode" > /dev/null 2>&1
right_status $? "${notice}"   # right_status generates a newline

separator "${PN}" "(2 - smart-word-wrap long message)"

# case 2: long message requiring word-wrap
# terminal width check for context
j_msg "-${notice}" -p "Terminal Width: $(termwidth)"
verbosity="$_verbosity" j_msg "-${notice}" -p -n "${_long_msg}"
printf "\n"    # the test function generates the newline to continue

separator "${PN}" "(Done)"
