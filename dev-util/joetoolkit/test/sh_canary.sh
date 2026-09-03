#!/bin/sh
# Copyright 2015-2026 Joseph Brendler
# SPDX-License-Identifier: GPL-3.0-or-later
#
# sh canary - use this file to test validate_scripts by uncommenting the bash line below

user="joe"

domain="brendler"

host="Elrond"

fqdn="${host}.${domain}"

target="${user}@${fqdn}"

string="$target"
# pure shell extraction of first character
char=${string%"${string#?}"}
# bash extraction of first character
char="${target:0:1}"   # should fail validate_scripts [ bashism ]

z=$(( char / 1.234 ))  # should fail validate_scripts [ bad math ]

#if [ "$user" = "joe" ] ; then echo "user is joe"; fi        # should pass validate_scripts
if [ "$user" = "joe" ] ; then echo "user is joe";           # should fail validate_scripts [ missing fi ]
