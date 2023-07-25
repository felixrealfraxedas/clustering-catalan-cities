
geo <- read.csv("3.2.Caps_de_municipi_de_Catalunya_georeferenciats.csv", sep = ",")
geo <- subset(geo, select = c("Municipi.forma.indexada", "Longitud", "Latitud"))
geo <- geo[order(geo$Municipi.forma.indexada, decreasing = FALSE), ]

pob <- read.csv("3.3.Population_per_town.csv", sep = ";")
pob <- pob[pob$any == 2021 & pob$sexe == "total" & pob$municipis != 'Catalunya', ]
pob <- subset(pob, select = c("municipis", "valor"))
pob <- pob[order(pob$municipis, decreasing=FALSE), ]

library(dplyr)
geo <- geo %>% inner_join(pob, by = c("Municipi.forma.indexada" = "municipis"))
names(geo)[4] <- "Poblacio"

row.names(geo) <- geo[["Municipi.forma.indexada"]]
geo$Municipi.forma.indexada <- NULL
geo$Poblacio <- as.integer(geo$Poblacio)

capitals <- c("Valls", "Figueres", "Vilafranca del Penedès",
              "Seu d'Urgell, la", "Pont de Suert, el", "Igualada",
              "Vielha e Mijaran", "Manresa", "Reus", "Tortosa",
              "Bisbal d'Empordà, la", "Sant Feliu de Llobregat",
              "Vendrell, el", "Barcelona", "Berga", "Puigcerdà",
              "Montblanc", "Vilanova i la Geltrú", "Borges Blanques, les",
              "Olot", "Girona", "Mataró", "Moià", "Amposta", "Balaguer",
              "Vic", "Tremp", "Sort", "Mollerussa", "Banyoles", "Falset",
              "Móra d'Ebre", "Ripoll", "Cervera", "Lleida", 
              "Santa Coloma de Farners", "Solsona", "Tarragona",
              "Gandesa", "Tàrrega", "Sabadell", "Granollers")

# Afegim 5000 habitants a les capitals de comarca!
for (i in 1:nrow(geo)){
  if(row.names(geo[i,]) %in% capitals){
    geo$Poblacio[i] <- geo$Poblacio[i] + 5000
  }
}

write.csv(geo, "3.4.dades_tots_municipis_netes.csv")

# Obtenim un subset amb les poblacions de més de x habitants
# Recordar que les capitals de comarca ja en tenen, mínim 5000
dades <- geo[geo$Poblacio > 5000, ]


library(stats)
# A dist(), ficar les variables que vulguem tenir en compte
distancies <- dist(cbind(dades$Longitud, dades$Latitud), diag = TRUE, upper = TRUE)
distancies <- as.matrix(distancies)

# Exportem un csv per passar les dades a AMPL
write.table(distancies, file = "distance_matrix_5000.csv", sep = " ")
