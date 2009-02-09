use strict;
use warnings;
package Net::Continental::Zone;

sub _new { bless $_[1] => $_[0] }

sub in_nerddk   { $_->[0] }
sub continent   { $Net::Continental::Continent{ $_->[1] } }
sub description { $_->[2] }
sub is_tld      { die }

1;
