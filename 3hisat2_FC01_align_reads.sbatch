#!/bin/bash -l

#SBATCH --job-name=HISAT2
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --partition=tier2q
#SBATCH --time=64:00:00
#SBATCH --cpus-per-task=6
#SBATCH --mem=64GB
#SBATCH --error=/scratch/qgong/NFile/aligning/log/FC01/star_%A.%a.%j.err
#SBATCH --output=/scratch/qgong/NFile/aligning/log/FC01/star_%A.%a.%j.out

#create a symbolic link to the orginal files

echo ${SLURM_ARRAY_TASK_ID}

# STEP2 map reads with STAR need to set $OUTDIR and $FILE (fastq filename)

OUTDIR=/scratch/qgong/NFile/aligning

module load gcc/12.1.0
module load hisat2/2.2.1
module load samtools

# map to hg38
# create job array ID file

#extract prefix
PREFIX=$( </scratch/qgong/NFile/aligning/ArrayJobID_FC1.txt egrep -w "^${SLURM_ARRAY_TASK_ID}" | cut -d" " -f2 )

echo ${PREFIX}

# remove space after ${PREFIX} each line
fq1=$( printf "%s%s\n" $OUTDIR/FQ1/FastQ/${PREFIX} _R1_001.fastq.gz)
fq2=$( printf "%s%s\n" $OUTDIR/FQ1/FastQ/${PREFIX} _R2_001.fastq.gz)

INDEX=/scratch/qgong/NFile/aligning/grch38_snp_tran/genome_snp_tran

# note: need BAM to be SortedByCoordinate to run verifyBamID but this takes longer and needs more memory

#cat <<EOF
srun hisat2 -p 6 -x $INDEX -1 $fq1 -2 $fq2 |samtools view -bS - |samtools sort -n - -o $OUTDIR/output/FC01/${PREFIX}.sorted.bam
srun samtools fixmate -m $OUTDIR/output/FC01/${PREFIX}.sorted.bam - | samtools sort - |samtools markdup -rs - $OUTDIR/output/FC01/${PREFIX}.rmPCRdup.bam



