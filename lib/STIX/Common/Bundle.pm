package STIX::Common::Bundle;

use 5.010001;
use strict;
use warnings;
use utf8;

use UUID::Tiny qw(:std);

use Moo;
use Types::Standard qw(Str InstanceOf ArrayRef);
use namespace::autoclean;

extends 'STIX::Base';

use constant SCHEMA =>
    'http://raw.githubusercontent.com/oasis-open/cti-stix2-json-schemas/stix2.1/schemas/common/bundle.json';

use constant PROPERTIES => qw(type id objects);

use constant STIX_OBJECT_TYPE => 'bundle';

has type    => (is => 'ro', default => 'bundle');
has objects => (is => 'rw', isa     => ArrayRef [], default => sub { [] });
has id      => (is => 'rw', isa     => Str, lazy => 1, default => sub { shift->generate_id });

1;

=encoding utf-8

=head1 NAME

STIX::Common::Bundle - STIX Bundle

=head1 SYNOPSIS

    use STIX::Common::Bundle;

    my $bundle = STIX::Common::Bundle->new(
        objects => [
            STIX::Vulnerability->new( ... ),
            STIX::Sighting->new( ... ),
            STIX::Common::Relationship->new( ... )
        ]
    );


=head1 DESCRIPTION

A Bundle is a collection of arbitrary STIX Objects and Marking Definitions
grouped together in a single container.


=head2 METHODS

L<STIX::Common::Bundle> inherits all methods from L<STIX::Base>
and implements the following new ones.

=over

=item STIX::Common::Bundle->new(%properties)

Create a new instance of L<STIX::Common::Bundle>.

=item $bundle->id

An identifier for this bundle. The id field for the Bundle is designed to
help tools that may need it for processing, but tools are not required to
store or track it. 

=item $bundle->objects

Specifies a set of one or more STIX Objects.

=item $bundle->type

The type of this object, which MUST be the literal C<bundle>.

=back


=head2 HELPERS

=over

=item $bundle->TO_JSON

Convert L<STIX::Common::Bundle> in JSON.

=item $bundle->to_string

Alias of L<TO_JSON>.

=item $bundle->validate

Validate L<STIX::Common::Bundle> object using JSON Schema (see L<STIX::Schema>).

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
