#!/bin/bash
#iterate each line to get sampleID and bamID

while read -r samp bamID
do
echo "$bamID"
short=/scratch/qgong/corrected_vbi45/pbs/$bamID


echo "#!/bin/bash" >$short.pbs
echo "#PBS -N verifyBamID" >>$short.pbs
echo "#PBS -l nodes=1:ppn=8" >>$short.pbs
echo "#PBS -l mem=48gb" >>$short.pbs
echo "#PBS -l walltime=04:00:00" >>$short.pbs
echo "#PBS -o /scratch/qgong/corrected_vbi45/log/${bamID}.out" >>$short.pbs
echo "#PBS -e /scratch/qgong/corrected_vbi45/log/${bamID}.err" >>$short.pbs

echo "module load gcc/6.2.0 samtools/1.9 verifybamid/1.1.3" >>$short.pbs

echo "bam=/scratch/qgong/Nfile_mapping_results/mapping/${bamID}_Aligned.sortedByCoord.out.bam" >>$short.pbs

#index bam file
echo "samtools index \${bam}" >>$short.pbs

#verify
echo "verifyBamID --vcf /scratch/qgong/genotype_vcf/vcf45_vbi.vcf --bam \${bam} --smID ${samp} --out /scratch/qgong/corrected_vbi45/vbi45_output/${bamID}.self --verbose --ignoreRG" >>$short.pbs

done < sampleID.txt

