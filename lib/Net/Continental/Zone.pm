use strict;
use warnings;
no warnings 'once';
package Net::Continental::Zone;

our $VERSION = '0.003';

use Net::Domain::TLD ();

=head1 NAME

Net::Continental::Zone - a zone of IP space

=head1 METHODS

B<Achtung!>  There is no C<new> method for you to use.  Instead, do this:

  my $zone = Net::Continental->zone('au');

=cut

sub _new { bless $_[1] => $_[0] }

=head2 code

This returns the zone's zone code.

=head2 in_nerddk

This is true if the nerd.dk country blacklist has an entry for this zone.

=head2 nerd_response

This returns the response that will be given by the nerd.dk country blacklist
for IPs in this zone, if one is defined.

=head2 continent

This returns the continent in which the zone has been placed.  These are
subject to change, for now, and there may be a method by which to define your
own classifications.  I do not want to get angry email from people in Georgia!

=head2 description

This is a short description of the zone, like "United States" or "Soviet
Union."

=head2 is_tld

This returns true if the zone code is also a country code TLD.

=cut

sub code          { $_[0][0] }
sub in_nerddk     { defined $Net::Continental::nerd_response{ $_[0][0] } }
sub nerd_response { $Net::Continental::nerd_response{ $_[0][0] } }
sub continent     { $Net::Continental::Continent{ $_[0][1] } }
sub description   { $_[0][2] }
sub is_tld        { Net::Domain::TLD::tld_exists($_[0][0], 'cc'); }

=head1 AUTHOR

This code was written in 2009 by Ricardo SIGNES.

The development of this code was sponsored by Pobox.com.  Thanks, Pobox!

=head1 COPYRIGHT AND LICENSE

Copyright 2009 by Ricardo SIGNES

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut

1;
