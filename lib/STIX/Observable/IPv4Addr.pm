package STIX::Observable::IPv4Addr;

use 5.010001;
use strict;
use warnings;
use utf8;

use Moo;
use Types::Standard qw(Str ArrayRef InstanceOf);
use namespace::autoclean;

extends 'STIX::Observable';

use constant SCHEMA =>
    'http://raw.githubusercontent.com/oasis-open/cti-stix2-json-schemas/stix2.1/schemas/observables/ipv4-addr.json';

use constant PROPERTIES => (
    qw(type id),
    qw(spec_version object_marking_refs granular_markings defanged extensions),
    qw(value resolves_to_refs belongs_to_refs)
);

use constant STIX_OBJECT      => 'SCO';
use constant STIX_OBJECT_TYPE => 'ipv4-addr';

has value => (is => 'rw', isa => Str, required => 1);

has resolves_to_refs => (is => 'rw', isa => ArrayRef [InstanceOf ['STIX::Observable::MACAddr']], default => sub { [] });

has belongs_to_refs =>
    (is => 'rw', isa => ArrayRef [InstanceOf ['STIX::Observable::AutonomousSystem']], default => sub { [] });

1;

=encoding utf-8

=head1 NAME

STIX::Observable::IPv4Addr - STIX Cyber-observable Object (SCO) - IPv4 Address

=head1 SYNOPSIS

    use STIX::Observable::IPv4Addr;

    my $ipv4_addr = STIX::Observable::IPv4Addr->new();


=head1 DESCRIPTION

The IPv4 Address Object represents one or more IPv4 addresses expressed
using CIDR notation.


=head2 METHODS

L<STIX::Observable::IPv4Addr> inherits all methods from L<STIX::Observable>
and implements the following new ones.

=over

=item STIX::Observable::IPv4Addr->new(%properties)

Create a new instance of L<STIX::Observable::IPv4Addr>.

=item $ipv4_addr->belongs_to_refs

Specifies a reference to one or more autonomous systems (AS) that the IPv4
address belongs to.

=item $ipv4_addr->id

=item $ipv4_addr->resolves_to_refs

Specifies a list of references to one or more Layer 2 Media Access Control
(MAC) addresses that the IPv4 address resolves to.

=item $ipv4_addr->type

The value of this property MUST be C<ipv4-addr>.

=item $ipv4_addr->value

Specifies one or more IPv4 addresses expressed using CIDR notation.

=back


=head2 HELPERS

=over

=item $ipv4_addr->TO_JSON

Convert L<STIX::Observable::IPv4Addr> object in JSON.

=item $ipv4_addr->to_string

Alias of L<TO_JSON>.

=item $ipv4_addr->validate

Validate L<STIX::Observable::IPv4Addr> object using JSON Schema
(see L<STIX::Schema>).

=back


=head1 SUPPORT

=head2 Bugs / Feature Requests

Please report any bugs or feature requests through the issue tracker
at L<https://github.com/giterlizzi/perl-STIX/issues>.
You will be notified automatically of any progress on your issue.

=head2 Source Code

This is open source software.  The code repository is available for
public review and contribution under the terms of the license.

L<https://github.com/giterlizzi/perl-STIX>

    git clone https://github.com/giterlizzi/perl-STIX.git


=head1 AUTHOR

=over 4

=item * Giuseppe Di Terlizzi <gdt@cpan.org>

=back


=head1 LICENSE AND COPYRIGHT

This software is copyright (c) 2024 by Giuseppe Di Terlizzi.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
