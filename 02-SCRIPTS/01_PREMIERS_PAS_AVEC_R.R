# ATELIERS CODONS
# PREMIERS PAS AVEC R

# ❓ QU'EST-CE QUE R ? -----------------------------------------------------

# R est un langage de programmation et un logiciel pour les calculs
# statistiques et la création de graphiques.

# Conçu en 1992 par Ross Ihaka et Robert Gentleman comme implémentation
# open source du langage de programmation S, et publié en 1995.

# Depuis, R s'est très largement développé et est utilisé pour :
# - conduire des analyses statistiques et des workflows de data science
# - créer des visualisations de haute complexité, prêtes à être publiées
# - générer des rapports automatiques
# - développer des applications web 
# - créer des diapositives de présentation, des livres, et des pages web

# Avantages de R :
# - libre, open source, et plateforme indépendant
# - large variété d'extensions proposant des foncionnalités supplémentaires
# - hautement compatible avec de nombreux autres langages de programmation
# - très puissant pour l'analyse et la visualisation de données
# - souvent considéré comme "simple à coder" (d'une perspective d'un non programmeur)

# Inconvénients de R :
# - performance : "scalability", mémoire et vitesse
# - courbe d'apprentissage (comme tout langage de programmation)
# - problèmes potentiels de sécurité (pertinent pour les applications web)
# - souvent considéré comme "étrange à coder" (d'une perspective d'un programmeur)

# 🆚 R VS. RSTUDIO --------------------------------------------------------

# Si R est le "moteur", RStudio est le tableau de bord.

# RStudio est un IDE (Integrated Development Environment) open source pour R.

# IDE le plus populaire depuis plusieurs années

# Nombreuses fonctionnalités et extensions qui facilitent les workflows, comme
# le suivi de version, les tables des matières, les add-ins, ...

# Possibilité de travailler dans des projets R et d'utiliser RMarkdown / Quarto

# ⬇️ INSTALLER R ET RSTUDIO -----------------------------------------------

# Pour installer R : 
# cloud.r-project.org

# Pour installer RStudio :
# posit.co/download/rstudio-desktop

# Possibilité de télécharger R depuis le site web de Posit.

# 🔎 RSTUDIO --------------------------------------------------------------

# Une fenêtre "classique" de RStudio se divise en 4 panneaux :
# - Le script
# - La console (+ terminal et jobs)
# - L'environnement (+ historique, build, suivi de version)
# - Les plots (+ fichiers, packages, aide, viewer, presentations)

# ⌨️ MISE EN PRATIQUE -----------------------------------------------------

# Ouvrez R, tapez les commandes suivantes dans la console et exécutez-les
# (touche Entrée)

# "Hello World!"
# 1

# Ouvrez RStudio et familiarisez-vous avec l'environnement
# - Help > Cheatsheets > RStudio IDE Cheat Sheet et étudiez le document
# - View > Panes > Pane Layout et modifiez l'emplacement des panneaux selon votre préférence
# - Ouvrez un script via File > New File... > R Script, ajoutez les deux commandes ci-dessus et
# sauvegardez le script
# - Exécutez les commandes en plaçant le curseur sur la première ligne du script et en cliquant
# sur le bouton Run (ou en utilisant le raccourci clavier Ctrl + Entrée)
# - Sauvegardez le script

# ⌨️ LA CONSOLE  ----------------------------------------------------------

# Le code que vous exécutez apparaît à la ligne qui débute avec ">" (invite de 
# commande).
# La console affiche également le résultat de la commande (la sortie), à la ligne 
# qui débute par "[1]".

# Pour effacer le contenu de la console : Ctrl + L

# ⌨️ COMMENTAIRES ---------------------------------------------------------

# Les commentaires sont utiles pour 
# - inactiver le code qu'on ne souhaite pas exécuter
# - ajouter des commentaires qui expliquent notre pensée et raisonnement

# Dans R, les commentaires sont indiqués par un hash "#". 
# Tout ce qui suit un "#" sur une même ligne ne sera pas traité comme du code.

# Convention possible : 
# "#" pour inactiver du code
# "##" pour commenter du code

# "Hello World!" ## ce code n'est plus utile mais je préfère le conserver

# Raccourci clavier pour commenter/décommenter du code (une ou plusieurs lignes)
# Ctrl + Shift + C

# ⚙️ PARAMETRES DE RSTUDIO ------------------------------------------------

# RStudio propose tout un tas de paramètres pour personnaliser son utilisation.

# Tools > Global Options > General > Basic
# - décocher les cases sous "Workspace" et "History"
# - valider les modifications en cliquant sur "Apply"

# Tools > Global Options > General > Graphics
# Choisir "AGG" dans Backend

# Tools > Global Options > Code > Display
# - Sous General, cocher "Highlight selected word" et "Show line numbers"
# - Sous General, cocher "Show margin" et choisir "80" pour Margin column
# - Sous Syntax, cocher toutes les cases

# Tools > Global Options > Appearance
# possibilité de modifier le thème de RStudio (couleur d'arrière-plan, couleur
# et taille de la police, ...)

# 📦 PROJETS R ------------------------------------------------------------

# Les projets R (ou projets RStudio) offrent un workflow robust qui nous sera utile :
# - construit sur l'idée que tous les fichiers associés à un projet devraient être
# stockés au même endroit
#   - facilite la recherche de fichiers
#   - augmente la reproductibilité
#   - facilite la collaboration
# - définit le répertoire de travail dans le dossier où se trouve le fichier .Rproj
#   - assure un répertoire de travail correct
#   - indépendant du setup et de l'organisation des dossiers
#   - réduit les obstacles lors d'une collaboration

# Pour créer un projet R de zéro : File > New Project > New Directory > R Project

# Associer un projet à un dossier existant : File > New Project > Existing Directory

# Pour ouvrir un projet dans RStudio : 
# - explorateur de fichier classique, naviguer jusqu'au répertoire de travail, et
# cliquer sur le fichier .Rproj

# - Dans RStudio, File > Open Project > naviguer

# - Dans RStudio, tout en haut à droite, sélectionner le projet dans le menu déroulant

# 🔢 VALEURS --------------------------------------------------------------

1
"Hello World!"
"2024-11-26 14:57:00"
x
"x"
pi

# Mise en pratique
# Tapez `2 + 3` et exécutez
# Essayez d'autres opérateurs arithmétiques comme -, *, /, ou ^.
# Calculez la racine carrée d'un nombre avec sqrt()

# R est un calculateur!
2 + 3
(59 + 73 + 2) * 5
1 / 200 * 30
sin(pi / 2)
10^12 * sqrt(4312)
log(exp(5))

# ⌨️ FONCTIONS ------------------------------------------------------------

sqrt(x = 25)
# sqrt : nom de la fonction
# x : nom de l'argument
# 25 : valeur de l'argument
# 5 : résultat

# R a une large collection de fonctions incluses qui sont appelées de la manière suivante :
# function_name(arg1 = val1, arg2 = val2, ...)

# Nous avons déjà vu d'autres fonctions dans les exercices précédents : 
# +, -, *, ^, sqrt(), log() sont des fonctions

sqrt(x = 25)
log(x = 25)
sin(x = pi / 2)
exp(x = 4)
mean(x = 4)

5^2

5 / 2
5 %/% 2
5 %% 2

# Corps de la fonction :
log
mean
methods(mean)
`+`
read.csv
read.table

# Arguments d'une fonction
log(x = 25)  # `base = exp(1)` par défaut
log(x = 25, base = 10)
log10(x = 25)  # équivalent de log(x = 25, base = 10)
log2(x = 25)  # équivalent de log(x = 25, base = 2)

# Apprendre à utiliser une fonction
help(log)
?log
# curseur + F1

# Aide d'une fonction : 
# - Description
# - Usage
# - Arguments

# Arguments d'une fonction: matching implicite
log(x = 25, base = 5)
log(25, 5)  # le 1er argument est `x`, le 2nd `base`
log(5, 25)  # le 1er argument est `x`, le 2nd `base`
log(25, base = 5)  # le 1er argument est `x`
log(base = 5, 25)  # à éviter
log(base = 5, x = 25)  # si on souhaite inverser l'ordre des arguments, les déclarer explicitement

# Matching implicite: attention!

# Noms d'arguments explicites (cet exemple utilise des vecteurs, càd des séquences de nombres créées à l'aide
# de `c()`, que nous verrons plus tard)
quantile(x = c(5, 1, 3), probs = c(0.25, 0.5, 0.75))

# Matching implicite par positions d'arguments
quantile(c(5, 1, 3), c(0.25, 0.5, 0.75))

# L'inversion des positions d'arguments peut engendrer tout un tas de problèmes
quantile(c(0.25, 0.5, 0.75), c(5, 1, 3))
quantile(c(0.25, 0.5, 0.75), c(0.95, 0.345, 1))

# ⌨️ MISE EN PRATIQUE -----------------------------------------------------

# Lesquelles de ces commandes vont fonctionner ?
log(x = 1)
log(x = "1")
log(x)
log(value = 1)
log(`1`)
log(1)

# ⬅️ ASSIGNATION ET OBJETS ------------------------------------------------

# Exécutez `x <- 1` puis `x`
x <- 1
x

# Exécutez maintenant `x + 2`
x + 2

# Exécutez `x <- 5` et à nouveau `x + 2`
x <- 5
x + 2

# Pourquoi n'y a-t-il aucune sortie après la 1e commande ?
# Quel est l'utilisé du symbole `<-` ?
# Quelle est la valeur finale de x ?
# Que se passe-t-il si on exécute `y <- x` ? Puis `y <- x <- 2`
y <- x ; x; y
y <- x <- 2 ; x ; y
# Que se passe-t-il si on exécute `y <- 2 <- x` ?
y <- 2 <- x
# Peut-on assigner une valeur et afficher l'objet en même temps ?
(x <- 4)

# Assignation : name <- "Cedric"
# name : nom de l'objet
# <- : flèche d'assignation
# "Cedric" : valeur de l'objet

x <- 1
x

x + 2

x <- 5
x + 2

x

y <- x
y

y <- x <- 2
x
y

y <- 2 <- x
