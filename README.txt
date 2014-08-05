Functional Classification for set of genes (also > 3000 genes)
----------------------------------------------------------------------------
INSTALL:

No installation required

USAGE: 

geneSCF <OPTIONS> -i=<INPUT FILE> -o=<OUTPUT PATH/FOLDER> -db=<GO_all|GO_BP|GO_MF|GO_CC|KEGG|REACTOME>

==========
Options:
==========

[-i= | --infile=]	Input file contains list of Entrez GeneIDs or OFFICIAL GENE SYMBOLS.
			The genes must be new lines seperated (One gene per line).

[-t= | --gtype=]	Type of input in the provided list either Entrez GeneIDs 'gid'
			or OFFICIAL GENE SYMBOLS 'sym' (Without quotes, default: sym).

[-db= | --database=]	Database you want to find gene enrichment which is either 
			geneontology 'GO_all' or geneontology-biological_process 
			'GO_BP' or geneontology-molecular_function 'GO_MF' or 
			geneontology-cellular_components 'GO_CC' or kegg 'KEGG' or 
			reactome 'REACTOME' (Without quotes).Soon updating with BIOCARTA.

[-o= | --outpath=]	Path to save output file. The output will be with saved in the 
			provided location as {INPUT_FILE_NAME}_{database}_functional_classification.tsv 
			(tab-seperated file).

[-bg= | --background=]	Total background genes to consider (default : 30000).

[-h | --help]		For displaying this help page.



--------------------------


Author: Santhilal Subhash
santhilal.subhash@gu.se
Last Updated: 2014 June 14
