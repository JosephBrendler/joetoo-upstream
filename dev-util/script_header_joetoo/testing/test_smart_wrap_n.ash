#!/bin/sh
# Copyright 2014-2026 Joseph Brendler
# SPDX-License-Identifier: GPL-3.0-or-later

# test_smart_wrap_n.ash - smart_wrap_n v0.2.0 test battery

script_header_installed_dir=/home/joe/joetoo-upstream/dev-util/script_header_joetoo

echo -n "sourcing test header"
source "${script_header_installed_dir}/script_header_joetoo"
right_status $? "$notice"

#-----[ variables ]------------------------------------------------------------------------------------

_test_case=$1
_verbosity="${2:-"${notice}"}"
FULLNAME="$0"
PN=${0##*/}

# setup environment
#export COLUMNS=40
#_tw=40
_indent=10

#-----[ functions ]------------------------------------------------------------------------------------

usage() {
  j_msg "-${err}" -p "usage: ${PN} [test_case]"
  printf "\n"
  j_msg "-${notice}" -p "${BYon}Current test inventory --${Boff}"
  grep -E '${W1}[0-9]${W1})' "${FULLNAME}"
}

do_test() {
  _tc=$1
  case "$_tc" in
    1 ) # test 1: far-right start (greedy wrap)
      separator "greedy wrap test"
      j_msg "-${notice}" -p "parameters 35 $_indent $_indent"
      printf "\r"; CUF 35
      # function should see it is at 35, realize "greedy" won't fit, and wrap to 10
      verbosity="${_verbosity}" smart_wrap_n 35 "$_indent" "$_indent" This sentence should jump to a new line and indent to ten immediately.
      printf "\n"
      ;;
    2 ) # test 2: fragment finish (short string)
      separator "fragment finish test"
      j_msg "-${notice}" -p "parameters 5 $_indent $_indent"
      printf "\r"; CUF 5
      # function should see it is at 5, realize the whole thing fits, and print on one line
      verbosity="${_verbosity}" smart_wrap_n 5 "$_indent" "$_indent" Small fragment.
      printf "\n"
      ;;
    3 ) # test 3: impossible word (emergency fallback)
      separator "impossible word test"
      j_msg "-${notice}" -p "parameters 0 $_indent $_indent"
      # tests the "case 4" emergency print to prevent infinite loops
      # the word is 50 chars, terminal is 40.
      _long_word="ThisIsAWordThatIsWayLongerThanTheTerminalWidthLimit"
      verbosity="${_verbosity}" smart_wrap_n 0 "$_indent" "$_indent" "$_long_word" and then some normal text.
      printf "\n"
      ;;
    4 ) # test 4: indent vs current col sync
      separator "indent sync test"
      j_msg "-${notice}" -p "parameters 20 5 5"
      printf "\r"; CUF 20
      # current=20, indent=5. first line stays at 20, wrap goes to 5.
      verbosity="${_verbosity}" smart_wrap_n 20 5 5 This starts at twenty but wraps back to five to show the hanging indent works.
      printf "\n"
      ;;
    5 ) # test 5: ansi safety check
      separator "ansi safety test"
      j_msg "-${notice}" -p "parameters 0 5 5"
      verbosity="${_verbosity}" smart_wrap_n 0 5 5 Normal text ${BGon}Green_Word_That_Is_Long_And_Colored${Boff} Normal text again.
      printf "\n"
        unset -v _tc
      ;;
    * )  j_msg "-${err}" -p "invalid test_case [$_test_case]"; usage;;
  esac
  return 0
}

#-----[ main script ]------------------------------------------------------------------------------------
checkroot
separator "$PN" "(starting)"
j_msg "-${notice}" -p "${LBon}input test_case${Boff}: [${Mon}${_test_case}${Boff}]"
j_msg "-${notice}" -p "dimensions: $(termwidth)x$(termheight)"
j_msg "-${notice}" -p "verbosity: $_verbosity"

if isnumber "${_test_case}"; then
  do_test "${_test_case}"
else
  j_msg "-${err}" -p "input test_case either null or invalid, running full sequence (CTRL-C to cancel)"
  for x in $(seq 1 5); do
    do_test "${x}"
  done
fi
separator "$PN" "(done)"
