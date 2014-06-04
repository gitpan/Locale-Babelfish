package Locale::Babelfish::Lang::ru_RU;

# ABSTRACT: ru_RU language

use parent 'Locale::Babelfish::Maketext';
use strict;

our $VERSION = '0.05'; # VERSION


sub quant_word {
    my ($self, $num, $single, $plural1, $plural2) = @_;
    my $num_s   = $num % 10;
    my $num_dec = $num % 100;
    my $ret;
    if    ($num_dec >= 10 and $num_dec <= 20) { $ret = $plural2 || $plural1 || $single }
    elsif ($num_s == 1)                       { $ret = $single }
    elsif ($num_s >= 2 and $num_s <= 4)       { $ret = $plural1 || $single }
    else                                      { $ret = $plural2 || $plural1 || $single }
    return $ret;
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Locale::Babelfish::Lang::ru_RU - ru_RU language

=head1 VERSION

version 0.05

=for Pod::Coverage quant_word

=head1 AUTHORS

=over 4

=item *

Igor Mironov <grif@cpan.org>

=item *

Crazy Panda LLC

=item *

REG.RU LLC

=back

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2014 by Igor Mironov.

This is free software, licensed under:

  The MIT (X11) License

=cut
