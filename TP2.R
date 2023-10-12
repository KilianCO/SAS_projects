# Kilian COLLET
# TP2

setwd("U:/Mes documents/M2/Data Mining")

# Exercice 1 ####
# Question 1
data(islands)
par(mfrow=c(1,2))
hist(islands)

plot(density(islands,kernel="gaussian"),main="par noyau normal")
plot(density(islands,kernel="triangular"),main="par noyau triangulaire")
write.table(islands,file="islands.txt",quote=F,col.names=F)
a=read.table('eaux.txt',col.names=c("hco3","so4","cl","ca","mg","na","s","p"))
attach(a)
hist(hco3)
shapiro.test(hco3) #HCO3 suit une loi normale
plot(density(hco3,kernel=))



# Question 2







# Exercice 2 ####

