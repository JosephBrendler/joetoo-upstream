#!/usr/bin/perl -w
# Copyright 2015-2026 Joseph Brendler
# SPDX-License-Identifier: GPL-3.0-or-later
#
# perl_sample.pl - used to test check_syntax
use strict;
use warnings;

my $message = "Hello from joetoolkit validation test";  # should pass check_syntax
#my $message = "Hello from joetoolkit validation test"   # should fail check_syntax

print "$message\n";
