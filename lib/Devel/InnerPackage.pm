package Devel::InnerPackage;

use strict;
use base qw(Exporter);
use vars qw($VERSION @EXPORT_OK);



$VERSION = '0.2';
@EXPORT_OK = qw(list_packages);

=pod

=head1 NAME


Devel::InnerPackage - find all the inner packages of a package

=head1 SYNOPSIS

    use Foo::Bar;
	use Devel::innerPackages qw(list_packages);

    my @inner_packages = list_packages('Foo::Bar');


=head1 DESCRIPTION


Given a file like this


    package Foo::Bar;

    sub foo {}


    package Foo::Bar::Quux;

    sub quux {}

    package Foo::Bar::Quirka;

    sub quirka {}

    1;

then

    list_packages('Foo::Bar');

will return

    Foo::Bar::Quux
    Foo::Bar::Quirka

=head1 METHODS

=head2 list_packages <package name>

Return a list of all inner packages of that package.

=cut

sub list_packages {
            my $pack = shift; $pack .= "::" unless $pack =~ m!::$!;

            no strict 'refs';
            my @packs;
            for (grep !/^(main|)::$/, grep /::$/, keys %{$pack})
            {
                s!::$!!;
                my @children = list_packages($pack.$_);
                push @packs, "$pack$_" unless /^::/; 
                push @packs, @children;
            }
            return grep {$_ !~ /::::ISA::CACHE/} @packs;
}

=head1 AUTHOR

Simon Wistow <simon@thegestalt.org>

=head1 COPYING

Copyright, 2005 Simon Wistow

Distributed under the same terms as Perl itself.

=head1 BUGS

None known.

=cut 





1;
