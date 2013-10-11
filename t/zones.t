use strict;
use warnings;

use Test::More tests => 10;

use Net::Continental;

{
  my $zone = Net::Continental->zone('ru');

  isa_ok($zone, 'Net::Continental::Zone');
  is($zone->code, 'ru', 'ru is ru');
  like($zone->description, qr{russia}i, 'ru is Russia');
  ok($zone->is_tld, 'ru is a tld');
  is($zone->nerd_response, '127.0.2.131', 'ru has expected nerd response');
}

{
  my $zone = Net::Continental->zone('ax');

  isa_ok($zone, 'Net::Continental::Zone');
  is($zone->code, 'ax', 'ax is ax');
  like($zone->description, qr{aland islands}i, 'ax is Aland Islands');
  ok($zone->is_tld, 'ax is a tld');
}

{
  my $zone = eval { Net::Continental->zone('oo') };

  ok(! $zone, "there is no oo zone");
}
