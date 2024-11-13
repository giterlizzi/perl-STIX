#!perl -T

use strict;
use warnings;

use Test::More;

use_ok('STIX');

done_testing();

diag("STIX $STIX::VERSION, Perl $], $^X");
