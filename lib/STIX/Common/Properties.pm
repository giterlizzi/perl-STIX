package STIX::Common::Properties;

use 5.010001;
use strict;
use warnings;
use utf8;


use Moo;
use STIX::Common::Timestamp;
use Types::Standard qw(Str Num ArrayRef HashRef Bool InstanceOf);
use namespace::autoclean;

extends 'STIX::Base';

use constant SCHEMA =>
    'http://raw.githubusercontent.com/oasis-open/cti-stix2-json-schemas/stix2.1/schemas/common/core.json';

use Carp;

has type => (is => 'rw', default => sub { shift->STIX_OBJECT_TYPE }, required => 1);

has spec_version => (is => 'rw', default => '2.1');

has id => (is => 'rw', isa => Str, default => sub { $_[0]->generate_id });

has created_by_ref => (is => 'rw', isa => InstanceOf ['STIX::Common::Identifier', 'STIX::Base']);

has created => (
    is      => 'rw',
    coerce  => sub { ref($_[0]) ? $_[0] : STIX::Common::Timestamp->new($_[0]) },
    isa     => InstanceOf ['STIX::Common::Timestamp'],
    default => sub { STIX::Common::Timestamp->new }
);

has modified => (
    is      => 'rw',
    coerce  => sub { ref($_[0]) ? $_[0] : STIX::Common::Timestamp->new($_[0]) },
    isa     => InstanceOf ['STIX::Common::Timestamp'],
    default => sub { shift->created }
);

has revoked => (is => 'rw', isa => Bool);

has labels => (is => 'rw', isa => ArrayRef [Str], coerce => 1, default => sub { [] });

has confidence => (is => 'rw', isa => Num);

has lang => (is => 'rw', isa => Str);

has external_references =>
    (is => 'rw', isa => ArrayRef [InstanceOf ['STIX::Common::ExternalReference']], default => sub { [] });

has object_marking_refs =>
    (is => 'rw', isa => ArrayRef [InstanceOf ['STIX::Common::Identifier', 'STIX::Base']], default => sub { [] });

has granular_markings =>
    (is => 'rw', isa => ArrayRef [InstanceOf ['STIX::Common::GranularMarking']], default => sub { [] });

has defanged => (is => 'rw', isa => Bool, trigger => 1);

has extensions => (is => 'rw');

has custom_properties => (is => 'rw', isa => HashRef, default => sub { {} });


sub _trigger_defanged {
    Carp::croak '"defanged": This property MUST NOT be used on any STIX Objects other than SCOs.'
        unless shift->STIX_OBJECT eq 'SCO';
}

1;

=encoding utf-8

=head1 NAME

STIX::Common::Properties - STIX Common Properties

=head1 SYNOPSIS

    use STIX::Common::Properties;

    my $object = STIX::Common::Properties->new();


=head1 DESCRIPTION

Common properties and behavior across all STIX Domain Objects and STIX
Relationship Objects.


=head2 METHODS

L<STIX::Common::Properties> inherits all methods from L<STIX::Base>
and implements the following new ones.

=over

=item STIX::Common::Properties->new(%properties)

Create a new instance of L<STIX::Common::Properties>.

=item $object->confidence

Identifies the confidence that the creator has in the correctness of their
data.

=item $object->created

The created property represents the time at which the first version of this
object was created. The timstamp value MUST be precise to the nearest
millisecond.

=item $object->created_by_ref

The ID of the Source object that describes who created this object.

=item $object->custom_properties

Additional custom properties (deprecated in STIX 2.1).

    $object->custom_properties(
        x_acme_org_risk_score => 10,
        x_acme_org_scoring => {
            impact      => 'high',
            probability => 'low'
        }
    );

=item $object->extensions

Specifies any extensions of the object, as a dictionary.

=item $object->external_references

A list of external references which refers to non-STIX information.

=item $object->granular_markings

The set of granular markings that apply to this object.

=item $object->id

=item $object->labels

The labels property specifies a set of terms used to describe this object.

=item $object->lang

Identifies the language of the text content in this object.

=item $object->modified

The modified property represents the time that this particular version of
the object was modified. The timstamp value MUST be precise to the nearest
millisecond.

=item $object->object_marking_refs

The list of marking-definition objects to be applied to this object.

=item $object->revoked

The revoked property indicates whether the object has been revoked.

=item $object->spec_version

The version of the STIX specification used to represent this object.

=item $object->type

The type property identifies the type of STIX Object (SDO, Relationship
Object, etc). The value of the type field MUST be one of the types defined
by a STIX Object (e.g., indicator).

=back


=head2 HELPERS

=over

=item $object->TO_JSON

Convert L<STIX::Common::Properties> in JSON.

=item $object->to_string

Alias of L<TO_JSON>.

=item $object->validate

Validate L<STIX::Common::Properties> object using JSON Schema (see L<STIX::Schema>).

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
