#!/bin/bash
for i in "$@"
do
case $i in
    -t=*|--gtype=*)
    GTYPE="${i#*=}"

    ;;
    -i=*|--infile=*)
    INFILE="${i#*=}"
    ;;
    -o=*|--outpath=*)
    OUTPATH="${i#*=}"
    ;;
   -db=*|--database=*)
    database="${i#*=}"
    ;;
   -bg=*|--background=*)
    background="${i#*=}"
    ;;
   -h*|--help)
    echo -e "\n\nUSAGE: \n\n./geneEnrich.sh <OPTIONS> -i=<INPUT FILE> -o=<OUTPUT PATH/FOLDER> -db=[KEGG|GO|REACTOME]\n\n==========\nOptions:\n==========\n\n[-i= | --infile=]\tInput file contains list of Entrez GeneIDs or OFFICIAL GENE SYMBOLS.\n\t\t\tThe genes must be new lines seperated (One gene per line).\n\n[-t= | --gtype=]\tType of input in the provided list either Entrez GeneIDs 'gid'\n\t\t\tor OFFICIAL GENE SYMBOLS 'sym' (Without quotes, default: sym).\n\n[-db= | --database=]\tDatabase you want to find gene enrichment which is either \n\t\t\tgene ontology database 'GO' or kegg 'KEGG' or reactome 'REACTOME' (Without quotes).\n\t\t\t*Soon updating with BIOCARTA.\n\n[-o= | --outpath=]\tPath to save output file. The output will be with saved in the \n\t\t\tprovided location as {INPUT_FILE_NAME}_{database}_functional_classification.tsv (tab-seperated file).\n\n[-bg= | --background=]\tTotal background genes to consider (default : 30000).\n\n[-h | --help]\t\tFor displaying this help page.\n";
exit 1;
    ;;
    *)
            # unknown option
    ;;
esac
done

if [ $# -eq 0 ]; then
    echo -e "\n\nPlease use:\n\n./geneEnrich.sh -h \n\n(or)\n\n./geneEnrich.sh --help \n\n for help\n";
	exit 1;
fi
if [ -z $database ]; then
    echo "Please specify database such as GO,KEGG";
	exit 1;
fi

if [ -z $GTYPE ]; then
   
GTYPE="sym";

fi

if [ -z $background ]; then
   
background=30000;

fi

if [ -z $INFILE ]; then
   
echo "Input file missing";

exit 1;

fi

if [ -z $OUTPATH ]; then

echo "Please specify out put path";

exit 1;

fi


DT=`/bin/date`
echo "processing started....$DT" 

perl ./class/functional_class.pl ${GTYPE} ${INFILE} ${OUTPATH} ${database} ${background}

DT=`/bin/date`
echo "$DT finished processing" 
