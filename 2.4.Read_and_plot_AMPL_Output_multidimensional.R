# Primer necessitem llegir el output d'AMPL (que hem passat a Excel)
library(readxl)
library(tidyr)

# Llegir el output
ampl_k2 <- read_excel("4.2.Output_AMPL_vot_k2.xlsx")
ampl_k3 <- read_excel("4.2.Output_AMPL_vot_k3.xlsx")
ampl_k4 <- read_excel("4.2.Output_AMPL_vot_k4.xlsx")

# Netejar les dades

# Ficar els nodes que ha agafat com a columnes
ampl_k2 <- pivot_longer(ampl_k2, c('6', '40'))
ampl_k2 <- as.factor(as.numeric(ampl_k2$name[ampl_k2$value==1]))

ampl_k3 <- pivot_longer(ampl_k3, c('1', '17', '41'))
ampl_k3 <- as.factor(as.numeric(ampl_k3$name[ampl_k3$value==1]))

ampl_k4 <- pivot_longer(ampl_k4, c('1', '20', '37', '41'))
ampl_k4 <- as.factor(as.numeric(ampl_k4$name[ampl_k4$value==1]))

# Llegir el csv amb les dades inicials
vot <- read.csv("3.1.dades_vot_comarques.csv", sep = ",")
vot <- vot[1:42, ]

# Llegir afegir noms de comarques als clusters
clusters_vot <- data.frame(ampl_k2, row.names = vot$Comarca)
# Juntar els resultats per el cas amb k = 2, k = 3 i k = 4
clusters_vot <- cbind(clusters_vot, ampl_k3, ampl_k4)
# Canviar els nivells del factor per veure quin es el medoid en cada cas
levels(clusters_vot$ampl_k2) <- c(vot$Comarca[6], vot$Comarca[40])
levels(clusters_vot$ampl_k3) <- c(vot$Comarca[c(1,17,41)])
levels(clusters_vot$ampl_k4) <- c(vot$Comarca[c(1,20,37,41)])

# Afegim dades de coordenades per poder fer la gràfica
geo <- read.csv("3.2.Caps_de_municipi_de_Catalunya_georeferenciats.csv", sep = ",")
geo <- subset(geo, select = c("Municipi.forma.indexada", "Comarca", "Longitud", "Latitud"))
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
geo <- geo[geo$Municipi.forma.indexada %in% capitals, ]
geo$Comarca[geo$Comarca == "Val d'Aran"] <- "Aran"
geo <- geo[order(geo$Comarca, decreasing = FALSE), ]

cl_plot <- cbind(clusters_vot, geo$Longitud, geo$Latitud)

# Fer el scatter plot diferenciant per colors
library(ggplot2)
ggplot(cl_plot, aes(geo$Longitud, geo$Latitud, color = ampl_k2)) + 
  geom_point() +
  theme_bw()

ggplot(cl_plot, aes(geo$Longitud, geo$Latitud, color = ampl_k3)) + 
  geom_point() +
  theme_bw()

ggplot(cl_plot, aes(geo$Longitud, geo$Latitud, color = ampl_k4)) + 
  geom_point() +
  theme_bw()
