#!/bin/bash

#SBATCH --partition=tier2q
#SBATCH --job-name=HISAT
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=200gb
#SBATCH --time=72:00:00
#SBATCH --error=/scratch/qgong/NFile/aligning/log/FC01/star_%A.%a.%j.err
#SBATCH --output=/scratch/qgong/NFile/aligning/log/FC01/star_%A.%a.%j.out

module load gcc/12.1.0
module load hisat2/2.2.1
module load samtools

ls /scratch/qgong/NFile/aligning/FQ1/FastQ|tail -246|awk -F'_R' '{print $1}' >FC01.list

#wget https://genome-idx.s3.amazonaws.com/hisat/grch38_snptran.tar.gz
#tar -xvf grch38_snptran.tar.gz

TARGET=/scratch/qgong/NFile/aligning
INDEX=/scratch/qgong/NFile/aligning/grch38_snp_tran/genome_snp_tran

cd $TARGET

sample_file=FC01.list

while IFS= read -r base; do
    echo $base

    fq1=$TARGET/FQ1/FastQ/${base}_R1_001.fastq.gz

    fq2=$TARGET/FQ1/FastQ/${base}_R2_001.fastq.gz

    hisat2 -p 6 -x $INDEX -1 $fq1 -2 $fq2 |samtools view -bS - |samtools sort -n - -o $TARGET/output/FC01/${base}$
    samtools fixmate -m $TARGET/output/FC01/${base}.sorted.bam - | samtools sort - |samtools markdup -rs - $TARGE$

done < $sample_file

echo "done!"
