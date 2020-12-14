a= read.table("../PartA/Nest_Temps.txt",sep = "\t",header = TRUE)

Control_Temperature_Mean=mean(a$Temperature[a$Treatment=="Control"])
Maternal_Temperature_Mean=mean(a$Temperature[a$Treatment=="Maternal"])

Control_Temperatures=a$Temperature[a$Treatment=="Control"]
Maternal_Temperatures=a$Temperature[a$Treatment=="Maternal"]

install.packages("ggplot2")                                         # Install and load ggplot2
library("ggplot2")

typeof(Control_Temperatures)

A=Control_Temperatures
B=Maternal_Temperatures

hgA <- hist(A, breaks = 12)
hgB <- hist(B)

range(c(hgA, hgB)) # Get range for x-axis

max(c(hgA, hgB))

plot(hgA, col = 2, xlim = c(16, 50), ylim = c(0,10))
plot(hgB, add = TRUE, col = c2)
