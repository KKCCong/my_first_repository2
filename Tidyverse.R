


# DAY3 Introduction to Tidyverse -----
# March 6, 2024

# load necessary libraries ----
library(tidyverse)
library(useful)
library(nycflights13)
library(ggthemes)
library(scales)
library(ggrepel)
install.packages("ggthemes")
install.packages("ggrepel")
install.packages("nycflights13")
?ggrepel
install.packages("ggforce")
library(ggforce)
install.packages("Hmisc")


# Tibbles vs Data frames----

vignette("tibble")

?iris
iris %>% head

as_tibble(iris)

tibble(x = 1:5,
       y = 1,
       z = x^2 + 1)

iris1
iris2 

# you cannot refer to the previous column while creating a data.frame
data.frame(x = 1:5,
       y = 1,
       z = x^2 + 1)

tibble(`:(` = "sad", `` = "space", `200` = "number")

iris[, "Sepal.Length", drop = FALSE] %>% head 
iris_t[, "Sepal.Length"]

tibble(-x,-y,-z,
        "a",1,2,
        "b",3,4)


nycflights13::flights
flights %>% print(n=10, width=Inf)

nycflights13 %>% view

df <- tibble(x = runif(5),y = rnorm(5))

df
df %>%


# Data visulization

?mpg
mpg %>% view
mpg %>% summary()
mpg %>% str
mpg %>% glimpse()
mpg %>% Hmisc::describe()

ggplot(data = mpg) + 
geom_point(mapping = aes(x = hwy, y= cyl))
ggplot(data = mpg) +
geom_point(mapping = aes(x = displ, y = hwy))

dim(mpg)
mpg
nrow(mpg)
ncol(mpg)


ggplot(data = mpg) + geom_point(mapping = aes(x = class, y = drv))

ggplot(data = mpg) + geom_jitter(mapping = aes(x = class, y = drv))

?geom_jitter

ggplot(data = mpg) + geom_jitter(mapping = aes(x = class, y = drv), 
                                 width = 0.1, height = 0.1)

?aes()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = class)) + 
  geom_point(size = 3, alpha = .75) + 
  geom_text(data = mpg[mpg$class == "2seater", ], aes(label = class)) + 
              theme_bw(base_size = 14, base_family = "Gillsans") + 
  labs(x = "Engine Displacement (liters)", 
      y = "Highway Efficiency (galons/mile)", color = "",
    title = "Except 2 seaters, larger engine less efficient",
    subtitle = "I can add a subtitle too!")


ggplot(mpg) + geom_point(mapping = aes(x = displ, y = hwy, size = class))

ggplot(mpg) + geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

ggplot(mpg) + geom_point(mapping = aes(x = displ, y = hwy, shape = class)) + 
  scale_shape_manual(value)


ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = class)) + 
  geom_point(size = 3, alpha = .75) + 
  geom_text_repel(aes(label = ifelse(class == "2seater", class, NA)),
                   color = "black") + 
  theme_bw(base_size = 14, base_family = "Gillsans") + 
  labs(x = "Engine Displacement (liters)", 
       y = "Highway Efficiency (galons/mile)", color = "",
       title = "Except 2 seaters, larger engine less efficient",
       subtitle = "I can add a subtitle too!")

x <- ifelse(condition, x1, x2)

ggplot(mpg) + geom_point(aes(x = displ, y = hwy, colour = "firebrick"))

ggplot(mpg) + geom_point(aes(x = displ, y = hwy, colour = cty)) + 
  scale_color_viridis_b()

# Facets ------
ggplot(mpg) + geom_point(aes(x = displ, y = hwy)) +
                           facet_wrap(. ~ class + drv)

ggplot(mpg) + geom_point(aes(x = displ, y = hwy)) +
  facet_wrap(. ~ class, scales = )

ggplot(mpg) + geom_point(aes(x = displ, y = hwy)) +
  facet_wrap(. ~ class, scales = "free")

ggplot(mpg) + geom_point(aes(x = displ, y = hwy)) +
  facet_wrap(. ~ class, scales = "free_x")

ggplot(mpg) + geom_point(aes(x = displ, y = hwy)) +
  facet_wrap(. ~ class, ncol = 2)

ggplot(mpg) + geom_point(aes(x = displ, y = hwy)) +
  facet_wrap(. ~ class, nrow = 1)

ggplot(mpg) + geom_point(aes(x = displ, y = hwy)) +
  facet_grid(drv ~ class, scales = "free")

# ggforce

ggplot(mpg) + geom_point(aes(x = displ, y = hwy)) +
  facet_wrap_paginate(cyl ~ class + drv, scales = "free", 
                      nrow = 2, ncol= 3, page = 3)

ggplot(mpg) + geom_point(aes(x = displ, y = hwy)) +
  facet_zoom(xy = (displ > 5) & (hwy > 20), split = TRUE) + 
  theme_bw()

ggplot(mpg) + geom_point(aes(x = displ, y = hwy, color = cty)) +
  facet_zoom(xy = (displ > 5) & (hwy > 20), split = TRUE) + 
  theme_bw() + scale_color_viridis_b()

# Geometric Objects -----

# points
ggplot(mpg) + geom_point(aes(x = displ, y = hwy))

# smooth line
ggplot(mpg) + geom_smooth(aes(x = displ, y = hwy))

ggplot(mpg) + geom_smooth(aes(x = displ, y = hwy, linetype = drv))
ggplot(mpg) + geom_smooth(aes(x = displ, y = hwy, 
                              linetype = drv, color = drv),
                          show.legend = FALSE)

ggplot(mpg, aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(aes(lty = drv), show.legend =  FALSE)

mpg %>%
ggplot(aes(x = displ, y = hwy)) + 
  geom_point(aes(color = class), size = 2) + 
  geom_smooth(data = mpg[mpg$class != "2seater", ], 
              se = TRUE, color = "black") + 
  theme_base(base_size = 12, base_family = "Gillsans") + 
  labs(x = "Engine Displacement (liters)", 
       y = "Fuel Efficiency (mpg)", color = "Class", shape = "Drive train",
       title = "Effcicency decreseas as engine gets larger",
       subtitle = "2 seaters are excluded from the fitted curve")
# OR
mpg %>%
  ggplot(aes(x = displ, y = hwy)) + 
  geom_point(aes(color = class), size = 2) + 
  geom_smooth(data = dplyr::filter(mpg, class != "2seater", ), 
              se = FALSE, color = "black") + 
  theme_base(base_size = 12, base_family = "Gillsans") + 
  labs(x = "Engine Displacement (liters)", 
       y = "Fuel Efficiency (mpg)", color = "Class", shape = "Drive train",
       title = "Effcicency decreseas as engine gets larger",
       subtitle = "2 seaters are excluded from the fitted curve")

#1st
mpg %>%
  ggplot(aes(x = displ, y = hwy)) + 
  geom_point(aes(size = class), size = 3) + 
  geom_smooth(data = mpg, 
              se = FALSE, color = "blue") + 
  theme_base(base_size = 12, base_family = "Gillsans") + 
  labs(x = "Engine Displacement (liters)", 
       y = "Fuel Efficiency (mpg)", color = "Class", shape = "Drive train",
       title = "Effcicency decreseas as engine gets larger",
       subtitle = "2 seaters are excluded from the fitted curve")
#2nd
mpg %>%
ggplot(aes(x = displ, y = hwy)) + 
  geom_point(aes(size = class), size = 3) + 
  geom_smooth(aes(lty = drv), show.legend =  FALSE) +
  theme_base(base_size = 12, base_family = "Gillsans") + 
  labs(x = "Engine Displacement (liters)", 
       y = "Fuel Efficiency (mpg)", color = "Class", shape = "Drive train",
       title = "Effcicency decreseas as engine gets larger",
       subtitle = "2 seaters are excluded from the fitted curve")

#1st slide 15
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + geom_smooth(se = FALSE)

ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + 
  geom_smooth(aes(group = drv), se = FALSE)

ggplot(mpg, aes(x = displ, y = hwy), color = drv) + 
  geom_point(aes(color = drv)) + geom_smooth(se = FALSE)

ggplot(mpg, aes(x = displ, y = hwy), color = drv) + 
  geom_point(aes(color = drv)) + 
  geom_smooth(aes(group = drv, color = drv), se = FALSE)

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point(aes(group = drv, color="white"), size = 3) + 
  geom_smooth(aes(group = drv, color = drv), se = FALSE)

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = drv)) +
  geom_smooth(aes(lty = drv), se = F)

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(fill =drv), shape = 21 , 
             color = "white", stroke = 1, size = 2)

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(color ="white",  size =3 )+
  geom_point(aes(color =drv))

mpg_tiny

mpg %>%
  ggplot(aes(x = drv, y = hwy, color = drv, fill =drv)) +
  geom_violin(color = "black", alpha = .1, show.legend = FALSE) +
  geom_sina(show.legend = FALSE) +
  geom_boxplot(alpha = 0, color = "black", width = .1, show.legend = FALSE) + 
  theme_bw() +
  facet_wrap(cyl ~., nrow = 1)


#mpg_tiny %>% ---
mpg_tiny <- mpg %>%
  dplyr::filter(cyl %in% c(4,6), drv %in% c("4","f"))

p1 = mpg_tiny %>%
  ggplot(aes(x = drv, y = hwy), color = drv, fill =drv) +
  geom_violin(color = "black", alpha = .1, show.legend = FALSE) +
  geom_sina(show.legend = FALSE) +
  geom_boxplot(alpha = 0, color = "black", width = .1, show.legend = FALSE) + 
  theme_bw() +
  facet_wrap(cyl ~., nrow = 1)


mpg_tiny %>%
  ggplot() + geom_density(aes(x= hwy, color = class))

mpg_tiny %>%
  ggplot() + geom_density(aes(x= hwy, fill = class), alpha = .5)

mpg_tiny %>%
  ggplot() + geom_histogram(aes(x= hwy, fill = class), alpha = 0.5,
                            binwidth = 10)

mpg_tiny %>%
  ggplot() + geom_histogram(aes(x= hwy, fill = class), position = "identity", 
                            alpha = 0.5,
                            binwidth = 10)

install.packages("ggbeeswarm")
library(ggbeeswarm)
install.packages("quasirandom")
library(quasirandom)

ggplot(mpg, aes(class, hwy,
                color = drv)) +
  geom_quasirandom()

ggplot(mpg, aes(class, hwy,
                color = drv)) +
  geom_beeswarm()


mpg %>%
  ggplot() +
  geom_bar(aes(x=class))


mpg %>%
  ggplot() +
  geom_bar(aes(x=class, y = after_stat(count)))


mpg %>%
  ggplot() +
  stat_count(aes(x = class))

mpg %>%
  dplyr::count(class) %>%
  ggplot() +
  geom_bar(aes(x=class, y = n), stat = "identity")

mpg %>%
  ggplot() +
  geom_bar(aes(x=class, y = after_stat(prop), group = 1))

mpg %>%
  ggplot() +
  stat_summary(aes(x=class, y = hwy),
               fun = median,
               fun.min = min, fun.max = max)

mpg %>%
  ggplot() +
  geom_bar(aes(x=class, y = after_stat(prop)))


mpg %>%
  ggplot() +
  geom_bar(aes(x=class, fill= drv, y = after_stat(prop), group = 1))

mpg %>%
  ggplot() +
  geom_bar(aes(x=class, fill= drv, y = after_stat(prop)))

mpg %>%
  ggplot() +
  geom_bar(aes(x=class, fill= drv, y = after_stat(prop), group = drv))

diamonds

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity, color= color))

??geom_bar

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "stack")

diamonds %>%
  ggplot() + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")

diamonds %>%
  ggplot() + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")

diamonds %>%
  ggplot() + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "identity", alpha=0.5)

diamonds %>%
  ggplot() + 
  geom_bar(mapping = aes(x = cut, color = clarity), position = "identity", alpha=0)

#exercise
diamonds %>%
  ggplot() + 
  geom_bar(mapping = aes(x = cut, color = clarity), position = "dodge", alpha = 0.2)

diamonds %>%
  ggplot() + 
  geom_histogram(aes(x = carat, fill = color))

diamonds %>%
  ggplot() + 
  geom_histogram(aes(x = carat, fill = color), position = "dodge")

diamonds %>%
  ggplot() + 
  geom_histogram(aes(x = carat, fill = color), position = "fill")


diamonds %>%
  ggplot() + 
  geom_histogram(aes(x = carat, fill = color), position = "identity", alpha= .5) + 
  scale_fill_ptol() + theme_bw()

mpg %>%
ggplot() + geom_point(aes(x = displ, y = hwy), position = "jitter")

mpg %>%
  ggplot() + geom_boxplot(aes(x = class, y = hwy))


mpg %>% 
  ggplot() + geom_boxplot(aes(x = as.character(cyl), y = hwy))


mpg %>%
  ggplot() + geom_boxplot(aes(x = as.factor(cyl), y = hwy))

?fct_infreq

mpg %>%
  ggplot() + geom_boxplot(aes(x = trans, y = displ))


mpg %>%
  ggplot() + geom_boxplot(aes(x = reorder(trans,displ, median), 
                              y = displ)) + 
  coord_flip()

mpg %>% 
  ggplot() + geom_boxplot(aes(x = as.character(cyl), y = hwy, color = class)) + 
  labs(x = "cyl")

c(2,4,6) %>% as.character()

c(2,4,6) %>% as.factor()

# coordinate systems -----

mpg %>%
  ggplot(aes(x = trans, y = displ)) + geom_boxplot() +
  theme(axis.text.x=element_text(angle = 75, vjust = 1, hjust =1))

mpg %>%
  ggplot(aes(x = trans, y = displ)) + geom_boxplot() +
  coord_flip()

bar <- ggplot(diamonds) +
  geom_bar(aes(x = cut, fill = cut),
             show.legend = FALSE, width = 1)

bar

bar <- ggplot(diamonds) +
  geom_bar(aes(x = cut, fill = cut), show.legend = FALSE, width = 1)
theme(aspect.ratio = 1) + labs(x=NULL, y= NULL)

bar2 <- bar + coord_flip()

bar3 <- bar + coord_polar()

bar2
bar3

p1 <- cowplot::plot_grid(bar, bar2, nrow = 1)
cowplot::plot_grid(p1, bar3, nrow=1)

mpg %>%
  ggplot(aes(x = cty, y = hwy)) + geom_point() + 
  coord_cartesian(xlim=c(0,NA),
                  ylim=c(0,NA))


mpg %>%
  ggplot(aes(x = cty, y = hwy)) + geom_point() + geom_smooth() + xlim(10,20)+
                  ylim(10,30)

mpg %>%
  ggplot(aes(x = cty, y = hwy)) + geom_point() + geom_smooth() +
  coord_cartesian(xlim=c(10,20),
                  ylim=c(10,30))

mpg %>%
  ggplot(aes(x = cty, y = hwy)) + geom_point() + geom_smooth() +
  geom_abline() + 
  geom_vline(aes(xintercept = 15)) + 
  geom_hline(aes(yintercept = 20)) 
  geom_abline(slope = 2, intercept = 1, lty = 2) + 
  coord_cartesian(xlim=c(10,20),
                  ylim=c(10,30))


# -----
# Introduciton to Tidyverse Part 2
# Ke Cong
# 7 MARCH 2024

library(tidyverse)
library(taigr)  
options(taigaclient.path=path.expand("~/miniconda3/miniconda3/envs/taigapy/bin/taigaclient"))
taigr::load.from.taiga("taigr-data-40f2.7/tiny_matrix")


# CRIPSPR gene dependency matrix, each row is a cell line
CRISPReffect
# Each value is probability of dependency
# Each value is Chronos score -- -1 is median of essential genes
  
colnames(CRISPR)

rm(CRISPRGeneDependency)

# Copy Number FEATURES
Omics
Omics

# Expression

# ssGSEA Features derived from expression

# Fusions

# Loss of heterozygosity

# A small matrix with MSI score, Aneuploidy score, ...

# Mutations


flights
head(flights)
glimpse(flights)
summary(flights)

# Filtering Rows -----

jan1 <- flights %>%
  dplyr::filter(month == 1, day ==1)

# both assign and print
(march24 <- flights %>%
  dplyr::filter(month == 3, day ==24))

filter(flights, month == 1)

sqrt(2)^2 == 2
1/49 * 49 == 1
near(1/49 * 49, 1)
?near()

nov_dec <- flights |>
  dplyr::filter(month == 11 | month == 12)

nov_dec <- flights |>
  dplyr::filter(month >= 11)
  
# What does this meean?
flights %>%
  dplyr::filter(!(arr_array > 120 | dep_delay > 120))

flights %>%
  dplyr::filter(arr_array <= 120, dep_delay <= 120)

flights %>%
  dplyr::filter(arr_array <= 120) %>%
  dplyr::filter(dep_delay <= 120)

# NA's are contigous
NA>5
10 == NA
NA == NA

is.na(NA)

df <- tibble(x = c(1,NA,3))
df %>% dplyr::filter(x>1)
df %>% dplyr::filter(!(x>1))
df %>% dplyr::filter((x>1)|is.na(x))


flights %>% glimpse
  dplyr::filter(arr_array >= 2)

flights %>%
  dplyr::filter(dest %in% c ("IAH", "HOU"))
  
flights %>%
  dplyr::filter(dest == "IAH" | dest == "HOU")
  
flights %>%
  dplyr::filter(is.na(dep_time))

# Arrange to sort the table
flights %>%
  dplyr::arrange(year, month, day)

# These two are qquivalent for numerical variation
flights %>%
  dplyr::arrange(desc(dep_delay))

flights %>%
  dplyr::arrange(-dep_delay)

flights %>%
  dplyr::arrange(desc(dep_delay), day)


#Default behavour of sorting is putting NA's to the end of the list
df 
dplyr::arrange(df,x)
dplyr::arrange(df,desc(x)) 


# conda activate taigapy

# pip install git+https://github.com/broadinstitute/taigapy.git@3.7.1


OmicsSomaticMutations <- load.from.taiga(data.name='internal-23q4-ac2b', data.version=68, data.file='OmicsSomaticMutations')

OmicsSomaticMutations %>%
  as_tibble()

# Selecting columns
flights
OmicsSomaticMutations

# Selecting colums by name

flights %>% 
  dplyr::select(year, month, day)

flights %>% 
  dplyr::distinct(year, month, day)

names(flights)

flights %>% 
  dplyr::select(year:day)

# all but things between year and day
flights %>% 
  dplyr::select(-(year:day))

flights %>% 
  dplyr::select(!(year:day))

flights %>% 
  dplyr::distinct(year, month, day, .keep_all = TRUE)

flights %>% 
  dplyr::select(Month=month, day, year) %>% head

flights %>% 
  dplyr::rename(Month=month) %>% head

flights %>% 
  dplyr::relocate(dep_time, sched_dep_time, .before = month)

flights %>% 
  dplyr::relocate(dep_time, sched_dep_time, .after = year)

flights %>% 
  dplyr::select(flight, time_hour, air_time, everything())

flights %>% 
  dplyr::relocate(flight, time_hour, air_time)

flights %>% 
  dplyr::select(flight, time_hour, air_time, ends_with("delay"))

?dplyr::select

a <- "Ke Cong"
b <- "KE CONG"
c <- "ke cong"
d <- "ke::cong"
tolower(c(a,b,c))
toupper(c(a,b,c))
make.names(c(a,b,c))

word(d, 1, -2, sep=fixed("::"))
substr(d,1,5)

flights %>% 
  dplyr::distinct(month, day, year)

flights %>% 
  dplyr::count(month, day, year)

flights %>% 
  dplyr::select(month, month, day)

OmicsSomaticMutations %>%
  glimpse

trimmed_mutations <- OmicsSomaticMutations %>%
  dplyr::select(ProteinChange, HugoSymbol, ModelID, HessDriver, LikelyLoF)

trimmed_mutations

# How many distinct driver (Hess) mutations
# with specified protein change?

trimmed_mutations %>% 
  dplyr::filter(HessDriver, !is.na(ProteinChange)) %>%
  dplyr::distinct(ProteinChange, HugoSymbol)

# For your favorite 3-5 genes, create a 
# barplot to show their count across depmap panel
# highlighting Hess drivers.

mygenes <- trimmed_mutations %>% 
  dplyr::filter(HessDriver, !is.na(ProteinChange)) %>%
  dplyr::distinct(ProteinChange, HugoSymbol)

trimmed_mutations %>%
  dplyr::filter(HugoSymbol %in% c("RB1", "EGFR", "BRAF", "PTEN","VHL")) %>%
  ggplot() + 
  geom_bar(aes(x=HugoSymbol, fill=HessDriver))
  
# Mutation: Creating/adding new columns -----

flights_small <- flights %>%
  dplyr::select(year:day,
                ends_with("delay"),
                distance,
                air_time)

flights_small
flights_small %>%
  dplyr::mutate(gain = dep_delay - arr_delay,
                speed = distance / air_time)

flights_small %>%
  dplyr::mutate(gain = dep_delay - arr_delay,
                speed = distance / air_time,
                .before = dep_delay)


# Some misc. functions

x <- 1:10
x
lag(x)
lead(x)
diff(x)

sum(x)
cumsum(x)
cummean(x)
y<- c(1,2,2,NA,3,4)
rank(y)
min_rank(y)

flights_small %>%
  dplyr::mutate(average_dep_delay = mean(dep_delay, na.rm = T),  
                log2_dep_delay=log2(dep_delay))
                head

                
# Grouping Summaries ------
flights %>% 
   dplyr::summarise(ave_dep_delay = mean(dep_delay, na.rm = T),
                    ave_arr_delay = mean(arr_delay, na.rm = T),
                    med_dep_delay = median(dep_delay, na.rm = T),
                    med_arr_delay = median(arr_delay, na.rm = T))
       
flights %>% 
  dplyr::sample_n(1000) %>%
  ggplot(aes(x = dep_delay,
             y = arr_delay)) + 
  geom_density_2d()

flights %>% 
  dplyr::sample_n(1000) %>%
  ggplot(aes(x = dep_delay,
             y = arr_delay)) + 
  geom_point()

flights %>% 
  dplyr::group_by(month, day, year)


day_summaries <- flights %>% 
  dplyr::group_by(month, day, year) %>%
  dplyr::summarise(ave_dep_delay = mean(dep_delay, na.rm = T),
                   ave_arr_delay = mean(arr_delay, na.rm = T),
                   med_dep_delay = median(dep_delay, na.rm = T),
                   med_arr_delay = median(arr_delay, na.rm = T))

day_summaries <- day_summaries %>%
  dplyr::group_by(month)

day_summaries

delays <- flights %>%
  dplyr::group_by(dest) %>%
  dplyr::summarise(count = n(),
                   dist = mean(distance, na.rm = TRUE),
                   delay = mean(arr_delay, na.rm = TRUE)) %>%
  dplyr::filter(count > 20, dest != "HNL")

delays

delays %>%
  ggplot(aes(x = dist, y = delay)) +
  geom_point() +
  geom_smooth(se=FALSE)

not_cancelled <- flights %>%
  dplyr::filter(is.finite(dep_delay), is.finite(arr_delay)) 

not_cancelled %>%
  dplyr::group_by(tailnum) %>%
  dplyr::summarise(delay = mean(arr_delay)) %>%
  ggplot(aes(x = delay)) +
  geom_freqpoly(binwidth = 10)

not_cancelled %>%
  dplyr::group_by(tailnum) %>%
  dplyr::summarise(n=n(),
                   delay = mean(arr_delay)) %>%
  ggplot() +
  geom_point(aes(x=n, y=delay), alpha = .1) + theme_bw()

not_cancelled %>%
  dplyr::group_by(tailnum) %>%
  dplyr::summarise(n=n(),
                   delay = mean(arr_delay)) %>%
  dplyr::filter(n>25) %>%
  ggplot() +
  geom_point(aes(x=n, y=delay), alpha = .1) + theme_bw()

not_cancelled %>%
  dplyr::group_by(month) %>%
  dplyr::slice_head(n=3)

not_cancelled %>%
  dplyr::group_by(month) %>%
  dplyr::slice_tail(n=3)

not_cancelled %>%
  dplyr::group_by(month) %>%
  dplyr::arrange(dep_delay) %>%
  dplyr::slice_head(n=3)

not_cancelled %>%
  dplyr::group_by(month) %>%
  dplyr::top_n(n=3, -dep_delay)

not_cancelled %>%
  dplyr::group_by(month) %>%
  dplyr::sample_n(10)

# a useful shortcut
not_cancelled %>%
  dplyr::group_by(year, month, day) %>%
  dplyr::summarise(arr_delay1 = mean(arr_delay),
                   arr_delay2 = mean(arr_delay[arr_delay > 0]))

not_cancelled %>%
  dplyr::mutate(arr_delay2 = ifelse(arr_delay >0, arr_delay, NA)) %>%
  dplyr::group_by(year, month, day) %>%
  dplyr::summarise(arr_delay1 = mean(arr_delay),
                   arr_delay2 = mean(arr_delay2, na.rm = T))

# Why some distances are variable?
not_cancelled %>%
  dplyr::group_by(dest) %>%
  dplyr::summarise(distance_sd = sd(distance), distance_mean = mean(distance)) %>%
  dplyr::arrange(desc(distance_sd))

# When do the first and last flights leave each day?

not_cancelled %>%
  dplyr::group_by(year, month, day) %>%
  dplyr::summarise(earliest = min(dep_time),
                   latest = max(dep_time)) %>%
  dplyr::arrange(desc(earliest)) %>%
  View()
print(20)

flights_small %>%
  dplyr::group_by(day, month, year) %>%
  dplyr::arrange(desc(arr_delay)) %>%
  dplyr::slice_head(n = 9)

flights_small %>%
  dplyr::group_by(day, month, year) %>%
  dplyr::top_n(9, arr_delay)

popular_destinations <- flights %>%
  dplyr::group_by(dest) %>%
  dplyr::filter(n() > 200)

popular_destinations %>%
  dplyr::relocate(dest)

popular_destinations %>%
  View()

popular_destinations <- flights %>%
  dplyr::group_by(dest) %>%
  dplyr::filter(n() > 200)
  dplyr::ungroup()

popular_destinations %>%
  dplyr::filter(arr_delay >0) %>%
  dplyr::group_by(dest) %>%
  dplyr::mutate(prop_delay = arr_delay / sum(arr_delay)) %>%
  dplyr::select(year:day, dest, arr_delay, prop_delay) %>%
  dplyr::ungroup()

popular_destinations %>% 
  dplyr::summarise(ave_del = mean(dep_delay, na.rm = T),
                   .by = c(dest, month))

# Tidy Data ----

# Some data different representations
table1
table2
table3
table4a
table4b


# Compute rate per 10000
table1 %>%
  dplyr::mutate(rate = cases / population * 10000)

# Count cases per year
table1 %>%
  dplyr::count(year, wt = cases)

table1 %>%
  ggplot(aes(x = year, y = cases)) +
  geom_line(aes(group=country), color = "gray") +
  geom_point(aes(color = country)) +
  theme_bw()


# Pivoting -----

# Pivot longer
table4a

tidy4a <- table4a %>%
  tidyr::pivot_longer(cols = c(`1999`,`2000`),
                      names_to = "year",
                      values_to = "cases")
table4b


tidy4b <- table4b %>%
  tidyr::pivot_longer(cols = 2:3,
                      names_to = "year",
                      values_to = "population")

# We will learn this tomorrow morning, but we reproduced
dplyr::left_join(table4a, tidy4b)

# Pivot wider
table2 %>%
  tidyr::pivot_wider(names_from =type,
                     values_from= count)

table3

table3 %>% 
  tidyr::separate(rate, into = c("cases","population")) %>%
  dplyr::mutate(cases = as.numeric(cases),
                population = as.numeric(population))

table3 %>% 
  tidyr::separate(rate, into = c("cases", "year"),
                  convert = TRUE)

table3 %>%
  tidyr::separate(year, into = c("century", "year"),
                  sep = 2,
                  convert = TRUE)
  
# inverse of the separate is unite
table5 %>%
  tidyr::unite(year, century, year, sep = "")

table5 %>%
  tidyr::unite(year, century, year, sep = "/")

