Gene Set Clustering based on Functional annotation
----------------------------------------------------------------------------
Hosting website: https://genescf.kandurilab.org

INSTALL:

No installation of GeneSCF required. The plot function in GeneSCF needs 'ggplot2' R package (R version > 3.0).


USAGE: 

./geneSCF -m=[update|normal] -i=<INPUT FILE> -o=<OUTPUT PATH/FOLDER/> -t=[gid|sym] -db=<GO_all|GO_BP|GO_MF|GO_CC|KEGG|REACTOME> -bg=<background_gene_set> --plot=[yes|no] -org=<org_codes_help>

==========
Options:
==========

[-m= | --mode=]		For normal mode use 'normal' and for update mode use 'update' without quotes.

[-i= | --infile=]	Input file contains list of Entrez GeneIDs or OFFICIAL GENE SYMBOLS.
			The genes must be new lines seperated (One gene per line).

[-t= | --gtype=]	Type of input in the provided list either Entrez GeneIDs 'gid'
			or OFFICIAL GENE SYMBOLS 'sym' (Without quotes, default: gid).

[-db= | --database=]	Database you want to find gene enrichment which is either 
			geneontology 'GO_all' or geneontology-biological_process 
			'GO_BP' or geneontology-molecular_function 'GO_MF' or 
			geneontology-cellular_components 'GO_CC' or kegg 'KEGG' or 
			reactome 'REACTOME' or Network of Cancer Genes 'NCG' (Without quotes).

[-o= | --outpath=]	Existing directory to save output file. The output will be with saved in the 
			provided location as {INPUT_FILE_NAME}_{database}_functional_classification.tsv 
			(tab-seperated file).

[-bg= | --background=]	Total background genes to consider (Example : ~20,000 for human).

[-org= | --organism=]	Please see organism codes(For human in KEGG ->'hsa' in Geneontology -> 'goa_human').

[-p= | --plot=]		For additional graphical output use 'yes' or 'no'.This requires R version > 3.0 and 
			'ggplot2' R package to be pre-installed on the system.

[-h | --help]		For displaying this help page.



--------------------------
Cite using project website: 

https://github.com/santhilalsubhash/geneSCF


--------------------------
Author: Santhilal Subhash
santhilal.subhash@gu.se
Last Updated: 2016/01/05
https://genescf.kandurilab.org
