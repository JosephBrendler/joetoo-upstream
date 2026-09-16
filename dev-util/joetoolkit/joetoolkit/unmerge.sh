#!/bin/bash
# Copyright 2009 Zucca
# Copyright 2016-2026 Joseph Brendler
# SPDX-License-Identifier: GPL-3.0-or-later
#
# unmerge.sh - interactively select packages to remove from the Portage world set
#
# based on "umerge.sh v0.0.2b" posted by Zucca on Gentoo Forums in 2009;
# modified and maintained by Joseph Brendler for joetoolkit since 2016
#
# Original source - https://forums.gentoo.org/viewtopic-t-724325-highlight-.html

UNMERGELIST=$(mktemp -t "unmerge_list_XXXXX")

set -- $(while read LINE; do echo -n "$LINE | off "; done < /var/lib/portage/world | sort)

dialog --title 'Dialog unmerger' --single-quoted --checklist \
  'Select packages to unmerge' 0 0 0 \
  "$@" \
  2> "$UNMERGELIST"

clear

# remove single-quotes from the unmerge list
sed -i "s/'//g" $UNMERGELIST

emerge --deselect $(cat $UNMERGELIST)
emerge -av --depclean
revdep-rebuild

rm $UNMERGELIST
