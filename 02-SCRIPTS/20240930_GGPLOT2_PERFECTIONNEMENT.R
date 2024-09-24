# ATELIERS CODONS
# VISUALISATION DE DONNEES A L'AIDE DE GGPLOT2
# PERFECTIONNEMENT
# 2024-09-30

# 📦 INSTALLER LES PACKAGES -----------------------------------------------

install.packages("tidyverse")  # manipulation, visualisation
install.packages("palmerpenguins")  # jeux de donnees
# install.packages("ggstatsplot")  # representer des tests stats
# install.packages("skimr")  # synthese des donnees
# install.packages("janitor")  # nettoyage des donnees
# install.packages("glue")  # evaluer du code et l'inserer dans du texte

# 📦 CHARGER LES PACKAGES$ ------------------------------------------------

library(tidyverse)  
library(palmerpenguins)
# library(skimr)
# library(janitor)
# library(glue)
# library(ggstatsplot)

pacman::p_load(tidyverse, palmerpenguins, skimr, janitor, glue)

# 🔽 IMPORTER LES DONNEES -------------------------------------------------

# Le package "palmerpenguins" contient 2 datasets :
# - penguins_raw : données brutes
# - penguins : données nettoyees

# Pour ce tutoriel de perfecionnement nous allons utiliser les donnees brutes.

penguins <- palmerpenguins::penguins

# 📊 SCATTER PLOT SIMPLE --------------------------------------------------

# Nous allons partir d'un scatter plot simple et voir commment modifier les
# differents parametres : 

p <- penguins |> 
  ggplot(aes(x = flipper_length_mm,
             y = bill_length_mm,
             col = species)) +
  geom_point() +
  labs(title = "Rapport entre la longueur de l'aile et la longueur du bec",
       subtitle = "Pour 3 especes de pingouins de l'archipel Palmer",
       caption = "Donnees issues du package {palmerpenguins}",
       x = "Longueur de l'aile (mm)",
       y = "Longueur du bec (mm)",
       col = "Espece") +
  theme_bw()

# 🎨 COULEURS -------------------------------------------------------------

# ggplot2 attribue par defaut des couleurs au plot, en fonction de
# palettes predefinies.

# Ces palettes peuvent etre affichees a l'aide de la fonction 
# diplay.brewer.all() du package {RColorBrewer} :

RColorBrewer::display.brewer.all()

# Les fonctions scale_color_brewer(palette = "...") et
# scale_fill_brewer(palette = "...") permettent d'utiliser les differentes
# palettes : 

p + scale_color_brewer(palette = "Set1")
p + scale_color_brewer(palette = "Set2")
p + scale_color_brewer(palette = "Set3")
p + scale_color_brewer(palette = "Pastel1")
p + scale_color_brewer(palette = "Pastel2")
p + scale_color_brewer(palette = "Paired")
p + scale_color_brewer(palette = "Dark2")
p + scale_color_brewer(palette = "Accent")

# Les fonctions scale_color_manual() et scale_fill_manual() permettent de 
# definir soi-meme les couleurs a utiliser : 

p + scale_color_manual(values = c("darkorange", "cyan4", "purple"))

# Par defaut, les couleurs sont appliquees aux niveaux de la variable 
# qualitative definie dans aes(color = ...), dans l'ordre alphabetique.

levels(penguins$species)

# Les figures de la page web du package {palmerpenguins} 
# (https://allisonhorst.github.io/palmerpenguins/) utilisent les trois couleurs
# suivantes : 
# 'darkorange' pour l'espece Adelie
# 'purple' pour l'espece Chinstrap
# 'cyan4' pour l'espece Gentoo

# Pour definir une couleur par niveau : 

p + scale_color_manual(values = c("Adelie" = "darkorange",
                                  "Chinstrap" = "purple",
                                  "Gentoo" = "cyan4"))

# EN VRAC ----

# Par defaut, les niveaux de la variable qualitative (ici les especes) sont triees
# par ordre alphabetique.

# Les fonction fct_*() du package {forcats} permettent de modifier l'ordre des niveaux
# d'un facteur.

# La fonction fct_infreq() permet de trier les niveaux d'un facteur par frequence (par
# defaut par ordre decroissant) : 

penguins |> 
  ggplot(aes(x = fct_infreq(species))) +
  geom_bar(width = 0.75)

# La fonction geom_text() permet d'ajouter une couche contenant du texte (chaine de
# caracteres ou valeurs numeriques) a notre plot.
# Dans la fonction geom_text(), nous precisons : 
# - quelle etiquette ajouter : 'aes(label = ..count..)'
# - quelle statistique utiliser : 'stat = "count"'

penguins |> 
  ggplot(aes(x = fct_infreq(species))) +
  geom_bar(width = 0.75) +
  geom_text(aes(label = ..count..), stat = "count")

# Nous souhaitons que les etiquettes soient affichees au-dessus des barres.
# Les fonctions hjust() et vjust() permettent de mofifier la justification de 
# texte ('hjust' pour la justification horizontale, 'vjust' pour la 
# justification verticale).

# Ces fonctions s'utilisent avec un argument, une valeur numerique qui precise
# la justification.
# Pour la fonction hjust(), ces valeurs indiquent quelle partie de l'etiquette
# est alignee sur la position le long de l'axe x :
# 0.5 -> centre
# 0 -> gauche
# 1 -> droite

penguins |> 
  ggplot(aes(x = fct_infreq(species))) +
  geom_bar(width = 0.75) +
  geom_text(aes(label = ..count..), stat = "count",
            hjust = 0.5)

penguins |> 
  ggplot(aes(x = fct_infreq(species))) +
  geom_bar(width = 0.75) +
  geom_text(aes(label = ..count..), stat = "count",
            hjust = 0)

penguins |> 
  ggplot(aes(x = fct_infreq(species))) +
  geom_bar(width = 0.75) +
  geom_text(aes(label = ..count..), stat = "count",
            hjust = 1)

# Pour la fonction vjust(), ces valeurs indiquent quelle partie de l'etiquette
# est alignee sur la position le long de l'axe y :
# 0.5 -> centre
# 0 -> bas
# 1 -> haut

penguins |> 
  ggplot(aes(x = fct_infreq(species))) +
  geom_bar(width = 0.75) +
  geom_text(aes(label = ..count..), stat = "count",
            vjust = 0.5)

penguins |> 
  ggplot(aes(x = fct_infreq(species))) +
  geom_bar(width = 0.75) +
  geom_text(aes(label = ..count..), stat = "count",
            vjust = 0)

penguins |> 
  ggplot(aes(x = fct_infreq(species))) +
  geom_bar(width = 0.75) +
  geom_text(aes(label = ..count..), stat = "count",
            vjust = 1)

# En utilisant des valeurs numeriques superieures a 1, l'etiquette peut
# etre eloignee de la position de l'axe x (vers la gauche) ou y (vers le bas) :

penguins |> 
  ggplot(aes(x = fct_infreq(species))) +
  geom_bar(width = 0.75) +
  geom_text(aes(label = ..count..), stat = "count",
            hjust = 1)

penguins |> 
  ggplot(aes(x = fct_infreq(species))) +
  geom_bar(width = 0.75) +
  geom_text(aes(label = ..count..), stat = "count",
            hjust = 1.5)

penguins |> 
  ggplot(aes(x = fct_infreq(species))) +
  geom_bar(width = 0.75) +
  geom_text(aes(label = ..count..), stat = "count",
            hjust = 2)

penguins |> 
  ggplot(aes(x = fct_infreq(species))) +
  geom_bar(width = 0.75) +
  geom_text(aes(label = ..count..), stat = "count",
            vjust = 1)

penguins |> 
  ggplot(aes(x = fct_infreq(species))) +
  geom_bar(width = 0.75) +
  geom_text(aes(label = ..count..), stat = "count",
            vjust = 1.5)

penguins |> 
  ggplot(aes(x = fct_infreq(species))) +
  geom_bar(width = 0.75) +
  geom_text(aes(label = ..count..), stat = "count",
            vjust = 2)

# En utilisant des valeurs numeriques inferieures a 0, l'etiquette peut
# etre eloignee de la position de l'axe x (vers la droite) ou y (vers le haut) :

penguins |> 
  ggplot(aes(x = fct_infreq(species))) +
  geom_bar(width = 0.75) +
  geom_text(aes(label = ..count..), stat = "count",
            hjust = 0)

penguins |> 
  ggplot(aes(x = fct_infreq(species))) +
  geom_bar(width = 0.75) +
  geom_text(aes(label = ..count..), stat = "count",
            hjust = -0.5)

penguins |> 
  ggplot(aes(x = fct_infreq(species))) +
  geom_bar(width = 0.75) +
  geom_text(aes(label = ..count..), stat = "count",
            hjust = -1)

penguins |> 
  ggplot(aes(x = fct_infreq(species))) +
  geom_bar(width = 0.75) +
  geom_text(aes(label = ..count..), stat = "count",
            vjust = 0)

penguins |> 
  ggplot(aes(x = fct_infreq(species))) +
  geom_bar(width = 0.75) +
  geom_text(aes(label = ..count..), stat = "count",
            vjust = -0.5)

penguins |> 
  ggplot(aes(x = fct_infreq(species))) +
  geom_bar(width = 0.75) +
  geom_text(aes(label = ..count..), stat = "count",
            vjust = -1)

# Par defaut, les niveaux de la variable qualitative sont triees
# par ordre alphabetique.

# La fonction fct_reorder() du package {forcats} permet de modifier l'ordre des 
# niveaux d'une variable qualitative en fonction d'une autre variable.
# Nous souhaitons trier les niveaux de la variable 'species' par ordre 
# croissant de la mediane de la variable 'body_mass_g'.

penguins |> 
  ggplot(aes(x = fct_reorder(.f = species,
                             .x = body_mass_g,
                             .fun = median, na.rm = TRUE),
             y = body_mass_g)) +
  geom_boxplot()