#!perl

use strict;
use warnings;
use v5.10;

use Test::More;

use STIX ':obsevables';
use Time::Piece;


my $object = ipv4_addr(value => '198.51.100.3');

my @errors = $object->validate;

diag 'IPv4 Single Address', "\n", "$object";

isnt "$object", '';

is $object->type, 'ipv4-addr';

is @errors, 0;

done_testing();
