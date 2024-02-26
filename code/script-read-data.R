
# Reproducibility workshop ------------------------------------------------

# This code reads in an example Excel data table.

# Libraries ---------------------------------------------------------------

library(readxl)      # read Excel files
library(tidyverse)   # tidy universe

# Read data ---------------------------------------------------------------

# By default, the executing directory is the project root directory.

dat <- read_xlsx("./data/mydata.xlsx",
                 na = "a", .name_repair = "universal")

# Data adjustments --------------------------------------------------------

dat <- dat %>% 
  # make factors
  mutate_at(vars(SCHLNR,
                 RASSE,
                 HERK,
                 Haltung) , ~as.factor(.)) %>% 
  # make date
  mutate_at(vars(GEBDAT,
                 SCHLDAT) , ~as.Date(.))

# Plot data ---------------------------------------------------------------

plot <- dat %>%
  ggplot(aes(x = Haltung,
             y = Sum.PUFAmg,
             fill = RASSE)) +
  geom_boxplot(col = "grey30",
               outlier.shape = NA, width=0.75,
               position = position_dodge(0.75)) +
  geom_point(aes(shape = HERK),
             col = "grey60", size = 2.5,
             position = position_jitterdodge()) +
  scale_y_continuous(limits = c(0, 400),
                     expand = c(0, 0),
                     breaks = seq(0,400,50)) +
  scale_fill_manual(values = c("#440154FF", "#21908CFF", "#FDE725FF")) +
  labs(x = "Haltung",
       y = "Summe PUFAs (mg)") +
  theme_bw() +
  guides(fill = guide_legend(override.aes = list(shape = NA)))

plot

# Save plot ---------------------------------------------------------------

png("./plots/myplot.png",
    width = 200, height = 180, units = "mm",
    pointsize = 10, res = 600)

plot

dev.off()

# How to cite R -----------------------------------------------------------

citation()
version$version.string

# Cite packages
citation("kableExtra")
citation("tidyverse")

# Session Info ------------------------------------------------------------

sessionInfo()

