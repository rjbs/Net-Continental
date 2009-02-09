use strict;
use warnings;
no warnings 'once';
package Net::Continental::Zone;

our $VERSION = '0.002';

use Net::Domain::TLD ();

sub _new { bless $_[1] => $_[0] }

sub code          { $_[0][0] }
sub in_nerddk     { defined $Net::Continental::nerd_response{ $_[0][0] } }
sub nerd_response { $Net::Continental::nerd_response{ $_[0][0] } }
sub continent     { $Net::Continental::Continent{ $_[0][1] } }
sub description   { $_[0][2] }
sub is_tld        { Net::Domain::TLD::tld_exists($_[0][0], 'cc'); }

1;
