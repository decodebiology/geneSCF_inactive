
args<-commandArgs(TRUE)



data <- read.delim(args[1], header=TRUE)
data <- data[order(data$P.value),]
size <- length(data[,1])
data[,"Rank_in_order"] <- c(seq(1:length(data[,1])))
data <- data[,cbind("Rank_in_order","Process.name","percentage.","P.value")]
colnames(data) <- c("Rank_in_order","process","genes","Pvalue")
data <- data[1:20,]
#lmt<-length(data[,1])
#write.table(data,paste0(args[2],"/",args[3],"_top_ranking_plotted.txt"),sep="\t",quote=F,row.names=F)

library(ggplot2)



## With geom_point labels single color



if(args[4]=="NCG") {


svg(paste0(args[2],"/",args[3],"_enrichment_plot.svg"),width=8,height=7)



ggplot(data, aes(x=Rank_in_order, y=-log10(Pvalue), size=genes, label=process,fill=paste0(data[,"Rank_in_order"],":",data[,"process"])),guide=FALSE)+

geom_point(colour="#2E2E2E", shape=21) + scale_size_area(max_size = 5)+

scale_x_continuous(name="Rank in order", limits=c(0,40))+
scale_y_continuous(name="-log10(Pvalue)")+
#scale_size_continuous(range=c(1, 15))+
labs(fill="Rank:CancerType (Top 20)")+
geom_text(size=3, color="#2E2E2E",hjust=0, vjust=0)+


geom_hline(yintercept=1.3)+
theme(axis.text.x= element_text("Arial", "plain", "#2E2E2E", "10"))+
theme(axis.text.y= element_text("Arial", "plain", "#2E2E2E", "10"))+
#theme(legend.text=element_text("Arial", "plain", "#2E2E2E", "20"))+
theme(text = element_text(size=10))
}



if(args[4]=="NCG") {

png(paste0(args[2],"/",args[3],"_enrichment_plot.png"),width=768,height=672)


ggplot(data, aes(x=Rank_in_order, y=-log10(Pvalue), size=genes, label=process,fill=paste0(data[,"Rank_in_order"],":",data[,"process"])),guide=FALSE)+

geom_point(colour="#2E2E2E", shape=21)+ scale_size_area(max_size = 5)+ 

scale_x_continuous(name="Rank in order", limits=c(0,40))+
scale_y_continuous(name="-log10(Pvalue)")+
#scale_size_continuous(range=c(1, 15))+
labs(fill="Rank:CancerType (Top 20)")+
geom_text(size=5, color="#2E2E2E",hjust=0, vjust=0)+


geom_hline(yintercept=1.3)+
#theme(axis.text.x= element_text("Arial", "plain", "#2E2E2E", "14"))+
#theme(axis.text.y= element_text("Arial", "plain", "#2E2E2E", "14"))+

#theme(legend.text=element_text("Arial", "plain", "#2E2E2E", "20"))+
theme(text = element_text(size=14))
}

if(args[4]=="NCG") {

pdf(paste0(args[2],"/",args[3],"_enrichment_plot.pdf"))



ggplot(data, aes(x=Rank_in_order, y=-log10(Pvalue), size=genes, label=process,fill=paste0(data[,"Rank_in_order"],":",data[,"process"])),guide=FALSE)+

geom_point(colour="#2E2E2E", shape=21)+ scale_size_area(max_size = 5)+ 

scale_x_continuous(name="Rank in order", limits=c(0,40))+
scale_y_continuous(name="-log10(Pvalue)")+
#scale_size_continuous(range=c(1, 15))+
labs(fill="Rank:CancerType (Top 20)")+
geom_text(size=5, color="#2E2E2E",hjust=0, vjust=0)+


geom_hline(yintercept=1.3)+
#theme(axis.text.x= element_text("Arial", "plain", "#2E2E2E", "14"))+
#theme(axis.text.y= element_text("Arial", "plain", "#2E2E2E", "14"))+
#theme(legend.text=element_text("Arial", "plain", "#2E2E2E", "20"))+
theme(text = element_text(size=14))

}







## Without geom_point labels


if(args[4]=="KEGG" || args[4]=="GO_all" || args[4]=="GO_BP" || args[4]=="GO_CC" || args[4]=="GO_MF") {

newdata <- cbind(gsub( "~.*$", "", data[,"process"]),data[,"Rank_in_order"])
colnames(newdata) <- c("IDs","Rank_in_order")
pdf(paste0(args[2],"/",args[3],"_enrichment_plot.pdf"),paper = "USr",width=900,height=625)
ggplot(data, aes(x=Rank_in_order, y=-log10(Pvalue), size=genes, label=newdata[,"IDs"],fill=paste0(data[,"Rank_in_order"],":",strtrim(data[,"process"], 35),"...")),guide=FALSE)+
geom_point(colour="#2E2E2E", shape=21)+ 
scale_size_area(max_size = 5)+ 
labs(fill="Rank:Process (Top 20)")+
scale_x_continuous(name="Rank in order", limits=c(0,40))+
scale_y_continuous(name="-log10(Pvalue)")+
#scale_size_continuous(range=c(1, 15))+
geom_text(size=5, color="#2E2E2E",hjust=0, vjust=0)+
geom_hline(yintercept=1.3)+
theme(text = element_text(size=14))
}


if(args[4]=="KEGG" || args[4]=="GO_all" || args[4]=="GO_BP" || args[4]=="GO_CC" || args[4]=="GO_MF") {
newdata <- cbind(gsub( "~.*$", "", data[,"process"]),data[,"Rank_in_order"])
colnames(newdata) <- c("IDs","Rank_in_order")
png(paste0(args[2],"/",args[3],"_enrichment_plot.png"),width=900,height=625)
ggplot(data, aes(x=Rank_in_order, y=-log10(Pvalue), size=genes, label=newdata[,"IDs"],fill=paste0(data[,"Rank_in_order"],":",strtrim(data[,"process"], 35),"...")),guide=FALSE)+
geom_point(colour="#2E2E2E", shape=21)+ 
scale_size_area(max_size = 5)+ 
labs(fill="Rank:Process (Top 20)")+
scale_x_continuous(name="Rank in order", limits=c(0,40))+
scale_y_continuous(name="-log10(Pvalue)")+
#scale_size_continuous(range=c(1, 15))+
geom_text(size=5, color="#2E2E2E",hjust=0, vjust=0)+
geom_hline(yintercept=1.3)+
theme(text = element_text(size=14))
}



if(args[4]=="KEGG" || args[4]=="GO_all" || args[4]=="GO_BP" || args[4]=="GO_CC" || args[4]=="GO_MF") {
newdata <- cbind(gsub( "~.*$", "", data[,"process"]),data[,"Rank_in_order"])
colnames(newdata) <- c("IDs","Rank_in_order")
svg(paste0(args[2],"/",args[3],"_enrichment_plot.svg"),width=8,height=7)
ggplot(data, aes(x=Rank_in_order, y=-log10(Pvalue), size=genes, label=newdata[,"IDs"],fill=paste0(data[,"Rank_in_order"],":",strtrim(data[,"process"], 35),"...")),guide=FALSE)+
geom_point(colour="#2E2E2E", shape=21)+ 
scale_size_area(max_size = 5)+ 
labs(fill="Rank:Process (Top 20)")+
scale_x_continuous(name="Rank in order", limits=c(0,40))+
scale_y_continuous(name="-log10(Pvalue)")+
#scale_size_continuous(range=c(1, 15))+
geom_text(size=3, color="#2E2E2E",hjust=0, vjust=0)+
geom_hline(yintercept=1.3)+
theme(text = element_text(size=10))
}



#### REACTOME



if(args[4]=="REACTOME") {


pdf(paste0(args[2],"/",args[3],"_enrichment_plot.pdf"))
ggplot(data, aes(x=Rank_in_order, y=-log10(Pvalue), size=genes, label=data[,"Rank_in_order"],fill=paste0(data[,"Rank_in_order"],":",strtrim(data[,"process"], 35),"...")),guide=FALSE)+
geom_point(colour="#2E2E2E", shape=21)+ 
scale_size_area(max_size = 5)+ 
labs(fill="Rank:Process (Top 20)")+
scale_x_continuous(name="Rank in order", limits=c(0,40))+
scale_y_continuous(name="-log10(Pvalue)")+
#scale_size_continuous(range=c(1, 15))+
geom_text(size=5, color="#2E2E2E",hjust=0, vjust=0)+
geom_hline(yintercept=1.3)+
theme(text = element_text(size=14))
}


if(args[4]=="REACTOME") {



png(paste0(args[2],"/",args[3],"_enrichment_plot.png"),width=768,height=672)
ggplot(data, aes(x=Rank_in_order, y=-log10(Pvalue), size=genes, label=data[,"Rank_in_order"],fill=paste0(data[,"Rank_in_order"],":",strtrim(data[,"process"], 35),"...")),guide=FALSE)+
geom_point(colour="#2E2E2E", shape=21)+ 
scale_size_area(max_size = 5)+ 
labs(fill="Rank:Process (Top 20)")+
scale_x_continuous(name="Rank in order", limits=c(0,40))+
scale_y_continuous(name="-log10(Pvalue)")+
#scale_size_continuous(range=c(1, 15))+
geom_text(size=5, color="#2E2E2E",hjust=0, vjust=0)+
geom_hline(yintercept=1.3)+
theme(text = element_text(size=14))
}



if(args[4]=="REACTOME") {



svg(paste0(args[2],"/",args[3],"_enrichment_plot.svg"),width=8,height=7)
ggplot(data, aes(x=Rank_in_order, y=-log10(Pvalue), size=genes, label=data[,"Rank_in_order"],fill=paste0(data[,"Rank_in_order"],":",strtrim(data[,"process"], 35),"...")),guide=FALSE)+
geom_point(colour="#2E2E2E", shape=21)+ 
scale_size_area(max_size = 5)+ 
labs(fill="Rank:Process (Top 20)")+
scale_x_continuous(name="Rank in order", limits=c(0,40))+
scale_y_continuous(name="-log10(Pvalue)")+
#scale_size_continuous(range=c(1, 15))+
geom_text(size=3, color="#2E2E2E",hjust=0, vjust=0)+
geom_hline(yintercept=1.3)+
theme(text = element_text(size=10))
}














dev.off()
dev.off()
dev.off()











