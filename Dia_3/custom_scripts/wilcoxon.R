#!/usr/bin/env Rscript


# setwd('~/Desktop/Curso_Vane/metaphlan2_final_output/')
# m <- read.csv('../map.txt', sep = '\t', stringsAsFactors = FALSE)
# x <- read.csv('merged_abundance_table_species.tsv', sep = '\t', stringsAsFactors = FALSE)


args = commandArgs(trailingOnly=TRUE)

printUsage <- function(){
  
  cat("Perform Wilcoxon Rank Sum Test.\n")
  
  #cat(".\n\n")
  
  cat('\tUsage: wilcoxon.R <table> <map> <variable>\n\n')
  
  cat('Example: wilcoxon.R humann2_pathabundance_unstratified.tsv map.txt Sample.Typen')
  
}

if (length(args)==0){
  
  printUsage()
  
}else{
  
  if (!file.exists(args[1])){
    printUsage()
    stop('file <table> does not exist')
  }
  
  if (!file.exists(args[2])){
    printUsage()
    stop('file <map> does not exist')
  }
  
  m <- read.csv(args[2], sep = '\t', stringsAsFactors = FALSE)
  rownames(m) <- m$Sample.Id
  
  vars <- args[3]
  if(!all(vars%in%colnames(m))){
    printUsage()
    stop('<variable> column is not in <map>')
  }
  
  x <- read.csv(args[1], sep = '\t', stringsAsFactors = FALSE)
  rownames(x) <- x$X..Pathway
  x$X..Pathway <- NULL
  colnames(x) <- sub('_\\w+$', '', colnames(x))
  x <- as.data.frame(t(x))
  x <- x[, -c(1,2)]
  
  if(!all(rownames(x)%in%m$Sample.Id)){
    printUsage()
    stop('<table> and <map> sample ids does not match.')
  }
  
  orm <- sapply(rownames(x), function(y){
    which(m$Sample.Id==y)
  })
  
  m <- m[orm, ]
  
  ap <- apply(x, 2, function(y){
    suppressWarnings(wilcox.test(y ~ m[[vars]])$p.value)
  })
  
  df <- data.frame(pathway=names(ap), 
                   p.value=unlist(ap), 
                   row.names = 1:length(ap))
  
  write.table(df, sep = '\t', row.names = F, col.names = F, quote = F)
  
}


