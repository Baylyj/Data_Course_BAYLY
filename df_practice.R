setwd("~/R/Data_Course_Material/Data_Course/data/")
list.files()
df = read.csv("Fake_grade_data.csv")
df$X = NULL
row.names(df) = df$Student
df$Student = NULL
df$`Total Grade`= rowSums(df)

A = df[df$`Total Grade` >= 700,]

A[order(A$`Total Grade`, decreasing = TRUE),]

sample(df$`Total Grade`)


