# ATELIERS CODONS
# VISUALISATION DE DONNEES A L'AIDE DE GGPLOT2
# EXTENSIONS
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
library(ggdist)

pacman::p_load(tidyverse, palmerpenguins, ggdist)

# 🔽 IMPORTER LES DONNEES -------------------------------------------------

# Le package "palmerpenguins" contient 2 datasets :
# - penguins_raw : données brutes
# - penguins : données nettoyees

# Pour ce tutoriel de perfecionnement nous allons utiliser les donnees nettoyees.

penguins <- palmerpenguins::penguins

# 📊 GGDIST ---------------------------------------------------------------

penguins |> 
  ggplot(aes(x = body_mass_g, y = species)) +
  stat_halfeye()

penguins |> 
  ggplot(aes(x = body_mass_g, y = species)) +
  stat_eye()

penguins |> 
  ggplot(aes(x = body_mass_g, y = species)) +
  stat_gradientinterval()

penguins |> 
  ggplot(aes(x = body_mass_g, y = species)) +
  stat_histinterval()

penguins |> 
  ggplot(aes(x = body_mass_g, y = species)) +
  stat_cdfinterval()

penguins |> 
  ggplot(aes(x = body_mass_g, y = species)) +
  stat_ccdfinterval()

penguins |> 
  ggplot(aes(x = body_mass_g, y = species)) +
  stat_interval()

penguins |> 
  ggplot(aes(x = body_mass_g, y = species)) +
  stat_pointinterval()

penguins |> 
  ggplot(aes(x = body_mass_g, y = species)) +
  stat_slab()

penguins |> 
  ggplot(aes(x = body_mass_g, y = species)) +
  stat_dots()

penguins |> 
  ggplot(aes(x = body_mass_g, y = species)) +
  stat_dotsinterval()

# 📊GGSTATSPLOT -----------------------------------------------------------

penguins |> 
  ggstatsplot::ggbetweenstats(x = species, y = bill_length_mm)
