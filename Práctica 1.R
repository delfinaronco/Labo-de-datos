# Ejercicio 1

matematica <- c(5,8,9,10,3,6)
lengua <- c(7,8,6,10,8,6)
biologia <- c(7,5,6,10,6,4)
historia <- c(10,9,8,7,8,7)

# Ejercicio 2

mean(matematica)

## [1] 6.833333

mean(lengua)

## [1] 7.5

mean(biologia)

## [1] 6.333333

mean(historia)

## [1] 8.166667

# Ejercicio 3

# a)
matematica[matematica < 7]

## [1] 5 3 6 

# b) 
length(matematica[matematica < 7])

## [1] 3

# c)

length(matematica[matematica < 7])/ length(matematica)

## [1] 0.5

# Ejercicio 4


desaprobados <- c(length(matematica[matematica < 7])/length(matematica), 
                  length(lengua[lengua < 7])/length(lengua),
                  length(biologia[biologia < 7])/length(biologia), 
                  length(historia[historia < 7])/length(historia)
                  )

# a)
which.max(desaprobados)

## [1] 3

# b)
desaprobados[3]

# [1] 0.66666667

# Ejercicio 5

prop_desaprobados <- function(materia){
  length(materia[materia < 7])/length(materia)
}

prop_desaprobados(matematica)

## [1] 0.5

prop_desaprobados(lengua)

## [1] 0.3333333

prop_desaprobados(biologia)

## 0.6666667

prop_desaprobados(historia)

## [1] 0

# Ejercicio 6

ed_fisica <- c(NA,10,NA,9,NA,8)

mean(ed_fisica, na.rm = T)
# na.rm = T ignora los na

## [1] 9

# Ejercicio 7

