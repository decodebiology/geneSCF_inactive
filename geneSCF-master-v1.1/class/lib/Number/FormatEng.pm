package Number::FormatEng;

use warnings;
use strict;
use Carp;
use POSIX;
use Scalar::Util qw(looks_like_number);

require Exporter;
our @ISA         = qw(Exporter);
our @EXPORT_OK   = qw(format_eng format_pref unformat_pref use_e_zero no_e_zero);
our %EXPORT_TAGS = (all => \@EXPORT_OK);

our $VERSION = '0.01';

my %prefix = (
    '-8' => 'y',    '8' => 'Y',
    '-7' => 'z',    '7' => 'Z',
    '-6' => 'a',    '6' => 'E',
    '-5' => 'f',    '5' => 'P',
    '-4' => 'p',    '4' => 'T',
    '-3' => 'n',    '3' => 'G',
    '-2' => 'u',    '2' => 'M',
    '-1' => 'm',    '1' => 'k',
     '0' => '' ,
);
my %exponent = reverse %prefix;

my $no_e_zero = 1;

sub use_e_zero {
    $no_e_zero = 0;
}

sub no_e_zero {
    $no_e_zero = 1;
}

sub format_pref {
    return format_num(1, @_);
}

sub format_eng {
    return format_num(0, @_);
}

sub format_num {
    my $prefix_mode = shift;
    my $num         = shift;

    my $name = ($prefix_mode) ? 'format_pref' : 'format_eng';

    # Check validity of input
    unless (defined $num) {
        croak("Error: $name requires numeric input. ",
              'It seems like no input was provided or input was undefined');
    }
    unless (looks_like_number($num)) {
        croak("Error: $name requires numeric input. '$num' is not numeric");
    }

    if ($num == 0) {
        if ($prefix_mode or $no_e_zero) {
            return '0';
        }
        else {
            return '0e0';
        }
    }

    my $sign = ($num < 0) ? '-' : '';
    $num = abs $num;

    if ($prefix_mode) {
        if ( ($num >= 1e27) or ($num <= 1e-25) ) {
            # switch to number exponent mode
            $prefix_mode = 0;
        }
    }

    my $e    = floor( log($num) / log(1000) );
    my $mult = 1000**$e;
    $num = adjust($num / $mult);
    if ($prefix_mode) {
        return $sign . $num . $prefix{$e};
    }
    else {
        if ($no_e_zero and ($e == 0)) {
            return $sign . $num;
        }
        else {
            return $sign . $num . 'e' . 3*$e;
        }
    }
}

sub adjust {
    my $num = shift;
    if ($num < 1) {
        return 1;
    }
    elsif (($num < 10) and ($num > 9.999_999_999)) {
        return 10;
    }
    elsif (($num < 100) and ($num > 99.999_999_99)) {
        return 100;
    }
    else {
        return $num;
    }
}

sub unformat_pref {
    my ($num) = @_;

    # Check validity of input
    unless (defined $num) {
        croak('Error: unformat_pref requires input. ',
              'It seems like no input was provided or input was undefined');
    }

    # Trim leading and trailing whitespace
    $num =~ s/^\s+//;
    $num =~ s/\s+$//;

    unless (length $num) {
        croak('Error: unformat_pref requires input. ',
              'It seems like no input was provided');
    }

    my $prefix = substr $num, -1;
    if (exists $exponent{$prefix}) {
        chop $num;
        unless (looks_like_number($num)) {
            croak("Error: unformat_pref input '$num' is not numeric before prefix '$prefix'");
        }
        $num = $num * (1000**$exponent{$prefix});
    }
    else {
        unless (looks_like_number($num)) {
            croak("Error: unformat_pref input '$num' is not numeric");
        }
    }

    return $num;
}


=head1 NAME

Number::FormatEng - Format a number using engineering notation

=head1 VERSION

This document refers to Number::FormatEng version 0.01.

=head1 SYNOPSIS

    use Number::FormatEng qw(:all);
    print format_eng(1234);     # prints 1.234e3
    print format_pref(-0.035);  # prints -35m
    unformat_pref('1.23T');     # returns 1.23e+12

=head1 DESCRIPTION

Format a number for printing using engineering notation.
Engineering notation is similar to scientific notation except that
the power of ten must be a multiple of three.
Alternately, the number can be formatted using an International
System of Units (SI) prefix representing a factor of a thousand.

=head1 SUBROUTINES

=over 4

=item format_eng($number)

Format a numeric value using engineering notation.  This function
returns a string whose exponent is a multiple of 3.  Here are some examples:

    format_eng(1234);   # returns 1.234e3
    format_eng(-0.03);  # returns -30e-3
    format_eng(7.8e7);  # returns 78e6

In most cases, the precision is preserved.  However, rounding will occur
if the number of digits is too large (system-dependent).  Keep this in
mind if C<$number> is a numeric expression.  For example, the following
may return a different number of digits from system to system:

    format_eng(1/3);

=item format_pref($number)

Format a numeric value using engineering notation.  This function
returns a string using one of the following SI prefixes (representing a
power of a thousand):

    m u n p f a z y
    k M G T P E Z Y

Notice that lower-case C<u> is used instead of the Greek letter Mu.

If the number is beyond the prefix ranges (y and Y), then C<format_pref>
returns the same formatted string as C<format_eng>.  In other words, it
does not use an SI prefix.

Here are some examples:

    format_pref(1234);      # returns 1.234k
    format_pref(-0.0004);   # returns -400u
    format_pref(1.27e13);   # returns 12.7G
    format_pref(7.5e60);    # returns 7.5e60

=item unformat_pref($string)

Convert a string formatted using C<format_pref> into a numeric value.
Here are some examples:

    unformat_pref('1.23T'); # returns 1.23e+12
    unformat_pref('-400u'); # returns -4e-4
    unformat_pref(37.5);    # returns 37.5

=item use_e_zero() and no_e_zero()

By default, if the exponent is zero, C<e0> is not displayed by
C<format_eng>.  To explicitly display C<e0>, use the C<use_e_zero> method.
Use the C<no_e_zero> method to return to the default behavior.

    format_eng(55);     # returns 55
    Number::FormatEng::use_e_zero();
    format_eng(55);     # now returns 55e0
    Number::FormatEng::no_e_zero();
    format_eng(55);     # back to 55

=back

=head1 EXPORT

Nothing is exported by default.  Functions may be exported individually, or
all functions may be exported at once, using the special tag C<:all>.

=head1 DIAGNOSTICS

Error conditions cause the program to die using C<croak> from the
C<Carp.pm> Core module.

=head1 BUGS AND LIMITATIONS

There are no known bugs in this module.

=head1 SEE ALSO

Refer to the following website:

L<http://en.wikipedia.org/wiki/Engineering_notation>

=head1 AUTHOR

Gene Sullivan (gsullivan@cpan.org)

=head1 ACKNOWLEDGEMENTS

Influenced by the following PerlMonks: BrowserUk, GrandFather and repellent.

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2009 Gene Sullivan.  All rights reserved.

This module is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.  See L<perlartistic>.

=cut

1;

