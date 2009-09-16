use strict;
use warnings;

use Test::More tests => 17;

use Net::Continental;

{
  my $zone = Net::Continental->zone('ru');

  isa_ok($zone, 'Net::Continental::Zone');
  is($zone->code, 'ru', 'ru is ru');
  like($zone->description, qr{russia}i, 'ru is Russia');
  ok($zone->is_tld, 'ru is a tld');
  ok($zone->in_nerddk, 'ru is supported by nerd.dk');
}

{
  my $zone = Net::Continental->zone('fx');

  isa_ok($zone, 'Net::Continental::Zone');
  is($zone->code, 'fx', 'fx is fx');
  like($zone->description, qr{metropol}i, 'fx is Metropolitan France');
  ok(! $zone->is_tld, 'fx is not a tld');
  ok($zone->in_nerddk, 'fx is supported by nerd.dk');

  my $reget = Net::Continental->zone_for_nerd_ip($zone->nerd_response);
  is($reget->code, $zone->code, "round trip by IP");
}

{
  my $zone = Net::Continental->zone('ax');

  isa_ok($zone, 'Net::Continental::Zone');
  is($zone->code, 'ax', 'ax is ax');
  like($zone->description, qr{aland islands}i, 'ax is Aland Islands');
  ok($zone->is_tld, 'ax is a tld');
  ok(! $zone->in_nerddk, 'ax is not supported by nerd.dk');
}

{
  my $zone = eval { Net::Continental->zone('oo') };

  ok(! $zone, "there is no oo zone");
}
