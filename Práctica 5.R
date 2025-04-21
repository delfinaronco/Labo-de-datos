install.packages("gapminder")
install.packages("ggplot2")
install.packages("dplyr")

library(gapminder)
library(ggplot2)
library(dplyr)

# Ejercicio 1

# a) Realizá un gráfico que muestre la relación entre la esperanza de vida y el PBI per cápita para datos del año 2007

datos_2007 <- gapminder %>%
  filter(year == 2007)

ggplot(datos_2007, aes(x = gdpPercap, y = lifeExp)) +
  geom_point() +
  labs(
    title = "Relación entre PBI per cápita y Esperanza de Vida (2007)",
    x = "PBI per cápita",
    y = "Esperanza de vida"
  ) +
  theme_minimal()

# b)  Realizá un gráfico que muestre la relación entre la esperanza de vida y el PBI per cápita para datos del año 1952.

datos_1952 <- gapminder %>%
  filter(year == 1952)

ggplot(datos_1952, aes(x = gdpPercap, y = lifeExp)) +
  geom_point() +
  labs(
    title = "Relación entre PBI per cápita y Esperanza de Vida (1952)",
    x = "PBI per cápita (log)",
    y = "Esperanza de vida"
  ) +
  theme_minimal()

# c) Realizá los mismos gráficos que en a) y b), pero en dónde se incorpore la información del continente de procedencia del dato graficado

ggplot(datos_2007, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), alpha = 0.7) +
  labs(
    title = "Relación entre PBI per cápita y Esperanza de Vida (2007)",
    x = "PBI per cápita",
    y = "Esperanza de vida",
    color = "Continente"
  ) +
  theme_minimal()

ggplot(datos_1952, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), alpha = 0.7) +  
  labs(
    title = "Relación entre PBI per cápita y Esperanza de Vida (1952)",
    x = "PBI per cápita",
    y = "Esperanza de vida",
    color = "Continente"
  ) +
  theme_minimal()

# Ejercicio 2

# a) Modificá el gráfico realizado en el ítem 1 c), para que además el tamaño del punto sea proporcional a la cantidad de población del país.

ggplot(datos_2007, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent, size = pop), alpha = 0.7) +  
  labs(
    title = "Relación entre PBI per cápita y Esperanza de Vida (2007)",
    x = "PBI per cápita",
    y = "Esperanza de vida",
    color = "Continente",
    size = "Población"
  ) +
  theme_minimal()

# b) Modificá el gráfico del punto anterior para que la escala del eje x sea logaritmica. Pensá en un epígrafe adecuado para este gráfico.

ggplot(datos_2007, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent, size = pop), alpha = 0.7) +
  scale_x_log10() +  # Transformación logarítmica del eje X
  labs(
    title = "Relación entre PBI per cápita y Esperanza de Vida (2007)",
    x = "PBI per cápita (escala logarítmica)",
    y = "Esperanza de vida",
    color = "Continente",
    size = "Población"
  ) +
  theme_minimal()

# Ejercicio 3

# a) Graficá la esperanza de vida a través de los años, en Argentina.

datos_argentina <- gapminder %>%
  filter(country == "Argentina")

ggplot(datos_argentina, aes(x = year, y = lifeExp)) +
  geom_line() +
  labs(
    title = "Esperanza de vida en Argentina",
    x = "Año",
    y = "Esperanza de vida"
  ) +
  theme_minimal()

# b) Graficá la esperanza de vida a través de los años, para los países de America. Hay varias opciones gráficas. La consigna es usar alguna que incluya facet_wrap

datos_america <- gapminder %>%
  filter(continent == "Americas")
ggplot(datos_america, aes(x = year, y = lifeExp)) +
  geom_line() +
  facet_wrap(~ country) +
  labs(
    title = "Esperanza de vida a través de los años en América",
    x = "Año",
    y = "Esperanza de vida"
  ) +
  theme_minimal()

# Ejercicio 4

# a)  Graficá la esperanza de vida promedio de los países de cada uno de los continentes junto con una medida de dispersión. ¿Cómo reportarías los resultados de este gráfico? ¿harías alguna observación o comentario respecto a Oceanía? ¿Cómo reportarías estos resultados?

datos_por_continente <- gapminder %>%
  group_by(continent) %>%
  summarise(
    media_vida = mean(lifeExp),
    sd_vida = sd(lifeExp)
  )

ggplot(datos_por_continente, aes(x = continent, y = media_vida)) +
  geom_col(fill = "steelblue") +
  geom_errorbar(aes(ymin = media_vida - sd_vida, ymax = media_vida + sd_vida),
                width = 0.2, color = "black") +
  labs(
    title = "Esperanza de vida promedio por continente",
    x = "Continente",
    y = "Esperanza de vida promedio"
  ) +
  theme_minimal()    

# Barras: muestran la esperanza de vida promedio por continente.
# Líneas negras: representan la dispersión (en este caso, la desviación estándar).
# "El gráfico muestra la esperanza de vida promedio en cada continente basada en los datos de todos los años disponibles en 
# el dataset de Gapminder. Europa y Oceanía presentan las esperanzas de vida más altas, seguidas por América, Asia y África. 
# África muestra la media más baja, con una alta dispersión que refleja grandes desigualdades entre países del continente."
# "Oceanía muestra una esperanza de vida promedio elevada y una baja dispersión, lo cual se explica porque en el dataset de 
# Gapminder solo se incluyen dos países en Oceanía: Australia y Nueva Zelanda. Ambos países tienen niveles de desarrollo similares
# y altos, por lo que sus valores son cercanos y no hay gran variabilidad."

