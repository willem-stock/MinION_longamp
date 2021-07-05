# MinION_longamp
## tools for long amplicon data processing for bacterial communities sequenced on a MinION

This workflow is used for obtaining consensus sequences and a count table, starting from demultiplexed fastq files. 
This can be done in a single step using _workflow_all_in_one.sh_ or in multiple seperate steps (see below).
##Installation:
This requires no additional software apart from what is already required to run NGSpeciesID. you can find the instructions to install NGSpeciesID [here](https://github.com/ksahlin/NGSpeciesID). Copy the required scipts provided in this branch to the folder containing the fasq files that you want to analyse.

_workflow_all_in_one.sh_ can be executed from the folder that contains the fastq files. It accepts one optional argument, the abundance ratio cutoff for NGSpeciesID. if this is not given, it is 0.002

`bash workflow_all_in_one.sh`

the same workflow can be run in different steps to increase flexiblity

1 add sample code to header  
`bash add_sample_code.sh`

`ls *fastq | sed -e 's/\.fastq$//' >file_names.txt`

2 merge fastqs if relevant
`cat *fastq > grouped.fastq`

3 run NGSpeciesID 
`./NGSpeciesID  --ont --fastq file.fastq --consensus --abundance_ratio 0.002 --racon --racon_iter 2 --outfolder folder_out ` 

4 count number of reads per sample per consensus seq

`bash readcount.sh ../file_names.txt`

6 merge concensus sequences
`cat *fasta >all_consensus.fasta`


taxonomic assignment
...




