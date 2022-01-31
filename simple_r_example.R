library(sfsmisc)
l_percent <- 7
h_percent <- 8

# start variable
muskcoins <- 200
doge <- 150

# calculate nft and split
nft <- muskcoins - doge
split <- doge / muskcoins

x <- seq(0, 100, by = 0.001)
set.seed(1)
# density of unif + nrom; by split of muskcoins
den <-
  density((runif(x, min = 6, max = 8)) * split +
            (rnorm(x, mean = 8, sd = 2) * (1 - split)))

# calculate mean of density
mean_den <- mean(den$x)

# integrate.xy(from library "sfsmisc") density from sliderinput
P_x <- sfsmisc::integrate.xy(den$x, den$y, l_percent, h_percent)

