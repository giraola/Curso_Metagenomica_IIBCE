#!/usr/bin/env Rscript


# setwd('~/Desktop/Curso_Vane/metaphlan2_final_output/')
# m <- read.csv('../map.txt', sep = '\t', stringsAsFactors = FALSE)
# x <- read.csv('merged_abundance_table_species.tsv', sep = '\t', stringsAsFactors = FALSE)


args = commandArgs(trailingOnly=TRUE)

printUsage <- function(){
  
  cat("Plot a Heatmap. Variables to plot separated by comma.\n")
  
  #cat(".\n\n")
  
  cat('\tUsage: plot_heatmap.R <table> <map> <variables> <pdfName>\n\n')
  
  cat('Example: plot_heatmap.R merged_abundance_table_genus.tsv map.txt Sample.Type,Sex heatmap_sampletype.pdf\n')
  
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
  
  vars <- strsplit(args[3], ',')[[1]]
  if(!all(vars%in%colnames(m))){
    printUsage()
    stop('<variable> column is not in <map>')
  }
  
  x <- read.csv(args[1], sep = '\t', stringsAsFactors = FALSE)
  rownames(x) <- x$ID
  x$ID <- NULL
  colnames(x) <- sub('_metaphlan_bugs_list', '', colnames(x))
  x <- as.data.frame(t(x))
  dx <- dim(x)
  
  if(!all(rownames(x)%in%m$Sample.Id)){
    printUsage()
    stop('<table> and <map> sample ids does not match.')
  }
  
  orm <- sapply(rownames(x), function(y){
    which(m$Sample.Id==y)
  })
  
  m <- m[orm, ]
  
  # x2 <- as.data.frame(cbind(x, m[, -1]))
  
  if(!require('pheatmap')){
    install.packages('pheatmap')
    require('pheatmap')
  }
  
  pheatmap(x, annotation_row = m[, vars, drop=F], filename = args[4])
  
}


