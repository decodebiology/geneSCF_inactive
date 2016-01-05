#!usr/bin/perl
#perl replaceIDS.pl GO.txt (goterm/bpname\tlist of geneIds with field seperator Here:;) IdsWithSym.txt (geneIds\tGeneSym) > result.txt
use lib "$ARGV[2]/class/lib";
use Tie::IxHash;
tie %kegg, 'Tie::IxHash';
$/=undef;
open(IN1,$ARGV[0]) or die "Error opening in file";
open(IN2,$ARGV[1]) or die "Error opening in file";
while(<IN1>){
	chomp;
	@temp1=split("\n",$_);
	foreach $temp1(@temp1)
	{
		@ar1 = split("\t",$temp1);
		$kegg{$ar1[0]} = $ar1[1];
	}
}
#print $kegg{'biological adhesion'};
while(<IN2>){
	@temp2=split("\n",$_);
	foreach $temp2(@temp2)
	{
		@ar2 = split("\n",$temp2);
		$bp{$ar2[0]} = $ar2[0];
	}
}
#print $bp{'81846'};
foreach my $keykg ( keys %kegg )
{
	#print $keykg."\t";
	@kgene=split(/, /,$kegg{$keykg});
	$count=0;
	foreach $kgene(@kgene)
	{
				if(exists $bp{$kgene})
				{
					$num=$count++;
					print $keykg."\t".$bp{$kgene}."\n";
				}
					
	}#print "\n";#print "\t".$num."\n";
}


