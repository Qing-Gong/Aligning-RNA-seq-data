cut -f1,7-129 featureCounts_sorted_output_FC01.txt > featureCounts_sorted_output_FC01_Rmatrix.txt

cut -f1,7-129 featureCounts_sorted_output_FC02.txt > featureCounts_sorted_output_FC02_Rmatrix.txt

cut -f1,7-129 featureCounts_rmPCRdup_output_FC01.txt > featureCounts_rmPCRdup_output_FC01_Rmatrix.txt

cut -f1,7-129 featureCounts_rmPCRdup_output_FC02.txt > featureCounts_rmPCRdup_output_FC02_Rmatrix.txt


# vim :%s/.sorted.bam//g (in command mode).
# :%s/\/scratch\/qgong\/NAPS\/aligning\/output\/FC01\///g (in command mode).
