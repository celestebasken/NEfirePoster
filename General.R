# NE fire poster
options(scipen = 999) 
# Mean Fire Return Interval horizontal bar
library(ggplot2)
library(readr)
library(tidyverse)
library(scales)
mfri <- read_csv("data/NE_mfri_clean.csv")
mfriPlot <-
mfri %>%
  mutate(LABEL = fct_reorder(LABEL, -VALUE)) %>% 
  ggplot( aes(x=LABEL, y=ACRES)) +
  geom_bar(stat="identity", fill="#56bf5f", alpha=.8, width=.8) +
  coord_flip() +
  xlab("") +
  theme_bw() + ggtitle("Mean Fire Return Interval") +
  scale_y_continuous(name="Acres", labels = comma)

mfriPlot

## Fire x ecosystems historically grouped bar
  # this way does it broken by groupVeg and then by type of disturbance
library(ggplot2)
library(readr)
library(scales)
groupVegData <- read_csv("data/groupVegFireAcres.csv")

ggplot(groupVegData, aes(fill=disturbance, y=acres, x=groupVeg)) + 
  geom_bar(position="dodge", stat="identity") +
  theme_bw() + 
  ggtitle("Acres of Historical Disturbance by Vegetation Group") +
  xlab("") + ylab("Acres") + guides(fill=guide_legend(title="Fire Type")) +
  coord_flip() 

groupColors <-c(  "#1d4220", # conifer OK
                  "#e6e0be", # grassland OK
                  "#56bf5f", # hardwood OK
                  "#397d3f", # hardwood-conifer OK
                  "#7db7c7", # riparian OK
                  "#5e513a", # savana
                  "#917e5c") # shrub
# information for potential later use:
#   "#fed9w8e", # surface
#   "#fe9929", # mixed
#   "#cc4c02" # replacement(?)

# removing savanna and shrub
limitedGroupVeg <- groupVegData[-c(16, 17, 18, 19, 20, 21), ]

ggplot(limitedGroupVeg, aes(fill=groupVeg, y=acres, x=disturbance)) + 
  geom_bar(position="stack", stat="identity") +
  scale_fill_manual(values = groupColors) +
  theme_bw() + ggtitle("Acres of Historical Disturbance by Fire Type") +
  xlab("") + ylab("Acres") + guides(fill=guide_legend(title="Vegetation group")) +
  scale_y_continuous(labels = comma)



## Bar chart with states
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
library(scales)
historicCurrentStates <- read_csv("data/historicCurrentStates.csv")
ggplot(historicCurrentStates, aes(y=state, x=historic_acres_burned, xend=currentAverageAcres)) +
  geom_dumbbell(size=3, color="#e3e2e1",
                colour_x = "#5b8124", colour_xend = "#bad744",
                dot_guide=TRUE, dot_guide_size=0.25) +
  labs(x=NULL, y=NULL, title="Change in acres burned") +
  theme_minimal() +
  theme(panel.grid.major.x=element_line(size=0.05)) +
  scale_x_continuous(labels = comma)


# randy code for saving
ggsave(filename = "sageSteppeChart3.png", plot = sageSteppeChart3, device = "png",  
       width = 5.75, height = 3.8, units = "in", dpi = 500)