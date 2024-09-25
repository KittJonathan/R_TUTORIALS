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

# Le package {forcats} est egalement tres utile pour modifier l'ordre des
# classes dans un barplot :

penguins |> 
  ggplot(aes(x = species,
             fill = species)) +
  geom_bar(width = 0.75,
           show.legend = FALSE) +
  scale_fill_manual(values = my_cols) +
  labs(title = "Nombre d'individus par espece",
       subtitle = "Pour 3 especes de pingouins de l'archipel Palmer",
       caption = "Donnees issues du package {palmerpenguins}",
       x = "",
       y = "Frequence") +
  theme_bw()

# La fonction fct_infreq() permet de trier les niveaux du facteur (la variable
# 'species' par ordre decroissant de frequence) :

penguins |> 
  ggplot(aes(x = fct_infreq(species),
             fill = species)) +
  geom_bar(width = 0.75,
           show.legend = FALSE) +
  scale_fill_manual(values = my_cols) +
  labs(title = "Nombre d'individus par espece",
       subtitle = "Pour 3 especes de pingouins de l'archipel Palmer",
       caption = "Donnees issues du package {palmerpenguins}",
       x = "",
       y = "Frequence") +
  theme_bw()

# 🔠 AJOUTER DU TEXTE -----------------------------------------------------

# Reprenons le barplot que nous venons de creer : 

penguins |> 
  ggplot(aes(x = fct_infreq(species),
             fill = species)) +
  geom_bar(width = 0.75,
           show.legend = FALSE) +
  scale_fill_manual(values = my_cols) +
  labs(title = "Nombre d'individus par espece",
       subtitle = "Pour 3 especes de pingouins de l'archipel Palmer",
       caption = "Donnees issues du package {palmerpenguins}",
       x = "",
       y = "Frequence") +
  theme_bw()

# Pour rendre ce plot plus explicite, nous souhaitons ajouter des etiquetttes
# au-dessus des barres indiquant la frequence.

# La fonction geom_text() permet d'ajouter du texte a un plot.
# Pour ajouter les etiquettes avec la frequence, nous precisons deux arguments : 
# 1) 'stat = "count" pour indiquer que nous souhaitons ajouter une frequence
# 2) 'aes(label = after_stat(count))' : pour 'mapper' la frequence sur l'etiquette

penguins |> 
  ggplot(aes(x = fct_infreq(species),
             fill = species)) +
  geom_bar(width = 0.75,
           show.legend = FALSE) +
  geom_text(stat = "count",
            aes(label = after_stat(count))) +
  scale_fill_manual(values = my_cols) +
  labs(title = "Nombre d'individus par espece",
       subtitle = "Pour 3 especes de pingouins de l'archipel Palmer",
       caption = "Donnees issues du package {palmerpenguins}",
       x = "",
       y = "Frequence") +
  theme_bw()

# 📄 JUSTIFIER DU TEXTE ---------------------------------------------------

# Les parametres 'hjust' et 'vjust' permettent de modifier la justification
# du texte.

# Pour illustrer comment utiliser ces deux parametres, nous creons un plot
# avec une ligne horizontale et une ligne verticale, a l'aide des fonctions
# geom_hline() et geom_vline().

# Le parametre 'linetype' permet de modifier le type de ligne : 
# 'linetype = 0' ou 'linetype = "blank"
# 'linetype = 1' ou 'linetype = "solid"
# 'linetype = 2' ou 'linetype = "dashed"
# 'linetype = 3' ou 'linetype = "dotted"
# 'linetype = 4' ou 'linetype = "dotdash"
# 'linetype = 5' ou 'linetype = "longdash"
# 'linetype = 6' ou 'linetype = "twodash"

# Pour information, le parametre 'linewidth' permet de modifier l'epaisseur de
# la ligne, a l'aide d'une valeur numerique (nous ne modifions pas ce parametre).

ggplot() +
  geom_hline(yintercept = 0, linetype = "blank") +
  geom_vline(xintercept = 0, linetype = 0)

ggplot() +
  geom_hline(yintercept = 0, linetype = "solid") +
  geom_vline(xintercept = 0, linetype = 1)

ggplot() +
  geom_hline(yintercept = 0, linetype = "dashed") +
  geom_vline(xintercept = 0, linetype = 2)

ggplot() +
  geom_hline(yintercept = 0, linetype = "dotted") +
  geom_vline(xintercept = 0, linetype = 3)

ggplot() +
  geom_hline(yintercept = 0, linetype = "dotdash") +
  geom_vline(xintercept = 0, linetype = 4)

ggplot() +
  geom_hline(yintercept = 0, linetype = "longdash") +
  geom_vline(xintercept = 0, linetype = 5)

ggplot() +
  geom_hline(yintercept = 0, linetype = "twodash") +
  geom_vline(xintercept = 0, linetype = 6)

# Creons un plot sur lequel nous verrons les differentes manieres
# d'utiliser 'hjust' et 'vjust' : 

p <- ggplot() +
  geom_hline(yintercept = 0, linetype = "dotted") +
  geom_vline(xintercept = 0, linetype = "dotted") +
  theme_bw()

p

# Par defaut, le texte est 'centre' : le milieu de la chaine de caracteres (ou
# de la valeur numerique) est aligne avec les positions definies en x et y.
# Les valeurs par defaut de 'hjust' et 'vjust' sont egales a 0.5 :

p + 
  geom_text(aes(x = 0, y = 0), label = "texte", hjust = 0.5, vjust = 0.5) +
  labs(title = "Justification du texte",
       subtitle = "hjust = 0.5 ; vjust = 0.5")

# Pour la justification horizontale, la valeur numerique precise quelle partie
# du texte est aligne sur la position definie en 'x' : 
# 'hjust = 0.5' -> milieu du texte 
# 'hjust = 0'   -> bord gauche du texte
# 'hjust = 1'   -> bord droit du texte

p + 
  geom_text(aes(x = 0, y = 0), label = "texte", hjust = 0, vjust = 0.5) +
  labs(title = "Justification du texte",
       subtitle = "hjust = 0 ; vjust = 0.5")

p + 
  geom_text(aes(x = 0, y = 0), label = "texte", hjust = 1, vjust = 0.5) +
  labs(title = "Justification du texte",
       subtitle = "hjust = 1 ; vjust = 0.5")

# Pour la justification verticale, la valeur numerique precise quelle partie
# du texte est aligne sur la position definie en 'y' : 
# 'vjust = 0.5' -> milieu du texte 
# 'vjust = 0'   -> bord inferieur du texte
# 'vjust = 1'   -> bord superieur du texte

p + 
  geom_text(aes(x = 0, y = 0), label = "texte", hjust = 0.5, vjust = 0) +
  labs(title = "Justification du texte",
       subtitle = "hjust = 0.5 ; vjust = 0")

p + 
  geom_text(aes(x = 0, y = 0), label = "texte", hjust = 0.5, vjust = 1) +
  labs(title = "Justification du texte",
       subtitle = "hjust = 0.5 ; vjust = 1")

# Testons differentes combinaisons pour les parametres 'hjust' et 'vjust' :

p + 
  geom_text(aes(x = 0, y = 0), label = "texte", hjust = 0, vjust = 0) +
  labs(title = "Justification du texte",
       subtitle = "hjust = 0 ; vjust = 0")

p + 
  geom_text(aes(x = 0, y = 0), label = "texte", hjust = 0, vjust = 0.5) +
  labs(title = "Justification du texte",
       subtitle = "hjust = 0 ; vjust = 0.5")

p + 
  geom_text(aes(x = 0, y = 0), label = "texte", hjust = 0, vjust = 1) +
  labs(title = "Justification du texte",
       subtitle = "hjust = 0 ; vjust = 1")

p + 
  geom_text(aes(x = 0, y = 0), label = "texte", hjust = 0.5, vjust = 0) +
  labs(title = "Justification du texte",
       subtitle = "hjust = 0.5 ; vjust = 0")

p + 
  geom_text(aes(x = 0, y = 0), label = "texte", hjust = 0.5, vjust = 0.5) +
  labs(title = "Justification du texte",
       subtitle = "hjust = 0.5 ; vjust = 0.5")

p + 
  geom_text(aes(x = 0, y = 0), label = "texte", hjust = 0.5, vjust = 1) +
  labs(title = "Justification du texte",
       subtitle = "hjust = 0.5 ; vjust = 1")

p + 
  geom_text(aes(x = 0, y = 0), label = "texte", hjust = 1, vjust = 0) +
  labs(title = "Justification du texte",
       subtitle = "hjust = 1 ; vjust = 0")

p + 
  geom_text(aes(x = 0, y = 0), label = "texte", hjust = 1, vjust = 0.5) +
  labs(title = "Justification du texte",
       subtitle = "hjust = 1 ; vjust = 0.5")

p + 
  geom_text(aes(x = 0, y = 0), label = "texte", hjust = 1, vjust = 1) +
  labs(title = "Justification du texte",
       subtitle = "hjust = 1 ; vjust = 1")

# En utilisant des valeurs numeriques superieures a 1 ou inferieures a 0,
# le bord du texte va s'eloigner des positions definies en 'x' et/ou 'y'.

p + 
  geom_text(aes(x = 0, y = 0), label = "texte", hjust = 0, vjust = 0.5) +
  labs(title = "Justification du texte",
       subtitle = "hjust = 0 ; vjust = 0.5")

p + 
  geom_text(aes(x = 0, y = 0), label = "texte", hjust = -0.5, vjust = 0.5) +
  labs(title = "Justification du texte",
       subtitle = "hjust = -0.5 ; vjust = 0.5")

p + 
  geom_text(aes(x = 0, y = 0), label = "texte", hjust = -1, vjust = 0.5) +
  labs(title = "Justification du texte",
       subtitle = "hjust = -1 ; vjust = 0.5")

p + 
  geom_text(aes(x = 0, y = 0), label = "texte", hjust = 1, vjust = 0.5) +
  labs(title = "Justification du texte",
       subtitle = "hjust = 1 ; vjust = 0.5")

p + 
  geom_text(aes(x = 0, y = 0), label = "texte", hjust = 1.5, vjust = 0.5) +
  labs(title = "Justification du texte",
       subtitle = "hjust = 1.5 ; vjust = 0.5")

p + 
  geom_text(aes(x = 0, y = 0), label = "texte", hjust = 2, vjust = 0.5) +
  labs(title = "Justification du texte",
       subtitle = "hjust = 2 ; vjust = 0.5")

p + 
  geom_text(aes(x = 0, y = 0), label = "texte", hjust = 0.5, vjust = 0) +
  labs(title = "Justification du texte",
       subtitle = "hjust = 0.5 ; vjust = 0")

p + 
  geom_text(aes(x = 0, y = 0), label = "texte", hjust = 0.5, vjust = -0.5) +
  labs(title = "Justification du texte",
       subtitle = "hjust = 0.5 ; vjust = -0.5")

p + 
  geom_text(aes(x = 0, y = 0), label = "texte", hjust = 0.5, vjust = -1) +
  labs(title = "Justification du texte",
       subtitle = "hjust = 0.5 ; vjust = -1")

p + 
  geom_text(aes(x = 0, y = 0), label = "texte", hjust = 0.5, vjust = 1) +
  labs(title = "Justification du texte",
       subtitle = "hjust = 0.5 ; vjust = 1")

p + 
  geom_text(aes(x = 0, y = 0), label = "texte", hjust = 0.5, vjust = 1.5) +
  labs(title = "Justification du texte",
       subtitle = "hjust = 0.5 ; vjust = 1.5")

p + 
  geom_text(aes(x = 0, y = 0), label = "texte", hjust = 0.5, vjust = 2) +
  labs(title = "Justification du texte",
       subtitle = "hjust = 0.5 ; vjust = 2")

# Il est egalement possible d'utiliser des valeurs numeriques 'intermediaires',
# comme 0.25, 0.75, -0.25, -0.75 :

p + 
  geom_text(aes(x = 0, y = 0), label = "texte", hjust = 0.5, vjust = 0.5) +
  labs(title = "Justification du texte",
       subtitle = "hjust = 0.5 ; vjust = 0.5")

p + 
  geom_text(aes(x = 0, y = 0), label = "texte", hjust = 0, vjust = 0) +
  labs(title = "Justification du texte",
       subtitle = "hjust = 0 ; vjust = 0")

p + 
  geom_text(aes(x = 0, y = 0), label = "texte", hjust = 0.25, vjust = 0.25) +
  labs(title = "Justification du texte",
       subtitle = "hjust = 0.25 ; vjust = 0.25")

# Reprenons le code du barplot avec les etiquettes de frequences. Pour alleger
# le code, nous commencons par assigner le code du plot - sans la fonction
# geom_text() - dans un objet 'bp' : 

bp <- penguins |> 
  ggplot(aes(x = fct_infreq(species),
             fill = species)) +
  geom_bar(width = 0.75,
           show.legend = FALSE) +
  scale_fill_manual(values = my_cols) +
  labs(title = "Nombre d'individus par espece",
       subtitle = "Pour 3 especes de pingouins de l'archipel Palmer",
       caption = "Donnees issues du package {palmerpenguins}",
       x = "",
       y = "Frequence") +
  theme_bw()

# Ajoutons les etiquettes : 

bp + 
  geom_text(stat = "count",
            aes(label = after_stat(count))) 

# Les etiquettes sont positionnees de la maniere suivante, avec par defaut
# un alignement du milieu de la valeur numeriques sur les valeurs 'x' et 'y' : 

# '152' -> x = 1 ; y = 152
# '124' -> x = 2 ; y = 124
# '68'  -> x = 3 ; y = 68

# Pour placer les etiquettes au-dessus du bord superieur des barres, en laissant
# un petit espace entre l'etiquette et le bord superieur de la barre, nous allons
# modifier 'vjust' pour 'eloigner' les etiquettes de la position definie en 'y'.

bp + 
  geom_text(stat = "count",
            aes(label = after_stat(count)),
            vjust = 0) 

bp + 
  geom_text(stat = "count",
            aes(label = after_stat(count)),
            vjust = -0.2) 

# Nous pourrions egalement placer les etiquettes a l'interieur des barres : 

bp + 
  geom_text(stat = "count",
            aes(label = after_stat(count)),
            vjust = 1.2) 

# 🔠 MODIFIER L'APPARENCE DU TEXTE ----------------------------------------

# Pour faciliter la lecture des frequences, nous allons modifier l'apparence 
# du texte : 
# - sa taille a l'aide du parametre 'size' 
# - sa couleur a l'aide du parametre 'color'

bp + 
  geom_text(stat = "count",
            aes(label = after_stat(count)),
            vjust = 1.2) 

bp + 
  geom_text(stat = "count",
            aes(label = after_stat(count)),
            vjust = 1.2,
            size = 8, color = "white", f) 

# 🎨 MODIFIER L'APPARENCE DU PLOT -----------------------------------------

# Les themes predefinis dans ggplot2 permettent de modifier l'apparence
# generale d'un plot (theme_bw(), theme_minimal(), ...)

# La fonction theme() permet de modifier tous les parametres du plot.

# Les plots generes a l'aide de ggplot2 se divisent en 4 zones, dont chacune
# pourra etre modifie : 

# 1) 'panel' : la zone qui contient la representation graphique 
# 2) 'plot' : la zone qui encadre le 'panel'
# 3) 'axis' : les axes x et y 
# 4) 'legend' : la legende de la figure

# Pour chaque zone d'une figure, il existe des arguments permettant de modifier
# les differents elements de la zone. Ces arguments commencent par le nom de la
# zone : panel.margin, plot.title, axis.ticks, legend.position, ...

# Dans ces fonctions, des parametres vont permettre de preciser quel type d'element
# est modifie : element_line(), element_rect(), element_text().

# Nous allons passer en revue les differents parametres qui peuvent etre
# modifies. Nous creons pour cela un scatter plot simple : 

my_cols <- c("Adelie" = "darkorange",
             "Chinstrap" = "purple",
             "Gentoo" = "cyan4")

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
  scale_color_manual(values = my_cols)

p


## PANEL ------------------------------------------------------------------

# panel.background : arriere-plan du 'panel' (concerne egalement 
# l'arriere-plan de la legende). 

p +
  theme(panel.background = element_rect(fill = "darkblue"))

p +
  theme(panel.background = element_rect(color = "darkblue"))

p +
  theme(panel.background = element_rect(color = "darkblue",
                                        linewidth = 2,
                                        linetype = "dashed"))

# panel.border : bordure du 'panel' (attention, bien preciser 
# 'fill = NA' pour que l'interieur du 'panel' soit visible).
# Permet de modifier la bordure du 'panel' sans modifier la bordure
# de la legende :

p +
  theme(panel.border = element_rect(color = "darkblue"))

p +
  theme(panel.border = element_rect(color = "darkblue", fill = NA))

p +
  theme(panel.border = element_rect(color = "darkblue", fill = NA,
                                    linewidth = 2))

p +
  theme(panel.border = element_rect(color = "darkblue", fill = NA,
                                    linewidth = 2, linetype = "dotted"))

# panel.grid : grilles a l'interieur du 'panel'. 
# Il est possible de modifier les grilles :
# - selon leur position (axe x ou axe y)
# - selon les graduations (majeures ou mineures).
# La fonction element_blank() permet de supprimer un parametre.

p +
  theme(panel.grid = element_line(color = "darkblue"))

p +
  theme(panel.grid = element_blank())

p +
  theme(panel.grid.major = element_blank())

p +
  theme(panel.grid.major = element_line(color = "darkblue"))

p +
  theme(panel.grid.minor = element_blank())

p +
  theme(panel.grid.minor = element_line(color = "darkblue"))

p +
  theme(panel.grid.major.x = element_blank())

p +
  theme(panel.grid.major.x = element_line(color = "darkblue"))

p +
  theme(panel.grid.major.y = element_blank())

p +
  theme(panel.grid.major.y = element_line(color = "darkblue"))

p +
  theme(panel.grid.minor.x = element_blank())

p +
  theme(panel.grid.minor.x = element_line(color = "darkblue"))

p +
  theme(panel.grid.minor.y = element_blank())

p +
  theme(panel.grid.minor.y = element_line(color = "darkblue"))

## PLOT -------------------------------------------------------------------

# plot.background : arriere-plan du 'plot' (ne concerne pas 
# l'arriere-plan de la legende). 

p +
  theme(plot.background = element_rect(fill = "darkblue"))

p +
  theme(plot.background = element_rect(fill = "darkblue", color = "darkblue"))

p +
  theme(plot.background = element_rect(fill = "darkblue",
                                       color = "lightblue", linewidth = 5))

# plot.title : modifier l'apparence et/ou la position du titre du plot :

p +
  theme(plot.title = element_text(face = "plain"))

p +
  theme(plot.title = element_text(face = "bold"))

p +
  theme(plot.title = element_text(face = "italic"))

p +
  theme(plot.title = element_text(face = "bold.italic"))

p +
  theme(plot.title = element_text(color = "red"))

p +
  theme(plot.title = element_text(size = 4))

p +
  theme(plot.title = element_text(size = 16))

# L'argument 'hjust' permet de modifier la justification horizontale du titre,
# par rapport au milieu de la zone 'panel' (par defaut : 'hjust = 0') : 

p + 
  theme(plot.title = element_text(hjust = 0))

p + 
  theme(plot.title = element_text(hjust = 0.5))

p + 
  theme(plot.title = element_text(hjust = 1))

# L'argument 'vjust' permet de modifier la justification verticale du titre
# (par defaut : 'vjust = 1') : 

p + 
  theme(plot.title = element_text(vjust = 1))

p + 
  theme(plot.title = element_text(vjust = 0.5))

p + 
  theme(plot.title = element_text(vjust = 0))

# Pour un alignement du titre par rapport au milieu de la zone 'plot', il
# faut preciser 'plot.title.position = "plot"' (par defaut, 
# 'plot.title.position = "panel"') :

p +
  theme(plot.title = element_text(hjust = 0.5))

p +
  theme(plot.title = element_text(hjust = 0.5),
        plot.title.position = "plot")

# L'argument 'plot.title.position' concerne le titre et le sous-titre. 
# L'argument 'plot.subtitle' permet de modifier la justification du sous-titre : 

p +
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        plot.title.position = "plot")

# L'argument 'margin' permet de modifier les marges autour du titre (et/ou du
# sous-titre).
# Cet argument utilise une fonction 'margin()', dans laquelle il faut preciser
# une ou plusieurs marges a l'aide de lettres et de valeurs numeriques : 
# 'margin(t = ..., r = ..., b = ..., l = ...)' pour top, right, bottom, left.
# Il est possible de preciser :
# - les quatres marges : 'margin(t = 10, r = 10, b = 10, l = 1O)'
# - une ou plusieurs marges : 'margin(t = 10, b = 10)'
# - les quatres marges a l'aide uniquement des valeurs numeriques : 
# 'margin(10, 10, 10, 10)'.
# Dans ce dernier cas, l'ordre est le suivant : top, right, bottom, left.

p +
  theme(plot.title = element_text(margin = margin(t = 10, b = 10)))

p +
  theme(plot.title = element_text(margin = margin(10, 0, 10, 0)))

# Les marges peuvent egalement etre modifiees pour le sous-titre : 

p +
  theme(plot.title = element_text(margin = margin(10, 0, 5, 0)),
        plot.subtitle = element_text(margin = margin(0, 0, 10, 0)))

# L'argument 'plot.caption' permet de modifier l'apparence et la position
# de la 'note de bas de page' : 

p +
  theme(plot.caption = element_text(face = "italic",
                                    hjust = 0.5,
                                    margin = margin(t = 10, b = 5)),
        plot.caption.position = "plot")

# L'argument 'plot.margin' permet de modifier les marges de la zone de 'plot' :

p +
  theme(plot.margin = margin(t = 5, r = 10, b = 5, l = 10))

## AXIS -------------------------------------------------------------------

# L'argument 'axis.title' permet de modifier l'apparence et la position des 
# titres d'axes : 

p +
  theme(axis.title = element_text(color = "red"))

# Les arguments 'hjust' permet de modifier la justification
# des titres des axes (penser a l'orientation des axes) :

# 'hjust = 0.5' -> milieu du titre centre sur le milieu de l'axe
# 'hjust = 0' -> milieu du titre centre sur le bord gauche de l'axe
# 'hjust = 1' -> milieu du titre centre sur le bord droit de l'axe

p +
  theme(axis.title = element_text(color = "red", hjust = 0.5))

p +
  theme(axis.title = element_text(color = "red", hjust = 0))

p +
  theme(axis.title = element_text(color = "red", hjust = 1))

# Pour modifier les marges autour des titres d'axes, il faut travailler
# par axe : 

p +
  theme(axis.title.x = element_text(color = "red",
                                    margin = margin(t = 10)))

p +
  theme(axis.title.y = element_text(color = "red",
                                    margin = margin(r = 10)))

# Contrairement a 'hjust', 'margin' ne tient pas compte de l'orientation 
# des axes !

# L'argument 'axis.text' permet de modifier la position et l'apparence du texte
# des axes : 

p +
  theme(axis.text = element_text(color = "red"))

p +
  theme(axis.text.x = element_text(color = "red",
                                   margin = margin(t = 5),
                                   angle = 45))

# L'argument 'axis.ticks' permet de modifier l'apparence des reperes de 
# graduations : 

p +
  theme(axis.ticks = element_blank())

p +
  theme(axis.ticks = element_line(color = "red",
                                  linewidth = 2))

# L'argument 'axis.ticks.length' permet de modifier la longueur des reperes
# de graduations : 

p + 
  theme(axis.ticks = element_line(color = "red"),
        axis.ticks.length = unit(0.25, "cm"))

# Il est possible de parametrer les reperes de graduations en fonction de 
# l'axe : 

p +
  theme(axis.ticks.x = element_line(color = "red"),
        axis.ticks.length.x = unit(0.25, "cm"),
        axis.ticks.y = element_line(color = "darkgreen"),
        axis.ticks.length.y = unit(0.25, "cm"))

## LEGEND -----------------------------------------------------------------

p

p +
  theme(legend.background = element_rect(fill = "darkblue"),
        legend.key = element_rect(fill = "darkblue"),
        legend.key.size = unit(0.5, "cm"),
        legend.title = )





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
