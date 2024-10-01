# ATELIERS CODONS
# VISUALISATION DE DONNEES A L'AIDE DE GGPLOT2
# CREER ET SAUVEGARDER DES PLOTS A L'AIDE DE BOUCLES 'FOR'
# 2024-09-30

# 📦 INSTALLER LES PACKAGES -----------------------------------------------

install.packages("tidyverse")  # manipulation, visualisation
install.packages("palmerpenguins")  # jeux de donnees


# 📦 CHARGER LES PACKAGES$ ------------------------------------------------

library(tidyverse)  
library(palmerpenguins)

# 🔽 IMPORTER LES DONNEES -------------------------------------------------

penguins <- palmerpenguins::penguins

# 🔃 PRINCIPE D'UNE BOUCLE 'FOR' ------------------------------------------

# Plutot que de copier-coller du code, il est possible de l'executer dans 
# une boucle 'for'.

# Une boucle necessite deux elements : 
# - les items sur lesquels le code va s'executer
# - le code a executer

# Pour comprendre le fonctionnement d'une boucle 'for', nous allons voir 
# comment creer une boucle pour imprimer les nombres de 0 a 10.

# La fonction 'print()' permet d'afficher dans la console le contenu des
# parentheses : 

print(0)
print("ce texte")

# Pour afficher les nombres de 0 a 10, nous pouvons multiplier les commandes
# 'print()' : 

print(0)
print(1)
print(2)
print(3)
print(4)
print(5)
print(6)
print(7)
print(8)
print(9)
print(10)

# Une boucle s'ecrit de la maniere suivante : 

# 'for (i in liste items) {code a executer}'

# Le 'i' peut etre remplace par ce que l'on souhaite : 'nb', 'nombre', ...
# Il faut simplement utiliser le meme nom dans le code : 

for (i in 1:10) {
  
  print(i)
  
}

for (nombre in 1:10) {
  
  print(nombre)
  
}

# Une boucle permet d'executer le meme bloc de code en modifiant les arguments.
# Calculons par exemple les carres des nombres de 1 a 10 : 

for (i in 1:10) {
  
  carre <- i^2
  
  print(paste0(i, "^2 = ", carre))
  
}

# 📊 CREATION D'UN PLOT ---------------------------------------------------

# Nous commencons par creer un plot pour ajuster les parametres, avant de
# modifier le code pour l'executer dans une boucle.

my_cols <- c("Adelie" = "darkorange",
             "Chinstrap" = "purple",
             "Gentoo" = "cyan4")

p <- penguins |> 
  ggplot(aes(x = flipper_length_mm,
             y = bill_length_mm,
             col = species)) +
  geom_point(show.legend = FALSE) +  # la legende n'est pas necessaire 
  labs(title = "Rapport entre la longueur de l'aile et la longueur du bec",
       subtitle = "Pour 3 especes de pingouins de l'archipel Palmer",
       caption = "Donnees issues du package {palmerpenguins}",
       x = "Longueur de l'aile (mm)",
       y = "Longueur du bec (mm)",
       col = "Espece") +
  scale_color_manual(values = my_cols) +
  theme_bw()

# Sauvegardons le plot pour nous assurer du rendu visuel : 

ggsave(filename = "05-FIGURES/dimensions_ailes.png", plot = p,
       dpi = 320, width = 12, height = 6)

# 📊🔃 CREATION DES PLOTS DANS UNE BOUCLE ---------------------------------

# Nous souhaitons creer et sauvegarder un plot par espece.

# Avant de creer les plots, nous allons extraire les valeurs min et max des
# deux variables d'interet, afin de conserver la meme echelle pour nos trois 
# plots et ainsi faciliter la comparaison entre les plots.
# Les fonctions 'xlim' et 'ylim' permettent de parametrer les echelles des 
# axes x et y d'un plot.

# Les fonctions 'min()' et 'max()' permettent d'extraire les valeurs min et max
# d'un vecteur. Attention ! Nos donnees contiennent des donnees manquantes,
# nous allons donc utiliser l'argument 'na.rm = TRUE'.

flipper_length_mm_max <- max(penguins$flipper_length_mm, na.rm = TRUE)
flipper_length_mm_min <- min(penguins$flipper_length_mm, na.rm = TRUE)
bill_length_mm_max <- max(penguins$bill_length_mm, na.rm = TRUE)
bill_length_mm_min <- min(penguins$bill_length_mm, na.rm = TRUE)

# Pour laisser un peu de marge autour des valeurs extremes, nous arrondissons a 
# l'aide de la fonction 'round_any()' du package {plyr}, qui permet d'arrondir
# une valeur au multiple le plus proche, soit superieur ('f = ceiling'), soit
# inferieur ('f = floor') : 

flipper_length_mm_max <- plyr::round_any(x = flipper_length_mm_max, accuracy = 10, f = ceiling)
flipper_length_mm_min <- plyr::round_any(x = flipper_length_mm_min, accuracy = 10, f = floor)
bill_length_mm_max <- plyr::round_any(x = bill_length_mm_max, accuracy = 10, f = ceiling)
bill_length_mm_min <- plyr::round_any(x = bill_length_mm_min, accuracy = 10, f = floor)

# Commencons par extraire la liste des especes, c'est cette liste (ce vecteur)
# que nous utiliserons comme items pour executer la boucle.

species_list <- penguins |> 
  mutate(species = as.character(species)) |>  # transformer 'species' en variable de type 'character'
  distinct(species) |>  # extraire les valeurs uniques 
  arrange(species) |>  # trier par ordre alphabetique
  pull()  # extraire le contenu de la colonne dans un vecteur

# Pour construire la boucle, nous reprenons le code du plot : 

my_cols <- c("Adelie" = "darkorange",
             "Chinstrap" = "purple",
             "Gentoo" = "cyan4")

p <- penguins |> 
  ggplot(aes(x = flipper_length_mm,
             y = bill_length_mm,
             col = species)) +
  geom_point(show.legend = FALSE) +  # la legende n'est pas necessaire 
  labs(title = "Rapport entre la longueur de l'aile et la longueur du bec",
       subtitle = "Pour 3 especes de pingouins de l'archipel Palmer",
       caption = "Donnees issues du package {palmerpenguins}",
       x = "Longueur de l'aile (mm)",
       y = "Longueur du bec (mm)",
       col = "Espece") +
  scale_color_manual(values = my_cols) +
  theme_bw()

ggsave(filename = "05-FIGURES/dimensions_ailes.png", plot = p,
       dpi = 320, width = 12, height = 6)

# Le premier bloc de code, dans lequel les couleurs sont definies, ne sera pas 
# place dans la boucle, car il ne varie pas en fonction des especes.

my_cols <- c("Adelie" = "darkorange",
             "Chinstrap" = "purple",
             "Gentoo" = "cyan4")

# Nous allons construire la boucle petit a petit en adaptant le code.
# Pour tester le code au fur et a mesure, il peut etre utile de placer au debut 
# du code entre accolades une 'definition' de valeur pour 'sp'. Cette ligne 
# de code pourra etre commentee puis supprimee quand le code sera operationnel.
# Plutot que d'executer la boucle, nous executons les differents blocs de code a
# l'interieur de la boucle pour nous assurer de leur bon fonctionnement.

# Il nous faut tout d'abord filtrer le dataset pour ne conserver que les observations
# appartenant a l'espece d'interet :

for (sp in species_list) {
  
  sp <- species_list[1]
  
  penguins |> 
    filter(species == sp) |> 
    distinct(species)  # s'assurer que le filtre a bien ete applique
  
}

# Nous ajoutons le code permettant d'afficher les points : 

for (sp in species_list) {
  
  sp <- species_list[1]
  
  penguins |> 
    filter(species == sp) |> 
    ggplot(aes(x = flipper_length_mm,
               y = bill_length_mm,
               col = species)) +
    geom_point(show.legend = FALSE)
  
}

# Nous ajoutons les couleurs : 

for (sp in species_list) {
  
  sp <- species_list[1]
  
  penguins |> 
    filter(species == sp) |> 
    ggplot(aes(x = flipper_length_mm,
               y = bill_length_mm,
               col = species)) +
    geom_point(show.legend = FALSE) +
    scale_color_manual(values = my_cols)
  
}

# Modifions les echelles des axes pour qu'elle soit identique quelle que 
# soit l'espece representee : 

for (sp in species_list) {
  
  sp <- species_list[1]
  
  penguins |> 
    filter(species == sp) |> 
    ggplot(aes(x = flipper_length_mm,
               y = bill_length_mm,
               col = species)) +
    geom_point(show.legend = FALSE) +
    scale_color_manual(values = my_cols) +
    xlim(flipper_length_mm_min, flipper_length_mm_max) +
    ylim(bill_length_mm_min, bill_length_mm_max)
  
}

# Nous allons a present ajouter les etiquettes. Il nous faut adapter le contenu
# des etiquettes pour afficher le nom de l'espece d'interet.
# Nous utilisons pour cela la fonction 'paste0()' qui permet de concatener du 
# texte 'brut' avec des valeurs 'dynamiques', dans notre cas le nom de l'espece
# qui se trouve dans l'item 'sp'

# Comme la legende est supprimee, nous n'avons pas besoin de l'etiquette 'col = "Espece"' : 

for (sp in species_list) {
  
  sp <- species_list[1]
  
  penguins |> 
    filter(species == sp) |> 
    ggplot(aes(x = flipper_length_mm,
               y = bill_length_mm,
               col = species)) +
    geom_point(show.legend = FALSE) +
    scale_color_manual(values = my_cols) +
    xlim(flipper_length_mm_min, flipper_length_mm_max) +
    ylim(bill_length_mm_min, bill_length_mm_max) +
    labs(title = "Rapport entre la longueur de l'aile et la longueur du bec",
         subtitle = paste0("Pour l'espece ", sp),
         caption = "Donnees issues du package {palmerpenguins}",
         x = "Longueur de l'aile (mm)",
         y = "Longueur du bec (mm)")
  
}

# Pour s'assurer que le plot sera different pour une autre espece, nous 
# modifions la definition de l'item 'sp' : 

for (sp in species_list) {
  
  sp <- species_list[2]
  
  penguins |> 
    filter(species == sp) |> 
    ggplot(aes(x = flipper_length_mm,
               y = bill_length_mm,
               col = species)) +
    geom_point(show.legend = FALSE) +
    scale_color_manual(values = my_cols) +
    xlim(flipper_length_mm_min, flipper_length_mm_max) +
    ylim(bill_length_mm_min, bill_length_mm_max) +
    labs(title = "Rapport entre la longueur de l'aile et la longueur du bec",
         subtitle = paste0("Pour l'espece ", sp),
         caption = "Donnees issues du package {palmerpenguins}",
         x = "Longueur de l'aile (mm)",
         y = "Longueur du bec (mm)")
  
}

# Notre code est presque pret, il nous reste a assigner le code servant a creer
# le plot dans un objet et a exporter cet objet dans un fichier image.

for (sp in species_list) {
  
  sp <- species_list[1]
  
  p <- penguins |> 
    filter(species == sp) |> 
    ggplot(aes(x = flipper_length_mm,
               y = bill_length_mm,
               col = species)) +
    geom_point(show.legend = FALSE) +
    scale_color_manual(values = my_cols) +
    xlim(flipper_length_mm_min, flipper_length_mm_max) +
    ylim(bill_length_mm_min, bill_length_mm_max) +
    labs(title = "Rapport entre la longueur de l'aile et la longueur du bec",
         subtitle = paste0("Pour l'espece ", sp),
         caption = "Donnees issues du package {palmerpenguins}",
         x = "Longueur de l'aile (mm)",
         y = "Longueur du bec (mm)")
  
  ggsave(filename = paste0("05-FIGURES/aile_vs_bec_", sp, ".png"), plot = p,
         dpi = 320, width = 12, height = 6)
  
}

# Tout le code fonctionne pour une espece, nous commentons (ou supprimons) la
# definition de l'item 'sp' et executons la boucle :

for (sp in species_list) {
  
  # sp <- species_list[1]
  
  p <- penguins |> 
    filter(species == sp) |> 
    ggplot(aes(x = flipper_length_mm,
               y = bill_length_mm,
               col = species)) +
    geom_point(show.legend = FALSE) +
    scale_color_manual(values = my_cols) +
    xlim(flipper_length_mm_min, flipper_length_mm_max) +
    ylim(bill_length_mm_min, bill_length_mm_max) +
    labs(title = "Rapport entre la longueur de l'aile et la longueur du bec",
         subtitle = paste0("Pour l'espece ", sp),
         caption = "Donnees issues du package {palmerpenguins}",
         x = "Longueur de l'aile (mm)",
         y = "Longueur du bec (mm)")
  
  ggsave(filename = paste0("05-FIGURES/aile_vs_bec_", sp, ".png"), plot = p,
         dpi = 320, width = 12, height = 6)
  
}

