# 

GCraw2sum=function(runName){
  filei<-paste(runName, "GLPrprtB.txt",sep="/") #file to open from subfolder i
 
  rawdata.temp<-read.table(filei,header=FALSE,sep="\\",blank.lines.skip=F) #read filei
  headlength<-grep('----',rawdata.temp[,1])
  
  #check to make sure there are peaks
  if(length(headlength)>0){
    rawdata<-read.table(filei,header=F,sep="\\", stringsAsFactors=F, blank.lines.skip=F,skip=headlength[1])
    rawdata<-rawdata[1:(nrow(rawdata)-1),]
    
    #make data frame
    data.fix=data.frame()
    
    #read each line one at a time and pull out data
    for (j in 1:length(rawdata)){
      rowi<-strsplit(as.character(rawdata[j]),split=" ")
      goodi<-which(rowi[[1]]!="" & rowi[[1]]!="S" & rowi[[1]]!="T" & rowi[[1]]!="X") #find non blanks
      datai<-t(as.data.frame(as.character(rowi[[1]][goodi])))
      if(ncol(datai)<8){
        datai=t(as.data.frame(as.character(c(rep(0, times=4), rowi[[1]][goodi]))))
      }
      data.fix<-rbind(data.fix,datai)
    }
    
    #remove some columns and convert to correct data type
    row.names(data.fix)<-NULL #remove row names
    data.fix<-data.fix[,c(1,5:8)] #remove unnecessary columns
    names(data.fix)<-c('sample','sig', 'RT','area','height')
    data.fix$runName<-paste(data.fix$sample, runName, sep="_")
    data.fix=data.fix[c('runName',"sample", 'sig','RT','area','height')] #reorder columns
  }
  return(data.fix)
}