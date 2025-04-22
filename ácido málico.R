library(ggplot2)
library(dplyr)

# Elaborar una tabla resumen que contenga, para cada tipo de vino, la cantidad de casos, la media y el desvío estándar del contenido de ácido málico.  

resumen <- wine %>% 
  group_by(Type) %>% 
  summarise(
    media_acido_málico = mean(Malic),
    sd_ácido_málico = sd(Malic),
    cantidad_casos = n())

ggplot(resumen, aes(x = Type, y = media_acido_málico, fill = Type)) +
  geom_bar(stat = "identity", position = "dodge", show.legend = FALSE) +  # Barra de la media
  geom_errorbar(aes(ymin = media_acido_málico - sd_ácido_málico, 
                    ymax = media_acido_málico + sd_ácido_málico), 
                width = 0.2) +  # Barras de error para la desviación estándar
  labs(
    title = "Ácido Málico por Tipo de Vino",
    x = "Tipo de Vino",
    y = "Media de Ácido Málico y Desviación Estándar"
  ) +
  theme_minimal()
  
  