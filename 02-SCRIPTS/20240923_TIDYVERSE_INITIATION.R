# ATELIERS CODONS
# INTRODUCTION AU TIDYVERSE
# INITIATION
# 2024-09-23

# 📦 INSTALLER LES PACKAGES -----------------------------------------------

install.packages("tidyverse")  # manipulation, visualisation
install.packages("palmerpenguins")  # jeux de donnees

# 📦 CHARGER LES PACKAGES$ ------------------------------------------------

library(tidyverse)  

# Dans la console s'affiche la liste des packages appartenant au tidyverse.

# Conflit = deux fonctions portant le meme nom qui appartiennent
# à deux packages différents. 
# La priorite est donnee au package charge en dernier.

# Namespace : le package auquel appartient la fonction est precise 
# package::fonction()

# Le namespace n'est pas obligatoire si le package est charge a l'aide de 
# library(package), mais il doit etre utilise si le package est installe
# sans etre charge.

# Pour du code qui sera partage, l'utilisation du namespace permet de clarifier
# le package de chaque fonction utilisee.

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

head(penguins)  # affiche les 6 premieres lignes du dataset
head(penguins, 2)

# Le 'tibble' est un format de data frame propre au tidyverse.
# L'affichage dans la console indique le type de donnees de chaque colonne.

tail(penguins)  # affiche les 6 dernieres lignes du dataset

str(penguins)  # affiche la structure du dataset

# La fonction glimpse() du package {dplyr} affiche egalement la structure du
# dataset :
dplyr::glimpse(penguins)

# ✅ FILTRER DES DONNEES ---------------------------------------------------

# Les fonctions appartenant au {tidyverse} s'utilisent de la maniere suivante :
# verbe(data, condition)

# La fonction filter() du package {dplyr} permet de selectionner un
# sous-ensemble d'observations (lignes) a l'aide de conditions :
dplyr::filter(penguins, body_mass_g == 4400)

# Les conditions peuvent etre multiples, separeees par des virgules ',' (ce
# qui equivaut a une intersection, un 'ET')
dplyr::filter(penguins, body_mass_g == 4400, species == "Adelie")

# Pour selectionner les observations qui correspondent a l'union ('OU') de deux
# ou plusieurs conditions, il faut utiliser l'operateur "|') :
dplyr::filter(penguins, body_mass_g == 4400,
              species == "Adelie" | species == "Chinstrap")

# La selection peut egalement se faire a l'aide de l'operateur '%in%', qui
# d'utiliser un vecteur :
dplyr::filter(penguins, body_mass_g == 4400,
              species %in% c("Adelie", "Chinstrap"))

# L'operateur '!' permet la negation d'une condition :
dplyr::filter(penguins, body_mass_g == 4400,
              !species %in% c("Adelie", "Chinstrap"))

# Cette commande est l'equivalente de 
dplyr::filter(penguins, body_mass_g == 4400, species == "Gentoo")

# La selection peut se faire a l'aide d'operateurs logiques :
dplyr::filter(penguins, body_mass_g > 6000)
dplyr::filter(penguins, body_mass_g >= 6000)
dplyr::filter(penguins, body_mass_g < 2900)
dplyr::filter(penguins, body_mass_g <= 2900)
dplyr::filter(penguins, body_mass_g == 6000)
dplyr::filter(penguins, body_mass_g != 6000)

# Attention ! Pour filtrer une variable numerique entre deux bornes, la 
# commande suivante renverra une erreur : 
dplyr::filter(penguins, 5500 <= body_mass_g <= 5600)

# Il faut preciser deux conditions, une par borne :
dplyr::filter(penguins, body_mass_g >= 5500, body_mass_g <= 5600)

# La fonction between() du package {dplyr} permet de filtrer une variable
# numerique entre deux bornes : 
dplyr::filter(penguins, dplyr::between(x = body_mass_g,
                                       left = 5500, right = 5600))

# 🪝 SELECTIONNER DES VARIABLES -------------------------------------------

# La fonction select() du package {dplyr} permet de selectionner une colonne :
dplyr::select(penguins, species)

# Selectionner deux colonnes :
dplyr::select(penguins, species, island)

# Selectionner des colonnes consecutives :
dplyr::select(penguins, species:bill_depth_mm)

# Selectionner un ensemble de colonnes :
dplyr::select(penguins, species, body_mass_g:sex)

# Cette fonction permet egalement de supprimer des colonnes :
dplyr::select(penguins, -year)

# Supprimer des colonnes consecutives :
dplyr::select(penguins, -(bill_length_mm:flipper_length_mm))

# Supprimer un ensemble de colonnes (concatenation avec c()) : 
dplyr::select(penguins, -c(island, bill_length_mm:flipper_length_mm))

# Le package {dplyr} dispose de fonctions permettant de selectionner des
# colonnes a l'aide de motifs :
dplyr::select(penguins, dplyr::starts_with("bill"))
dplyr::select(penguins, dplyr::ends_with("mm"))
dplyr::select(penguins, dplyr::contains("length"))

# La fonction select() permet de deplacer des colonnes : 
dplyr::select(penguins, species, island, year, bill_length_mm:sex)

# La fonction everything() du package {dplyr} permet de selectionner toutes
# les colonnes qui n'ont pas encore ete nommees :
dplyr::select(penguins, species, island, year, dplyr::everything())

# La fonction relocate() du package {dplyr} permet de deplacer des colonnes.
# Par defaut, cette fonction place la colonne en debut de tableau :
dplyr::relocate(penguins, year)

# Les arguments '.after' et '.before' permettent d'indiquer la position
# souhaitee par rapport a une colonne de reference :
dplyr::relocate(penguins, year, .after = island)
dplyr::relocate(penguins, year, .before = bill_length_mm)

# La fonction select() permet de renommer des colonnes, a l'aide de la 
# syntaxe suivante : select(nouveau_nom = ancien_nom)
dplyr::select(penguins, SPECIES = species, dplyr::everything())

# La fonction rename() du package {dplyr} permet de renommer des colonnes
# sans avoir a selectionner les autres colonnes du dataset :
dplyr::rename(penguins, SPECIES = species)

# 🔃 TRIER DES OBSERVATIONS -----------------------------------------------

# La fonction arrange() du package {dplyr} permet de trier les observations.
# Par defaut, le tri se fait par ordre croissant :
dplyr::arrange(penguins, body_mass_g)

# Pour effectuer un tri par ordre decroisant :
dplyr::arrange(penguins, -body_mass_g)
dplyr::arrange(penguins, dplyr::desc(body_mass_g))

# Le tri peut se faire sur plusieurs variables, ce qui peut etre utile
# pour departager des ex-aequo :
dplyr::arrange(penguins, body_mass_g, bill_length_mm)

# Chaque variable peut etre triee par ordre croissant ou decroissant :
dplyr::arrange(penguins, body_mass_g, -bill_length_mm)

# Les valeurs manquantes (NA) sont placees en fin de dataset, quel que soit
# l'ordre du tri :
tail(dplyr::arrange(penguins, body_mass_g))
tail(dplyr::arrange(penguins, -body_mass_g))

# ➕ CREER OU MODIFIER DES VARIABLES ---------------------------------------

# La fonction mutate() du package {dplyr} permet de creer 
# une nouvelle variable :
dplyr::mutate(penguins, body_mass_kg = body_mass_g / 1000)

# Par defaut, la nouvelle variable est placee en fin de dataset. 
# Les arguments '.after' et '.before' permettent de deplacer la nouvelle
# colonne a l'emplacement souhaite :
dplyr::mutate(penguins, body_mass_kg = body_mass_g / 1000,
              .after = body_mass_g)

dplyr::mutate(penguins, body_mass_kg = body_mass_g / 1000,
              .before = sex)

# La fonction mutate() permet la creation de plusieurs nouvelles variables
# a la fois :
dplyr::mutate(penguins,
              body_mass_kg = body_mass_g / 1000,
              bill_ratio = bill_length_mm / bill_depth_mm)

# Dans ce cas, les arguments '.after' et '.before' s'appliquent a l'ensemble
# des nouvelles variables :
dplyr::mutate(penguins,
              body_mass_kg = body_mass_g / 1000,
              bill_ratio = bill_length_mm / bill_depth_mm,
              .after = body_mass_g)

# Lors de la creation de nouvelles variables, la 1e variable peut etre
# utilisee pour creer la 2e :
dplyr::mutate(penguins,
              bill_ratio = bill_length_mm / bill_depth_mm,
              bill_ratio_pct = 100 * bill_ratio,
              .after = bill_depth_mm)

# Quand elle est appliquee a une variable deja existante, la fonction 
# mutate() en modifie le contenu :
dplyr::mutate(penguins, bill_length_mm = round(bill_length_mm, 0))

# Il est possible de calculer des statistiques a l'aide de mutate() :
dplyr::mutate(penguins,
              body_mass_g_mean = mean(body_mass_g))

# Attention aux donnees manquantes ! 
dplyr::mutate(penguins,
              body_mass_g_mean = mean(body_mass_g, na.rm = TRUE))

# 📊 SYNTHETISER DES VARIABLES --------------------------------------------

# La fonction summarise() - ou summarize() - du package {dplyr} permet de 
# synthetiser une variable.

# La fonction n() du package {dplyr} permet par exemple d'afficher le nombre
# d'observations :
dplyr::summarise(penguins, n = dplyr::n())

# Calculer la moyenne d'une variable :
dplyr::summarise(penguins, body_mass_g_mean = mean(body_mass_g, na.rm = TRUE))

# A la difference du calcul d'une statistique a l'aide de mutate(), la fonction
# summarise() aggrege les donnees.

# Plusieurs statistiques peuvent etre calculees a la fois :
dplyr::summarise(penguins,
                 body_mass_g_mean = mean(body_mass_g, na.rm = TRUE),
                 body_mass_g_sd = sd(body_mass_g, na.rm = TRUE))

# 🔢 CREATION D'UNE STRUCTURE INTERNE -------------------------------------

# La fonction group_by() du package {dplyr} permet d'ajouter au dataset une
# structure interne, en tenant compte de groupes ou categories :
dplyr::group_by(penguins, species)

# La structure peut comprendre plusieurs niveaux :
dplyr::group_by(penguins, species, island)

# Cette structure interne permet de calculer des statistiques par groupe :
penguins_group <- dplyr::group_by(penguins, species)
dplyr::summarise(penguins_group, n = dplyr::n())

# La fonction ungroup() du package {dplyr} permet de supprimer la structure
# interne : 
penguins_group
dplyr::ungroup(penguins_group)

# 🔗 ENCHAINER LES COMMANDES A L'AIDE DU PIPE -----------------------------

# Imaginons un 'exercice', dont voici l'enonce :
# 1. Filtrer les donnees pour ne conserver que les individus de l'espece 'Adelie'
# 2. Selectionner les variables 'species', 'island', 'body_mass_g'
# 3. Convertir la variable 'body_mass_g' en kg
# 4. Ajouter une structure interne par ile
# 5. Calculer la moyenne de la variable 'body_mass_kg' par ile

# Nous pourrions proceder de la facon suivante :
adelie <- dplyr::filter(penguins, species == "Adelie")

adelie_subset <- dplyr::select(adelie, species, island, body_mass_g)

adelie_subset_body_mass_kg <- dplyr::mutate(adelie_subset,
                                            body_mass_kg = body_mass_g / 1000)

adelie_subset_body_mass_kg_island <- dplyr::group_by(adelie_subset_body_mass_kg,
                                                     island)

adelie_body_mass_kg_mean_island <- dplyr::summarise(adelie_subset_body_mass_kg_island,
                                                    mean = mean(body_mass_kg, na.rm = TRUE))

adelie_body_mass_kg_mean_island

# Cette facon de proceder est loin d'etre optimale et necessite de creer 
# autant d'objets intermediaires qu'il y a d'etapes.

# Une autre facon de faire consisterait a imbriquer les commandes les unes dans
# les autres : 

adelie_body_mass_kg_mean_island <-
  dplyr::summarise(
    dplyr::group_by(
      dplyr::mutate(
        dplyr::select(
          dplyr::filter(penguins, species == "Adelie"),
          species, island, body_mass_g),
        body_mass_kg = body_mass_g / 1000),
      island),
    mean = mean(body_mass_kg, na.rm = TRUE)
    )

adelie_body_mass_kg_mean_island

# Le code ci-dessus est difficilement lisible, et pour comprendre le deroulement
# des etapes, il faut commencer par les parentheses les plus internes.

# Le 'pipe' permet d'enchainer les operations les unes apres les autres.
# Un pipe se note '|>' et se place a la fin de chaque commande :

penguins |> 
  dplyr::filter(species == "Adelie") |> 
  dplyr::select(species, island, body_mass_g) |> 
  dplyr::mutate(body_mass_kg = body_mass_g / 1000) |> 
  dplyr::group_by(island) |> 
  dplyr::summarise(body_mass_kg_mean = mean(body_mass_kg, na.rm = TRUE))
  
# Cette facon d'ecrire le code rend ce dernier bien plus lisible et 
# comprehensible, et evite de devoir creer des objets intermediaires.

# Un autre - enorme - avantage a l'utilisation du pipe est la possibilite
# d'utiliser l'auto-completion a l'aide de la touche 'Tab'.
# Cette fonctionnalite est tres appreciable quand les noms de 
# variables sont complexes ou que le dataset contient beaucoup de variables.

# Il existe un autre format de pipe, note '%>%'. Il s'agit d'une fonction 
# du package {magrittr}. Depuis la version 4.1 de R, le pipe dit 'natif', 
# note '|>', est dispnible directement dans l'installation basique de R.
# Ce pipe ne necessite donc pas l'installation d'un package supplementaire.

# Un raccourci clavier permet d'inserer un pipe en fin de ligne de commande : 
# 'Ctrl + Shift + M'. Par defaut, ce raccourci insere le pipe '%>%'. Pour que
# ce raccourci clavier insere un pipe '|>', il faut aller dans
# Tools > Global Options > Code.
# Dans l'onglet Editing, cocher 'Use native pipe operator'.