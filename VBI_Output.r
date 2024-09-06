
module load gcc/6.2.0 R/4.0.3

#FREEMIX : Sequence-only estimate of contamination (0-1 scale)
#CHIPMIX : Sequence+array estimate of contamination (NA if the external genotype is unavailable) (0-1 scale)

#When [CHIPMIX] >> 0.02 and/or [FREEMIX] >> 0.02, meaning 2% or more of non-reference bases are observed in reference sites,
#When [CHIPMIX] ~ 1 AND [FREEMIX] ~ 0, then it is possible that the sample is swapped with another sample

setwd("/scratch/qgong/verifyBamID_45")
files <- Sys.glob("*self.selfSM")
out <- NULL
for(i in files){
data <- read.table(i,header=F)
id <- gsub(".self.selfSM","",i)
data$id <- id
out <- rbind(out,data)
}
names(out) <- c("SEQ_ID","RG","CHIP_ID","SNPS","READS","AVG_DP","FREEMIX","FREELK1","FREELK0","FREE_RH","FREE_RA","CHIPMIX","CHIPLK1","CHIPLK0","CHIP_RH","CHIP_RA","DPREF","RDPHET","RDPALT","ID")

#output variables of interests
output <- out[,c(1, 3, 7, 12, 20)]

#check FREEMIX > 0.05
output[output$FREEMIX > 0.05,]

#check CHIPMIX > 0.5
output[output$CHIPMIX > 0.5,]
