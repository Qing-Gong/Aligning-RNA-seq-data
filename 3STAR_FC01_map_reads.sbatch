#!/bin/bash  -l

#SBATCH --job-name=STAR_map
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --partition=tier1q
#SBATCH --time=08:00:00
#SBATCH --cpus-per-task=6
#SBATCH --mem=48gb
#SBATCH --error=/scratch/qgong/NFile/mapping/log/FC01/star_%A.%a.%j.err
#SBATCH --output=/scratch/qgong/NFile/mapping/log/FC01/star_%A.%a.%j.out

#create a symbolic link to the orginal files

echo ${SLURM_ARRAY_JOB_ID}
echo ${SLURM_ARRAY_TASK_ID}

# STEP2 map reads with STAR need to set $OUTDIR and $FILE (fastq filename)
OUTDIR=/scratch/qgong/NFile/mapping/output/FC01

module load gcc/12.1.0 star/2.7.10b

# map to hg38
# create job array ID file

cd /scratch/qgong/NFile/mapping/FQ1/FastQ

#extract prefix
PREFIX=$( </scratch/qgong/NFile/mapping/ArrayJobID_FC1.txt egrep -w "^${SLURM_ARRAY_TASK_ID}" | cut -d" " -f2 )

echo ${PREFIX}
#(pattern); \ escape sign; means before "_R1" or "_R2" there is at least one character and the pattern in () was extract using \1
# .* should be used if at least 1 character trying to match

# remove space after ${PREFIX} each line
fq1=$( printf "%s%s\n" ${PREFIX} _R1_001.fastq.gz)
fq2=$( printf "%s%s\n" ${PREFIX} _R2_001.fastq.gz)

genomeDIR=/gpfs/data/referenceFiles/Homo_sapiens/STARgenome/GRCh38.primary_Gencode38/Sequence/STAR_99
#genomeDIR=/scrach/qgong/reference/STAR/GRCh38_Gencode38_STAR2.7.10b_index 
outPrefix=${OUTDIR}/${PREFIX}_

# note: need BAM to be SortedByCoordinate to run verifyBamID but this takes longer and needs more memory
# can also set BAM to be Unsorted which is faster

#cat <<EOF
srun STAR --runMode alignReads \
     --runThreadN 6 \
     --readFilesIn ${fq1} ${fq2} \
     --readFilesCommand zcat \
     --genomeDir ${genomeDIR} \
     --quantMode GeneCounts \
     --alignEndsType Local \
     --outFileNamePrefix ${outPrefix} \
     --outSAMtype BAM SortedByCoordinate

#EOF
# note: ${outPrefix}ReadsPerGene.out.tab has gene counts
