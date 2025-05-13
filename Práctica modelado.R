# 1.1 Cargar la librería palmerpenguins y el dataset penguins. Borrar las observaciones -filas- que tengan NA en alguna variable. ¿Cuántas son?

library(palmerpenguins)
datos.original <- data.frame(penguins)
datos <- na.omit(datos.original)

# 1.2 Realizar un gráfico de dispersión que muestre la relación entre el ancho y el largo del pico de los pinguinos de la especie “Chinstrap” (columnas bill_depth_mm y bill_length_mm).

chinstrap_data <- datos %>%
  filter(species == "Chinstrap")


ggplot(chinstrap_data, aes(x = bill_len, y = bill_dep)) +
  geom_point() +
  geom_smooth(method = "lm", se = F) +
  labs(title = "Relación entre el Ancho y el Largo del Pico de los Pingüinos Chinstrap",
       x = "Largo del Pico (mm)",
       y = "Ancho del Pico (mm)") +
  theme_minimal()


# 1.3 Escribir la ecuación del modelo (de regresión lineal simple) estimado que tenga como variable respuesta el largo del pico y como explicativa al ancho (usar lm() para calcular los coeficientes del modelo).
library(ggplot2)
library(dplyr)


m1 <- lm(bill_length_mm ~ bill_depth_mm, chinstrap_data)
m1

# 1.4 ¿Qué unidades tienen la ordenada al origen y la pendiente? ¿Cómo se interpretan los valores estimados de la ordenada al origen y la pendiente?
  
La unidad de la ordenada al origen (B_{0}) está en mm, y la pendiente, mm/mm. 
Para la ordenada al origen, la interpretación es que es el valor medio de "y" cuando "x" vale 0 (es una extrapolación, pues la profundidad del pico no va a ser nunca 0).
La interpretación para pendiente,  es que la relación entre bill_depth_mm y bill_depth_mm es positiva.
  
# 1.5 ¿Cuál es el valor del coeficiente de determinación R2? Programar una función que dado un lm, calcule el R2

r2 <- summary(m1)$r.squared 
r2

# 1.6 Suponga que se encuentra un pinguino de la especie “Chinstrap” que tiene un pico de 2 cm de ancho. El dato del largo del pico se perdió. Usando el modelo lineal simple, ¿Qué valor de largo de pico predice para un pinguino con ese ancho? ¿Cómo se interpreta? Si se encuentra un pinguino bebé con un pico de 5mm de ancho, ¿sería adecuado usar este modelo para conocer el largo del pico dado su ancho?

nueva_data <- data.frame(bill_depth_mm = 20)
predict(m1, nueva_data)

Se espera que un pingüino con un pico de 2cm de ancho tenga un pico de 5,19 cm de largo.

No sería adecuado: no se puede usar el modelo con una entrada fuera del rango de los datos a partir de los cuales se construyó el modelo. El rango de la variable bill_depth_mm es de 16.40 a 20.80.

# 1.7 Repetir el ìtem 1.3 para los pinguinos de las otras 2 especies.
# 1.3 Escribir la ecuación del modelo (de regresión lineal simple) estimado que tenga como variable respuesta el largo del pico y como explicativa al ancho (usar lm() para calcular los coeficientes del modelo).

adelie_data <- datos %>%
  filter(species == "Adelie")

m2 <- lm(bill_length_mm ~ bill_depth_mm, adelie_data)
m2

gentoo_data <- datos %>%
  filter(species == "Gentoo")

m3 <- lm(bill_length_mm ~ bill_depth_mm, gentoo_data)
m3

# 1.8 Graficar los datos con las respectivas rectas ajustadas (utilizando la funcion geom_smooth y luego, “a mano”, usando los resultados de 1.7 y geom_abline()

ggplot(adelie_data, aes(x = bill_depth_mm, y = bill_length_mm)) +
  geom_point() +
  geom_smooth(method = "lm", col = "blue") +
  labs(title = "Regresión de Largo de Pico vs Ancho de Pico para Adelie")

ggplot(gentoo_data, aes(x = bill_depth_mm, y = bill_length_mm)) +
  geom_point() +
  geom_smooth(method = "lm", col = "red") +
  labs(title = "Regresión de Largo de Pico vs Ancho de Pico para Gentoo")

# Graficamos para Adelie usando geom_abline()
ggplot(adelie_data, aes(x = bill_depth_mm, y = bill_length_mm)) +
  geom_point() +
  geom_abline(slope = coef(m2)["bill_depth_mm"], intercept = coef(m2)["(Intercept)"], col = "blue") +
  labs(title = "Regresión de Largo de Pico vs Ancho de Pico para Adelie")

# Graficamos para Gentoo usando geom_abline()
ggplot(gentoo_data, aes(x = bill_depth_mm, y = bill_length_mm)) +
  geom_point() +
  geom_abline(slope = coef(m3)["bill_depth_mm"], intercept = coef(m3)["(Intercept)"], col = "red") +
  labs(title = "Regresión de Largo de Pico vs Ancho de Pico para Gentoo")

# 1.9 Sólo para los pinguinos de la especie “Chinstrap”, definir una nueva variable que sea el ancho del pico centrado respecto al ancho promedio. Es decir, para cada pinguino calcular ancho_centrado = ancho_i - ancho_promedio.  Repetir el ítem 1.3 para el modelo con ancho del pico centrado respecto del promedio.

