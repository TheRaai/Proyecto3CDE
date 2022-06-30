pacman::p_load(janitor, data.validator, sf, stats, tidyverse, dplyr)


mapa <- read_sf("C:/Users/tomas/OneDrive - Universidad Adolfo Ibanez/U/11/ciencia de datos espaciales/proyecto 3/RM_SII_CBR2/RM_SII_CBR2.shp")

mapa_pennalolen <- filter(mapa, COMUNA == "PENALOLEN")

mapa_pennalolen <- distinct(mapa_pennalolen) #se eliminan filas repetidas

as.data.frame(colnames(mapa_pennalolen))

mapa_pennalolen <- subset(mapa_pennalolen, select = -c(40, 41)) # Se eliminan columnas casi vacías

