#!/bin/bash

cd /scratch/qgong/NAPS/aligning/FQ1/FastQ

# generate array job id for Flow cell FC1
for FILE in *.fastq.gz
do
        basename $FILE|sed 's/\(.*\)_R[12]_.*.fastq\.gz/\1/g'
done \
        | sort | uniq \
        | while read PREFIX
do
        echo $PREFIX|awk -F'_' '{print substr($2, 2), $PREFIX}'
done >/scratch/qgong/NAPS/aligning/ArrayJobID_FC1.txt


cd /scratch/qgong/NAPS/aligning/FQ2/FastQ

# generate array job id for Flow cell FC2
for FILE in *.fastq.gz
do
        basename $FILE|sed 's/\(.*\)_R[12]_.*.fastq\.gz/\1/g'
done \
        | sort | uniq \
        | while read PREFIX
do
        echo $PREFIX|awk -F'_' '{print substr($2, 2), $PREFIX}'
done >/scratch/qgong/NAPS/aligning/ArrayJobID_FC2.txt
