# Solve time in AMPL

solve_time <- data.frame("Seconds" = c(0.122849, 0.308728, 
                                       0.750642, 1.09849, 
                                       4.02729, 7.27386, 
                                       17.0562, 20.7094, 
                                       37.5476, 84.0149), 
                         "Number_of_points" = c(42, 57, 79, 100, 139, 
                                                172, 219, 251, 315, 396),
                         row.names = c("capitals_comarca", "mes_de_50000h", 
                                       "mes_de_25000h", "mes_de_17500h",
                                       "mes_de_10000h", "mes_de_7500h",
                                       "mes_de_5000h", "mes_de_3750h",
                                       "mes_de_2500h", "mes_de_1500h"))

# In the last m, AMPL does not return the number of simplex iterations
png(file="Execution_time.png")
plot(solve_time$Seconds ~ solve_time$Number_of_points, 
     type = "b",
     xlab = "Number of points", ylab = "Seconds", lwd = 2, col = "red")
dev.off()
