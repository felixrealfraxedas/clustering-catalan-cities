# Primer necessitem llegir el output d'AMPL (que hem passat a Excel)
library(readxl)
library(tidyr)

# Llegir el output
ampl <- read_excel("4.1.Output_Ampl_5000.xlsx")

# Netejar les dades

  # Ficar els nodes que ha agafat com a columnes
ampl <- pivot_longer(ampl, c('45', '74', '89', '126'))
ampl <- as.factor(as.numeric(ampl$name[ampl$value==1]))

# Llegir les dades que hem utilitzat i filtrar per municipis > 5000 habitants
dades <- read.csv("dades_tots_municipis_netes.csv", sep = ",")
data_5000 <- dades[dades$Poblacio > 5000, ]
data_5000 <- cbind(data_5000, ampl)
levels(data_5000$ampl) <- c(data_5000$X[c(45, 74, 89, 126)])
names(data_5000)[5] <- "Centroid"

# Fer el scatter plot diferenciant per colors
library(ggplot2)
png(file = "Cluster_median_2D.png", width = 600, height = 500)
ggplot(data_5000, aes(Longitud, Latitud, color = Centroid)) + 
  geom_point() +
  theme_bw() 
dev.off()
