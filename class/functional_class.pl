#!/usr/bin/perl

$/=undef;
use Cwd;
$pwd=cwd();
use lib "$ARGV[5]/class/lib";
use lib "$ARGV[5]/class//lib/Tie-IxHash-1.23";
use Tie::IxHash;
use Statistics::Multtest qw(bonferroni holm hommel hochberg BH BY qvalue);
use Statistics::Multtest qw(:all);
tie %kegg, 'Tie::IxHash';
use Text::NSP::Measures::2D::Fisher::right;
use Number::FormatEng qw(:all);
use Data::Dumper;
@myout=split("/",$ARGV[1]);
open(RESULT,">@ARGV[2]/@{myout[$#myout]}_${ARGV[3]}_functional_classification.tsv");
##if(! defined @ARGV[0] && ! defined @ARGV[1] && ! defined @ARGV[2] || $ARGV[0] eq "-h")
##{
#print"Gene Ontology/Functional Classification for set of genes\n--------------------------------------------------------\nUsage: OntologyClass [gene_identifier] [list]\n\nidentifier: Gene identifier for given input ['sym' - without quotes for gene symbols and 'gid' - without quotes for Gene ID ].\nlist: Gene list for analysis.\n\nAuthor: Santhilal Subhash\nsanthilal.subhash\@gu.se\nLast Updated: 2013 July 14\n"
##print"Gene Ontology/Functional Classification for set of genes\n--------------------------------------------------------\nUsage: OntologyClass [identifier] [list] [OUTPATH]\n\nidentifier: Gene identifier for given input ['sym' - without quotes for gene symbols and 'gid' - without quotes for Gene ID ].\nlist: Gene list for analysis.\nOUTPATH: The path where output file should be stored (This script generates output named YOUR_INPUT_FILE_functional_classification.tsv in the mentioned path).\n\nAuthor: Santhilal Subhash\nsanthilal.subhash\@gu.se\nLast Updated: 2014 February 6\n"
##}

#### GeneOntology DB ####
if($ARGV[0] eq "sym" && $ARGV[3] eq "GO_all")
{
$mytype="Gene Symbol";
open(IN1,"$ARGV[5]/annotation/gene_association.grouped.annotated140122_new.txt") or die "Error opening in file";
}
if($ARGV[0] eq "gid" && $ARGV[3] eq "GO_all")
{
$mytype="Entrez GeneID";
open(IN1,"$ARGV[5]/annotation/gene_association.grouped.annotated_RplcdIDs140122_new.txt") or die "Error opening in file";
}


if($ARGV[0] eq "sym" && $ARGV[3] eq "GO_BP")
{
$mytype="Gene Symbol";
open(IN1,"$ARGV[5]/annotation/gene_association.grouped.annotated140122_new_bp.txt") or die "Error opening in file";
}
if($ARGV[0] eq "gid" && $ARGV[3] eq "GO_BP")
{
$mytype="Entrez GeneID";
open(IN1,"$ARGV[5]/annotation/gene_association.grouped.annotated_RplcdIDs140122_new_bp.txt") or die "Error opening in file";
}

if($ARGV[0] eq "sym" && $ARGV[3] eq "GO_MF")
{
$mytype="Gene Symbol";
open(IN1,"$ARGV[5]/annotation/gene_association.grouped.annotated140122_new_mf.txt") or die "Error opening in file";
}
if($ARGV[0] eq "gid" && $ARGV[3] eq "GO_MF")
{
$mytype="Entrez GeneID";
open(IN1,"$ARGV[5]/annotation/gene_association.grouped.annotated_RplcdIDs140122_new_mf.txt") or die "Error opening in file";
}

if($ARGV[0] eq "sym" && $ARGV[3] eq "GO_CC")
{
$mytype="Gene Symbol";
open(IN1,"$ARGV[5]/annotation/gene_association.grouped.annotated140122_new_cc.txt") or die "Error opening in file";
}
if($ARGV[0] eq "gid" && $ARGV[3] eq "GO_CC")
{
$mytype="Entrez GeneID";
open(IN1,"$ARGV[5]/annotation/gene_association.grouped.annotated_RplcdIDs140122_new_cc.txt") or die "Error opening in file";
}

#### KEGG DB ####
if($ARGV[0] eq "sym" && $ARGV[3] eq "KEGG")
{
$mytype="Gene Symbol";
open(IN1,"$ARGV[5]/annotation/KEGG_pathway_updated130711_geneSym.txt") or die "Error opening in file";
}
if($ARGV[0] eq "gid" && $ARGV[3] eq "KEGG")
{
$mytype="Entrez GeneID";
open(IN1,"$ARGV[5]/annotation/KEGG_pathway_updated130711_geneID.txt") or die "Error opening in file";
}

#### REACTOME DB ####
if($ARGV[0] eq "sym" && $ARGV[3] eq "REACTOME")
{
$mytype="Gene Symbol";
open(IN1,"$ARGV[5]/annotation/ReactomePathways_updated140614_geneSym.txt") or die "Error opening in file";
}
if($ARGV[0] eq "gid" && $ARGV[3] eq "REACTOME")
{
$mytype="Entrez GeneID";
open(IN1,"$ARGV[5]/annotation/ReactomePathways_updated140614_RplcdIDs.txt") or die "Error opening in file";
}


open(IN2,$ARGV[1]) or print "\n**Error opening input file: $ARGV[1]**\n\n";

print RESULT "Genes\tProcess\tGO:Class\tnum_of_Genes\tP-value\tEASE (http://david.abcc.ncifcrf.gov/content.jsp?file=functional_annotation.html#fisher) \tBenjamini and Hochberg (FDR)\t Hommel singlewise process\tBonferroni single-step process\tHommel singlewise process\tHochberg step-up process\tBenjamini and Yekutieli\n";

while(<IN1>){
	chomp;
	@temp1=split("\n",$_);
	foreach $temp1(@temp1)
	{
		@ar1 = split("\t",$temp1);
		$kegg{$ar1[0]} = ["$ar1[1]","$ar1[2]"];
	}
}



while(<IN2>){
	@temp2=split("\n",$_);
	foreach $temp2(@temp2)
	{
		@ar2 = split("\t",$temp2);
		$bp{$ar2[0]} = $ar2[0];
	}
}
$gene_list=@temp2;

@mykeys=();	
foreach my $keykg ( keys %kegg )
{
	
	@kgene=split(",",$kegg{$keykg}[1]);
	$kcount=1;
	$gcount=1;
	$gnum=0;
	@gset=();
	foreach $kgene(@kgene)
	{$knum=$kcount++;
				if(exists $bp{$kgene})
				{
					$gnum=$gcount++;
					$indgene=$bp{$kgene}.";";
					push(@gset,$indgene);
					##print RESULT $bp{$kgene}.";";
				}
				
					
	}


if($gnum>0)
{
$x=$gnum;
$n=$gene_list;
$M=$knum; ## total genes in process
$N=$ARGV[4];




$fisher_value = calculateStatistic( n11=>$x,n1p=>$n,np1=>$x+$M,npp=>$N+$n);
$ease_value= calculateStatistic( n11=>$x-1,n1p=>$n,np1=>$x+$M,npp=>$N+$n);

push(@new,$fisher_value);

##print RESULT "\t$keykg\t$kegg{$keykg}[0]\t$gnum\t$knum\t$fisher_value\t$ease_value\n";
push(@finres,"@gset\t$keykg\t$kegg{$keykg}[0]\t$gnum\t$fisher_value\t$ease_value\t");

}


}

$p=\@new;
$bhres = BH($p);
$holmres = holm($p);
$bfres=bonferroni($p);
$hommel=hommel($p);
$hochberg=hochberg($p);
$byres=BY($p);


for($i=0;$i<=$#finres;$i++)
{
print RESULT $finres[$i];
print RESULT @$bhres[$i]."\t".@$holmres[$i]."\t".@$bfres[$i]."\t".@$hommel[$i]."\t".@$hochberg[$i]."\t".@$byres[$i]."\n";

}





close(RESULT);
print"=================\nRun successful. Check your output directory $ARGV[2] \n=================\n\nParameters used:\n\nbackground genes:\t$ARGV[4]\nIdentitiy:\t\t$mytype\nDatabase used:\t\t$ARGV[3]\nOutput file:\t\t@ARGV[2]@{myout[$#myout]}_${ARGV[3]}_functional_classification.tsv\n\t\tWARNING: Your output is not sorted with P-val/FDR.\n\n\n---------------------\n\nAuthor: Santhilal Subhash\nsanthilal.subhash\@gu.se\nLast Updated: 2014 June 14\n"
