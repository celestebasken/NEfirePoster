# NE fire poster

# Mean Fire Return Interval horizontal bar
library(ggplot2)
library(readr)
library(tidyverse)
mfri <- read_csv("data/NE_mfri_clean.csv")
mfriPlot <-
mfri %>%
  mutate(LABEL = fct_reorder(LABEL, VALUE)) %>% # this line orders them by year, but they're backwards
  ggplot( aes(x=LABEL, y=ACRES)) +
  geom_bar(stat="identity", fill="#56bf5f", alpha=.8, width=.8) +
  coord_flip() +
  xlab("") +
  theme_bw() 

mfriPlot
