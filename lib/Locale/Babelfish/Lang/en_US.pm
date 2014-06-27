package Locale::Babelfish::Lang::en_US;

# ABSTRACT: en_US language

use parent 'Locale::Babelfish::Maketext';
use strict;

our $VERSION = '0.06'; # VERSION


sub quant_word { shift->quant_word_std_double(@_) }

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Locale::Babelfish::Lang::en_US - en_US language

=head1 VERSION

version 0.06

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
