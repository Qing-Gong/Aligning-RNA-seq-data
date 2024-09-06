#!/bin/bash
#iterate each line in mismatch file

while read -r LINE
do
echo "$LINE"
short=/scratch/qgong/corrected_vbi45/pbs2/$LINE

echo "#!/bin/bash" >$short.pbs
echo "#PBS -N bestmatch" >>$short.pbs
echo "#PBS -l nodes=1:ppn=8" >>$short.pbs
echo "#PBS -l mem=48gb" >>$short.pbs
echo "#PBS -l walltime=04:00:00" >>$short.pbs
echo "#PBS -o /scratch/qgong/corrected_vbi45/log/${LINE}.out" >>$short.pbs
echo "#PBS -e /scratch/qgong/corrected_vbi45/log/${LINE}.err" >>$short.pbs

echo "module load gcc/6.2.0 samtools/1.9 verifybamid/1.1.3" >>$short.pbs

echo "bam=/scratch/qgong/NFile_mapping_results/mapping/${LINE}_Aligned.sortedByCoord.out.bam" >>$short.pbs

#index bam file
echo "samtools index \${bam}" >>$short.pbs

#verify to find best match
echo "verifyBamID --vcf /scratch/qgong/genotype_vcf/vcf45_vbi.vcf --bam \${bam} --out /scratch/qgong/corrected_vbi45/best_match/${LINE}.best.all --verbose --ignoreRG --best" >>$short.pbs

#read sample ID from a txt file
done < mismatch.txt
