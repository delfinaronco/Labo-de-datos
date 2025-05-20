library(dplyr)
library(ggplot2)
library(boot)

life_exp <- read.csv("/home/Estudiante/Documentos/Life_Expectancy_2015.csv")

m1 <- lm(Life.expectancy ~ log(GDP), data = life_exp)

m2 <- lm(Life.expectancy ~ log(GDP) + BMI, data = life_exp)

summary(m2)$r.squared


# Modelo macro (GDP y Population)

formula_macro <- "Life.expectancy ~ log(GDP) + Population"
glm_macro <- glm(formula_macro, data = life_exp)
MSE_macro <- cv.glm(life_exp, modelo)$delta[1]
lm_macro <- lm(formula_macro, data = life_exp)
r2_macro <- summary(lm_macro)$r.squared

# Modelo inmunización
formula_inmunizacion <- c("Life.expectancy ~ Hepatitis.B + Polio + Diphtheria")
glm_inmunizacion <- glm(formula_inmunizacion, data = life_exp)
MSE_inmunnizacion <- cv.glm(life_exp, glm_inmunizacion)$delta[1]
lm_inmunizacion <- lm(formula_inmunizacion, data = life_exp)
r2_inmunizacion <- summary(lm_inmunizacion)$r.squared

# Modelo infancia

formula_infancia <- c("Life.expectancy ~ infant.deaths + HIV.AIDS + Measles + Schooling")
glm_infancia <- glm(formula_infancia, data = life_exp)
MSE_infancia <- cv.glm(life_exp, glm_infancia)$delta[1]
lm_infancia <- lm(formula_infancia, data = life_exp)
r2_infancia <- summary(lm_infancia)$r.squared

# Modelo propio

formula_propia <- c("Life.expectancy ~ log(GDP) + Population + Hepatitis.B + Polio + Diphtheria + infant.deaths + HIV.AIDS + Measles + Schooling")
glm_propia <- glm(formula_propia, data = life_exp)
MSE_propia <- cv.glm(life_exp, glm_propia)$delta[1]
lm_propia <- lm(formula_propia, data = life_exp)
r2_propia <- summary(lm_propia)$r.squared

# No sé qué es esto

modelos <- c("Life.expectancy ~ log(GDP) + Population",
             "Life.expectancy ~ Hepatitis.B + Polio + Diphtheria",
             "Life.expectancy ~ infant.deaths + HIV.AIDS + Measles + Schooling")

MSE <- rep(0,length(modelos))
r2 <- rep(0,length(modelos))

for (i in 1: length(modelos)){
  lm <- glm(modelos[i], data = life_exp)
  MSE[i] <- round(cv.glm(life_exp, lm)$delta[1], digits = 2)
}

# relacionar columnas numéricas
life_exp_num <- life_exp %>%
  select(where(is.numeric))

matriz_correlacion <- round(cor(life_exp_num), digits = 2)

df_modelos <- data.frame(modelos,MSE)

library(corrplot)

corrplot(matriz_correlacion,
         method = "color",
         type = "upper",
         addCoef.col = "black",
         tl.col = "black",
         tl.cex = 2,
         tl.srt = 45,
         number.cex = 2,
         diag = FALSE)

corrplot(matriz_correlacion)

# predictores categóricos
lm(Life.expectancy ~ Status, data = life_exp)

lm(formula = Life.expectancy ~ log(GDP)*Status, data = life_exp)

lm(formula = Life.expectancy ~ log(GDP) + Status, data = life_exp)

escaladas <- as.data.frame(scale(life_exp_num))

mean(escaladas$Life.expectancy)

# otra forma

escaladas_1 <- life_exp_num %>%
  scale() %>%
  data.frame()


