#!/usr/bin/perl
#use strict;
#use warnings;
use MIME::Base64;
use lib "$ARGV[2]/class/lib";

use Tie::Hash::Regex;

  my %hash;

  tie %hash, 'Tie::Hash::Regex';


my $file1 = $ARGV[0];
my $file2 = $ARGV[1];
open (FILE1, $file1) || die "Could not open file \n";
open (FILE2, $file2) || die "Could not open file \n";
#my $outfile = $ARGV[2];
my @outlines;
my @outlines2;
my @outlines_cor;
my @outlines_swiss;
#my %hash = ();
my %hash_2 = ();
###open (OUTFILE, ">$outfile") or die "Cannot open $outfile for writing \n";
#x.txt
while (<FILE1>) {
    my @array = split(/\t/);
       # $array[33] =~ /$array[33].*/;
$hash{$array[0]} = join("\t",@array);
######$hash{$array[2]} = join("\t",$array[2],$array[5],$array[7],"\n"); # user other column as identifier
######$hash{$array[2]} = join("\t",@array); # user other column as identifier
}
 #print $hash{ABHD14A-ACY1};
#y.txt
while (<FILE2>) {
    #next unless (/^[A-Z]/);#skip lines that do not start with an uppercase alpha
    chomp;
    my $col1 = (split(/\n/))[0];

    if (exists $hash{$col1}) {#next;

	print $hash{$col1};
	

###       print OUTFILE $hash{$col1};
    }
    else
    {
###print OUTFILE $col1."\n";
#print $hash{$col1};
  #print  "$col1\tNA\tNA\tNA\tNA\tNA\tNA\n";
#print $col1."\t$col1\tNA\tNA"."\n";
#print "$col1\n";
#next;
    }

}

###close OUTFILE;
close FILE1;
close FILE2;
