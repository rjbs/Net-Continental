use strict;
use warnings;
package Net::Continental;

use Carp ();
use Net::Continental::Zone;
use Scalar::Util qw(blessed);

our $VERSION = '0.005';

our %Continent = (
  N => 'North America',
  S => 'South America',
  E => 'Europe',
  A => 'Asia',
  F => 'Africa',
  O => 'Oceania',
  Q => 'Antarctica',
);

#         qw(continent description)

my %zone = (
  ae => [ A => q{United Arab Emirates} ],
  af => [ A => q{Afghanistan} ],
  az => [ A => q{Azerbaijan} ],
  bd => [ A => q{Bangladesh} ],
  bh => [ A => q{Bahrain} ],
  bt => [ A => q{Bhutan} ],
  bn => [ A => q{Brunei Darussalam} ],
  cn => [ A => q{China} ],

  # classification of Georgia in Europe or Asia is touchy
  ge => [ A => q{Georgia} ],

  hk => [ A => q{Hong Kong} ],
  il => [ A => q{Israel} ],
  in => [ A => q{India} ],
  id => [ A => q{Indonesia} ],
  iq => [ A => q{Iraq} ],
  ir => [ A => q{Iran (Islamic Republic of)} ],
  jo => [ A => q{Jordan} ],
  jp => [ A => q{Japan} ],
  kg => [ A => q{Kyrgyzstan} ],
  kh => [ A => q{Cambodia} ],
  kp => [ A => q{Korea, Democratic People's Republic} ],
  kr => [ A => q{Korea, Republic of} ],
  kw => [ A => q{Kuwait} ],
  kz => [ A => q{Kazakhstan} ],
  la => [ A => q{Lao People's Democratic Republic} ],
  lb => [ A => q{Lebanon} ],
  lk => [ A => q{Sri Lanka} ],
  mm => [ A => q{Myanmar} ],
  mn => [ A => q{Mongolia} ],
  mo => [ A => q{Macau} ],
  mv => [ A => q{Maldives} ],
  my => [ A => q{Malaysia} ],
  np => [ A => q{Nepal} ],
  om => [ A => q{Oman} ],
  ph => [ A => q{Philippines} ],
  pk => [ A => q{Pakistan} ],
  ps => [ A => q{Palestinian Territories} ],
  qa => [ A => q{Qatar} ],
  ru => [ A => q{Russian Federation} ],
  sa => [ A => q{Saudi Arabia} ],
  sg => [ A => q{Singapore} ],
  su => [ A => q{Soviet Union} ],
  sy => [ A => q{Syrian Arab Republic} ],
  th => [ A => q{Thailand} ],
  tj => [ A => q{Tajikistan} ],
  tl => [ A => q{Timor-Leste} ],
  tm => [ A => q{Turkmenistan} ],
  tp => [ A => q{East Timor} ],
  tr => [ A => q{Turkey} ],
  tw => [ A => q{Taiwan} ],
  uz => [ A => q{Uzbekistan} ],
  vn => [ A => q{Vietnam} ],
  ye => [ A => q{Yemen} ],

  ad => [ E => q{Andorra} ],
  al => [ E => q{Albania} ],
  am => [ E => q{Armenia} ],
  at => [ E => q{Austria} ],
  ax => [ E => q(Aland Islands) ],
  ba => [ E => q{Bosnia and Herzegovina} ],
  be => [ E => q{Belgium} ],
  bg => [ E => q{Bulgaria} ],
  by => [ E => q{Belarus} ],
  ch => [ E => q{Switzerland} ],
  cy => [ E => q{Cyprus} ],
  cz => [ E => q{Czech Republic} ],
  de => [ E => q{Germany} ],
  dk => [ E => q{Denmark} ],
  ee => [ E => q{Estonia} ],
  es => [ E => q{Spain} ],
  eu => [ E => q{European Union} ],
  fi => [ E => q{Finland} ],
  fo => [ E => q{Faroe Islands} ],
  fr => [ E => q{France} ],
  fx => [ E => q{France, Metropolitan} ],
  gb => [ E => q{United Kingdom} ],
  gg => [ E => q{Guernsey} ],
  gi => [ E => q{Gibraltar} ],
  gr => [ E => q{Greece} ],
  hr => [ E => q{Croatia/Hrvatska} ],
  hu => [ E => q{Hungary} ],
  ie => [ E => q{Ireland} ],
  im => [ E => q{Isle of Man} ],
  is => [ E => q{Iceland} ],
  it => [ E => q{Italy} ],
  je => [ E => q{Jersey} ],
  li => [ E => q{Liechtenstein} ],
  lt => [ E => q{Lithuania} ],
  lu => [ E => q{Luxembourg} ],
  lv => [ E => q{Latvia} ],
  mc => [ E => q{Monaco} ],
  md => [ E => q{Moldova, Republic of} ],
  me => [ E => q(Montenegro) ],
  mk => [ E => q{Macedonia, Former Yugoslav Republic} ],
  mt => [ E => q{Malta} ],
  nl => [ E => q{Netherlands} ],
  no => [ E => q{Norway} ],
  pl => [ E => q{Poland} ],
  pt => [ E => q{Portugal} ],
  ro => [ E => q{Romania} ],
  rs => [ E => q(Serbia) ],
  se => [ E => q{Sweden} ],
  si => [ E => q{Slovenia} ],
  sj => [ E => q{Svalbard and Jan Mayen Islands} ],
  sk => [ E => q{Slovak Republic} ],
  sm => [ E => q{San Marino} ],
  ua => [ E => q{Ukraine} ],
  uk => [ E => q{United Kingdom} ],
  va => [ E => q{Holy See (City Vatican State)} ],
  yu => [ E => q{Yugoslavia} ],

  ac => [ F => q{Ascension Island} ],
  ao => [ F => q{Angola} ],
  bf => [ F => q{Burkina Faso} ],
  bi => [ F => q{Burundi} ],
  bj => [ F => q{Benin} ],
  bw => [ F => q{Botswana} ],
  cd => [ F => q{Congo, Democratic Republic of the} ],
  cf => [ F => q{Central African Republic} ],
  cg => [ F => q{Congo, Republic of} ],
  ci => [ F => q{Cote d'Ivoire} ],
  cm => [ F => q{Cameroon} ],
  cv => [ F => q{Cap Verde} ],
  dj => [ F => q{Djibouti} ],
  dz => [ F => q{Algeria} ],
  eg => [ F => q{Egypt} ],
  eh => [ F => q{Western Sahara} ],
  er => [ F => q{Eritrea} ],
  et => [ F => q{Ethiopia} ],
  ga => [ F => q{Gabon} ],
  gh => [ F => q{Ghana} ],
  gm => [ F => q{Gambia} ],
  gn => [ F => q{Guinea} ],
  gq => [ F => q{Equatorial Guinea} ],
  gw => [ F => q{Guinea-Bissau} ],
  ke => [ F => q{Kenya} ],
  km => [ F => q{Comoros} ],
  lr => [ F => q{Liberia} ],
  ls => [ F => q{Lesotho} ],
  ly => [ F => q{Libyan Arab Jamahiriya} ],
  ma => [ F => q{Morocco} ],
  mg => [ F => q{Madagascar} ],
  ml => [ F => q{Mali} ],
  mr => [ F => q{Mauritania} ],
  mu => [ F => q{Mauritius} ],
  mw => [ F => q{Malawi} ],
  mz => [ F => q{Mozambique} ],
  na => [ F => q{Namibia} ],
  ne => [ F => q{Niger} ],
  ng => [ F => q{Nigeria} ],
  re => [ F => q{Reunion Island} ],
  rw => [ F => q{Rwanda} ],
  sc => [ F => q{Seychelles} ],
  sd => [ F => q{Sudan} ],
  sh => [ F => q{St. Helena} ],
  sl => [ F => q{Sierra Leone} ],
  sn => [ F => q{Senegal} ],
  so => [ F => q{Somalia} ],
  st => [ F => q{Sao Tome and Principe} ],
  sz => [ F => q{Swaziland} ],
  td => [ F => q{Chad} ],
  tg => [ F => q{Togo} ],
  tn => [ F => q{Tunisia} ],
  tz => [ F => q{Tanzania} ],
  ug => [ F => q{Uganda} ],
  yt => [ F => q{Mayotte} ],
  za => [ F => q{South Africa} ],
  zm => [ F => q{Zambia} ],
  zr => [ F => q{Zaire} ],
  zw => [ F => q{Zimbabwe} ],

  ag => [ N => q{Antigua and Barbuda} ],
  ai => [ N => q{Anguilla} ],
  an => [ N => q{Netherlands Antilles} ],
  aw => [ N => q{Aruba} ],
  bb => [ N => q{Barbados} ],
  bl => [ N => q(Saint Barthelemy) ],
  bm => [ N => q{Bermuda} ],
  bo => [ N => q{Bolivia} ],
  bs => [ N => q{Bahamas} ],
  bz => [ N => q{Belize} ],
  ca => [ N => q{Canada} ],
  co => [ N => q{Colombia} ],
  cr => [ N => q{Costa Rica} ],
  cu => [ N => q{Cuba} ],
  dm => [ N => q{Dominica} ],
  do => [ N => q{Dominican Republic} ],
  ec => [ N => q{Ecuador} ],
  gd => [ N => q{Grenada} ],
  gl => [ N => q{Greenland} ],
  gp => [ N => q{Guadeloupe} ],
  gt => [ N => q{Guatemala} ],
  hn => [ N => q{Honduras} ],
  ht => [ N => q{Haiti} ],
  jm => [ N => q{Jamaica} ],
  kn => [ N => q{Saint Kitts and Nevis} ],
  lc => [ N => q{Saint Lucia} ],
  mf => [ N => q{Saint Martin (French part)} ],
  mq => [ N => q{Martinique} ],
  ms => [ N => q{Montserrat} ],
  mx => [ N => q{Mexico} ],
  ni => [ N => q{Nicaragua} ],
  pa => [ N => q{Panama} ],
  pm => [ N => q{St. Pierre and Miquelon} ],
  pr => [ N => q{Puerto Rico} ],
  sv => [ N => q{El Salvador} ],
  tc => [ N => q{Turks and Caicos Islands} ],
  tt => [ N => q{Trinidad and Tobago} ],
  us => [ N => q{United States} ],
  vc => [ N => q{Saint Vincent and the Grenadines} ],
  vg => [ N => q{Virgin Islands (British)} ],
  vi => [ N => q{Virgin Islands (USA)} ],

  as => [ O => q{American Samoa} ],
  au => [ O => q{Australia} ],
  cc => [ O => q{Cocos (Keeling) Islands} ],
  ck => [ O => q{Cook Islands} ],
  cx => [ O => q{Christmas Island} ],
  fj => [ O => q{Fiji} ],
  fm => [ O => q{Micronesia, Federated States of} ],
  gu => [ O => q{Guam} ],
  io => [ O => q{British Indian Ocean Territory} ],
  ki => [ O => q{Kiribati} ],
  ky => [ O => q{Cayman Islands} ],
  mh => [ O => q{Marshall Islands} ],
  mp => [ O => q{Northern Mariana Islands} ],
  nc => [ O => q{New Caledonia} ],
  nf => [ O => q{Norfolk Island} ],
  nr => [ O => q{Nauru} ],
  nu => [ O => q{Niue} ],
  nz => [ O => q{New Zealand} ],
  pf => [ O => q{French Polynesia} ],
  pg => [ O => q{Papua New Guinea} ],
  pn => [ O => q{Pitcairn Island} ],
  pw => [ O => q{Palau} ],
  sb => [ O => q{Solomon Islands} ],
  tk => [ O => q{Tokelau} ],
  to => [ O => q{Tonga} ],
  tv => [ O => q{Tuvalu} ],
  um => [ O => q{US Minor Outlying Islands} ],
  vu => [ O => q{Vanuatu} ],
  wf => [ O => q{Wallis and Futuna Islands} ],
  ws => [ O => q{Western Samoa} ],

  aq => [ Q => q{Antartica} ],
  bv => [ Q => q{Bouvet Island} ],
  gs => [ Q => q{South Georgia and the South Sandwich Islands} ],
  hm => [ Q => q{Heard and McDonald Islands} ],
  tf => [ Q => q{French Southern Territories} ],

  ar => [ S => q{Argentina} ],
  br => [ S => q{Brazil} ],
  cl => [ S => q{Chile} ],
  fk => [ S => q{Falkland Islands (Malvina)} ],
  gf => [ S => q{French Guiana} ],
  gy => [ S => q{Guyana} ],
  pe => [ S => q{Peru} ],
  py => [ S => q{Paraguay} ],
  sr => [ S => q{Suriname} ],
  uy => [ S => q{Uruguay} ],
  ve => [ S => q{Venezuela} ],
);

our %nerd_response = qw(
  ad  127.0.0.20
  ae  127.0.3.16
  af  127.0.0.4
  ag  127.0.0.28
  ai  127.0.2.148
  al  127.0.0.8
  am  127.0.0.51
  an  127.0.2.18
  ao  127.0.0.24
  aq  127.0.0.10
  ar  127.0.0.32
  as  127.0.0.16
  at  127.0.0.40
  au  127.0.0.36
  aw  127.0.2.21
  az  127.0.0.31
  ba  127.0.0.70
  bb  127.0.0.52
  bd  127.0.0.50
  be  127.0.0.56
  bf  127.0.3.86
  bg  127.0.0.100
  bh  127.0.0.48
  bi  127.0.0.108
  bj  127.0.0.204
  bm  127.0.0.60
  bn  127.0.0.96
  bo  127.0.0.68
  br  127.0.0.76
  bs  127.0.0.44
  bt  127.0.0.64
  bv  127.0.0.74
  bw  127.0.0.72
  by  127.0.0.112
  bz  127.0.0.84
  ca  127.0.0.124
  cc  127.0.0.166
  cf  127.0.0.140
  cg  127.0.0.178
  ch  127.0.2.244
  ci  127.0.1.128
  ck  127.0.0.184
  cl  127.0.0.152
  cm  127.0.0.120
  cn  127.0.0.156
  co  127.0.0.170
  cr  127.0.0.188
  cu  127.0.0.192
  cv  127.0.0.132
  cx  127.0.0.162
  cy  127.0.0.196
  cz  127.0.0.203
  de  127.0.1.20
  dj  127.0.1.6
  dk  127.0.0.208
  dm  127.0.0.212
  do  127.0.0.214
  dz  127.0.0.12
  ec  127.0.0.218
  ee  127.0.0.233
  eg  127.0.3.50
  eh  127.0.2.220
  er  127.0.0.232
  es  127.0.2.212
  et  127.0.0.231
  fi  127.0.0.246
  fj  127.0.0.242
  fk  127.0.0.238
  fm  127.0.2.71
  fo  127.0.0.234
  fr  127.0.0.250
  fx  127.0.0.249
  ga  127.0.1.10
  gd  127.0.1.52
  ge  127.0.1.12
  gf  127.0.0.254
  gh  127.0.1.32
  gi  127.0.1.36
  gl  127.0.1.48
  gm  127.0.1.14
  gn  127.0.1.68
  gp  127.0.1.56
  gq  127.0.0.226
  gr  127.0.1.44
  gs  127.0.0.239
  gt  127.0.1.64
  gu  127.0.1.60
  gw  127.0.2.112
  gy  127.0.1.72
  hk  127.0.1.88
  hm  127.0.1.78
  hn  127.0.1.84
  hr  127.0.0.191
  ht  127.0.1.76
  hu  127.0.1.92
  id  127.0.1.104
  ie  127.0.1.116
  il  127.0.1.120
  in  127.0.1.100
  io  127.0.0.86
  iq  127.0.1.112
  ir  127.0.1.108
  is  127.0.1.96
  it  127.0.1.124
  jm  127.0.1.132
  jo  127.0.1.144
  jp  127.0.1.136
  ke  127.0.1.148
  kg  127.0.1.161
  kh  127.0.0.116
  ki  127.0.1.40
  km  127.0.0.174
  kn  127.0.2.147
  kp  127.0.1.152
  kr  127.0.1.154
  kw  127.0.1.158
  ky  127.0.0.136
  kz  127.0.1.142
  la  127.0.1.162
  lb  127.0.1.166
  lc  127.0.2.150
  li  127.0.1.182
  lk  127.0.0.144
  lr  127.0.1.174
  ls  127.0.1.170
  lt  127.0.1.184
  lu  127.0.1.186
  lv  127.0.1.172
  ly  127.0.1.178
  ma  127.0.1.248
  mc  127.0.1.236
  md  127.0.1.242
  mg  127.0.1.194
  mh  127.0.2.72
  mk  127.0.3.39
  ml  127.0.1.210
  mm  127.0.0.104
  mn  127.0.1.240
  mo  127.0.1.190
  mp  127.0.2.68
  mq  127.0.1.218
  mr  127.0.1.222
  ms  127.0.1.244
  mt  127.0.1.214
  mu  127.0.1.224
  mv  127.0.1.206
  mw  127.0.1.198
  mx  127.0.1.228
  my  127.0.1.202
  mz  127.0.1.252
  na  127.0.2.4
  nc  127.0.2.28
  ne  127.0.2.50
  nf  127.0.2.62
  ng  127.0.2.54
  ni  127.0.2.46
  nl  127.0.2.16
  no  127.0.2.66
  np  127.0.2.12
  nr  127.0.2.8
  nu  127.0.2.58
  nz  127.0.2.42
  om  127.0.2.0
  pa  127.0.2.79
  pe  127.0.2.92
  pf  127.0.1.2
  pg  127.0.2.86
  ph  127.0.2.96
  pk  127.0.2.74
  pl  127.0.2.104
  pm  127.0.2.154
  pn  127.0.2.100
  pr  127.0.2.118
  ps  127.0.1.19
  pt  127.0.2.108
  pw  127.0.2.73
  py  127.0.2.88
  qa  127.0.2.122
  re  127.0.2.126
  ro  127.0.2.130
  ru  127.0.2.131
  rw  127.0.2.134
  sa  127.0.2.170
  sb  127.0.0.90
  sc  127.0.2.178
  sd  127.0.2.224
  se  127.0.2.240
  sg  127.0.2.190
  sh  127.0.2.142
  si  127.0.2.193
  sj  127.0.2.232
  sk  127.0.2.191
  sl  127.0.2.182
  sm  127.0.2.162
  sn  127.0.2.174
  so  127.0.2.194
  sr  127.0.2.228
  st  127.0.2.166
  sv  127.0.0.222
  sy  127.0.2.248
  sz  127.0.2.236
  tc  127.0.3.28
  td  127.0.0.148
  tf  127.0.1.4
  tg  127.0.3.0
  th  127.0.2.252
  tj  127.0.2.250
  tk  127.0.3.4
  tm  127.0.3.27
  tn  127.0.3.20
  to  127.0.3.8
  tp  127.0.2.114
  tr  127.0.3.24
  tt  127.0.3.12
  tv  127.0.3.30
  tw  127.0.0.158
  tz  127.0.3.66
  ua  127.0.3.36
  ug  127.0.3.32
  uk  127.0.3.58
  um  127.0.2.69
  us  127.0.3.72
  uy  127.0.3.90
  uz  127.0.3.92
  va  127.0.1.80
  vc  127.0.2.158
  ve  127.0.3.94
  vg  127.0.0.92
  vi  127.0.3.82
  vn  127.0.2.192
  vu  127.0.2.36
  wf  127.0.3.108
  ws  127.0.3.114
  ye  127.0.3.119
  yt  127.0.0.175
  yu  127.0.3.123
  za  127.0.2.198
  zm  127.0.3.126
  zr  127.0.0.180
  zw  127.0.2.204
);

our %ip_country = reverse %nerd_response;

=head1 NAME

Net::Continental - IP addresses of the world, by country and continent

=head1 METHODS

=head2 zone

  # Get the zone for the US.
  my $zone = Net::Continental->zone('us');

This returns a L<Net::Continental::Zone> object for the given code.  Zone codes
are generally the same as ISO codes or country-code top level domains.

=cut

sub zone {
  my ($self, $code) = @_;
  Carp::croak("unknown code $code") unless exists $zone{$code};

  $zone{ $code } = Net::Continental::Zone->_new([ $code, @{ $zone{ $code } } ])
    unless blessed $zone{ $code };

  return $zone{ $code };
}

=head2 zone_for_nerd_ip

  # get the zone for nerd's response for the US
  my $zone = Net::Continental->zone_for_nerd_ip('127.0.3.72');

=cut

sub zone_for_nerd_ip {
  my ($self, $ip) = @_;

  Carp::croak("unknown nerd ip $ip") unless exists $ip_country{$ip};

  return $self->zone($ip_country{ $ip });
}

=head2 known_zone_codes

  my @codes = Net::Continental->known_zone_codes;

This returns a list of all known zone codes, in no particular order.

=cut

sub known_zone_codes {
  return keys %zone
}

=head1 AUTHOR

This code was written in 2009 by Ricardo SIGNES.

The development of this code was sponsored by Pobox.com.  Thanks, Pobox!

=head1 COPYRIGHT AND LICENSE

Copyright 2009 by Ricardo SIGNES

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut


1;
