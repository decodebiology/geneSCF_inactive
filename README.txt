Gene Set Clustering based on Functional annotation
----------------------------------------------------------------------------
https://github.com/santhilalsubhash/geneSCF/wiki

INSTALL:

No installation required

TEST DATASETS:

Run command

./test_geneSCF

You will get output in './test/output/' directory.


USAGE: 

geneSCF <OPTIONS> -i=<INPUT FILE> -o=<OUTPUT PATH/FOLDER> -db=<GO_all|GO_BP|GO_MF|GO_CC|KEGG|REACTOME|NCG>

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
			reactome 'REACTOME' or Network of Cancer Genes 'NCG' (Without quotes).

[-o= | --outpath=]	Path to save output file. The output will be with saved in the 
			provided existing location as 
			{INPUT_FILE_NAME}_{database}_functional_classification.tsv 
			(tab-seperated file). Note: This tool will not create output directory, 
			only outputs in exiting location.

[-bg= | --background=]	Total background genes to consider (default : 30000).

[-h | --help]		For displaying this help page.



--------------------------
Cite using website: 
" 
<a href="http://www.nature.com/ncomms/2015/150724/ncomms8743/full/ncomms8743.html" target=new>MEG3 long noncoding RNA regulates TGF-β pathway genes through formation of RNA-DNA triplex structures.
Mondal T, Subhash S, Vaid R, Enroth S, Sireesha K , Reinius B, Mitra S, Mohammed A, James AR, Hoberg E, Moustakas A, Gyllensten U, Jones S, Gustafsson C, Sims AH, Westerlund F, Gorab E and Chandrasekhar Kanduri.
Nature communications 2015 </a>
"

--------------------------
Author: Santhilal Subhash
santhilal.subhash@gu.se
Last Updated: 2015 June 05
https://github.com/santhilalsubhash/geneSCF/wiki
