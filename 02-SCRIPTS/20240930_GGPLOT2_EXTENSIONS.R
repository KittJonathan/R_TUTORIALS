# ATELIERS CODONS
# VISUALISATION DE DONNEES A L'AIDE DE GGPLOT2
# EXTENSIONS
# 2024-09-30

# 📦 INSTALLER LES PACKAGES -----------------------------------------------

install.packages("tidyverse")  # manipulation, visualisation
install.packages("palmerpenguins")  # jeux de donnees
install.packages("ggpmisc")  # ajouter des annotations


# 📦 CHARGER LES PACKAGES$ ------------------------------------------------

library(tidyverse)  
library(palmerpenguins)
library(ggpmisc)

pacman::p_load(tidyverse, palmerpenguins, ggpmisc)

# 🔽 IMPORTER LES DONNEES -------------------------------------------------

# Le package "palmerpenguins" contient 2 datasets :
# - penguins_raw : données brutes
# - penguins : données nettoyees

# Pour ce tutoriel de perfecionnement nous allons utiliser les donnees propres.

penguins <- palmerpenguins::penguins

# 📊 REGRESSION LINEAIRE --------------------------------------------------

# Nous souhaitons representer la relation entre les variables 'body_mass_g' et
# 'flipper_length_mm', sans tenir compte (dans un premier temps) des differentes
# especes : 

p <- penguins |> 
  ggplot(aes(x = body_mass_g, y = flipper_length_mm)) +
  geom_point(col = "cyan4") +
  scale_color_manual(values = my_cols) +
  labs(title = "Rapport entre la masse corporelle et la longueur de l'aile",
       subtitle = "Pour 3 especes de pingouins de l'archipel Palmer",
       caption = "Donnees issues du package {palmerpenguins}",
       x = "Masse corporelle (g)",
       y = "Longueur de l'aide (mm)")

p

# La fonction 'stat_poly_line()' du package {ggpmisc} permet d'ajouter une
# droite de regression. Pour preciser que nous souhaitons appliquer une
# regression lineaire, nous ajoutons l'argument 'method = "lm"' :

p +
  stat_poly_line(method = "lm")

# L'argument 'se = FALSE' permet de n'afficher que la droite, sans l'erreur
# standard ('se' = 'standard error'). Nous modifions egalement la couleur et
# la largeur de la droite : 

p +
  stat_poly_line(method = "lm", se = FALSE,
                 color = "red", linewidth = 0.5) 

# Calculons l'equation de la droite de regression a l'aide de la fonction 'lm' :

fit <- lm(flipper_length_mm ~ body_mass_g, data = penguins)

fit$coefficients

# La fonction 'stat_poly_eq()' permet d'ajouter l'equation et les coefficients
# de la regression : 

p +
  stat_poly_line(method = "lm", se = FALSE,
                 color = "red", linewidth = 0.5) +
  stat_poly_eq()

# Par defaut, la fonction 'stat_poly_eq()' affiche le coefficient R^2.
# D'autres elements peuvent etre ajoutes au plot a l'aide de la fonction
# 'use_label()' :

p +
  stat_poly_line(method = "lm", se = FALSE,
                 color = "red", linewidth = 0.5) +
  stat_poly_eq(use_label("eq", "R2"))

# Nous allons maintenant representer les droites de regression par espece : 

my_cols <- c("Adelie" = "darkorange",
             "Chinstrap" = "purple",
             "Gentoo" = "cyan4")

p <- penguins |> 
  ggplot(aes(x = body_mass_g, y = flipper_length_mm,
             color = species)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, show.legend = FALSE) +
  scale_color_manual(values = my_cols) +
  labs(title = "Rapport entre la masse corporelle et la longueur de l'aile",
       subtitle = "Pour 3 especes de pingouins de l'archipel Palmer",
       caption = "Donnees issues du package {palmerpenguins}",
       x = "Masse corporelle (g)",
       y = "Longueur de l'aide (mm)",
       col = "Espece")

# Nous ajoutons les equations des 3 droites de regression : 

p +
  stat_poly_line(method = "lm", se = FALSE,
                 linewidth = 0.5, show.legend = FALSE) +
  stat_poly_eq(use_label("eq", "R2"))

# PCA  --------------------------------------------------------------------

library(tidymodels)

my_cols <- c("Adelie" = "darkorange",
             "Chinstrap" = "purple",
             "Gentoo" = "cyan4")

df <- penguins |> 
  select(species, where(is.numeric), -year) |> 
  drop_na()

pca_fit <- df |> 
  select(where(is.numeric)) |> 
  prcomp(scale = TRUE)


pca_fit |> 
  augment(df) |> 
  ggplot(aes(.fittedPC1, .fittedPC2, color = species)) +
  geom_point() +
  scale_color_manual(values = my_cols)

pca_fit |> 
  tidy(matrix = 'rotation')

