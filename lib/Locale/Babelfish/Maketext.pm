package Locale::Babelfish::Maketext;

# ABSTRACT: Wrapper around Locale::Maketext

use utf8;
use Modern::Perl;
use Carp;
use parent 'Locale::Maketext';

our $VERSION = '0.05'; # VERSION


sub create_lh {
    my ( $class, $dictname, $lang, $lex, $parent ) = @_;

    $dictname =~ s/[^a-zA-Z0-9_]/_/g;
    my $gen_class = __PACKAGE__."::Dynamic::${dictname}::${lang}";

    $parent ||= "Locale::Babelfish::Lang::$lang";

    $parent = 'Locale::Babelfish::Lang::en_US' unless eval "require $parent;";

    unless ($gen_class->isa('Locale::Babelfish::Maketext')) {
        ## no critic
        eval "
            package $gen_class;
            use parent '$parent';
            use strict;
            our %Lexicon;
            1;
        ";
        die "Maketext: generation of dynamic class '$gen_class' failed: $@"
            if $@;
        eval "
            package ${gen_class}::".lc($lang).";
            use parent '$parent';
            use strict;
            our %Lexicon;
            1;
        ";
        die "Maketext: generation of dynamic class '${gen_class}::".lc($lang)."' failed: $@"
            if $@;
        ## use critic
    }

    my $lh = $gen_class->get_handle($lang);
    $lh->set_lexicon($lex);
    $lh->fail_with(sub {});
    return $lh;
}


sub set_lexicon {
    my ($self, $lex) = @_;
    no strict 'refs';
    %{ref($self)."::Lexicon"} = %$lex if ref $lex eq 'HASH';
}


sub lexicon {
    my $self = shift;
    no strict 'refs';
    return \%{ref($self)."::Lexicon"};
    use strict 'refs';
}



sub l10n { shift->maketext(@_) }


sub quant {
    my $self = shift;
    return $_[0] . ' ' . $self->quant_word(@_);
}


sub numb {
    my $self = shift;
    return  $self->quant_word(@_);
}


sub quant_word { die "Must be implemented" }


sub quant_word_std_single {
    my ($self, $num, $single) = @_;
    return $single;
}


sub quant_word_std_double {
    my ($self, $num, $single, $plural) = @_;
    $num ||= 0;
    return $num == 1 ? $single : ($plural || $single);
}


1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Locale::Babelfish::Maketext - Wrapper around Locale::Maketext

=head1 VERSION

version 0.05

=head1 METHODS

=head2 create_lh

Handler for dictionary at Locale::Maketext

    $class->create_lh( $dictname, $lang, $lex );

=head2 set_lexicon

    $self->set_lexicon( $lex );

=head2 lexicon

    $self->lexicon();

=head2 l10n

    $self->l10n( ... );

=for Pod::Coverage quant

=for Pod::Coverage numb

=for Pod::Coverage quant_word

=for Pod::Coverage quant_word_std_single

=for Pod::Coverage quant_word_std_double

=head1 SEE ALSO

L<Locale::Maketext>

L<https://github.com/nodeca/babelfish>

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
