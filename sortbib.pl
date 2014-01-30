#!/usr/bin/env perl
use warnings;
use strict;

=head1 NAME

sortbib.pl

=head1 USAGE

    sortbib.pl <file.bib > outfile.bib

This is actually more useful as a filter for vim:

    :%!sortbib.pl

=head1 DESCRIPTION

Sorts a .bib file (given on stdin) by citekey, then dumps it to stdout. Super
simple: has no options, and does exactly one thing.

=head1 DEPENDENCIES

Text::BibTeX (for parsing bib file).

=cut

use Text::BibTeX;

my $infile = Text::BibTeX::File->new('-');

my @entries;

while (my $entry = new Text::BibTeX::Entry $infile) {
    push @entries, $entry;
}

$_->write() for map { $_->[1] }
                sort { $a->[0] cmp $b->[0]}
                map { [$_->{key}, $_] } @entries;

=head1 BUGS AND LIMITATIONS

Probably lots of limitations. Let me know if you want something that's not
here.

=head1 AUTHOR

Michael McClimon, L<< michael@mcclimon.org >>

=head1 LICENSE AND COPYRIGHT

Copyright 2014, Michael McClimon.

Released under the MIT License or the Artistic License 2.0, whichever you
prefer.
