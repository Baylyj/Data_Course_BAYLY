library(ShortRead)
library(vegan)
library(purrr)


setwd("R/Data_Course_Material/Data_Course/Exams/Exam_3/")

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

rm(trimmed1,trimmed2,sample1,sample2)

###Part2####
#Import and clean
table = read.csv("exam3_otu_table.csv")
meta = read.csv("exam3_metadata.csv")
lineage = as.data.frame(table$Consensus.lineage)
table$Consensus.lineage = NULL
rownames(table) <- table[,1]
meta[,1] -> rownames(meta)
meta$SampleID = NULL
table$OTU.ID = NULL

meta$SampleType = as.factor(meta$SampleType)


transpose = as.data.frame(t(table))
lineage$otu = colnames(transpose)

#Subset data
meta = subset(meta, meta$SampleType == "Soil" | meta$SampleType == "rhizosphere")
transpose = subset(transpose, rownames(transpose) %in% rownames(meta))

#No Significant Difference
adonis(transpose ~ meta$SampleType)

#Find max OTU
soil = subset(transpose, rownames(transpose) %in% rownames(meta[which(meta$SampleType == "Soil"),]))
rhiz = subset(transpose, rownames(transpose) %in% rownames(meta[which(meta$SampleType == "rhizosphere"),]))

max.soil = as.character(lineage[which (colSums(soil) == max(colSums(soil))),1])
max.rhiz = as.character(lineage[which (colSums(rhiz) == max(colSums(rhiz))),1])

strsplit(max.soil,"g__", fixed = TRUE) -> splitS
strsplit(max.rhiz,"g__", fixed = TRUE) -> splitR

map(splitS,2)
map(splitR,2)
