#!/bin/ba sh -l
bash createArrayID.sh

#chmod +x FC01_align_reads.sbatch

sbatch --array=1-123 \
        /scratch/qgong/NFile/aligning/FC01_align_reads.sbatch
