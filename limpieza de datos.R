pacman::p_load(sf, stats, tidyverse, dplyr)


mapa <- read_sf("RM_SII_CBR2/RM_SII_CBR2.shp")

#poligonos <- readRDS("RM_SII_CBR2/RM_SII_CBR2.shp")

mapa_pennalolen <- filter(mapa, COMUNA == "PENALOLEN")

mapa_pennalolen <- distinct(mapa_pennalolen) #se eliminan filas repetidas

as.data.frame(colnames(mapa_pennalolen))

mapa_pennalolen <- subset(mapa_pennalolen, select = -c(40, 41)) # Se eliminan columnas casi vacías

mapa_pennalolen <- subset(mapa_pennalolen, select = -c(23,24,25,26,27,28,29,30)) #se eliminan columnas referentes al conservador de bienes raices
mapa_pennalolen <-subset(mapa_pennalolen, select = -c(1,3,27,28)) #se eliminan las columnas comuna

#Se asume que las en la columna depto casa los valores == 0 son las casas
mapa_pennalolen <- filter(mapa_pennalolen, DPTO_CASA==0)
mean(mapa_pennalolen$Score)
mapa_pennalolen <-subset(mapa_pennalolen, select = -c(1)) #se elimina score por tener el mismo valor en todas las variables

write.csv(mapa_pennalolen, "mapa_pennalolen.csv")

precio_casa <- mapa_pennalolen %>% select( UF_TRANS, Ten_Metro,Ten_MetroC) %>% st_drop_geometry()


# analizamos las correlaciones entre las variables

cor(precio_casa)

# vemos que la escala sigue siendo relevante
summary(precio_casa)


#K Means 1


# usamos el metodo mas sencillo, kmeans, para agrupar los condados en 10 clusters segun las variables
clusters_k2 <- kmeans(precio_casa, 10)

# creamos la variable cluster en el conjunto nc
mapa_pennalolen$cluster_kmeans2 <- as.factor(clusters_k2$cluster)

# visualizamos
ggplot(mapa_pennalolen) +
  geom_sf(aes(fill = cluster_kmeans2))



# escalamos las variables nuevas
scaled_precio_casa <- scale(precio_casa)

summary(scaled_precio_casa)

cor(scaled_precio_casa)


#K Means 2


clusters_k_sc2 <- kmeans(scaled_precio_casa, 10)

mapa_pennalolen$cluster_kmeans_sc2 <- as.factor(clusters_k_sc2$cluster)

ggplot(mapa_pennalolen) +
  geom_sf(aes(fill = cluster_kmeans_sc2))


#K Means 3

dist_precio_casa <- dist(scaled_precio_casa)

# generamos modelo jerarquico
hclust <- hclust(dist_precio_casa)

plot(hclust)

# cortamos modelo en 10 clusters
clusters_hier <- factor(cutree(hclust, k = 10))

ggplot(mapa_pennalolen) +
  geom_sf(aes(fill = clusters_hier))






