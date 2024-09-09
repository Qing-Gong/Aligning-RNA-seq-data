#!/bin/bash

#SBATCH --partition=tier2q
#SBATCH --job-name=featureCounts
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=5
#SBATCH --mem=64gb
#SBATCH --time=12:00:00
#SBATCH --error=/scratch/qgong/NAPS/aligning/log/featureCounts1_FC01.err
#SBATCH --output=/scratch/qgong/NAPS/aligning/log/featureCounts1_FC01.out

module load gcc/12.1.0
module load subread


OUTDIR=/scratch/qgong/NAPS/aligning/output

featureCounts -p --countReadPairs -T 5 -s 1 \
-a /gpfs/data/referenceFiles/Homo_sapiens/STARgenome/GRCh38.primary_Gencode38/Annotation/gencode.v38.primary_assembly.annotation.gtf \
-o ${OUTDIR}/featureCounts1_sorted_output_FC01.txt ${OUTDIR}/FC01/*.sorted.bam 
