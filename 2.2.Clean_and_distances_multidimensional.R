# Llegir el csv de dades de vot

vot <- read.csv("3.1.dades_vot_comarques.csv", sep = ",")
vot <- vot[1:42, ] # Nomes agafem les comarques

row.names(vot) <- vot[["Comarca"]]
vot$Comarca <- NULL
vot$Participació <- NULL # Treiem la participació
vot$Abstenció <- NULL # Treiem l'abstenció

head(vot) # ja tenim la matriu de dades, no cal estandaritzar perquè són %
          # i tenen la suma per files aprox = 100

write.csv(vot, "3.5.dades_electorals_comarca.csv") # guardem les dades

library(stats)
# Calcular distancies tenint en compte totes les variables
distancies <- dist(vot, diag = TRUE, upper = TRUE)
distancies <- as.matrix(distancies)
row.names(distancies) <- c(1:42) # esborrem noms files
colnames(distancies) <- c(1:42) # esborrem noms columnes
write.table(distancies, file = "distance_matrix_vot", sep = " ")


