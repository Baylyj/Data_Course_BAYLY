library(ShortRead)
library(vegan)


setwd("R/Data_Course_Material/Data_Course/Exam3/")

###Part1####
#read and convert
sample1 = readFastq("Sample1.fastq")
sample2 = readFastq("Sample2.fastq")
writeFasta(sample1,"Sample1.fasta")
writeFasta(sample2,"Sample2.fasta")

#number of sequences
length(sample1)
length(sample2)

#trim to first 100 bases
trimmed1 = narrow(sample1, start = 1, end = 100)
trimmed2 = narrow(sample2, start = 1, end = 100)
#Save
writeFastq(trimmed1, "Sample1.fastq.trim")
writeFastq(trimmed2, "Sample2.fastq.trim")

###Part2####
table = read.csv("exam3_otu_table.csv")
meta = read.csv("exam3_metadata.csv")
table[,1] -> rownames(table)
table$OTU.ID = NULL
meta[,1] -> rownames(meta)
meta$SampleID = NULL
meta$SampleType = as.factor(meta$SampleType)
submeta = meta[rownames(meta[c(which(meta$SampleType == "Soil"),which(meta$SampleType == "rhizosphere")),]),]
subtable = table[rownames(submeta)]
