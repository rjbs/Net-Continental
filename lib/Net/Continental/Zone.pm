use strict;
use warnings;
no warnings 'once';
package Net::Continental::Zone;
# ABSTRACT: a zone of IP space

use Locale::Codes::Country ();
use Net::Domain::TLD ();

=method new

B<Achtung!>  There is no C<new> method for you to use.  Instead, do this:

  my $zone = Net::Continental->zone('au');

=cut

sub _new { bless $_[1] => $_[0] }

=method code

This returns the zone's zone code.

=method in_nerddk

This is true if the nerd.dk country blacklist has an entry for this zone.

=method nerd_response

This returns the response that will be given by the nerd.dk country blacklist
for IPs in this zone, if one is defined.

=method continent

This returns the continent in which the zone has been placed.  These are
subject to change, for now, and there may be a method by which to define your
own classifications.  I do not want to get angry email from people in Georgia!

=method description

This is a short description of the zone, like "United States" or "Soviet
Union."

=method is_tld

This returns true if the zone code is also a country code TLD.

=cut

sub code          { $_[0][0] }

sub in_nerddk     {
  Carp::cluck("in_nerddk method is deprecated");
  return defined $_[0]->nerd_response;
}

sub nerd_response {
  my ($self) = @_;
  my $n = Locale::Codes::Country::country_code2code(
    $self->code,
    'alpha-2',
    'numeric',
  );
  return unless $n;
  my $top = $n >> 8;
  my $bot = $n % 256;
  return "127.0.$top.$bot";
}

sub continent     { $Net::Continental::Continent{ $_[0][1] } }
sub description   { $_[0][2] }
sub is_tld        { Net::Domain::TLD::tld_exists($_[0][0], 'cc'); }

1;
