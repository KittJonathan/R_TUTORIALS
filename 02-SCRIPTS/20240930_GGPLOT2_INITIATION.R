# ATELIERS CODONS
# VISUALISATION DE DONNEES A L'AIDE DE GGPLOT2
# INITIATION
# 2024-09-30

# 📦 INSTALLER LES PACKAGES -----------------------------------------------

install.packages("tidyverse")  # manipulation, visualisation
install.packages("palmerpenguins")  # jeux de donnees

# 📦 CHARGER LES PACKAGES$ ------------------------------------------------

library(tidyverse)  
library(palmerpenguins)

# Pour charger plusieurs packages (installer le package "pacman") :
pacman::p_load(tidyverse, palmerpenguins)

# 🔽 IMPORTER LES DONNEES -------------------------------------------------

# Le package "palmerpenguins" contient 2 datasets :
# - penguins_raw : données brutes
# - penguins : données nettoyees

# Pour cette initiation au {tidyverse} nous allons utiliser les donnees
# deja netoyees.

penguins <- palmerpenguins::penguins

# 🔎 EXPLORATION DES DONNEES ----------------------------------------------

# La fonction glimpse() du package {dplyr} affiche egalement la structure du
# dataset :
dplyr::glimpse(penguins)

# 📊 SCATTER PLOT SIMPLE --------------------------------------------------

# Un ggplot se construit couche par couche.
# Pour ajouter une couche, utiliser un '+'.

# La fonction ggplot() permet d'initialiser un ggplot :
ggplot()

# La construction d'un ggplot basique necessite au moins 3 elements : 
# 1) Le dataset 
# 2) Les variables a representer
# 3) La facon de representer les variables

# Une des notions les plus importantes dans ggplot2 est celle de 'mapping' :
# Les variables sont 'mappees' sur les axes.

# Le mapping s'effectue de la maniere suivante : mapping = aes(...)
# La fonction aes() sert a preciser les parametres esthetiques du plot : les
# variables a representer, les couleurs, les formes, les tailles, ...
# Tout ce qui est precise dans la fonction aes() sera 'mappe', applique aux
# varibles.

# Continuons a construire notre plot, en ajoutant les informations au fur
# et a mesure: 

ggplot(data = penguins)  # 1) le dataset

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,  # 2) les variables
                     y = bill_length_mm))

# Ce code 'prepare' le plot en affichant les legendes des axes et en 
# calculant les echelles des axes x et y.

# Le dernier element a preciser, la facon de representer les variables.
# Ce parametre se precise a l'aide d'une fonction 'geometrique' : geom_*().
# Dans notre cas, nous souhaitons representer nos variables par des points, nous
# utilisons donc la fonction geom_point().
# Cette fonction est une nouvelle couche :

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,
                     y = bill_length_mm)) +
  geom_point()

# Dans la console, nous pouvons lire que 2 observations ont ete retirees du
# plot a cause de la presence de donnees manquantes.

# 🎨 COULEURS -------------------------------------------------------------

# Il existe deux manieres d'ajouter de la couleur a un plot : 

# 1) Appliquer une meme couleur a l'ensemble des points :

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,
                     y = bill_length_mm)) +
  geom_point(color = "cyan4")

# 2) Appliquer une couleur par classe pour une variable categorielle. Nous 
# pouvons par exemple afficher une couleur par espece. Dans ce cas,
# il faut 'mapper' le parametre couleur dans la fonction aes() :

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,
                     y = bill_length_mm,
                     color = species)) +
  geom_point()

# Une couleur peut etre precisee de trois manieres : 

# 1) a l'aide d'un nom :

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,
                     y = bill_length_mm)) +
  geom_point(color = "cyan4")

# 2) a l'aide des valeurs RGB (Red - Green - Blue) : 

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,
                     y = bill_length_mm)) +
  geom_point(color = rgb(red = 0, green = 139, blue = 139,
                         maxColorValue = 255))

# 3) a l'aide d'un code hexadecimal : 

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,
                     y = bill_length_mm)) +
  geom_point(color = "#008B8B")

# Les versions recentes de RStudio permettent d'afficher directement dans le 
# code l'apercu de la couleur : 
# Tools > Global Options > Code > Display > Enable preview of named and hexadecimal colors

# Il est possible de convertir les differents formats :

col2rgb("cyan4")  # nom -> RGB
rgb(red = 0, green = 139, blue = 139, maxColorValue = 255)  # RGB -> hex

# L'argument 'alpha' permet d'ajouter de la transparence aux points.
# Cet argument prend une valeur numerique entre 0 (transparent) et 1 (opaque) :

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,
                     y = bill_length_mm)) +
  geom_point(color = "#008B8B", alpha = 0)

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,
                     y = bill_length_mm)) +
  geom_point(color = "#008B8B", alpha = 1)

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,
                     y = bill_length_mm)) +
  geom_point(color = "#008B8B", alpha = 0.5)

# Il est egalement possible de 'mapper' la transparence a une variable 
# quantitative : 

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,
                     y = bill_length_mm,
                     color = species, alpha = body_mass_g)) +
  geom_point()

# Si une variable qualitative est mappee a la transparence, le plot est
# genere mais la console affiche un message d'avertissement : 

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,
                     y = bill_length_mm,
                     color = species, alpha = island)) +
  geom_point()

# 📏 TAILLE ---------------------------------------------------------------

# Comme pour la couleur, la taille des points peut etre modifiee de deux
# manieres :

# 1) en appliquant le meme parametre a l'ensemble des points : 

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,
                     y = bill_length_mm)) +
  geom_point(color = "cyan4",
             size = 4)


# 2) en 'mappant' une variable quantitative sur la taille : 

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,
                     y = bill_length_mm,
                     size = body_mass_g)) +
  geom_point(color = "cyan4")

# ⏹️ FORME ----------------------------------------------------------------

# Les observations du plot peuvent etre representes par differentes formes : 

vignette("ggplot2-specs")

# Une 'vignette' est une documentation detaillee permettant de voir comment
# utiliser une fonction et ses arguments. 

# Pour les formes 0 a 14, la couleur est appliquee au contour : 

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,
                     y = bill_length_mm)) +
  geom_point(color = "cyan4",
             shape = 14)

# Pour les formes 15 a 20, la couleur est appliquee a l'interieur de la forme :

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,
                     y = bill_length_mm)) +
  geom_point(color = "cyan4",
             shape = 20)

# Pour les formes 21 a 24, la couleur est appliquee soit a la bordure ('color'),
# soit a l'interieur ('fill'). Si l'argument 'fill' est le seul precise, le 
# contour sera par defaut 'color = "black"': 

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,
                     y = bill_length_mm)) +
  geom_point(color = "cyan4",
             shape = 24)

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,
                     y = bill_length_mm)) +
  geom_point(fill = "cyan4",
             shape = 24)

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,
                     y = bill_length_mm)) +
  geom_point(color = "cyan4", fill = "lightgreen",
             shape = 24)

# Pour ces formes 21 a 24, un troisieme argument permet de modifier la largeur du
# contour : 'stroke = ..."

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,
                     y = bill_length_mm)) +
  geom_point(color = "cyan4", fill = "lightgreen", stroke = 1,
             shape = 24)

# Comme pour la couleur et la taille, la forme peut soit etre appliquee a 
# l'ensemble des points, soit etre 'mappee' a une variable qualitative : 

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,
                     y = bill_length_mm)) +
  geom_point(color = "cyan4",
             shape = 24)

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,
                     y = bill_length_mm,
                     shape = species)) +
  geom_point(color = "cyan4")

# La forme ne peut pas etre 'mappee' a une variable quantitative : 

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,
                     y = bill_length_mm,
                     shape = body_mass_g)) +
  geom_point(color = "cyan4")

# Il est possible de mapper ces differents elements (couleur, taille, forme) a
# differentes variables (mais cela peut compliquer la lecture du plot) : 

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,
                     y = bill_length_mm,
                     color = species,
                     size = body_mass_g,
                     shape = island)) +
  geom_point()

# 🔃 ORDRE DU CODE --------------------------------------------------------

# Il existe differentes facons d'ecrire le code pour creer un meme plot :

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,
                     y = bill_length_mm,
                     color = species)) +
  geom_point()

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm,
                     y = bill_length_mm,
                     color = species)) +
  geom_point(mapping = aes(color = species))

ggplot(data = penguins) +
  geom_point(mapping = aes(x = flipper_length_mm,
                           y = bill_length_mm,
                           color = species))

# Il est egalement possible d'utiliser un pipe '|>'. Cette maniere de faire
# permet d'enchainer l'importation des donnees, leur nettoyage, et la creation
# du plot.
# Attention ! Nous utilisons un pipe pour initialiser le plot, mais nous 
# continuons a utiliser le '+' pour ajouter des couches au plot :

penguins |> 
  ggplot(mapping = aes(x = flipper_length_mm,
                       y = bill_length_mm,
                       color = species)) +
  geom_point()

# Le 'mapping = ...' n'est pas indispensable : 

penguins |> 
  ggplot(aes(x = flipper_length_mm,
             y = bill_length_mm,
             color = species)) +
  geom_point()

# L'argument 'color' peut s'ecrire de plusieurs facons : 'color', 'colour' ou 'col' :

penguins |> 
  ggplot(aes(x = flipper_length_mm,
             y = bill_length_mm,
             color = species)) +
  geom_point()

penguins |> 
  ggplot(aes(x = flipper_length_mm,
             y = bill_length_mm,
             colour = species)) +
  geom_point()

penguins |> 
  ggplot(aes(x = flipper_length_mm,
             y = bill_length_mm,
             col = species)) +
  geom_point()

# ⬅️ PLOT ET OBJET --------------------------------------------------------

# Comme tout ce que nous manipulons dans R (variables, vecteurs, matrices,
# data frames, fonctions, ...), le code servant a creer un plot peut etre
# assigne dans un objet.

p <- penguins |> 
  ggplot(aes(x = flipper_length_mm,
             y = bill_length_mm,
             col = species)) +
  geom_point()

p

# Cela permet de repartir d'un plot deja cree pour continuer a le modifier.

# ✒️ AJOUTER DES TITRES ---------------------------------------------------

# La fonction labs() permet d'ajouter (ou modifier) :
# - un titre au plot .............. : 'title = ...'
# - un sous-titre au plot ......... : 'subtitle = ...'
# - une 'note de bas de page' ..... : 'caption = ...'
# - un titre d'axe ................ : 'x = ...' et/ou 'y = ...'
# - un titre de legende ........... : '{param} = ...'

# Pour la legende, il faut reprendre le nom du parametre : 'col', 'shape', 
# 'size', ...

p +
  labs(title = "Rapport entre la longueur de l'aile et la longueur du bec",
       subtitle = "Pour 3 especes de pingouins de l'archipel Palmer",
       caption = "Donnees issues du package {palmerpenguins}",
       x = "Longueur de l'aile (mm)",
       y = "Longueur du bec (mm)",
       col = "Espece")

# 📊 BAR PLOT SIMPLE ------------------------------------------------------

# La fonction geom_bar() permet de generer un bar plot : 

penguins |> 
  ggplot(aes(x = species)) +
  geom_bar()

# L'argument 'width = ...' permet de modifier la largeur des barres : 

penguins |> 
  ggplot(aes(x = species)) +
  geom_bar(width = 0.75)

# Ajoutons les titres : 

penguins |> 
  ggplot(aes(x = species)) +
  geom_bar(width = 0.75) +
  labs(title = "Nombre d'individus par espece",
       subtitle = "Pour 3 especes de pingouins de l'archipel Palmer",
       caption = "Donnees issues du package {palmerpenguins}",
       x = "",
       y = "Frequence")


# 📊 BOX PLOT SIMPLE ------------------------------------------------------

# La fonction geom_boxplot() permet de creer un boxplot : 

penguins |> 
  ggplot(aes(x = species, y = body_mass_g)) +
  geom_boxplot()

# L'argument 'width = ...' permet de modifier la largeur des boites : 

penguins |> 
  ggplot(aes(x = species, y = body_mass_g)) +
  geom_boxplot(width = 0.5)

# Ajoutons les titres : 

penguins |> 
  ggplot(aes(x = species, y = body_mass_g)) +
  geom_boxplot(width = 0.5) +
  labs(title = "Repartition de la masse corporelle par espece",
     subtitle = "Pour 3 especes de pingouins de l'archipel Palmer",
     caption = "Donnees issues du package {palmerpenguins}",
     x = "",
     y = "Masse corporelle (g)")

# 📊 HISTOGRAMME SIMPLE ---------------------------------------------------

# La fonction geom_histogram() permet de creer un histogramme : 

penguins |> 
  ggplot(aes(x = body_mass_g)) +
  geom_histogram()

# Nous pouvons lire dans la console que le plot a été genere en utilisant
# 30 classes ('bins = 30').

# Nous pouvons modifier le nombre de classes : 

penguins |> 
  ggplot(aes(x = body_mass_g)) +
  geom_histogram(bins = 5)


penguins |> 
  ggplot(aes(x = body_mass_g)) +
  geom_histogram(bins = 20)

# Nous pouvons modifier la largeur des classes :  

penguins |> 
  ggplot(aes(x = body_mass_g)) +
  geom_histogram(binwidth = 500)

penguins |> 
  ggplot(aes(x = body_mass_g)) +
  geom_histogram(binwidth =  1000)

# Pour afficher un histogramme par espece, il faut 'mapper' la variable 'species'
# (variable qualitative) a un parametre esthetique de couleur ('col' ou 'fill') :

penguins |> 
  ggplot(aes(x = body_mass_g, col = species)) +
  geom_histogram()

penguins |> 
  ggplot(aes(x = body_mass_g, fill = species)) +
  geom_histogram()

# Pour faciliter la lecture, nous ajoutons de la transparence (Attention ! Nous
# ne 'mappons' par la transparance, nous l'appliquons a l'ensemble) : 

penguins |> 
  ggplot(aes(x = body_mass_g, fill = species)) +
  geom_histogram(alpha = 0.5)

# Les classes des histogrammes peuvent s'arranger de trois manieres : 

# 1) 'position = stack' :

penguins |> 
  ggplot(aes(x = body_mass_g, fill = species)) +
  geom_histogram(alpha = 0.5, position = "stack")

# 2) 'position = identity' :

penguins |> 
  ggplot(aes(x = body_mass_g, fill = species)) +
  geom_histogram(alpha = 0.5, position = "identity")

# 1) 'position = dodge' :

penguins |> 
  ggplot(aes(x = body_mass_g, fill = species)) +
  geom_histogram(alpha = 0.5, position = "dodge")

# Ajoutons les titres : 

penguins |> 
  ggplot(aes(x = body_mass_g, fill = species)) +
  geom_histogram(alpha = 0.5, position = "identity") +
  labs(title = "Distribution de la masse corporelle par espece",
       subtitle = "Pour 3 especes de pingouins de l'archipel Palmer",
       caption = "Donnees issues du package {palmerpenguins}",
       x = "Masse corporelle (g)",
       y = "Frequence")

# 🎨 THEMES ---------------------------------------------------------------

# ggplot2 dispose de differents themes permettant de modifier l'apparence 
# generale d'un plot. Les fonctions theme_*() permettent de choisir le theme
# (en ajoutant une couche) :

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
       col = "Espece")

p

p + theme_gray()  # theme par defaut (ou theme_grey())
p + theme_bw()
p + theme_classic()
p + theme_dark()
p + theme_light()
p + theme_linedraw()
p + theme_minimal()
p + theme_void()

# 💾 SAUVEGARDER UN PLOT --------------------------------------------------

# Un plot peut etre sauvegarde directement depuis la fenetre graphique de 
# RStudio : Export > ...

# Il est egalement possible d'utiliser la fonction ggsave(), en precisant 
# certains arguments : 
# - le nom du fichier dans lequel le plot sera exporte
# - le nom de l'objet contenant le plot a sauvegarder
# - la definition de l'ecran
# - la largeur du plot
# - la hauteur du plot

ggsave(filename = "05-FIGURES/ratio_aile_bec.png",
       plot = p,
       dpi = 320, width = 12, height = 6)

# Il est utile de sauvegarder un plot afin de s'assurer du rendu visuel, sans se 
# reposer uniquement sur l'apercu de la fenetre graphique. Cela permet d'operer aux
# ajustements necessaires pour rendre la figure plus lisible si necessaire (taille du texte en
# particulier).