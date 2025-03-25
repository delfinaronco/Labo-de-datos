

# Entorno de trabajo ------------------

# Para ver los elementos listados usar el siguiente comando
ls()
# Si no tenemos nada aparecera "character(0)"
# Si tenemos algo aparecera la lista de elementos (objetos) 

# Para borrar todos los elementos que tenemos listados
rm(list=ls())

ls()

# setwd
# setwd("~/") # escribir su ruta




# Importar datos  --------------------------

# Creen una carpeta en el disco C llamada "LAboDatos" 
# Dentro de ella pueden generar una subcarpeta "Clase2"
# Guarden alli los archivos de esta clase.

# Para importar la tabla de datos

# Vamos a importar datos desde una tabla, "gapminder.csv"

?read.csv

datos <- read.csv("gapminder.csv", header = T, sep=",", dec=".")

str(datos) 
summary(datos)

# De que tipo son las variables?

# para que transforme character a factor
datos <- read.csv("gapminder.csv", header = T, sep=",", dec=".", stringsAsFactors = T)

# comparar
str(datos) 
summary(datos)


# Vista de la tabla  -----------------
# en consola de R
datos 

# en nueva ventana
View(datos)


# Medidas resumen ---------------------

summary(datos)

# explore la funcion "table"

table(datos$region, datos$income_level)

# comparar la salida agregando el argumento useNA
table(datos$region, datos$income_level, useNA = "always")


# Manipulacion del DF -----------------

# Renombrar "Americas" por "America"

levels(datos$region)
levels(datos$region)[2] <- "America"

# exploramos 
levels(datos$region)
summary(datos)


# seleccionar
# el primer elemento en la primera columna del data frame
datos[1,1]
# primer elemento en la 6ta columna del data frame
datos[6,1]
# primera columna del data frame (como un vector)
datos[, 1]
# primera columna del data frame (como un data.frame)
datos[1]
# 3ra fila del data frame (como un data.frame)
datos[3, ]
# primeros tres elementos en la 7ma columna (como un vector)
datos[1:3, 7]


# crear nuevos dataset con estas caracteristicas:
# sin las filas 1, 3, 5 y 8
datos[-c(1,3,5,8), ]

# sin las filas 10 a 30
datos[-c(10:30), ]

# sin las filas 5 a 15 y 55 a 75
datos[-c(5:15, 55:75), ]


# subconjuntos de columnas o variables utilizando nombres
datos$country          # El resultado es un vector
datos["country"]       # El resultado es un data.frame
datos[c("country", "region", "income" )] # El resultado es un data.frame

datos[,"country"]     # El resultado es un vector
datos[, c("country", "region", "income")]   # El resultado es un data.frame

datos[["country" ]]     # El resultado es un vector




# Y si queremos seleccionar los datos de países de America?
datosAmerica <- datos[datos$region=="America",]

# exploramos
summary(datosAmerica)
dim(datosAmerica) #cantidad de filas y columnas

# otra forma alternativa de armar la base America
datosAmerica2 <- datos[which(datos$region=="America"),]

# A veces queremos agregar columnas que surgen operaciones de otras columnas
datosConNuevaColumna <- cbind(datos, datos$co2*datos$population)
head(datosConNuevaColumna)



# data.frames desde librerias --------------
# ejemplo con dataset penguins

library(palmerpenguins)
df <- data.frame(penguins)
summary(df)


# ejemplo con dataset gapminder! (otro parecido)

library(gapminder)
df <- data.frame(gapminder)
summary(df)

# otros dataset "famosos
mtcars
?mtcars

iris
?iris
