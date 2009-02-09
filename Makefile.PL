use inc::Module::Install;
all_from('lib/Net/Continental.pm');

requires('Carp'             => 0);
requires('Net::Domain::TLD' => 0);
requires('Scalar::Util'     => 0);

test_requires('Test::More' => 0);

auto_manifest;

WriteAll;
