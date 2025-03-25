
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



# Crear un data.frame -------------------------

# Ejemplo "de juguete" con valores de filas y columnas "inventados"
# Una opcion: 

d <-  data.frame(encuestado = 1:20,  carreraLCD = c(T,T,T,T,T,F,T,F,F,T,F,T,T,T,F,T,F,F,T,F), horas_estudio= sample(1:8, 20, replace = T))
d


# clase df
class(d)


# Funciones para inspeccionar el contenido y la estructura de un data frame -------------------------

# explorar el help de las funciones
# ejemplo
?dim
?head

# ejecutar y escribir una linea sobre qué hace cada función
dim(d)
# 20 3 (20 filas y 3 columnas)
# me devuelve la cantidad de filas y columnas (la dimensión)

nrow(d) 
# 20 (filas)

ncol(d)
# 3 (columnas)

head(d) 
# me devuelve las primeras 6 filas

tail(d)
# me devuelve las úlimas 6 filas

names(d)
# me devuelve lo que hay en cada columna (los títulos)

rownames(d)
# me devuelve los nombres de las filas (?) o el número de cada fila

str(d)
# me devuelve los tipos de cada columna

summary(d)
# me devuelve un resumen con el mínimo, el máximo, el promedio y no sé qué más

mean(d$carreraLCD)
# devuelve el promedio de la columna de carreraLCD (toma true 1 y false 0)

class(d$carreraLCD)
# devuelve el tipo de los elementos de la columna carreraLCD 

class(d$horas_estudio)
# devuelve el tipo de los elementos de la columna de horas_estudio

class(d$encuestado)
# devuelve el tipo de la columna encuestado

# Subconjuntos ------------------

# explorar y concluir
d[1, 1]   
d[1, 2]   
d[, 1] # primera columna horizontal    
d[1]   # primera columna vertical
d[3, ] # tercera fila
d[c(1, 2, 3), 2] # muestra los primeros tres elementos de la segunda columna
d[1:3, 2] #lo mismo
d[, -1]  # toda la tabla sin la primera columna
d[-(1:9), ] # la tabla sin las primeras 9 filas

# cual es la diferencia entre estas formas d extraer "x"?
# extraer x
d$encuestado        
d["encuestado"] # primera columna vertical
d[["encuestado"]] # primera columna horizontal
d[, "encuestado"] # primera columna horizontal   

# extraer mas de una columna
d[c("encuestado", "horas_estudio")] 
d[, c("encuestado", "horas_estudio")]   


# comparar el objeto head_d creado, con el resultado de funcion head(d) 
head_d <- d[1:6, ] 
head_d
head(d)


# Factores ------------------

# crear un vector con el lugar de residencia. La residencia puede ser PBA o CABA

reside <- factor(sample(c("PBA", "CABA"), 20, replace = T))
reside
class(reside)
levels(reside)
nlevels(reside)

# ordenar los niveles del factor
levels(reside)
reside_ordenado <- factor(reside, levels = c("PBA", "CABA"))
levels(reside_ordenado)

# incorporar la columna al data.frame ya existente
d$reside <- reside

#explorar el data frame modificado
head(d)
str(d) # te da los tipos de cada columna
View(d)


# Ejercicio 1 ------------------
# Para experimentar !
# Hay algunos errores en este data frame ¿podés encontrarlos y arreglarlos? 
  
animal_data <- data.frame(
    animal = c("dog", "cat", "sea cucumber", "sea urchin"),
    feel = c("furry", "squishy", "spiny", "spiny"),
    weight = c(45, 8, 1.1, 0.8)
)


# Ejercicio 2 ------------------
# Predecir el tipo de cada una de las columnas en el siguiente ejemplo

country_climate <- data.frame(
  country = c("Canada", "Panama", "South Africa", "Australia"),
  climate = c("cold", "hot", "temperate", "hot/temperate"),
  temperature = c(10, 30, 18, 15),
  northern_hemisphere = c(TRUE, TRUE, FALSE, FALSE),
  has_kangaroo = c(FALSE, FALSE, FALSE, TRUE))


# chequear con la funcion str()
str(country_climate)


# ¿Eran lo que esperabas? ¿Por qué?
# ¿Qué deberías cambiar para que cada columna sea del tipo adecuado?
  
