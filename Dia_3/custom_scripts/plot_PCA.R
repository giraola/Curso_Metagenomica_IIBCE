#!/usr/bin/env Rscript


# setwd('~/Desktop/Curso_Vane/metaphlan2_final_output/')
# m <- read.csv('../map.txt', sep = '\t', stringsAsFactors = FALSE)
# x <- read.csv('merged_abundance_table_species.tsv', sep = '\t', stringsAsFactors = FALSE)


args = commandArgs(trailingOnly=TRUE)

printUsage <- function(){
  
  cat("Plot first two Principal Components of a PCA.\n")
  
  #cat(".\n\n")
  
  cat('\tUsage: plot_PCA.R <table> <map> <variable> <pdfName>\n\n')
  
  cat('Example: plot_PCA.R merged_abundance_table_species.tsv map.txt Sample.Type pca_sampletype.pdf\n')
  
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
  
  if(!args[3]%in%colnames(m)){
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
  
  x2 <- as.data.frame(cbind(x, m[, -1]))
  
  if(!require('ggfortify')){
    install.packages('ggfortify')
    require('ggfortify')
  }
  
  pca <- prcomp(x[, 1:dx[2]], center = TRUE, scale. = TRUE)
  
  gg <- autoplot(pca, data = x2, colour=args[3])
  
  ggsave(args[4], gg, device = 'pdf')

}


