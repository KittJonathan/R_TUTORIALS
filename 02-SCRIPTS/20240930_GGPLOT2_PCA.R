# ATELIERS CODONS
# VISUALISATION DE DONNEES A L'AIDE DE GGPLOT2
# ACP
# https://www.kaggle.com/code/jbasurtod/principal-component-analysis-on-palmer-penguins/notebook
# 2024-09-30

# 📦 INSTALLER LES PACKAGES -----------------------------------------------

install.packages("tidyverse")  # manipulation, visualisation
install.packages("palmerpenguins")  # jeux de donnees
install.packages("summarytools")  # exploration des donnees
install.packages("GGally")  # matrice de correlation
install.packages("corrr")
# install.packages("ggstatsplot")  # representer des tests stats
# install.packages("skimr")  # synthese des donnees
# install.packages("janitor")  # nettoyage des donnees
# install.packages("glue")  # evaluer du code et l'inserer dans du texte

# 📦 CHARGER LES PACKAGES$ ------------------------------------------------

library(tidyverse)  
library(palmerpenguins)
library(summarytools)
library(GGally)
library(corrr)
# library(skimr)
# library(janitor)
# library(glue)
# library(ggstatsplot)

pacman::p_load(tidyverse, palmerpenguins, skimr, janitor, glue)

# 🔽 IMPORTER LES DONNEES -------------------------------------------------

# Le package "palmerpenguins" contient 2 datasets :
# - penguins_raw : données brutes
# - penguins : données nettoyees

# Pour ce tutoriel de perfecionnement nous allons utiliser les donnees nettoyees.

penguins <- palmerpenguins::penguins

# 🔎 EXPLORATION DES DONNEES ----------------------------------------------

view(dfSummary(penguins))

# Pour l'ACP, nous ne garderons que les variables numeriques.
# Attention, la variable 'year' est de type 'integer', mais nous allons
# considerer qu'il s'agit d'une variable qualitative, et nous ne la 
# conservons pas pour la suite des analyses.
# Nous supprimons les donnees manquantes.
# Nous conservons egalement la variable 'species' pour garder l'information.

df <- penguins |> 
  select(species, where(is.numeric), -year) |> 
  drop_na()

view(dfSummary(df))

# 📊 MATRICE DE CORRELATION -----------------------------------------------

my_cols <- c("Adelie" = "darkorange",
             "Chinstrap" = "purple",
             "Gentoo" = "cyan4")

df |> 
  ggpairs(aes(color = species),
          columns = c("bill_length_mm", "bill_depth_mm",
                      "flipper_length_mm", "body_mass_g")) +
  scale_color_manual(values = my_cols) +
  scale_fill_manual(values = my_cols)

df |> 
  select(-species) |> 
  corrr::correlate(method = "spearman") |> 
  pivot_longer(cols = -term,
               names_to = "var2",
               values_to = "cor")



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
