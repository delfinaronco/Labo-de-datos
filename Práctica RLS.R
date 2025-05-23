# 1.1 Cargar la librería palmerpenguins y el dataset penguins. Borrar las observaciones -filas- que tengan NA en alguna variable. ¿Cuántas son?


library(palmerpenguins)
datos.original <- data.frame(penguins)
datos <- na.omit(datos.original)

# 1.2 Realizar un gráfico de dispersión que muestre la relación entre el ancho y el largo del pico de los pinguinos de la especie “Chinstrap” (columnas bill_depth_mm y bill_length_mm).

chinstrap_data <- datos %>%
  filter(species == "Chinstrap")


ggplot(chinstrap_data, aes(x = bill_length_mm, y = bill_depth_mm)) +
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

data <- chinstrap_data %>%
  mutate(ancho_centrado = bill_depth_mm - mean(bill_depth_mm))

modelo <- lm(bill_length_mm ~ ancho_centrado, data)
modelo

# El modelo predice la recta: bill_length_mm = 1.922 * ancho_centrado + 48.834.

# 1.10 ¿Qué interpretación tienen ahora la ordenada al origen y la pendiente del modelo? Discutir las ventajas y desventajas de usar ancho o ancho centrado

# Ordenada al origen (intercept): Es el valor promedio de la longitud del pico cuando el ancho del pico es igual al promedio (porque ancho_centrado = 0). Es decir, la longitud del pico esperada para un pingüino Chinstrap con ancho de pico promedio.

# Pendiente: Representa el cambio en la longitud del pico por cada unidad de desviación respecto al promedio del ancho del pico. Es la misma pendiente que usarías si no hubieras centrado la variable.

# Ventajas de centrar la variable: 
# Mejor interpretación del intercepto: El intercepto tiene un significado útil: el valor esperado cuando la variable predictora está en su promedio.
# Evita colinealidad (cuando hay múltiples predictores): Centrar variables reduce la multicolinealidad, especialmente si luego se incluyen términos cuadráticos o interacciones.
# Estabilidad numérica: Mejora la precisión numérica en algoritmos de estimación.

# Desventajas:
# No es directamente interpretable: El valor de la variable centrada no representa un valor real observable (como 18 mm de ancho), sino una desviación respecto a un promedio.
# Requiere transformación si se quieren hacer predicciones sobre valores originales (no centrados).

# 1.11 Calcular el coeficiente de determinación para este nuevo modelo. ¿Es igual o diferente al calculado en 1.5? Explicar.

summary(modelo)$r.squared

# El coeficiente de determinación R² es el mismo en ambos modelos.
# La pendiente también es igual.
# La única diferencia es que al centrar el ancho (bill_depth_mm), el intercepto del modelo pasa a representar el valor esperado de la longitud del pico cuando el ancho es promedio.
# Esto mejora la interpretación del intercepto, pero no cambia el poder explicativo del modelo.

# Ejercicio 2
# 2.1 Utilizando la librería mtcars incluida en R-base, que contiene datos sobre automóviles (dataset mtcars), crear un gráfico para visualizar la relación entre la potencia del motor (columna hp) y la eficiencia en millas por galón (columna mpg). ¿Qué patrón se observa?

data(mtcars)

ggplot(mtcars, aes(x = hp, y = mpg)) +
  geom_point(color = "steelblue", size = 3) +
  labs(title = "Relación entre Potencia del Motor (hp) y Eficiencia (mpg)",
       x = "Potencia (hp)",
       y = "Millas por galón (mpg)") +
  theme_minimal()

# 2.2 Realiza una regresión lineal simple para predecir la eficiencia en millas por galón en función de la potencia del motor, ¿Cuál es el valor del coeficiente de determinación R2?
  
modelo_autos <- lm(mpg ~ hp, data = mtcars)

r2_autos <- summary(modelo_autos)$r.squared

# Cada aumento de 1 hp en potencia del motor reduce la eficiencia esperada en 0.068 millas por galón.

# El R² es aproximadamente 0.60, lo que indica que el modelo explica el 60% de la variabilidad de mpg.

# 2.3 Discutir si parece adecuado un modelo lineal para describir esta relación.
# No ya que no crece linealmente.

# Ejercicio 3

# 3.1 Cargar e inspeccionar la estructura del dataset

data("anscombe")

# 3.2 Analizar la tendencia central y dispersión de cada conjunto de datos. Una opción es reacomodando el dataset en formato “long”, como se muestra a continuación. A cada grupo de pares (x, y) los llamaeremos “q”
# 3.2 Inspeccionar la estructura del dataset anscomb_long

anscombe_long <-
  rbind(
    tibble(x = anscombe$x1, y = anscombe$y1, grupo_q = "q1"),
    tibble(x = anscombe$x2, y = anscombe$y2, grupo_q = "q2"),
    tibble(x = anscombe$x3, y = anscombe$y3, grupo_q = "q3"),
    tibble(x = anscombe$x4, y = anscombe$y4, grupo_q = "q4"))

# 3.3 Calcular promedio, mediana, desvio, min y max de la variable X y la variable Y de cada grupo “q”
anscombe_summary <- anscombe_long %>%
  group_by(grupo_q) %>%
  summarise(
    media_x = mean(x),
    mediana_x = median(x),
    sd_x = sd(x),
    min_x = min(x),
    max_x = max(x),
    
    media_y = mean(y),
    mediana_y = median(y),
    sd_y = sd(y),
    min_y = min(y),
    max_y = max(y)
  )

print(anscombe_summary)

# 3.4 Realizar graficos de dispersión de Y vs X, para cada grupo

ggplot(anscombe_long, aes(x = x, y = y)) +
  geom_point(size = 3, color = "steelblue") +
  facet_wrap(~ grupo_q) +
  theme_minimal() +
  labs(title = "Gráfico de dispersión para cada grupo de Anscombe")

# 3.5 Ajustar modelos de RLS para cada conjunto de observaciones. Analizar los parámetros estimados.

modelos <- anscombe_long %>%
  group_by(grupo_q) %>%
  summarise(
    modelo = list(lm(y ~ x))
  )

modelos_parametros <- modelos %>%
  mutate(
    intercept = sapply(modelo, function(m) coef(m)[1]),
    pendiente = sapply(modelo, function(m) coef(m)[2])
  ) %>%
  select(grupo_q, intercept, pendiente)

print(modelos_parametros)
# son todos iguales

# 3.6 Para los modelos ajustados en el ítem anterior, calcular el R2

modelos_r2 <- modelos %>%
  mutate(
    r_squared = sapply(modelo, function(m) summary(m)$r.squared)
  ) %>%
  select(grupo_q, r_squared)

print(modelos_r2)
# son todos iguales 

# 3.7 Comparar los valores estimados para intercept, pendiente y R2 de los distintos modelos. Extraer conclusiones.

left_join(modelos_parametros, modelos_r2, by = "grupo_q")

# Todos los grupos tienen estadísticos iguales o muy similares (media, pendiente, R²), pero los gráficos muestran relaciones radicalmente distintas.

# Esto prueba que si no graficás, te podés perder relaciones no lineales, outliers o datos mal distribuidos.

# 3.8 Graficar las rectas de regresión (modelo) con los valores observados. Realizar una crítica a cada uno de los modelos ajustados y si cree que es posible el ajuste a un modelo de RLS excluyendo dato/s atípicos o influyentes.

ggplot(anscombe_long, aes(x = x, y = y)) +
  geom_point(color = "blue", size = 3) +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  facet_wrap(~ grupo_q) +
  theme_minimal() +
  labs(title = "Modelos ajustados para los 4 conjuntos de Anscombe")

# El modelo de regresión simple funciona bien para q1.

# En q2, hay una relación clara, pero no es lineal.

# En q3, un outlier influye poco pero destaca que los otros datos no tienen variación.

# En q4, un solo punto extremo cambia completamente la regresión.

# Este conjunto ilustra la importancia de visualizar los datos, no solo mirar números.

# Ejercicio 4

# 4.1 Cargar la librería gapminder. Seleccionar datos de un año particular y realizar un gráfico de dispersión que muestre la relación entre el PIB per cápita (columna gdpPercap) y la esperanza de vida (columna lifeExp).

library(gapminder)

gapminder_2007 <- gapminder %>%
  filter(year == 2007)

ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(color = "steelblue", size = 3) +
  scale_x_log10() +  # log en el eje x para mejor visualización
  labs(title = "Relación entre PBI per cápita y Esperanza de vida (2007)",
       x = "PBI per cápita (log scale)",
       y = "Esperanza de vida") +
  theme_minimal()

# 4.2 Realizar una regresión lineal simple para predecir la esperanza de vida en función del PBI per cápita para 1997 en el continente americano.

gapminder_america_1997 <- gapminder %>%
  filter(year == 1997, continent == "Americas")

ggplot(gapminder_america_1997, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(color = "steelblue", size = 3) + 
  labs(title = "Relación entre PBI per cápita y Esperanza de vida en América (1997)",
       x = "PBI per cápita (log scale)",
       y = "Esperanza de vida") +
  theme_minimal()

modelo_america_1997 <- lm(lifeExp ~ gdpPercap, data = gapminder_america_1997)
summary(modelo_america_1997)

r2_america_1997 <- summary(modelo_america_1997)$r.squared

# 4.3 Discutir si el modelo es adecuado para describir esta relación.

# Ventajas:
  
  # Sencillo de interpretar.

  # Captura una tendencia creciente.

# Problemas:
  
  # La relación parece no lineal (especialmente a bajos niveles de ingreso).

  # Hay heterogeneidad entre países que un modelo simple no explica.

  # Mejoraría usando una transformación (log) o un modelo no lineal.

# 4.4 Repetir 4.2 para un modelo pero utilizando como variable respuesta el logaritmo de la esperanza de vida y como variable explicativa el logaritmo del PBI per capita. Discutir la conveniencia de usar el logaritmo de las variables.

ggplot(gapminder_america_1997, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(color = "steelblue", size = 3) +
  scale_x_log10() +
  labs(title = "Relación entre PBI per cápita y Esperanza de vida en América (1997)",
       x = "PBI per cápita (log scale)",
       y = "Esperanza de vida") +
  theme_minimal()

modelo_log <- lm(log(lifeExp) ~ log(gdpPercap), data = gapminder_america_1997)
summary(modelo_log)

r2_log <- summary(modelo_log)$r.squared

# El r2 antes era 0.36  y ahora con log es 0.62.
# Usar transformaciones logarítmicas mejora el ajuste y la interpretación cuando las relaciones no son lineales en escala original.

# Ejercicio 5

# 5.1 Cargar el conjunto de datos iris, incluida en R-base, que contiene información sobre especies de flores y sus características.

data(iris)

# 5.2 Explorar gráfica y analíticamente los datos (tamaño de muestras, tendencia central, dispersión, existencia de datos faltantes, etc.).

# 150 observaciones
# 5 variables: Sepal.Length, Sepal.Width, Petal.Length, Petal.Width, Species

summary(iris)

iris %>%
  group_by(Species) %>%
  summarise(
    media_largo = mean(Sepal.Length),
    mediana_largo = median(Sepal.Length),
    sd_largo = sd(Sepal.Length),
    min_largo = min(Sepal.Length),
    max_largo = max(Sepal.Length),
    
    media_ancho = mean(Sepal.Width),
    mediana_ancho = median(Sepal.Width),
    sd_ancho = sd(Sepal.Width),
    min_ancho = min(Sepal.Width),
    max_ancho = max(Sepal.Width)
  )

ggplot(iris, aes(x = Species, y = Sepal.Length)) +
  geom_boxplot(fill = "lightblue") +
  labs(title = "Largo del sépalo por especie")

ggplot(iris, aes(x = Species, y = Sepal.Width)) +
  geom_boxplot(fill = "lightgreen") +
  labs(title = "Ancho del sépalo por especie")

ggplot(iris, aes(x = Sepal.Width, y = Sepal.Length, color = Species)) +
  geom_point(size = 2) +
  labs(title = "Relación entre ancho y largo del sépalo por especie")

anyNA(iris)
 # No hay datos faltantes

# Sepal.Length tiene diferencias claras entre especies, tanto en su media como en su rango.

# Sepal.Width también varía, pero con más traslape entre especies.

# La dispersión (sd, rango) muestra que setosa tiene sépalos más anchos en promedio, mientras que virginica tiene sépalos más largos.

# 5.3 Intenta realizar una regresión lineal simple para predecir la longitud del sépalo (columna Sepal.Length) en función del ancho del sépalo (columna Sepal.Width). ¿Cuál es el valor del coeficiente de determinación R2? Discutir el resultado obtenido.

modelo_iris <- lm(Sepal.Length ~ Sepal.Width, data = iris)

# Sepal.Length = 6.5262 - 0.2234 * Sepal.Width

# La ordenada al origen ((Intercept)) es 6.5262: cuando el ancho del sépalo es 0 (lo cual no tiene sentido práctico, pero es parte de la ecuación), la longitud esperada sería 6.5262.

# La pendiente es -0.2234, lo que sugiere que a mayor ancho del sépalo, la longitud disminuye un poco.

r2_iris <- summary(modelo_iris)$r.squared

# r2 = 0.01382 → el modelo explica solo el 1.38% de la variación en la longitud del sépalo.

# Ejercicio 6

# 6.1 Abrir y explorar los datos

setwd("c:/Users/Usuario/OneDrive/Documentos/DATOS/labo de datos")

rendimientos <- read.table("datosRendimientos.txt", header = TRUE)

head(rendimientos)
summary(rendimientos)
str(rendimientos)

# 6.2 Realizar un gráfico de dispersión de rendimiento en función de los gramos de nuevo fertilizante / 100 g de mezcla.

ggplot(rendimientos, aes(x = Fert, y = Rend)) +
  geom_point(color = "steelblue", size = 2) + 
  labs(title = "Rendimiento vs Fertilizante",
       x = "Gramos de Fertilizante Nuevo por 100g",
       y = "Rendimiento (kg/ha)") +
  theme_minimal()

# 6.3 Ajustar un modelo de RLS a partir del conjunto de datos. Escribir la ecuación estimada de la recta e interpretar la pendiente e intercept.

modelo_rendimientos <- lm(Rend ~ Fert, data = rendimientos)

# Rend = 692.10 + 22.44*Fert

# Intercepto (692.10): cuando no se aplica fertilizante nuevo, el rendimiento promedio es de 692.10 kg/ha.

# Pendiente (22.44): por cada 1g más de fertilizante nuevo por 100g de mezcla, el rendimiento aumenta en promedio unos 22.44 kg/ha.

# 6.4 Calcular el coeficiente de determinación R2

r2_rendimientos <- summary(modelo_rendimientos)$r.squared

# el r2 es de 0.78, muy bueno.

# 6.5 Si se repitiera el experimento, ¿Qué piensa que ocurriría con el valor obtenido de los parámetros estimados? ¿y con el valor del coeficiente de determinaciòn?
  
# Es probable que los parámetros estimados varíen un poco (por el azar de las muestras), pero deberían mantenerse similares si las condiciones son las mismas.

# El valor del R² podría cambiar, pero no demasiado si el patrón se mantiene.

# 6.6 Si centrara la variable x en la media(x), ¿cómo se interpreta la intercept? ¿cambia el valor de la intercept, de la pendiente y del R2?

rendimientos$Fert_centrado <- rendimientos$Fert - mean(rendimientos$Fert)
modelo_centrado <- lm(Rend ~ Fert_centrado, data = rendimientos)
summary(modelo_centrado)

# El R² y la pendiente NO cambian.

# Lo único que cambia es la interpretación del intercepto: 
  # Ahora el intercepto representa el rendimiento cuando la cantidad de fertilizante es igual al promedio.
  # Es útil para interpretar comparaciones relativas.
