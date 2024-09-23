# ATELIERS CODONS
# INTRODUCTION AU TIDYVERSE
# PERFECTIONNEMENT
# 2024-09-23

# 📦 INSTALLER LES PACKAGES -----------------------------------------------

install.packages("tidyverse")  # manipulation, visualisation
install.packages("palmerpenguins")  # jeux de donnees
install.packages("skimr")  # synthese des donnees
install.packages("janitor")  # nettoyage des donnees
install.packages("glue")  # evaluer du code et l'inserer dans du texte

# 📦 CHARGER LES PACKAGES$ ------------------------------------------------

library(tidyverse)  
library(palmerpenguins)
library(skimr)
library(janitor)
library(glue)

pacman::p_load(tidyverse, palmerpenguins, skimr, janitor, glue)

# 🔽 IMPORTER LES DONNEES -------------------------------------------------

# Le package "palmerpenguins" contient 2 datasets :
# - penguins_raw : données brutes
# - penguins : données nettoyees

# Pour ce tutoriel de perfecionnement nous allons utiliser les donnees brutes.

penguins <- palmerpenguins::penguins_raw

# 📷 CREER UNE COPIE DE TRAVAIL -------------------------------------------

# Commencons par creer une copie de travail. Cette etape est importante car
# elle permet de revenir facilement au dataset d'origine en cas d'erreur de 
# code (tres utile en cas de dataset volumineux prenant du temps a importer).

penguins_copy <- penguins

# 🔎 EXPLORATION DES DONNEES ----------------------------------------------

dplyr::glimpse(penguins_copy)

# Les noms des variables ne respectent pas de convention d'ecriture
# particuliere, et aucune variable n'est de type 'facteur'.

# La fonction skim() du package {skimr} permet d'afficher le detail du 
# contenu d'un dataset :

skimr::skim(penguins_copy)

# Certaines variables de type 'character' ne possedent qu'une seule et 
# unique valeur ('n_unique = 1'). Ces variales n'appartant rien, nous 
# verrons par la suite comment les supprimer.

# 🧹 NETTOYER LES NOMS DE VARIABLES ---------------------------------------

# La fonction names() permet d'afficher les noms des colonnes (variables) :
names(penguins_copy)

# Le package {janitor} propose des fonctions permettant le nettoyage d'un
# dataset. La fonction clean_names() permet de nettoyer les noms de variables :
names(janitor::clean_names(penguins_copy))

# Par defaut, la fonction clean_names() du package janitor cree des noms
# de colonne au format 'snake_case'.

# D'autres formats sont disponibles :
names(janitor::clean_names(penguins_copy, "snake"))
names(janitor::clean_names(penguins_copy, "small_camel"))
names(janitor::clean_names(penguins_copy, "big_camel"))
names(janitor::clean_names(penguins_copy, "screaming_snake"))
names(janitor::clean_names(penguins_copy, "lower_upper"))
names(janitor::clean_names(penguins_copy, "upper_lower"))
names(janitor::clean_names(penguins_copy, "all_caps"))

# Assigner le tableau avec les noms de colonnes nettoyees dans
# l'objet penguins_copy

penguins_copy <- janitor::clean_names(penguins_copy)

# Verification
names(penguins_copy)

# 🔠 MANIPULER DES CHAINES DE CARACTERES ----------------------------------

# Le package {stringr} propose des fonctions utiles a la manipulation de 
# chaines de caracteres. Ces fonctions se presentent sous la forme str_*().

# Commencons par extraire le contenu de la variable 'island' dans un vecteur.
# Nous utilisons pour cela deux fonctions du package {dplyr} : 
# - distinct() pour extraire les valeurs uniques de la variable
# - pull() pour extraire la variable sous forme de vecteur

islands <- penguins_copy |> 
  dplyr::distinct(island) |> 
  dplyr::pull()

typeof(islands)  # affiche le type de donnees du vecteur

length(islands)  # nombre d'elements dans le vecteur

# Nombre de caracteres de chaque element du vecteur :
stringr::str_length(string = islands)

# Extraire les 3 premiers caracteres de chaque element du vecteur :
stringr::str_sub(string = islands, start = 1, end = 3)

# Rechercher un motif present ou non dans chaque element du vecteur :
stringr::str_detect(string = islands, pattern = "sc")
stringr::str_detect(string = islands, pattern = "sc", negate = TRUE)

# Rechercher un motif present ou non au debut dans chaque element du vecteur :
stringr::str_starts(string = islands, pattern = "Tor")
stringr::str_starts(string = islands, pattern = "Tor", negate = TRUE)

# Rechercher un motif present ou non a la fin de chaque element du vecteur :
stringr::str_ends(string = islands, pattern = "sen")
stringr::str_ends(string = islands, pattern = "sen", negate = TRUE)

# Compter le nombre de fois qu'un motif apparait dans chaque element du vecteur :
stringr::str_count(string = islands, pattern = "r")

# Afficher l'emplacement d'un motif dans chaque element du vecteur :
stringr::str_view(string = islands, pattern = "e")

# Extraire les elements du vecteur contenant ou non un motif
stringr::str_subset(string = islands, pattern = "sc")
stringr::str_subset(string = islands, pattern = "sc", negate = TRUE)

# Extraire un motif de chaque element du vecteur : 
stringr::str_extract(string = islands, pattern = "e")  # 1e occurence seulement
stringr::str_extract_all(string = islands, pattern = "e")  # toutes les occurences

# Remplacer un motif par un autre dans chaque element d'un vecteur :
stringr::str_replace(string = islands, pattern = "e", replacement = "E")  # 1e occurence seulement
stringr::str_replace_all(string = islands, pattern = "e", replacement = "E")  # toutes les occurences

# Supprimer un motif de chaque element d'un vecteur :
stringr::str_remove(string = islands, pattern = "e")  # 1e occurence seulement
stringr::str_remove_all(string = islands, pattern = "e")  # toutes les occurences

# Transformer une chaine de caracteres en minuscules
stringr::str_to_lower(string = islands)

# Transformer une chaine de caracteres en majuscules
stringr::str_to_upper(string = islands)

# Faire commencer une chaine de caracteres par une majuscule
stringr::str_to_title(string = stringr::str_to_lower(islands))

# Concatener des chaines de caracteres
stringr::str_c(islands, "island", sep = " ")

# Le package {stringr} permet egalement de gerer les espaces vides presents
# au debut et a la fin d'une chaine de caracteres : 
stringr::str_trim(c("     gauche", "droite     "), side = "left")
stringr::str_trim(c("     gauche", "droite     "), side = "right")
stringr::str_trim(c("     gauche", "droite     "), side = "both")

# La fonction str_squish() permet de supprimer les espaces vides en debut
# et en fin d'une chaine de caracteres, et remplace tous les espaces vides au
# sein de la chaine par un seul espace vide :
stringr::str_squish("  beaucoup          d'espaces  ")

# La fonction str_wrap() permet d'effectuer un passage a la ligne lorsqu'une
# chaine de caracteres est trop longue. Cela peut etre utile pour ajuster
# du texte dans une figure.
stringr::str_wrap(string = stringr::str_c(islands, "island", sep = " "),
                  width = 9)

# La fonction str_trunc() permet la troncation d'une chaine de caracteres : 
stringr::str_trunc(string = islands, width = 5)

# La fonction word() permet d'extraire les mots consecutifs d'une
# chaine de caracteres :
stringr::word(string = "Un Deux Trois", start = 1, end = 1)
stringr::word(string = "Un Deux Trois", start = 1, end = 2)
stringr::word(string = "Un Deux Trois", start = 2, end = 3)

# 🧹 RENOMMER DES VARIABLES -----------------------------------------------

names(penguins_copy)

# Les variables 'culmen_length_mm' et 'culmen_depth_mm' sont nommees respectivement
# 'bill_length_mm' et 'bill_depth_mm' dans le dataset nettoye (palmerpenguins::penguins).

# Les variables 'delta_15_n_o_oo' et 'delta_13_c_o_oo' indiquent des ratios
# d'isotopes, le motif 'o_oo' vient de la notation en 'pour mille' dans le 
# dataset d'origine. Nous souhaitons supprimer ce motif 'o_oo'.

# Nous pouvons renommer ces variables a l'aide de la fonction rename() du 
# package {dplyr} :
penguins_copy |> 
  dplyr::rename(bill_length_mm = culmen_length_mm,
                bill_depth_mm = culmen_depth_mm,
                delta_15_n = delta_15_n_o_oo,
                delta_13_c = delta_13_c_o_oo) |> 
  names()

# Nous allons tirer profit des fonctions du package {stringr} pour effectuer 
# cette operation.
# Plutot que la fonction rename(), nous utilisons la fonction rename_with() du
# package {dplyr} qui permet de renommer des variables a l'aide d'une fonction.
# La syntaxe est un peu particuliere :
# - la fonction utilisee pour renommer est precedee d'un tilde '~'
# - l'argument 'string = .x' permet d'indiquer que la fonction doit etre 
# appliquee a l'ensemble du dataset :

penguins_copy |> 
  dplyr::rename_with(.fn = ~ stringr::str_replace(string = .x,
                                                  pattern = "culmen",
                                                  replacement = "bill")) |> 
  dplyr::rename_with(.fn = ~ stringr::str_remove(string = .x,
                                               pattern = "_o_oo")) |> 
  names()

# Ce code fonctionne, nous assignons le resultat a l'objet 'penguins_copy' :
penguins_copy <- penguins_copy |> 
  dplyr::rename_with(.fn = ~ stringr::str_replace(string = .x,
                                                  pattern = "culmen",
                                                  replacement = "bill")) |> 
  dplyr::rename_with(.fn = ~ stringr::str_remove(string = .x,
                                                 pattern = "_o_oo")) 

# 🪝 SELECTIONNER DES VARIABLES -------------------------------------------

# La fonction select() du package {dplyr} permet de selectionner des variables.
# La fonction where() du package {dplyr} permet de selectionner des variables
# selon une condition :

penguins_copy |> dplyr::select(dplyr::where(is.numeric)) |> head(2)
penguins_copy |> dplyr::select(dplyr::where(is.character)) |> head(2)

# Nous avons vu avec la fonction skim() du package {skimr} que certaines 
# variables ('region' et 'stage') ne contiennent qu'une seule et unique valeur.
# Ces variables n'apportant aucune information supplementaire a notre dataset,
# nous souhaitons les supprimer. 
# Nous pourrions le faire a l'aide de code 'en dur', c'est-a-dire du code ecrit
# pour un cas de figure particulier et qui ne fonctionnera que pour ce cas 
# bien precis :

penguins_copy |> 
  dplyr::select(-region, -stage) |> 
  head(2)

# La fonction n_distinct() du package {dplyr} permet de compter le nombre de
# valeurs uniques (ou distinctes) d'une variable : 

dplyr::n_distinct(penguins_copy$region)
dplyr::n_distinct(penguins_copy$stage)

# Nous pouvons tirer profit de la fonction where() du package {dplyr} pour 
# selectionner dans un premier les colonnes du dataset ne contenant qu'une 
# seule et unique valeur : 

penguins_copy |> 
  dplyr::select(dplyr::where(~ dplyr::n_distinct(.) == 1)) |> 
  head(2)

# Nous souhaitons supprimer ces deux variables de notre copie de travail :
penguins_copy <- penguins_copy |> 
  dplyr::select(!dplyr::where(~ dplyr::n_distinct(.) == 1))

# Nous aurions egalement pu utiliser ce code : 
penguins_copy <- penguins_copy |> 
  dplyr::select(dplyr::where(~ dplyr::n_distinct(.) > 1))

# La fonction remove_constant() du package {janitor} permet d'effectuer
# la meme operation : 
penguins_copy |> 
  janitor::remove_constant()

# ➕ CREER OU MODIFIER DES VARIABLES ---------------------------------------

# La fonction mutate() du package {dplyr} permet de creer une nouvelle variable,
# ou de modifier le contenu d'une variable existante.

# Les arguments '.after' et '.before' permettent de preciser l'emplacement de
# la nouvelle variable dans le dataset (par defaut, la nouvelle variable
# est placee a la fin du dataset).

# La fonction mutate() propose d'autres arguments permettant de preciser 
# quelles variables conserver.

# Pour illustrer cela, creons un petit 'tibble' : 

df <- tibble::tibble(
  letter = LETTERS[1:5],
  num1 = 1:5,
  num2 = 6:10)

# Il existe une deuxieme facon de creer un tibble, en travaillant par ligne (on
# parle de tribble, pour 'row-wise tribble') : 

df2 <- tibble::tribble(
  ~ "letter", ~ "num1", ~ "num2",
  "A"       , 1       , 6,
  "B"       , 2       , 7,
  "C"       , 3       , 8,
  "D"       , 4       , 9,
  "E"       , 5       , 10
)

df |> dplyr::mutate(num3 = num1 + num2)
df |> dplyr::mutate(num3 = num1 + num2, .after = letter)
df |> dplyr::mutate(num3 = num1 + num2, .before = num1)

# L'argument 'keep' permet de preciser quelles colonnes conserver en plus de 
# la nouvelle colonne. 

# Conserver toutes les colonnes :
df |> dplyr::mutate(num3 = num1 + num2, .keep = "all")

# Ne conserver que les colonnes ayant servi a creer la nouvelle colonne :
df |> dplyr::mutate(num3 = num1 + num2, .keep = "used")

# Ne conserver que les colonnes n'ayant pas servi a creer la nouvelle colonne :
df |> dplyr::mutate(num3 = num1 + num2, .keep = "unused")

# Ne conserver que la nouvelle colonne (equivalent de l'ancienne fonction
# transmute() du package {dplyr}) : 
df |> dplyr::mutate(num3 = num1 + num2, .keep = "none")

# Revenons a nos pingouins ...
# Regardons de plus pres la variable 'body_mass_g', a l'aide de la fonction
# summary() : 
summary(penguins_copy$body_mass_g)

# Cette variable a ete mesuree en g, alors que la valeur minimale est egale
# a 2700g. Nous allons donc modifier cette variable 'body_mass_g' en 
# 'body_mass_kg' :

penguins_copy <- penguins_copy |> 
  dplyr::mutate(body_mass_kg = body_mass_g / 1000,
                .after = body_mass_g,
                .keep = "unused")

# La variable 'species' contient une longue chaine de caracteres. 
# Nous souhaitons simplifier le contenu de cette variable en extrayant le 
# premier mot ('Adelie', 'Chinstrap', 'Gentoo'). 
# Nous testons le code et verifions le resultat en affichant les valeurs
# distinctes de la variable modifiee : 

penguins_copy |> 
  dplyr::mutate(species = stringr::word(string = species,
                                        start = 1,
                                        end = 1)) |> 
  dplyr::distinct(species)

# Nous pouvons re-assigner le contenu dans l'objet 'penguins_copy' :

penguins_copy <- penguins_copy |> 
  dplyr::mutate(species = stringr::word(string = species,
                                        start = 1,
                                        end = 1))

# Si nous souhaitons conserver les noms latins des especes, nous pouvons
# proceder de la facon suivante : 

penguins_copy |> 
  dplyr::mutate(latin = stringr::word(string = species, # extraire les 3e et 4e mots
                                      start = 3,
                                      end = 4), 
                latin = stringr::str_remove_all(string = latin, # supprimer les parentheses
                                                pattern = "[()]"))  

# Ou nous pouvons utiliser une expression reguliere : 
penguins_copy |> 
  dplyr::mutate(latin = stringr::str_extract(string = Species,
                                             pattern = "(?<=\\().+?(?=\\))"))

# 🪝 EXTRAIRE DES LIGNES --------------------------------------------------

# Le package {dplyr} propose des fonctions permettant l'extraction de lignes.
# Ces fonctions sont au format slice_*().

# Creons tout d'abord un sous-ensemble de notre dataset, ne comportant que
# l'espece, l'ile et la masse.
# La fonction rowid_to_column() permet d'ajouter une colonne d'index. Par defaut
# cette colonne est placee au debut du dataset, et a pour nom 'rowid' (ce nom
# est modifiable a l'aide de l'argument 'var = ...') : 

penguins_sub <- penguins_copy |> 
  dplyr::select(species, island, body_mass_kg) |> 
  tibble::rowid_to_column(var = "ind_nb")

# Extraire les lignes 51 a 55 :
penguins_sub |>
  dplyr::slice(51:55)

# Extraire les deux premiers individus de chaque espece.
# Pour cela, nous groupons notre dataset par espece :
penguins_sub |>
  dplyr::group_by(species) |>
  dplyr::slice(1:2)

# En procedant de cette facon, nous obtenons un tibble trie par ordre
# alphabetique d'espece.

# Il existe une autre maniere de faire, sans utiliser la fonction group_by().
# La fonction slice() dispose d'un argument '.by' permettant de creer les
# groupes directement, sans modifier l'ordre du resultat :
penguins_sub |> 
  dplyr::slice(1:2, .by = species)

# Nous le verrons plus loin, mais cet argument '.by' peut etre utilise dans les
# fonctions mutate() et summarise(), ce qui permet de ne plus utiliser la 
# fonction group_by().

# Extraire les lignes en fonction des valeurs min et max d'une variable : 
penguins_sub |> 
  dplyr::slice_min(n = 2, order_by = body_mass_kg)

# S'il existe des observations ayant la meme valeur pour la variable 
# d'interet, par defaut les ex-aequo seront affiches.
# L'argument 'with_ties = FALSE' permet de ne conserver que
# la premiere observation :
penguins_sub |> 
  dplyr::slice_min(n = 2, order_by = body_mass_kg, with_ties = FALSE)

penguins_sub |> 
  dplyr::slice_max(n = 3, order_by = body_mass_kg, with_ties = TRUE)

penguins_sub |> 
  dplyr::slice_max(n = 3, order_by = body_mass_kg, with_ties = FALSE)

# Plutot qu'un nombre de lignes ('n = ...'), il est possible d'extraire
# une proportion a l'aide de l'argument 'prop = ...'.
# Par exemple, pour extraire les 5% d'individus ayant la masse la plus elevee :
penguins_sub |> 
  dplyr::slice_max(prop = 0.05, order_by = body_mass_kg)

nrow(penguins_sub) * 0.05

# La fonction slice_sample() permet d'extraire des lignes de maniere aleatoire : 

penguins_sub |> 
  dplyr::slice_sample(n = 10)

# L'argument 'prop = ...' permet d'extraire aleatoirement une proportion de lignes.
# Cela peut etre utile en modelisation, pour attribuer aleatoirement une certaine
# proportion des observations au sous-set de training ou de test.

penguins_sub |> 
  dplyr::slice_sample(prop = 0.2)

344 * 0.2

# 📊 COMPTER LES OBSERVATIONS ---------------------------------------------

# La fonction count() du package {dplyr} permet de compter les observations :
penguins_sub |> 
  dplyr::count(species)

# L'argument 'sort = TRUE' permet de trier les classes (par ordre decroissant
# de frequence) :
penguins_sub |> 
  dplyr::count(species, sort = TRUE)

# L'argument 'name = ..." permet de renommer la colonne 'n' : 
penguins_sub |> 
  dplyr::count(species, sort = TRUE, name = "freq")

# La fonction count() permet de compter les observations sur plusieurs
# niveaux : 

penguins_sub |> 
  dplyr::count(species)

penguins_sub |> 
  dplyr::count(species, island)

# Cette fonction n'affiche que les combinaisons de classes pour lesquelles
# il existe des observations. Dans notre dataset, les especes 'Chinstrap' et
# 'Gentoo' ne sont presentes que sur une seule ile, respectivement 'Dream' et 
# 'Biscoe'.
# La fonction complete() du package {tidyr} permet de rendre l'absence
# d'observations dans certaines combinaisons de classes plus explicite : 

penguins_sub |> 
  dplyr::count(species, island) |> 
  tidyr::complete(species, island)

# L'argument 'fill' permet de remplacer les NA par autre chose, par exemple 
# des '0'. Cet argument s'utilise de la maniere suivante : 
# 'fill = list(nom_variable_de_comptage = remplacement)'

penguins_sub |> 
  dplyr::count(species, island) |> 
  tidyr::complete(species, island,
                  fill = list(n = 0))

# Attention ! Si l'argument 'name = ...' est utilise, il faudra modifier le 'n'
# dans l'argument 'fill = ...' par le nom correspondant : 

penguins_sub |> 
  dplyr::count(species, island, name = "freq") |> 
  tidyr::complete(species, island,
                  fill = list(freq = 0))

# 📊 SYNTHETISER DES VARIABLES --------------------------------------------

# La fonction summarise() - ou summarize() - du package {dplyr} permet de 
# synthetiser une variable.
# Nous avons vu comment creer une structure interne a notre dataset a l'aide
# de la fonction group_by() du package {dplyr} :

penguins_copy |> 
  dplyr::group_by(species) |> 
  dplyr::summarise(body_mass_kg_mean = mean(body_mass_kg, na.rm = TRUE))

# L'argument '.by = ...' peut etre utilise directement dans la fonction
# summarise() : 

penguins_copy |> 
  dplyr::summarise(body_mass_kg_mean = mean(body_mass_kg, na.rm = TRUE),
                   .by = species)

# Il est possible de calculer plusieurs statistiques a la fois : 
penguins_copy |> 
  dplyr::summarise(body_mass_kg_mean = mean(body_mass_kg, na.rm = TRUE),
                   body_mass_kg_sd = sd(body_mass_kg, na.rm = TRUE),
                   .by = species)

# La fonction across() du package {dplyr} permet de calculer des statistiques
# sur plusieurs variables a la fois (utilisation de across() similaire a 
# l'utilisation de where()) :

penguins_copy |> 
  dplyr::summarise(dplyr::across(.cols = dplyr::starts_with("bill"),
                                 .fns = ~ mean(.x, na.rm = TRUE)))

# Le resultat ne nous indique pas qu'il s'agit de la moyenne.
# Il faut pour cela 'creer' la variable 'mean' dans une liste, ce
# qui ajoute un suffixe aux noms des variables :

penguins_copy |> 
  dplyr::summarise(dplyr::across(.cols = dplyr::starts_with("bill"),
                                 .fns = list(
                                   mean = ~ mean(.x, na.rm = TRUE))))

# Nous pouvons ainsi calculer plusieurs statistiques sur plusieurs variables :

penguins_copy |> 
  dplyr::summarise(dplyr::across(.cols = dplyr::starts_with("bill"),
                                 .fns = list(
                                   mean = ~ mean(.x, na.rm = TRUE),
                                   sd = ~ sd(.x, na.rm = TRUE))))

# Nous pouvons egalement ajouter une structure interne : 

penguins_copy |> 
  dplyr::summarise(dplyr::across(.cols = dplyr::starts_with("bill"),
                                 .fns = list(
                                   mean = ~ mean(.x, na.rm = TRUE),
                                   sd = ~ sd(.x, na.rm = TRUE))),
                   .by = species)

# La combinaison des fonctions across() et where() permet par example de 
# calculer des statistiques pour toutes les variables numeriques du dataset :

penguins_copy |> 
  dplyr::summarise(dplyr::across(.cols = dplyr::where(is.numeric),
                                 .fns = list(
                                   mean = ~ mean(.x, na.rm = TRUE)
                                 )),
                   .by = species)

# La variable 'sample_number' est consideree comme variable de type numerique
# alors qu'il s'agit d'une variable categorielle.
# Nous allons voir comment manipuler les variables de ce type, encore 
# appelees 'facteurs'.

# 🧹 MANIPULER DES FACTEURS -----------------------------------------------

# Les colonnes (variables) d'un dataframe (ou tibble) contiennent des elements
# d'un seul et meme type (caractere, numerique, date). Il s'agit de vecteurs,
# c'est-a-dire des collections a une dimension d'elements de meme type.

# Plusieurs variables du dataset sont en realite des variables categorielles,
# qui ne possedent qu'un nombre limite d'observations (des classes).

# Pour bien differencier les variables numeriques (les mesures) des variables
# categorielles, nous allons transformer ces dernieres en facteurs.

# Le package {forcats} propose un ensemble de fonctions utiles a la 
# creation et a la manipulation de facteurs.

# La fonction fct() permet de transformer une variable en facteur :
penguins_copy |> 
  dplyr::mutate(species = forcats::fct(species),
                .keep = "none") 

# Pour comprendre le fonctionnement des differentes fonctions du package
# {forcats}, nous transformons la variable 'island' en facteur.
# Nous utilisons la fonction factor() qui appartient au R de base :
penguins_fct <- penguins_copy |> 
  dplyr::mutate(island_fct = factor(island))

# La fonction levels() permet d'afficher les 'niveaux' d'un facteur,
# c'est-a-dire les classes ou categories :
levels(penguins_fct$island_fct)

# Par defaut, la fonction factor() cree un facteur dont les classes sont
# triees par order alphabetique.

# La fonction fct() permet de creer un facteur, mais avec des classes triees
# par ordre d'apparition dans le dataset :
fct0 <- penguins_fct |> 
  dplyr::mutate(island_fct = forcats::fct(island))
levels(fct0$island_fct)

# La fonction fct_inorder() trie les classes par ordre d'apparition dans
# le dataset.
fct1 <- penguins_fct |> 
  dplyr::mutate(island_fct = forcats::fct_inorder(island_fct))

levels(fct1$island_fct)

# La fonction distinct() du package {dplyr} permet d'afficher les observations
# uniques d'une variable par ordre d'apparition :
penguins_copy |> 
  dplyr::distinct(island)

# La fonction fct_infreq() trie les classes par ordre decroissant de frequence :
fct2 <- penguins_fct |> 
  dplyr::mutate(island_fct = forcats::fct_infreq(island_fct))

levels(fct2$island_fct)

# Pour verifier, utilisons la fonction count() du package {dplyr} :
penguins_copy |> 
  dplyr::count(island, sort = TRUE)

# La fonction fct_rev() permet d'inverser l'ordre des classes : 
fct3 <- penguins_fct |> 
  dplyr::mutate(island_fct = forcats::fct_rev(island_fct))

levels(fct3$island_fct)

# La fonction fct_recode() permet de modifier les niveaux d'un facteur 
# manuellement : 
fct4 <- penguins_fct |> 
  dplyr::mutate(island_fct = forcats::fct_recode(island_fct,
                                                 Tor = "Torgersen",
                                                 Bis = "Biscoe",
                                                 Dre = "Dream"))
levels(fct4$island_fct)

# La fonction fct_relevel() permet de modifier les niveaux d'un facteur 
# les uns par rapport aux autres: 
fct5 <- penguins_fct |> 
  dplyr::mutate(island_fct = forcats::fct_relevel(island_fct,
                                                  "Biscoe", after = 2))
levels(penguins_fct$island_fct)
levels(fct5$island_fct)


# Nous allons transformer les variables categorielles suivantes en facteurs :
# 'study_name', 'sample_number', 'species', 'island', 'individual_id',
# 'clutch_completion', 'sex'.
# Verifions le type actuel de ces variables : 

penguins_copy |> 
  dplyr::select(study_name:clutch_completion, sex) |> 
  head(2)

# Une seule variable est de type 'double', les autres sont de type 'character'.
# Pour appliquer la fonction factor() a l'ensemble de ces variables, nous 
# utilisons la fonction where() du package {dplyr} pour la selection, et 
# la fonction across() du package {tidyr} pour l'application de la fonction.

# Nous testons d'abord le code et verifions le resultat avec la fonction
# glimpse() :

penguins_copy |> 
  dplyr::mutate(dplyr::across(.cols = c(dplyr::where(is.character), 
                                        sample_number, -comments),
                              .fns = ~ factor(.x))) |> 
  dplyr::glimpse()

# Les variables souhaitees ont bien ete transformees en facteurs : nous 
# ecrasons alors l'objet 'penguins_copy' :
penguins_copy <- penguins_copy |> 
  dplyr::mutate(dplyr::across(.cols = c(dplyr::where(is.character), 
                                        sample_number, -comments),
                              .fns = ~ factor(.x)))

# Reprenons le code utilise pour calculer la moyenne et l'ecart-type de 
# l'ensemble des variables de type numerique : 
penguins_copy |> 
  dplyr::summarise(dplyr::across(.cols = dplyr::where(is.numeric),
                                 .fns = list(
                                   mean = ~ mean(.x, na.rm = TRUE)
                                 )),
                   .by = species)

# 📚 JOINDRE DES TABLEAUX -------------------------------------------------

# Les fonctions *_join() du package {dplyr} permettent de joindre des
# data frames (tibbles).

# Pour illustrer le fonctionnement de ces fonctions, nous allons utiliser
# des datasets integres au package {dplyr} :

dplyr::band_members
dplyr::band_instruments
dplyr::band_instruments2

# Les fonctions *_join() s'utilisent en precisant les deux datasets a joindre.
# On parlera de 1er dataset (ou dataset de gauche) et de 2e dataset (ou 
# dataset de droite).
# La jointure se fait a l'aide d'une (ou plusieurs) colonne(s) commune(s)
# aux deux datasets : on parle de 'cle' de jointure.

# Si une observation est presente dans un dataset mais pas dans l'autre, 
# la valeur correspondante est remplacee par un NA.

# La fonction left_join() permet d'ajouter les colonnes du 2e dataset au 1er :
dplyr::left_join(band_members, band_instruments)
dplyr::left_join(band_instruments, band_members)

# La colonne commune aux deux datasets (la cle de jointure) porte le meme
# nom. Si tel n'est pas le cas, le code renverra une erreur :
dplyr::left_join(band_members, band_instruments2)

# Il faut alors preciser les noms de la colonne de jointure pour chaque
# dataset, a l'aide de l'argument 'by' : 'by = c("cle1" = "cle2")'.
dplyr::left_join(band_members, band_instruments2, by = c("name" = "artist"))

# La fonction right_join() effectue la meme operation, mais en ajoutant
# les colonnes du 1er dataset au 2e :
dplyr::right_join(band_members, band_instruments)

# Dans le dataset resultant, l'ordre des colonnes est conserve, avec
# les colonnes du 1er dataset placees avant les colonnes du 2e dataset.

# La fonction inner_join() ajoute les colonnes du 2e dataset aux colonnes
# du 1er dataset, et ne conserve que les observations pour lesquelles la 
# valeur de la colonne cle sont presentes dans les 2 datasets.
dplyr::inner_join(band_members, band_instruments)
dplyr::inner_join(band_instruments, band_members)

# La fonction full_join() effectue une jointure 'complete' : le dataset
# resultat comprend toutes les observations et toutes les colonnes, les
# valeurs manquantes dans l'un des deux datasets etant remplacees par des NA :
dplyr::full_join(band_members, band_instruments)
dplyr::full_join(band_instruments, band_members)

# La fonction anti_join() ne garde que les colonnes du 1er dataset et
# supprime du 1er dataset les observations pour lesquelles les valeurs
# sont presentes dans le 2e dataset : 
dplyr::anti_join(band_members, band_instruments)
dplyr::anti_join(band_instruments, band_members)

# Ce type de jointure est utilise pour la fouille de texte (text mining),
# lorsqu'on veut supprimer d'un texte les mots de liaison listes dans 
# un autre dataset.

# La fonction semi_join() permet d'effectuer l'inverse de la fonction
# anti_join() : garder les colonnes du 1er dataset et conserver les
# observations pour lesquelles les valeurs sont presentes dans le 2e dataset :
dplyr::semi_join(band_members, band_instruments)
dplyr::semi_join(band_instruments, band_members)

# 🔄️ TRANSFORMER DES TABLEAUX --------------------------------------------

# Un data frame (ou tibble) peut se presenter sous deux formats :

# - format long : chaque colonne contient une variable et chaque ligne
# contient une observation. Ce format est le plus pratique pour les
# operations de selection d'observations (on parle de format 'tidy',
# sur lequel repose la 'philosophie' du {tidyverse}).

# - format large : il y a davantage de colonnes que de lignes. L'exemple
# type de ce format est celui du plan de plaque utilise en laboratoire.

# Les fonctions pivot_*() du package {tidyr} permettent de basculer entre
# ces deux formats.

# Pour comprendre le fonctionnement de ces fonctions, nous creons un
# dataset en comptant les observations par ile et par espece (sans ajouter
# les classes ne comportant aucune observation) : 

penguins_count <- penguins_copy |> 
  dplyr::count(species, island)

penguins_count

# Ce dataset est au format long, avec une variable par colonne et une 
# observation par ligne.

# La fonction pivot_wider() permet de basculer d'un format long a un
# format large.
# Il faut preciser plusieurs arguments : 
# - 'id_cols' : la ou les colonne(s) servant a identifier les individus
# - 'names_from' : la colonne qui servira a generer les noms des colonnes
# du dataset au format large
# - 'values_from' : la colonne qui contient les valeurs qui seront reparties
# dans les colonnes creees par l'argument 'names_from'.

penguins_count |> 
  tidyr::pivot_wider(id_cols = species,
                     names_from = island,
                     values_from = n)

# Comme pour la fonction complete() du package {dplyr}, il est possible
# de remplacer les NA : 

penguins_count |> 
  tidyr::pivot_wider(id_cols = species,
                     names_from = island,
                     values_from = n,
                     values_fill = list(n = 0))

# Assignons le dataset au format large dans l'objet 'penguins_wide' : 
penguins_wide <- penguins_count |> 
  tidyr::pivot_wider(id_cols = species,
                     names_from = island,
                     values_from = n)

# La fonction pivot_longer() permet de basculer d'un format large a un
# format long.
# Il faut preciser plusieurs arguments : 
# - 'cols' : les colonnes qui seront transformees
# - 'names_to' : le nom de la colonne qui contiendra les noms des colonnes
# transformees
# - 'values_to' : le nom de la colonne qui contiendra les valeurs des colonnes
# transformees

penguins_wide |> 
  tidyr::pivot_longer(cols = -species,
                      names_to = "island",
                      values_to = "n")

# Par defaut, toutes les combinaisons sont conservees, y compris celles pour 
# lesquelles aucune observation n'est presente (les NA).
# L'argument 'values_drop_NA = TRUE' permet de supprimer ces observations : 

penguins_wide |> 
  tidyr::pivot_longer(cols = -species,
                      names_to = "island",
                      values_to = "n",
                      values_drop_na = TRUE)

# 📆 MANIPULER DES DATES --------------------------------------------------

# Le package {lubridate} propose des fonctions utiles a la manipulation
# de dates.

# Commencons par creer un sous-set du dataset : nous ne conservons que la 
# colonne 'date_egg' et ajoutons une colonne d'index.

penguins_dates <- penguins_copy |> 
  dplyr::select(date_egg) |> 
  tibble::rowid_to_column(var = "ind_nb")

# Les fonctions year(), month() et day() permettent d'extraire les elements
# d'une date : 

penguins_dates |> 
  dplyr::mutate(year = lubridate::year(date_egg),
                month = lubridate::month(date_egg),
                day = lubridate::day(date_egg))

# Par defaut, ces fonctions retournent des valeurs numeriques.

# Des arguments permettent d'afficher les noms des mois : 
# - 'label = TRUE' pour afficher le nom 
# - 'abbr = FALSE' pour afficher le nom en entier
# - 'locale = ...' pour changer de langue

penguins_dates |> 
  dplyr::mutate(month = lubridate::month(date_egg,
                                         label = TRUE,
                                         abbr = FALSE,
                                         locale = "en"))

# La fonction wday() permet d'afficher les noms jours : 

penguins_dates |> 
  dplyr::mutate(day = lubridate::wday(date_egg))

# La fonction wday() dispose des memes arguments que la fonction month() :

penguins_dates |> 
  dplyr::mutate(weekday = lubridate::wday(date_egg,
                                          label = TRUE,
                                          abbr = FALSE,
                                          locale = "en"))

# La variable 'weekday' est de type 'ordered' : il s'agit d'une variable
# ordinale, avec un ordre des valeurs de la variable. L'argument 'week_start'
# permet de modifier le jour de debut de semaine (par defaut le dimanche,
# 'week_start = 7').

# Cet argument permet de changer l'ordre des jours de la semaine, par exemple
# pour compter le nombre d'observations par jour : 

penguins_dates |> 
  dplyr::mutate(weekday = lubridate::wday(date_egg,
                                          label = TRUE,
                                          abbr = FALSE,
                                          locale = "en")) |> 
  dplyr::count(weekday)

penguins_dates |> 
  dplyr::mutate(weekday = lubridate::wday(date_egg,
                                          label = TRUE,
                                          abbr = FALSE,
                                          locale = "en",
                                          week_start = 1)) |> 
  dplyr::count(weekday)

# ❓ GESTION DES DONNEES MANQUANTES ----------------------------------------

# Notre dataset contient des donnees manquantes : 
head(penguins_copy)

# La fonction skim() du package skimr() revele que les differentes variables
# ont un nombre different de donnees manquantes : 
skimr::skim(penguins_copy)

# Nous pouvons supprimer les observations pour lesquelles une des variables
# contient des donnees manquantes. La fonction 'is.na()' permet d'extraire
# les donnees manquantes d'une variable, ou de les supprimer a l'aide de la
# negation '!is.na()' :

penguins_copy |> 
  dplyr::filter(is.na(delta_15_n)) |> 
  dplyr::count()

penguins_copy |> 
  dplyr::filter(!is.na(delta_15_n)) |> 
  dplyr::count()

# La fonction drop_na() du package {tidyr} permet de supprimer les observations
# pour lesquelles une variable a des donnees manquantes : 

penguins_copy |> 
  tidyr::drop_na(delta_15_n)

# En precisant des variables dans la fonction drop_na(), les observations
# pour lesquelles il existe des donnees manquantes pour d'autre variables sont
# conservees : 

penguins_copy |> 
  tidyr::drop_na(delta_15_n) |> 
  dplyr::filter(is.na(sex))

# Si aucune variable n'est precisee dans la fonction drop_na(), les observations
# pour lesquelles il existe au moins une donnee manquante dans au moins une 
# des variables du dataset sont supprimees : 

penguins_copy |> 
  tidyr::drop_na()

# La fonction replace_na() du package {tidyr} permet de remplacer les donnees
# manquantes par une autre valeur ou par une chaine de caracteres : 

penguins_copy |>
  dplyr::select(sex, body_mass_kg, comments) |> 
  tidyr::replace_na(replace = list(body_mass_kg = -999))

# La fonction replace_na() ne fonctionne pas sur un facteur, il faut
# d'abord transformer la variable en variable de type 'character' :
penguins_copy |>
  dplyr::select(sex, body_mass_kg, comments) |> 
  dplyr::mutate(sex = as.character(sex)) |> 
  tidyr::replace_na(replace = list(sex = "Not available"))

# Nous souhaitons faire une analyse plus poussee de la repartition
# des donnees manquantes de notre dataset. 

# La variable 'clutch_completion' indique s'il y a eu ponte ('Yes') 
# ou non ('No'). Nous souhaitons compter les donnees manquantes,
# nous allons donc considerer qu'un 'No' pour cette variable
# correspond a une donnee manquante.

# Nous allons utiliser la fonction str_replace() du package 
# {stringr}. Mais nous ne pouvons pas simplement remplacer 'No' par
# NA, il faut preciser qu'il s'agit d'un 'NA de type caractere' :

penguins_na <- penguins_copy |> 
  dplyr::mutate(
    clutch_completion = stringr::str_replace(string = clutch_completion,
                                             pattern = "No",
                                             replacement = NA_character_))

# Nous comptons maintenant les NA pour chacune des variables :
na_count <- penguins_na |> 
  dplyr::summarise(dplyr::across(.fns = ~ sum(is.na(.x)))) |> 
  tidyr::pivot_longer(cols = dplyr::everything())

na_count

# Les 36 NA de la variable 'clutch_completion' correspondent
# bien aux 36 'No' de la variable d'origine :
penguins_copy |> 
  dplyr::count(clutch_completion)

# Nous allons supprimer les variables n'ayant aucune donnee manquante
# pour la suite de l'analyse. 
# Nous commencons par extraire dans un vecteur les noms des
# variables ayant des donnees manquantes :

no_na <- na_count |> 
  dplyr::filter(value != 0) |> 
  dplyr::pull(name)

# Pour selectionner les variables d'un dataset a l'aide d'un
# vecteur de noms de variables, nous utilisons la fonction
# all_of() du package {dplyr} :

penguins_na <- penguins_na |> 
  dplyr::select(dplyr::all_of(no_na))

# Nous allons maintenant compter le nombre de NA de chaque 
# variable par commentaire pour verifier que le contenu des
# commentaires explique bien la repartition des NA dans les
# differentes variables :

penguins_na |> 
  dplyr::summarise(dplyr::across(.fns = ~ sum(is.na(.x))),
                   .by = comments) |> 
  View()

# ➕ CREER DES OBSERVATIONS A L'AIDE DE CONDITIONS -------------------------

# Nous aimerions creer une variable separant les individus en deux 
# classes en fonction de leur masse : 
# - 'over 5 kg'
# - 'under 5 kg'

# La fonction case_when() du package {dplyr}, utilisee dans une 
# fonction mutate() du meme package, permet de definir des conditions.
# La fonction case_when() s'utilise de la maniere suivante :
# case_when(condition 1 ~ "valeur1", .default ~ "valeur par defaut)

penguins_copy |> 
  dplyr::select(body_mass_kg) |> 
  tibble::rowid_to_column(var = "ind_nb") |> 
  dplyr::mutate(cat = dplyr::case_when(body_mass_kg > 5 ~ "over 5 kg",
                                       .default = "under 5 kg"))

# Verifions le resultat : 

penguins_mass <- penguins_copy |> 
  dplyr::select(body_mass_kg) |> 
  tibble::rowid_to_column(var = "ind_nb") |> 
  dplyr::mutate(cat = dplyr::case_when(body_mass_kg > 5 ~ "over 5 kg",
                                       .default = "under 5 kg"))

penguins_mass |> 
  dplyr::filter(body_mass_kg > 5) |> 
  dplyr::count()

penguins_mass |> 
  dplyr::count(cat)

# Il est possible de multiplier les conditions : 

penguins_mass <- penguins_copy |> 
  dplyr::select(body_mass_kg) |> 
  tibble::rowid_to_column(var = "ind_nb") |> 
  dplyr::mutate(cat = dplyr::case_when(body_mass_kg > 5 ~ "over 5 kg",
                                       body_mass_kg < 3 ~ "over 3 kg",
                                       .default = "average"))

penguins_mass |> 
  dplyr::filter(body_mass_kg > 5) |> 
  dplyr::count()

penguins_mass |> 
  dplyr::filter(body_mass_kg < 3) |> 
  dplyr::count()

penguins_mass |> 
  dplyr::count(cat)

# 🪄 CREER DES CHAINES AVEC DU CODE INTERPRETE ----------------------------

# La fonction glue() du package {glue} permet de creer des chaines
# de caracteres avec du code interprete au sein du texte.
# Cette fonction est utile par exemple pour decrire les observations
# de maniere dynamique.
# Le code et les noms de variables sont inseres a l'aide de
# crochets {}, et l'utilisation de virgule entre blocs facilite
# l'ecriture et la lecture du code :

penguins_copy |> 
  dplyr::select(individual_id, species:individual_id,
                sex, body_mass_kg) |> 
  tidyr::drop_na() |> 
  dplyr::slice_max(body_mass_kg, by = species) |> 
  dplyr::mutate(description = 
                  glue::glue("L'individu {individual_id} ",
                             "({stringr::str_sub(sex, 1, 1)}) ",
                             "de l'espece {species} ",
                             "et present sur l'ile {island}, a une masse ",
                             "corporelle de {round(body_mass_kg, 1)}kg"),
                .keep = "none")
