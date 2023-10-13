#Multi level full profile conjoint analysis
#install.packages("NbClust")
library(readxl)
library(conjoint)
library(tidyverse)
library(cluster) 
library(factoextra)

data1 <-  read_excel("Scenarios.xlsx")

conj1 <- read_excel("multilevel.xlsx")

data <- data.frame(data1)
conj <- data.frame(conj1)

lev<- c("accepted_cookies","signup","liked","no_action","subscription","discount","no_ads","personalized", "non_personalized")

lev.df <- data.frame(lev) 

#Get utilities of each attributes 
caModel(y=data[1,2:25],x=conj[,4:6]) 


results <- Conjoint(data[,2:25],conj[,4:6],lev.df)
 
#Get importance of each attribute 
caImportance(y=data[,2:25],x=conj[,4:6])

#find segments
hc <- hclust(dist(data), method = "complete")

plot_dendro <- fviz_dend(hc, k = NULL, cex = 0.5, horiz = TRUE)

library(NbClust)
optimal_k <- NbClust::NbClust(scale(data), diss = NULL, distance = "euclidean", min.nc = 2, max.nc = 10, method = "kmeans")$Best.nc

#we get 4 cluster as optimal 

sink("segments_output.txt")

#group respondents into segments

caSegmentation(data[,2:25],conj[,4:6], c=4)
sink()

clust <- caSegmentation(data[,2:25],conj[,4:6], c=4)

library(conjoint)
require(fpc)
segments<-caSegmentation(data[,2:25],conj[,4:6], c=4)
print(segments$seg)
plotcluster(segments$util,segments$sclu)

##

#Individual

#Get importance of each attribute for each individual
df_ind_attri<- data.frame()

for (i in 1:120) {
  val <- caImportance(y=data[i,2:25],x=conj[,4:6])
  df_ind_attri[i, 'Action'] <-  val[1]
  df_ind_attri[i, 'Benefit'] <-  val[2]
  df_ind_attri[i, 'Personalization'] <-  val[3]
}


write.csv(df_ind_attri, "attriimpind.csv")

#Part utilities

#Get importance of each attribute for each individual
df_part_util<- data.frame()

for (i in 1:120) {
  part_uti <- caPartUtilities(data[i,2:25],conj[,4:6],lev.df)
  df_part_util[i, 'Cookies'] <-  part_uti[2]
  df_part_util[i, 'signup'] <-  part_uti[3]
  df_part_util[i, 'like'] <-  part_uti[4]
  df_part_util[i, 'Noact'] <-  part_uti[5]
  df_part_util[i, 'Subs'] <-  part_uti[6]
  df_part_util[i, 'Disc'] <-  part_uti[7]
  df_part_util[i, 'NoAds'] <-  part_uti[8]
  df_part_util[i, 'Per'] <-  part_uti[9]
  df_part_util[i, 'NonPer'] <-  part_uti[10]
}


write.csv(df_part_util,"ind_attri_imp.csv")
