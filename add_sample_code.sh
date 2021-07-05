#! /bin/bash
for f in *.fastq ; do
	b=${f%.fastq}
	sed -i "1~4s/$/sample=$b/" $f
done
