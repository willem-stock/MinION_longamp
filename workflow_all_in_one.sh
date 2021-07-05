#! /bin/bash

#start in workindirectory with the fastq files to be analysed 

echo "running NGSpeciesID on the fastq files in this folder with an abundance treshold of  ${1-0.002}"

#1 add sample code to header 
for f in *.fastq ; do
	b=${f%.fastq}
	sed -i "1~4s/$/sample=$b/" $f
done

#2 merge fastqs 
cat *fastq > summed.fastq
#3 run NGSpeciesID 
/home/wstock/NGSpeciesID_gitinstall/NGSpeciesID  --ont --fastq summed.fastq --consensus --abundance_ratio ${1-0.002} --racon --racon_iter 2 --outfolder folder_out 
#4 count number of reads per sample per consensus seq
sample_names=""
for f in *.fastq; do
  test "$f" = summed.fastq && continue
  b=${f%.fastq}
  echo $b
  if [ -z "$sample_names" ]; then
        grep -c  -i sample=$b folder_out/reads_to_consensus*.fastq >$b.readcount.txt
  else
        grep -c  -i -h sample=$b folder_out/reads_to_consensus*.fastq >$b.readcount.txt
  fi
  sample_names+="$b",
  done
paste -d, *.readcount.txt > joined_readcount.txt
sed -i "1 i\sequence:${sample_names%?}" joined_readcount.txt


#6 merge concensus sequences
cat folder_out/*fasta >all_consensus.fasta
