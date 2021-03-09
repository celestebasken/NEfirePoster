# NE fire poster

# Mean Fire Return Interval horizontal bar
library(ggplot2)
library(readr)
library(tidyverse)
library(scales)
mfri <- read_csv("data/NE_mfri_clean.csv")
mfriPlot <-
mfri %>%
  mutate(LABEL = fct_reorder(LABEL, VALUE)) %>% # this line orders them by year, but they're backwards
  ggplot( aes(x=LABEL, y=ACRES)) +
  geom_bar(stat="identity", fill="#56bf5f", alpha=.8, width=.8) +
  coord_flip() +
  xlab("") +
  theme_bw() + ggtitle("Mean Fire Return Interval") # + options(scipen = 999) + scale_x_continuous(labels = comma)  + scale_x_continuous(labels = scales::comma)

mfriPlot

# Fire x ecosystems historically grouped bar
  # this way does it broken by groupVeg and then by type of disturbance
library(ggplot2)
library(readr)
groupVegData <- read_csv("data/groupVegFireAcres.csv")
ggplot(groupVegData, aes(fill=disturbance, y=acres, x=groupVeg)) + 
  geom_bar(position="dodge", stat="identity") +
  theme_bw() + 
  ggtitle("Acres of Historical Disturbance by Vegetation Group") +
  xlab("") + ylab("Acres") + guides(fill=guide_legend(title="Fire Type"))
  # this way does it broken by type of disturbance and then by groupVeg - if this is what we want, it's probably better as a stacked bar
ggplot(groupVegData, aes(fill=groupVeg, y=acres, x=disturbance)) + 
  geom_bar(position="stack", stat="identity") +
  theme_bw() + ggtitle("Acres of Historical Disturbance by Fire Type") +
  xlab("") + ylab("Acres") + guides(fill=guide_legend(title="Vegetation group"))

# Bar chart with states
library(ggplot2)
library(readr)
historicCurrentStates <- read_csv("data/historicCurrentStates.csv")
ggplot(historicCurrentStates, aes(x=state, y=`historical_ annual_percent_burned`)) + 
  geom_bar(stat = "identity", fill="#56bf5f") +
  theme_bw() + ggtitle("Historical Annual Percent Burned by State") +
  xlab("") + ylab("Percent")

# Dumbbell chart with states - not sure why they all start at 0
library(ggplot2)
library(readr)
library(ggalt)   
library(tidyverse)
historicCurrentStates <- read_csv("data/historicCurrentStates.csv")
ggplot(historicCurrentStates, aes(y=state, x=historic_acres_burned, xend=currentAverageAcres)) +
  geom_dumbbell(size=3, color="#e3e2e1",
                colour_x = "#5b8124", colour_xend = "#bad744",
                dot_guide=TRUE, dot_guide_size=0.25) +
  labs(x=NULL, y=NULL, title="Change in acres burned") +
  theme_minimal() +
  theme(panel.grid.major.x=element_line(size=0.05))
