# From workshop:
##### TWS 2022 Genomic Analysis Workshop #####
#This uses bioconductor to install some packages
if(!requireNamespace("BiocManager", quietly = TRUE)){install.packages("BiocManager")}
BiocManager::install(c("gdsfmt","SNPRelate","LEA","qvalue","XML","karyoploteR", "IRanges","Biostrings"),update=FALSE)

#
# install.packages("devtools")
library(devtools)

## Load Packages ##
install.packages("vcfR")
install.packages("hierfstat")
install_github("drveera/ggman")
install.packages("pcadapt")
install_github("jdstorey/qvalue")


#Load library
library(LEA)
library(vcfR)
library(tidyverse)
library(hierfstat)
library(ggman)
library(pcadapt)
library(qvalue)
library(here)

#set your working directory to where your vcf files are stored


#SambaR info can be found at https://github.com/mennodejong1986/SambaR and
#the paper at https://onlinelibrary.wiley.com/doi/full/10.1111/1755-0998.13339
# source("https://github.com/mennodejong1986/SambaR/raw/master/SAMBAR_v1.08.txt")
# 
# getpackages()

# read in vcf file
vcf<-read.vcfR(here("data/trus_first_round_seq/vcf/populations.snps.vcf"))
vcf

# convert to genlight object
gen<-vcfR2genlight(vcf)

# include popIDs
indNames(gen)

pop_df<-read_csv(here("data/trus_first_round_seq/popmap_first_plate_states.csv"))
pops<-as.factor(pop_df$population[1:96])
pop(gen)<-pops
popNames(gen)
table(pop(gen))

# convert genlight object to sambaR format
genlight2sambar("gen", do_confirm = T)


#filter data
filterdata(indmiss=0.5)

# Calculate 
calcdiversity()

#population structure
findstructure(Kmax = 7)

#estimate population differentiation
calcdistance()


