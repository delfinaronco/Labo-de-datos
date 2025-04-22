# Ejercicio 1
# ¿Existe asociación entre la graduación alcohólica del vino (GA) y su intensidad de color (I)? Explorá esta posible relación utilizando un gráfico apropiado, considerando 
# a) todos los tipos de vino en conjunto,
# b) por separado para cada tipo de vino.

library(ggplot2)

# a)
ggplot(wine, aes(x = Alcohol, y = Color)) + 
  geom_point() +  # Agrega los puntos
  labs(
    title = "Relación entre GA e Intensidad de Color (Todos los tipos de vino)",
       x = "Graduación Alcohólica (GA)",
       y = "Intensidad de Color (I)") +
  theme_minimal()

# b)
wine2 <- wine %>% 
  mutate(Type = as.factor(wine$Type))

ggplot(wine2, aes(x = Alcohol, y = Color, color = Type)) + 
  geom_point() +  # Agrega los puntos
  labs(
    title = "Relación entre GA e Intensidad de Color",
    x = "Graduación Alcohólica (GA)",
    y = "Intensidad de Color (I)",
    color = "Tipo de vino") +
  theme_minimal()
