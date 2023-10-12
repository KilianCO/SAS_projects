install.packages('CCA')
library(CCA)

data(nutrimouse)

gene=nutrimouse$gene[76:90]
agh=nutrimouse$lipid[11:21]
#nutridiet=nutrimouse$diet
#nutrigenotype=nutrimouse$genotype

write.table(x=cbind(gene,agh),
            file="U:/Mes documents/M2/Data Mining Project/nutrimouse.txt",
            col.names=T,row.names=F,quote=F,na='.')

write.table(x=gene,
            file="U:/Mes documents/M2/Data Mining Project/genes.txt",
            col.names=T,row.names=F,quote=F,na='.')

write.table(x=agh,
            file="U:/Mes documents/M2/Data Mining Project/agh.txt",
            col.names=T,row.names=F,quote=F,na='.')
