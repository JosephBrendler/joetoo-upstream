#!/usr/bin/perl -w
# Copyright 2015-2026 Joseph Brendler
# SPDX-License-Identifier: GPL-3.0-or-later
#
# perl_camary.pl - used to test validate_scripts

use strict;
use warnings;

#my $message = "Hello from joetoolkit validation test";  # should pass validate_scripts
my $message = "Hello from joetoolkit validation test"   # should fail validate_scripts [ missing ; ]

print "$message\n";
