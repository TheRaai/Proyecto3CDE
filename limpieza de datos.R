pacman::p_load(sf, stats, tidyverse, dplyr)


mapa <- read_sf("C:/Users/tomas/OneDrive - Universidad Adolfo Ibanez/U/11/ciencia de datos espaciales/proyecto 3/RM_SII_CBR2/RM_SII_CBR2.shp")

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

write.csv(mapa_pennalolen, "C:/Users/tomas/OneDrive - Universidad Adolfo Ibanez/U/11/ciencia de datos espaciales/proyecto 3/mapa_pennalolen.csv")
