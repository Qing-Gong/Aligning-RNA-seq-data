#!/bin/bash  -l

sbatch --array=1-123 \
        /scratch/qgong/NFile/mapping/3FC01_map_reads.sbatch
