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

# Il est possible de definir un vecteur de couleurs et d'utiliser ce dernier : 

my_cols <- c("Adelie" = "darkorange",
             "Chinstrap" = "purple",
             "Gentoo" = "cyan4")

p + scale_color_manual(values = my_cols)

# ➕ COMBINER PLUSIEURS TYPES DE REPRESENTATION ----------------------------

# Creons un boxplot de la variable 'bill_length_mm' par espece.

penguins |> 
  ggplot(aes(x = species, y = bill_length_mm,
             fill = species, color = species)) +
  geom_boxplot(width = 0.5) +
  labs(title = "Repartition de longueur du bec par espece",
       subtitle = "Pour 3 especes de pingouins de l'archipel Palmer",
       caption = "Donnees issues du package {palmerpenguins}",
       x = "",
       y = "Longueur du bec (mm)") +
  theme_bw()

# Ajoutons de la transparence pour voir les quartiles : 

penguins |> 
  ggplot(aes(x = species, y = bill_length_mm,
             fill = species, color = species)) +
  geom_boxplot(width = 0.5, alpha = 0.5) +
  labs(title = "Repartition de longueur du bec par espece",
       subtitle = "Pour 3 especes de pingouins de l'archipel Palmer",
       caption = "Donnees issues du package {palmerpenguins}",
       x = "",
       y = "Longueur du bec (mm)") +
  theme_bw()

# La legende n'est pas utile, nous la supprimons a l'aide de
# l'argument 'show.legend = FALSE). Nous stockons le code dans 
# un objet 'bp' :

bp <- penguins |> 
  ggplot(aes(x = species, y = bill_length_mm,
             fill = species, color = species)) +
  geom_boxplot(width = 0.5, alpha = 0.5,
               show.legend = FALSE) +
  labs(title = "Repartition de longueur du bec par espece",
       subtitle = "Pour 3 especes de pingouins de l'archipel Palmer",
       caption = "Donnees issues du package {palmerpenguins}",
       x = "",
       y = "Longueur du bec (mm)") +
  theme_bw()

# Ajoutons nos couleurs ainsi que de la transparence : 

bp +
  scale_fill_manual(values = my_cols) +
  scale_color_manual(values = my_cols)

# Nous souhaitons afficher en plus des boxplots les observations
# sous forme de points pour mettre en evidence la distribution :

bp +
  geom_point(alpha = 0.25, show.legend = FALSE) +
  scale_fill_manual(values = my_cols) +
  scale_color_manual(values = my_cols)

# Pour distinguer les points qui sont superposes, nous pouvons
# utiliser la fonction geom_jitter() a la place de geom_point() : 

bp +
  geom_jitter(alpha = 0.25, show.legend = FALSE) +
  scale_fill_manual(values = my_cols) +
  scale_color_manual(values = my_cols)

# L'argument 'width = ...' permet de modifier la largeur du 
# nuage de points :

bp +
  geom_jitter(alpha = 0.25, width = 0.2, show.legend = FALSE) +
  scale_fill_manual(values = my_cols) +
  scale_color_manual(values = my_cols)

# 🔃 GESTION DES FACTEURS -------------------------------------------------

# Commencons par recreer le plot precedent : 

penguins |> 
  ggplot(aes(x = species, y = bill_length_mm,
             fill = species, color = species)) +
  geom_boxplot(width = 0.5, alpha = 0.5,
               show.legend = FALSE) +
  geom_jitter(alpha = 0.25, width = 0.2, show.legend = FALSE) +
  scale_fill_manual(values = my_cols) +
  scale_color_manual(values = my_cols) +
  labs(title = "Repartition de longueur du bec par espece",
       subtitle = "Pour 3 especes de pingouins de l'archipel Palmer",
       caption = "Donnees issues du package {palmerpenguins}",
       x = "",
       y = "Longueur du bec (mm)") +
  theme_bw()

# Par defaut, les niveaux de la variable qualitative 'species' sont 
# tries par ordre alphabetique.
# Pour rendre la lecture du plot plus aisee, nous souhaitons trier les
# niveaux (les especes) par ordre decroissant de la mediane de la variable
# quantitative 'bill_length_mm'.

# Nous allons pour cela tirer profit des fonctions fct_*() du package
# {forcats}, qui permettent de redefinir les niveaux d'un facteur (d'une
# variable qualitative, ou categorielle).

# Quels sont les niveaux actuels de cette variable ?
levels(penguins$species)

# Calculons la mediane de la variable 'bill_length_mm' pour chaque espece :
penguins |> 
  summarise(bill_length_mm_median = median(bill_length_mm, na.rm = TRUE),
            .by = species) |> 
  arrange(-bill_length_mm_median)

# Pour ce qui est de la mediane, les niveaux de la variable qualitative 'species'
# sont les suivants : Adelie < Gentoo < Chinstrap.

# Pour utiliser cet ordre directement dans le code du plot, nous utilisons la fonction
# fct_reorder() : 

levels(
  fct_reorder(.f = penguins$species,  # le facteur a trier
              .x = penguins$bill_length_mm,  # la variable par laquelle trier
              .fun = median,  # la fonction utilisee pour le tri
              .na_rm = TRUE))  # supprimer les donnees manquantes

# L'argument '.desc = TRUE' permet de trier par ordre decroissant

levels(
  fct_reorder(.f = penguins$species,
              .x = penguins$bill_length_mm,
              .fun = median,
              .na_rm = TRUE,
              .desc = TRUE))

# Le meme resultat peut etre obtenu en utilisant fct_rev() pour inverser 
# l'ordre des niveaux : 

levels(
  fct_rev(
    fct_reorder(.f = penguins$species,
                .x = penguins$bill_length_mm,
                .fun = median,
                .na_rm = TRUE)))

# Utilisons a present ce code directement dans le code du plot : 

penguins |> 
  ggplot(aes(x = fct_reorder(.f = species,
                            .x = bill_length_mm,
                            .fun = median,
                            .na_rm = TRUE,
                            .desc = TRUE),
             y = bill_length_mm,
             fill = species, color = species)) +
  geom_boxplot(width = 0.5, alpha = 0.5,
               show.legend = FALSE) +
  geom_jitter(alpha = 0.25, width = 0.2, show.legend = FALSE) +
  scale_fill_manual(values = my_cols) +
  scale_color_manual(values = my_cols) +
  labs(title = "Repartition de longueur du bec par espece",
       subtitle = "Pour 3 especes de pingouins de l'archipel Palmer",
       caption = "Donnees issues du package {palmerpenguins}",
       x = "",
       y = "Longueur du bec (mm)") +
  theme_bw()




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