#!/bin/bash

#SBATCH -c 10
#SBATCH --mem=60G
#SBATCH --job-name STAR_index
#SBATCH -o /scratch/qgong/reference/STAR/log/createSTARIndex.out
#SBATCH -e /scratch/qgong/reference/STAR/log/createSTARIndex.err

module load gcc/12.1.0 star/2.7.10b

STAR --runThreadN 10 \
     --runMode genomeGenerate \
     --genomeDir /scratch/qgong/reference/STAR/GRCh38_Gencode38_STAR2.7.10b_index \
     --genomeFastaFiles /gpfs/data/referenceFiles/Homo_sapiens/STARgenome/GRCh38.primary_Gencode38/Sequence/GRCh38.primary_assembly.genome.fa \
     --sjdbGTFfile /gpfs/data/referenceFiles/Homo_sapiens/STARgenome/GRCh38.primary_Gencode38/Annotation/gencode.v38.primary_assembly.annotation.gtf \
     --sjdbOverhang 50
