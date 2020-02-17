# concatonate all the summary files 
concatSummaries=function(summaryDir="~/OneDrive - nd.edu/underc-field-2019/gc2019underc/summaries/", 
                         databaseOutput="~/OneDrive - nd.edu/underc-field-2019/gc2019underc/currentDB/GCdatabase2019.csv"){
  # Create lists of all summary names
  csvs=list.files(summaryDir)
  # Create empty object to fill
  gcDatabase=data.frame()
  
  # Use for loop to read in summaries and rbind to gcDatabase
  for(i in 1:length(csvs)){
    print(paste(i, csvs[i], sep=": "))
    temp=read.csv(paste0(summaryDir, csvs[i]), stringsAsFactors = F)
    gcDatabase=rbind(gcDatabase, temp)
  }
  
  # Write gcDatabase to output
  write.csv(x=gcDatabase, file=databaseOutput, row.names = F, quote = F)
}


