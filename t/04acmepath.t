#!perl -w

use strict;
use lib 't/lib';
use Test::More qw/no_plan/;


my $foo;
ok($foo = MyTest->new());

my @plugins;
my @expected = qw(Acme::MyTest::Plugin::Foo);
ok(@plugins = $foo->plugins);
is_deeply(\@plugins, \@expected);


package MyTest;
use File::Spec::Functions qw(catdir);
use strict;
use Module::Pluggable (search_path => [catdir(qw(Acme MyTest Plugin))]);
use base qw(Module::Pluggable);


sub new {
    my $class = shift;
    return bless {}, $class;

}
1;
