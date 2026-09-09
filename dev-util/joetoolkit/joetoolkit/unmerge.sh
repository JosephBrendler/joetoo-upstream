#!/bin/bash
# Copyright 2009 Zucca
# Copyright 2025-2026 Joseph Brendler
#
# unmerge.sh - interactively select packages to remove from the Portage world set
#
# Originally written by Zucca and published as "umerge.sh v0.0.2b" on the
# Gentoo Forums in 2009. Modified by Joseph Brendler for joetoolkit.
#
# Original source:
# https://forums.gentoo.org/viewtopic-t-724325-highlight-.html

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
