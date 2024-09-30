# ATELIERS CODONS
# VISUALISATION DE DONNEES A L'AIDE DE GGPLOT2
# EXTENSIONS
# 2024-09-30

# 📦 INSTALLER LES PACKAGES -----------------------------------------------

install.packages("tidyverse")  # manipulation, visualisation
install.packages("palmerpenguins")  # jeux de donnees
install.packages("ggpubr")  # figures 'pretes a etre publiees'


# 📦 CHARGER LES PACKAGES$ ------------------------------------------------

library(tidyverse)  
library(palmerpenguins)
library(ggpubr)

pacman::p_load(tidyverse, palmerpenguins, ggpubr)

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

# La fonction 'geom_smooth' permet d'ajouter une droite de regression.
# Pour preciser que nous souhaitons appliquer une regression lineaire, nous 
# ajoutons l'argument 'method = "lm"'.

p +
  geom_smooth(method = "lm")

# L'argument 'se = FALSE' permet de n'afficher que la droite, sans l'erreur
# standard ('se' = 'standard error'). Nous modifions egalement la couleur et
# la largeur de la droite : 

p +
  geom_smooth(method = "lm", se = FALSE,
              color = "red", linewidth = 0.5)

# Calculons l'equation de la droite de regression a l'aide de la fonction 'lm' :

fit <- lm(flipper_length_mm ~ body_mass_g, data = penguins)

fit$coefficients

# Le package {ggpubr} permet d'ajouter directement l'equation de la droite de
# regression au plot, a l'aide de la fonction 'stat_regline_equation()' : 

p +
  geom_smooth(method = "lm", se = FALSE,
              color = "red", linewidth = 0.5) +
  stat_regline_equation()

# Les arguments 'label.x' et 'label.y' permettent de deplacer l'equation,
# et l'argument 'size' permet de modifier la taille du texte : 

p +
  geom_smooth(method = "lm", se = FALSE,
              color = "red", linewidth = 0.5) +
  stat_regline_equation(label.x = 5000, label.y = 190, size = 5)

# La fonction 'stat_cor' permet d'ajouter le coefficient de correlation.
# Pour afficher le 'R^2', nous ajoutons une deuxieme couche 'stat_cor' et
# utilisons l'argument 'aes(label = ..rr.label..)' :

p +
  geom_smooth(method = "lm", se = FALSE,
              color = "red", linewidth = 0.5) +
  stat_regline_equation(label.x = 5000, label.y = 190, size = 5) +
  stat_cor(label.x = 5000, label.y = 185, size = 4) +
  stat_cor(aes(label = ..rr.label..),
           label.x = 5000, label.y = 180, size = 4)

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
  stat_regline_equation(aes(label = paste(..eq.label.., ..adj.rr.label.., sep = "\t")))

# Et les coefficients de correlation : 

p +
  stat_regline_equation(label.x = -Inf, label.y = Inf)



# Nous souhaitons afficher sur notre plot l'equation de la regression lineaire
# ainsi que les coefficients :



penguins |> 
  ggplot(aes(x = body_mass_g, y = flipper_length_mm,
             color = species)) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_color_manual(values = my_cols) +
  labs(title = "Rapport entre la masse corporelle et la longueur de l'aile",
       subtitle = "Pour 3 especes de pingouins de l'archipel Palmer",
       caption = "Donnees issues du package {palmerpenguins}",
       x = "Masse corporelle (g)",
       y = "Longueur de l'aide (mm)",
       col = "Espece")
  


# PCA  --------------------------------------------------------------------

library(tidymodels)

df <- penguins |> 
  select(species, where(is.numeric), -year) |> 
  drop_na()

pca_fit <- df |> 
  select(where(is.numeric)) |> 
  prcomp(scale = TRUE)


pca_fit |> 
  augment(df) |> 
  ggplot(aes(.fittedPC1, .fittedPC2, color = species)) +
  geom_point()

