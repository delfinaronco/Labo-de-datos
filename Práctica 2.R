install.packages("tidyverse")
install.packages("nycflights13")
library(nycflights13)
library(dplyr)
vuelos <- flights

# Ejercicio 1

# Las observaciones son las filas y las variables son las columnas

dim(vuelos)

# Otra opción usando nrow() y ncol()
num_filas <- nrow(vuelos)
num_columnas <- ncol(vuelos)

# Mostrar los resultados
cat("El dataset tiene", num_filas, "observaciones y", num_columnas, "variables.\n")

# Ejercicio 2

vuelos <- vuelos %>%
  mutate(air_time_hours = air_time / 60)

vuelos <- vuelos %>%
  mutate(distance_km = distance * 1.6)

# Ejercicio 3

contar_NAs <- function(df) {
  sapply(df, function(col) sum(is.na(col)))
}

NAs_por_columna <- contar_NAs(vuelos)

print(NAs_por_columna)

summary(vuelos)

# la cantidad de NAs quedó igual

vuelos_filtrado <- vuelos %>%
  select(month, flight, origin, dest, air_time_hours, distance_km)

# otra manera

vuelos_filtrado2 <- vuelos[, c("month", "flight", "origin", "dest", "air_time_hours", "distance_km")]

# Ejercicio 5

# a) Para conocer cuáles son los vuelos con más de dos horas de demora en la llegada usaría la variable arr_delay.
# b) Esa variable está en minutos.
# c) Genero un nuevo dataframe que incluya solo los vuelos que cumplan con esta característica:

vuelos_demorados <- vuelos %>%
  filter(arr_delay > 120)

glimpse(vuelos_demorados)

# d) Creo un dataframe que incluya los vuelos con más de dos horas de demora para invierno (enero, febrero y marzo) y para verano (julio, agosto, septiembre.)

vuelos_demorados_invierno <- vuelos_demorados %>%
  filter(month %in% c(1, 2, 3))
  
vuelos_demorados_verano <- vuelos_demorados %>%
  filter(month %in% c(7, 8, 9))

# Ejercicio 6

# Crear un nuevo dataframe con el resumen por destino

resumen_aeropuertos <- vuelos %>%
  group_by(dest) %>%  # Agrupar por destino
  summarise(
    cantidad_vuelos = n(),  # (a) Cantidad de vuelos por destino
    media_dist = mean(distance_km, na.rm = TRUE),  # (b) Distancia media recorrida en km
    media_delay = mean(arr_delay, na.rm = TRUE)  # (c) Retraso medio en la llegada
  ) %>%
  arrange(desc(cantidad_vuelos))  # Ordenar por cantidad de vuelos

# Mostrar los primeros resultados
print(resumen_aeropuertos)
  
# Ejercicio 7

# A partir del dataframe realizado en el punto anterior, ordenar los datos para establecer cuales son los 5 destinos con más y menos demoras

top_5_mas_demorados <- resumen_aeropuertos %>%
  arrange(desc(media_delay)) %>%
  head(5)

print(top_5_mas_demorados)

top_5_menos_demorados <- resumen_aeropuertos %>%
  arrange(media_delay) %>%
  head(5)

print(top_5_menos_demorados)

# Ejercicio 8

demoras_por_mes <- vuelos %>%
  group_by(month) %>%
  summarise(
    demora_media = mean(arr_delay, na.rm = TRUE)
    ) %>%
  arrange(desc(demora_media))

print(demoras_por_mes)

# está ordenado de los meses con más demoras a los meses con menos

