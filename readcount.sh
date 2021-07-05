#! /bin/bash
echo "looping"
sample_names=""
while read p; do
  echo "$p"
  if [ -z "$sample_names" ]; then
    grep -c  -i $p *.fastq >$p.readcount.txt
  else
    grep -c -i -h $p *.fastq >$p.readcount.txt
  fi
  sample_names+="$p",
done <$1
paste -d, *.readcount.txt > joined_readcount.txt
sed -i "1 i\sequence:$sample_names" joined_readcount.txt
