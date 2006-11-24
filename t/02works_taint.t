#!perl -wT

# NOTE: Module::Pluggable is going into core
# and CORE tests can't modify @INC under taint 
# so this is a work around to make sure it
# still works under taint checking.

use strict;
use Test::More tests => 5;

my $foo;
ok($foo = MyTest->new());

my @plugins;
my @expected = qw(Module::Pluggable::Object);
ok(@plugins = sort $foo->plugins);



is_deeply(\@plugins, \@expected, "is deeply");

@plugins = ();

ok(@plugins = sort MyTest->plugins);




is_deeply(\@plugins, \@expected, "is deeply class");



package MyTest;

use strict;
use Module::Pluggable search_path => 'Module::Pluggable';


sub new {
    my $class = shift;
    return bless {}, $class;

}
1;

