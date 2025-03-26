
### Clase 1 - parte A ###############################
# Los comentarios se encuentran a lo largo del codigo

# R como calculadora -----------------------------
# Realizar las siguientes operaciones básicas en la consola

2+7
14-8
25-29
12*7
125/5

4^3
4**3


16 %% 5  # (probar con otros números para entender qué significa)

24 %/% 4 # (probar con otros números para entender qué significa)

0/0    # que ocurre?


# mas operaciones
sqrt(9)
log(1)
exp(1)
cos(1)   
cos(pi)
# etc

# help -----------------------------
?sqrt
?log
# etc



# Objetos y asignacion -----------------------------

peso_kg <- 87 # shorcut para "<-": "Alt" +  "-"

# si quiero ver el contenido de "peso_kg"...
peso_kg

# si quiero crear el objeto "peso_kg" y ver su contenido en un solo comando escribimos...
(peso_kg <- 87)

altura_m <- 1.7

peso_kg / altura_m^2


#### Ejercicio 1 -----------------------------

# ¿Cuáles son los valores de los siguientes objetos luego de cada asignación?

mass <- 47.5            # mass?
age  <- 122             # age?
mass <- mass * 2.0      # mass?
age  <- age - 20        # age?
mass_age <- mass / age  


# Vectores -----------------------------
# 

weight_g <- c(50, 60, 65, 82)
weight_g

animals <- c("mouse", "rat", "dog")
animals

# muchas funciones que permiten inspeccionar el contenido de un vector
length(weight_g)
length(animals)

class(weight_g)
class(animals)

str(weight_g)
str(animals)


# tipo de vectores

# ¿Qué sucede cuando se realizan las siguientes operaciones que mezclan variables de distinta clase? ¿Por qué les parece que pasa? (usar class() para investigar el tipo de dato de los objetos)

num_char <- c(1, 2, 3, "a")
num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
tramposo <- c(1, 2, 3, "4")

combined_logical <- c(num_logical, char_logical)


# agregar elementos con c()
weight_g <- c(weight_g, 90) # agrega a final del vector
weight_g <- c(30, weight_g) # agrega al principio del vector
weight_g


# extraer elementos de vectores
animals <- c("mouse", "rat", "dog", "cat")
animals[2]
animals[c(3, 2)]

# repetir indices para crear un objeto con mas elementos que el original
more_animals <- animals[c(1, 2, 3, 2, 1, 4)]
more_animals


# crear subconjuntos es mediante el uso de un vector lógico

weight_g <- c(21, 34, 39, 54, 55)
weight_g[c(TRUE, FALSE, TRUE, TRUE, FALSE)]


# ejemplo
weight_g[weight_g > 50]

# por que?
weight_g > 50    

# combinacion de expresiones logicas
# & (“ambas condiciones son verdaderas”, AND) o | (“al menos una de las condiciones es verdadera”, OR):

weight_g[weight_g < 30 | weight_g > 50]

weight_g[weight_g >= 30 & weight_g == 21]


# función %in% 

animals <- c("mouse", "rat", "dog", "cat")
animals

animals[animals == "cat" | animals == "rat"] # devuelve las componentes que tengan "cat" o "rat"

animals %in% c("rat", "cat", "dog", "duck", "goat") 
animals[animals %in% c("rat", "cat", "dog", "duck", "goat")] 



#### Ejercicio 2  -----------------------------

# Explorar estas distintas formas de extraer información del vector c("banana", "pera", "durazno", "anana"). Primero crear el vector en la consola y asignarlo al vector frutas. Luego correr cada caso en la consola y explicar en pocas palabras qué es lo que sucede.

frutas <- c("banana", "pera", "durazno")

frutas[2]
frutas[c(1,4)]
frutas[c(1,4,1,1,2)]
frutas %in% c("ciruela", "frutilla", "pera", "mandarina")
frutas[frutas %in% c("ciruela", "frutilla", "pera", "mandarina") ]


#### Ejercicio 3 -----------------------------

# ¿Por qué da error la línea 4 de esta secuencia?
  
datos <- c("banana", 2, "pera", 5, "durazno", 0)
datos[2] 
datos[4]
datos[2] + datos[4]

# ¿Por qué no da error la línea 2 de esta secuencia?

datos <- c(1, 3, 5, 7, 9)
datos[2] + datos[4]


#### Ejercicio 4 -----------------------------

# Explorar las distintas formas de extraer información del vector alturas_cm. Escribir una frase explicando qué hace cada una. ¿Por qué la última retorna numeric(0)?

alturas_cm <- c(180, 178, 154, 202)

  
alturas_cm[c(TRUE, FALSE, TRUE, TRUE)]
alturas_cm[alturas_cm >= 180]
alturas_cm[alturas_cm >= 180 & alturas_cm < 200]
alturas_cm[alturas_cm >= 160 & alturas_cm == 195]



# Matrices -----------------------------

# crear una matriz, una opción:
m <- matrix(1:6, nrow = 2, ncol = 3)
m
dim(m)

# Extraer primera fila de la matriz m
m[1,]

# Extraer tercera columna de la matriz m
m[,3]


# crear una matriz, otra opción:

M <- matrix(c(2,3,5,7,11,13,15,17,19), ncol=3)
M

# Extraer primera fila de la matriz M

# Extraer tercera columna de la matriz M



# Funciones -----------------------------

# ya usamos algunas, ejemplo:
sqrt()
mean()
# ... etc etc


# Explorar las funciones max(), min(), mean() y sort() aplicadas al vector alturas_cm

alturas_cm <- c(180, 178, 154, 202)
max(alturas_cm)
min(alturas_cm)
mean(alturas_cm)
sort(alturas_cm)

# Usar las funciones which.min() y which.max() con el mismo vector de alturas. Interpretar qué hace cada una.

which.min(alturas_cm)
which.max(alturas_cm) 

#### round() -----------------------------


# correr estas lineas 

round(3.14159)
round(3.14159,3)
round(3.14159,2)

?round
# opciones (argumentos opcionales)

# se recomienda poner unicamente los nombres de los argumentos opcionales

round(3.14159, digits = 2) # recomendado

# otras formas correctas

round(x = 3.14159, digits = 2)
round(3.14159, 2)
round(digits = 2, x = 3.14159)

# forma incorrecta (¿por que?)

round(2, 3.14159)


# otro ejemplo
round(sqrt(3), 5)
round(sqrt(3), 2)
round(sqrt(3))


#### seq() -----------------------------

# Para generar secuencias de numeros
1:30  # Secuencia regular de numeros enteros

# La funcion seq puede generar secuencias de numeros:
seq(1, 5, 0.5)
seq(from=1, to=5, by=0.5)

# Tambien se puede usar:
seq(length=9, from=1, to=5)

# Help
?seq()


#### rep() -----------------------------
# explorar el help y aplicar esta funcion de manera de obtener un vector que contenga 5 veces el numero 3

?rep()



#### sample() -----------------------------


sample(x = c("frambuesa", "frutilla"), size = 7, replace = TRUE )

sample(x = c(0,1), size = 7, replace = TRUE )

# por que da Error?
sample(x = c(-1,1), size = 3)


#### which() -----------------------------
# 
which(animals=="dog")



# etc etc etc


# Funciones definidas por el usuario-----------

# Ejemplo: 

media <- function(data){
  
  valor <- mean(data)
  resultado <- paste("La media es igual a", valor)
  
  return(resultado)
  
}

media(alturas_cm)



# Datos faltantes -----------------------------


# dado este vector de alturas:

heights <- c(2, 4, 4, NA, 6)


# (exploramos clase y longitud)

class(heights)
length(heights)

# ¿Qué devuelven los siguientes comandos?

mean(heights)
max(heights)

heights[!is.na(heights)]
na.omit(heights)
heights[complete.cases(heights)]

# vector con casos completos
heights_comp <- c(2, 4, 4, 7, 6)

# funciones 
mean(heights_comp) 
sum(heights_comp) 
max(heights_comp)
min(heights_comp)

# podemos aplicar esas funciones sobre el vector con NA?
mean(heights)
sum(heights)
max(heights)
min(heights)

# opcion na.rm

mean(heights, na.rm = TRUE) 
sum(heights, na.rm = TRUE)
max(heights, na.rm = TRUE)
min(heights, na.rm = TRUE)

?mean

# queremos crear un vector con las componentes distintas de NA de heights

# si queremos las componentes de heights disintas de 6 hacemos...
heights[heights != 6]

# si queremos las componentes de heights disintas de NA, lo primero que se nos ocurre es hacer...

heights[heights != NA] # pero esto NO funciona

# quiero el vector: 
# TRUE TRUE TRUE FALSE TRUE

heights[!is.na(heights)]
is.na(heights)

na.omit(heights)

heights[complete.cases(heights)]
complete.cases(heights)

# ahora si creamos un vector con las componentes distintas de NA de heights y luego le calculamos la media

heights_no_na1 <- heights[!is.na(heights)]
heights_no_na2 <- na.omit(heights)
heights_no_na3 <- heights[complete.cases(heights)]

mean(heights_no_na1)

# corroboramos que da o mismo que usar la funcion mean con el vector heights original y la opcion na.rm especificada en TRUE
mean(heights, na.rm = TRUE)


#### Ejercicio 5 -----------------------------

# para el siguiente vector de alturas en pulgadas:

heights <- c(63, 69, 60, 65, NA, 68, 61, 70, 61, 59, 64, 69, 63, 63, NA, 72, 65, 64, 70, 63, 65)

# a) creá un nuevo vector, heights_no_na, con los NA eliminados.
(heights_no_na <- heights[!is.na(heights)])

# b) Usá la función median() para calcular la mediana del vector heights de dos formas distintas: sin usar el vector heights_no_na y usándolo.
median(heights) # no funciona
median(heights_no_na)

# c) Averiguá cuántas personas en el conjunto miden más de 67 pulgadas.

length(heights_no_na[heights_no_na > 67])


#### Ejercicio 6 -----------------------------

# para el siguiente vector:

weights <- c(NA, 40, NA, 16, 28, 12, 24, 12, 23, 30,  4, 16, 11, 34, NA, 15, 13, NA, 26, NA)
weights

# a) Averiguá en qué posiciones  weights tiene valores menores a 21.
which(weights < 21)

# b) Averiguá en qué posiciones  weights tiene datos faltantes.
which(is.na(weights))

# c) Calculá la media de los valores de weights mayores a 20.
(weights_withoutna <- weights[!is.na(weights)])
median(weights_withoutna[weights_withoutna > 20])



