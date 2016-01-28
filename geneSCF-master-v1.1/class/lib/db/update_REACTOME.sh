#!/bin/bash
organism=$1;
DIR=$2;
bpath="$DIR/class/lib/db/$organism";
#mkdir -p $bpath
rm $DIR/class/lib/db/gene_info_limit.gz;
echo "Downloading REACTOME database...."

wget -P  $bpath/ http://www.reactome.org/download/current/ReactomePathways.gmt.zip --quiet;



echo "Updating gene information...";
wget -P  $DIR/class/lib/db/ ftp://ftp.ncbi.nlm.nih.gov/gene/DATA/gene_info.gz --quiet;
echo "Do not panic. The processing is going on...";
gzip -d  $DIR/class/lib/db/gene_info.gz;
cat $DIR/class/lib/db/gene_info | grep -v "^#" | awk -F '\t' '{print $1"\t"$3"\t"$2;}' > $DIR/class/lib/db/gene_info_limit;
rm $DIR/class/lib/db/gene_info;




unzip -q $bpath/ReactomePathways.gmt.zip -d $bpath/;
cat $bpath/ReactomePathways.gmt | sed 's/\t/\$/' | sed 's/\t/\$/' | sed 's/\t/\,/g' | sed 's/\$/\t/g' | cut -f1,3 > $bpath/ReactomePathways_sym.tmp;

echo "Extracting organism information...";

#gzip -d $DIR/class/lib/db/gene_info_limit.gz;
cat $DIR/class/lib/db/gene_info_limit | grep -w "^9606" | awk -F '\t' '{print $2"\t"$3;}' > $bpath/geneSymWithID.txt; #$org_taxid
gzip $DIR/class/lib/db/gene_info_limit;


awk 'BEGIN{FS="\t"}{ if( !seen[$1]++ ) order[++oidx] = $1; stuff[$1] = stuff[$1] $2 "," } END { for( i = 1; i <= oidx; i++ ) print order[i]"\t"stuff[order[i]] }' $bpath/geneSymWithID.txt | sed 's/,$//' > $bpath/geneSymWithID_DupGrpd.txt;


perl $DIR/class/scripts/replaceIDS.pl $bpath/ReactomePathways_sym.tmp $bpath/geneSymWithID_DupGrpd.txt $DIR > $bpath/ReactomePathways_gid.tmp



mv $bpath/ReactomePathways_gid.tmp $bpath/REACTOME_gid.txt;
mv $bpath/ReactomePathways_sym.tmp $bpath/REACTOME_sym.txt;

rm $bpath/geneSymWithID.txt $bpath/geneSymWithID_DupGrpd.txt $bpath/ReactomePathways.gmt.zip $bpath/ReactomePathways.gmt;

echo "Finished processing...";


echo "Database retreived..You are now ready to use geneSCF with organism Human ($organism) from --database REACTOME";
DT=`/bin/date`;
echo "Done....$DT";


