
args<-commandArgs(TRUE)

maxN <- function(x, N=2){
  len <- length(x)
  if(N>len){
    warning('N greater than length(x).  Setting N=length(x)')
    N <- length(x)
  }
  sort(x,partial=len-N+1)[len-N+1]
}

x <- read.table(args[1], header=TRUE, row.names=1)
x <- x[order(x$P.value),]
size <- length(x[,1])

x[,"percent_new"] <- (x[,"percentage."]/100)

pdf(paste0(args[2],"/",args[3],"enrichment_plot1.pdf"))
if(size>25)
{
#par(mfrow=c(1,2))
barplot(x$P.value[1:25],names=paste0(x$name[1:25],"(",rownames(x)[1:25],")"),las=2, main="Top 25 process",ylab="P-value",col="#DF3A01",cex.axis = 0.5,cex.lab=0.5,cex.names=0.2)
mtext(paste0("test upper right\ntest upper right"),side=3,outer=T,adj=15,line=-1,cex=0.5) 
myx <- ((length(x$P.value[1:25])/2)-2)
myy <- max(c(x$P.value[1:25]))
legend(myx,myy,c("Pvalues"),bty = "n", fill=c("#DF3A01"))

#plot.table(as.maitrix(as.numeric(x[1:25,])))

}
if(size<25)
{
barplot(x$P.value,names=paste0(x$name,"(",rownames(x),")"),las=2, main="All process",ylab="P-value",col="#DF3A01",cex.axis = 0.5,cex.lab=0.5,cex.names=0.2)
myx <- ((length(x$P.value)/2)-2)
myy <- max(c(x$P.value))
legend(myx,myy,c("Pvalues"),bty = "n", fill=c("#DF3A01"))
}
dev.off()



pdf(paste0(args[2],"/",args[3],"enrichment_plot2.pdf"))
if(size>25)
{
mybar <- barplot(x$P.value[1:25],names=paste0(x$name[1:25],"(",rownames(x)[1:25],")"),las=2, main="Top 25 process",ylab="Enriched process",col="#DF3A01",cex.axis = 0.5,cex.lab=0.5,cex.names=0.2,ylim=c(0,max(x$percent_new[1:25])))
myx <- ((length(x$P.value[1:25])/2)-2)
myy <- max(c(x$percent_new[1:25],x$P.value[1:25]))
legend(myx,myy,c("Pvalues"),bty = "n", fill=c("#DF3A01"))

points(x = mybar , y = x$percent_new[1:25])
lines(x = mybar , y = x$percent_new[1:25])

myx <- ((length(x$P.value[1:25])/2)-2)
myy <- maxN(c(x$percent_new[1:25],x$P.value[1:25]),N=2)
legend(myx,myy,c("(% of genes / 100)"), col=c("black"), lwd=2, lty=1, pch=c(1,1), merge=FALSE ,yjust = 1,bty = "n")
#legend( x=c(15,1), legend=c("NumberOfGenes"), col=c("black"), lwd=1, lty=1, pch=c(15,1), merge=FALSE )
}
if(size<25)
{
mybar <- barplot(x$P.value,names=paste0(x$name,"(",rownames(x),")"),las=2, main="All process",ylab="Enriched process",col="#DF3A01",cex.axis = 0.5,cex.lab=0.5,cex.names=0.2,ylim=c(0,max(x$percent_new[1:25])))

myx <- ((length(x$P.value)/2)-2)
myy <- max(x$percent_new,x$P.value)
legend(myx,myy,c("Pvalues"),bty = "n", fill=c("#DF3A01"))


points(x = mybar , y = x$percent_new)
lines(x = mybar , y = x$percent_new)

myx <- ((length(x$P.value)/2)-2)
myy <- maxN(c(x$percent_new,x$P.value),N=2)
legend(myx,myy,c("(% of genes / 100)"), col=c("black"), lwd=2, lty=1, pch=c(1,1), merge=FALSE ,yjust = 1,bty = "n")
#legend( x=c(15,1), legend=c("NumberOfGenes"), col=c("black"), lwd=1, lty=1, pch=c(15,1), merge=FALSE )
}
dev.off()


