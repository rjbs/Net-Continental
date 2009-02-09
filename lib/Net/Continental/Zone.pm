use strict;
use warnings;
no warnings 'once';
package Net::Continental::Zone;

use Net::Domain::TLD ();

sub _new { bless $_[1] => $_[0] }

sub code        { $_->[0] }
sub in_nerddk   { $_->[1] }
sub continent   { $Net::Continental::Continent{ $_->[2] } }
sub description { $_->[3] }
sub is_tld      { Net::Domain::TLD::tld_exists($_->[0], 'cc'); }

1;
