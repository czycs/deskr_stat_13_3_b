# Deskriptive Statistik Blatt 13 Aufgabe 3 b


Unsere neue Verteilung $R_J$ setzt sich zusammen aus $R_1$ und $R_2$.
Der Erwartungswert von  $R_J$ für das Vermögen von 200 Muskcoins ist bekannt aus 3a (214.5), also folgt daraus:

<img src="https://latex.codecogs.com/png.image?\dpi{110}&space;V=Muskcoins\cdot&space;(1&plus;\frac{\frac{Muskcoins&space;In&space;Doge}{muskcoins}\cdot&space;R_1&space;&plus;\frac{Muskcoins&space;Nn&space;Nft}{muskcoins}\cdot&space;R_2}{100})" title="V=Muskcoins\cdot (1+\frac{\frac{Muskcoins In Doge}{muskcoins}\cdot R_1 +\frac{Muskcoins Nn Nft}{muskcoins}\cdot R_2}{100})" />


Daraus folgt:

$V=Muskcoins\cdot (1+\frac{\frac{Muskcoins In Doge}{muskcoins}\cdot R_1 +\frac{Muskcoins Nn Nft}{muskcoins}\cdot R_2}{100})$  

Für $R_J$ gilt also:  

$R_J=\frac{Muskcoins In Doge}{muskcoins}\cdot R_1 +\frac{Muskcoins In Nft}{muskcoins}\cdot R_2$  
bzw.  

$R_J=\frac{Muskcoins In Doge}{muskcoins}\cdot R_1 +\frac{Musnkcoins-Muskcoins In Doge}{muskcoins}\cdot R_2$  

$R_J=\frac{Muskcoins In Doge}{muskcoins}\cdot \mathcal{U}(6,8) +\frac{Musnkcoins-Muskcoins In Doge}{muskcoins}\cdot \mathcal{N}(8,4)$  

In R:  

```
x <- seq(0, 100, by = 0.001)

set.seed(1)
den<-density(Muskcoins_In_Doge/muskcoins*runif(x, min = 6, max = 8)+
    (muskcoins-Muskcoins_In_Doge)/muskcoins*rnorm(x, mean = 8, sd = 2))

```

Durch das Integral von der Dichtefunktion, können wir nun die Wahrscheinlichkeit für
die insgesamte prozentuale Jahresrendite $R_J$: 

$P(l\% \leq X \leq h\%)=\int_{l\%}^{h\%}f_{R_J}(x)dx$  
$P(l\% \leq X \leq h\%)=\int_{l\%}^{h\%}(\frac{Muskcoins In Doge}{muskcoins}\cdot R_1 +\frac{Musnkcoins-Muskcoins In Doge}{muskcoins}\cdot R_2) dx$  

In R:  

```
library(sfsmisc)
# integrate.xy(from library "sfsmisc") density
area <- integrate.xy(den$x, den$y, l_percent, h_percent%)
```

Konzept visualisiert mit R Shiny:

![R Shiny Demo](https://raw.githubusercontent.com/czycs/deskr_stat_13_3_b/main/pictures/r_shiny_demo.gif)
