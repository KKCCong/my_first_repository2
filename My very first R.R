
# -----
# MY VERY FIRST INTRODUCTION TO R
# AUTHOR: Ke Cong
# Date: March 4 2024
# DeSCRIPTION: First lecture notes from the CP BOOTCAMP
# ----

# Introduction----

3+ 4

3 ^42

3 + 5 ; 12 - 8

3:10  
3:100

6 / 2^2 -1
(6/2)^2 - 1

# This is my first vector:
1:6


# Here is a longer vector:
23:59

# My first R object----
a <- 3

die <- 1:6


# Naming objects:
namesAreCaseSensitive <- 3
namesAreCaseSENSITIVE <- 5

# They cannot start eiwht a number or a special 
1object <- 100
@nospecial <- 100

underscores_or.dots.are.okay <- 10


namesAreCaseSensitive / 2


NA <- 3
NULL <- 5
TRUE <- 10

# elementwise operations
die
die - 1
doubled_die <- die*2
die * die
die * doubled_die
die %*% die
die %o% die
rep(1/6,6)
probability = rep(1/6,6)
sum(die * probability)

die * 1:2
die * c(1,2,1,2,1,2)
die * 1:4

# Function ----
round(3.5)

rnorm(1)
factorial(5)
exp(2)
log(2)
log(100)
log2(16)
rnorm(n = 10, mean = 0, sd = 3)
mean(1:10)
mean
rnorm(1)
round(mean(1:10))
a <- exp(2)
rounded_a <- round(a)
sample(x = die, size = 2, replace = TRUE)
sample(die, 2, TRUE)
sample(x = die)
sample(size = 3)
sample(x = die, size = 6)
?sample()




sample(x = 7, size = 2, replace = TRUE)


if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("ComplexHeatmap")
??qplot
ggplot2::qplot()
library(ggplot2)
library(tidyverse)

library(ComplexHeatmap)

Heatmap()

qplot()
qplot()

x <- c(-1, 0.8, 0.5, 3, -2, 10, 1.1, 5)
x <- sort(x)
y<- x^3
y
plot(x,y, type = "b")

?base::sort
?base::plot

qplot(x,y)

qplot(y)

x
y

brew install git
