setwd("C:/Users/Usuario/Documents/DATOS")
data <- read.csv("establecimientos-educativos-28042025.csv")
library(ggplot2)
library(dplyr)
install.packages("gridExtra")
library("gridExtra")
View(data)


--------------------
A. ¿Cómo es la distribución de cantidad de establecimientos educativos en la PBA por
categoría, área y ámbito?
--------------------
  


barras_categoria <- ggplot(data, aes(x= categoria)) + geom_bar(fill= " skyblue", color = "black")+labs(y="Cantidad de establecimientos educativos")
barras_categoria
  
barras_area <- ggplot(data, aes(x=area))+ geom_bar(fill="red", color="black")+labs(y="Cantidad de establecimientos educativos")
barras_area

barras_ambito <- ggplot(data, aes(x = ambito)) + geom_bar(fill="green", color= "black")+labs(y="Cantidad de establecimientos educativos")
barras_ambito


grafico_unificado <- grid.arrange(barras_categoria, barras_area, barras_ambito, ncol=3,top="Cantidad de establecimientos en la PBA por categoría ,área y ámbito") 
grafico_unificado 

--------------------------------------------- 
  B. ¿Existe alguna relación entre la matrícula y la cantidad de secciones de un
establecimiento. ¿Qué ocurre si se analiza discriminando por modalidad, área,
sector, etc.?
---------------------------------------------
  
ggplot(data, aes(x = secciones, y = matricula)) +geom_point()+ geom_smooth(method = "lm") +facet_wrap(~ modalidad,scales = "free") + labs(title="Relación entre secciones y matrículas en establecimientos educativos de la PBA")
datos_por_modalidad <- data %>% group_by(modalidad) %>% count() %>% arrange(n)
datos_por_modalidad

datos_modalidad_educacion_especial <- data %>% filter(modalidad == "Educación Especial")
ggplot(datos_modalidad_educacion_especial, aes(x=secciones, y=matricula)) + geom_point()
View(datos_modalidad_educacion_especial)

datos_modalidad_comunitaria_y_pedagogia<- data %>% filter(modalidad == "Psicología Comunitaria y Pedagogía Social")
ggplot(datos_modalidad_comunitaria_y_pedagogia, aes(x=secciones, y=matricula)) + geom_point()
 
ggplot(data, aes(x = secciones, y = matricula)) + geom_point() + geom_smooth(method = "lm") +facet_wrap(~ area) 

ggplot(data, aes(x = secciones, y = matricula)) + geom_point() + geom_smooth(method = "lm") +facet_wrap(~ sector) 
  
ggplot(data, aes(x = secciones, y = matricula)) + geom_point() + geom_smooth(method = "lm") +facet_wrap(~ nivel) 

datos_por_nivel <- data %>% group_by(nivel) %>% count() %>% arrange(n)
datos_por_nivel

------------------------------------
  C. ¿Cuántos estudiantes y cuántas secciones tienen en promedio los establecimientos
de una misma dependencia? ¿Cómo es la variabilidad? En especial interesa analizar
las dependencias que tengan más de 500 establecimientos bajo su órbita, mientras
que el resto puede ser analizado en conjunto como una categoría “otro” (en referencia a otro tipo de dependencia).
-----------------------------------
2+2

datos_por_dependencia <- data %>% group_by(dependencia) %>% summarise(
  promedio_estudiantes = mean(matricula),
  sd_estudiantes = sd(matricula),
  promedio_secciones = mean(secciones),
  sd_secciones = sd(secciones),
  count = n())

datos_por_dependencia



datos_dependencia_mayores_a_500 <- data %>% filter(dependencia == "Oficial" | dependencia == "Privada")
datos_dependencia_mayores_a_500

ggplot(datos_por_dependencia, aes(x=dependencia, y =promedio_estudiantes))+ geom_bar(stat="identity", position = "dodge")+
  geom_errorbar(aes(ymin = promedio_estudiantes-sd_estudiantes, ymax = promedio_estudiantes + sd_estudiantes),width=0.2) + theme_minimal()



datos_otras_dependencias<- data %>% filter(dependencia != "Oficial" | dependencia != "Privada")
datos_otras_dependencias



# D. ¿Cómo se caracteriza la oferta de turnos para cada uno de los niveles educativos? ¿Varía según área, sector y el tipo de dependencia?
  
datos_nivel_turnos <- data %>% group_by(nivel,turnos) %>% count()
datos_nivel_turnos

mas_importantes <- data_turnos %>% filter(nivel == "Nivel Inicial" | nivel == "Nivel Primario"| nivel =="Nivel Secundario" | nivel == "Formación Profesional")
menos_importantes <- data_turnos %>% filter(nivel != "Nivel Inicial" & nivel != "Nivel Primario" & nivel !="Nivel Secundario" & nivel != "Formación Profesional")

  
ggplot(mas_importantes, aes(x = nivel, fill = turnos)) +
  geom_bar() +
  labs(title = "Relación entre Nivel y Turno",
       x = "Nivel Educativo",
       y = "Cantidad de Establecimientos",
       fill = "Turno") +
  theme_minimal()

ggplot(menos_importantes, aes(x = nivel, fill = turnos)) +
  geom_bar() +
  labs(title = "Relación entre Nivel y Turno",
       x = "Nivel Educativo",
       y = "Cantidad de Establecimientos",
       fill = "Turno") +
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

library(tidyr)
data_turnos <- separate_rows(data, turnos, sep = ",") %>%
  mutate(turnos = trimws(turnos))  # elimina espacios


ggplot(mas_importantes, aes(x = nivel, fill = turnos)) +
  geom_bar() +
  facet_wrap(~ area) +
  labs(title = "Relación entre Nivel y Turno por área",
       x = "Nivel Educativo",
       y = "Cantidad de Establecimientos",
       fill = "Turno") +
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  

ggplot(menos_importantes, aes(x = nivel, fill = turnos)) +
  geom_bar() +
  facet_wrap(~ area) +
  labs(title = "Relación entre Nivel y Turno por área",
       x = "Nivel Educativo",
       y = "Cantidad de Establecimientos",
       fill = "Turno") +
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  

# ahora por sector


ggplot(mas_importantes, aes(x = nivel, fill = turnos)) +
  geom_bar() +
  facet_wrap(~ sector) +
  labs(title = "Relación entre Nivel y Turno por sector",
       x = "Nivel Educativo",
       y = "Cantidad de Establecimientos",
       fill = "Turno") +
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) 

# por dependencia


ggplot(mas_importantes, aes(x = nivel, fill = turnos)) +
  geom_bar() +
  facet_wrap(~ dependencia) +
  labs(title = "Relación entre Nivel y Turno por tipo de dependencia",
       x = "Nivel Educativo",
       y = "Cantidad de Establecimientos",
       fill = "Turno") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  



