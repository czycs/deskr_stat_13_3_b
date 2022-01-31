# Deskriptive Statistik Blatt 13 Aufgabe 3 b


Unsere neue Verteilung <img src="https://latex.codecogs.com/png.image?\dpi{110}&space;\bg_white&space;\inline&space;R_J" title="\bg_white \inline R_J" /> setzt sich zusammen aus <img src="https://latex.codecogs.com/png.image?\dpi{110}&space;\bg_white&space;\inline&space;R_J" title="\bg_white \inline R_1" /> und <img src="https://latex.codecogs.com/png.image?\dpi{110}&space;\bg_white&space;\inline&space;R_J" title="\bg_white \inline R_2" />.
Der Erwartungswert von  <img src="https://latex.codecogs.com/png.image?\dpi{110}&space;\bg_white&space;\inline&space;R_J" title="\bg_white \inline R_J" /> für das Vermögen von 200 Muskcoins ist bekannt aus 3a (214.5), also folgt daraus:

<img src="https://latex.codecogs.com/png.image?\dpi{110}&space;\bg_white&space;\\214.5=200\cdot&space;(1&plus;\frac{E(R_J)}{100})&space;&space;&space;\\214.5=200\cdot&space;&space;(1&plus;\frac{\frac{150}{200}&space;\cdot&space;E(R_1)}{100}&plus;\frac{\frac{50}{200}&space;\cdot&space;E(R_2)}{100})&space;&space;\\214.5=200\cdot&space;(1&plus;\frac{0.75&space;\cdot&space;E(R_1)&space;&plus;&space;0.25&space;\cdot&space;E(R_2)}{100})214.5=200\cdot&space;(1&plus;\frac{0.75&space;\cdot&space;7&space;&plus;&space;0.25&space;\cdot&space;8}{100})&space;\\214.5=200\cdot&space;(1&plus;\frac{5,25&space;&plus;&space;2}{100})&space;&space;\\214.5=200\cdot&space;(1.0725)&space;=>&space;214.5=214.5&space;&space;\\" title="\bg_white \\214.5=200\cdot (1+\frac{E(R_J)}{100}) \\214.5=200\cdot (1+\frac{\frac{150}{200} \cdot E(R_1)}{100}+\frac{\frac{50}{200} \cdot E(R_2)}{100}) \\214.5=200\cdot (1+\frac{0.75 \cdot E(R_1) + 0.25 \cdot E(R_2)}{100})214.5=200\cdot (1+\frac{0.75 \cdot 7 + 0.25 \cdot 8}{100}) \\214.5=200\cdot (1+\frac{5,25 + 2}{100}) \\214.5=200\cdot (1.0725) => 214.5=214.5 \\" />

Daraus folgt:

<img src="https://latex.codecogs.com/png.image?\dpi{110}&space;\bg_white&space;V=Muskcoins\cdot&space;(1&plus;\frac{\frac{Muskcoins&space;In&space;Doge}{muskcoins}\cdot&space;R_1&space;&plus;\frac{Muskcoins&space;Nn&space;Nft}{muskcoins}\cdot&space;R_2}{100})" title="\bg_white V=Muskcoins\cdot (1+\frac{\frac{Muskcoins In Doge}{muskcoins}\cdot R_1 +\frac{Muskcoins Nn Nft}{muskcoins}\cdot R_2}{100})" />

Für <img src="https://latex.codecogs.com/png.image?\dpi{110}&space;\bg_white&space;\inline&space;R_J" title="\bg_white \inline R_J" /> gilt also:  

<img src="https://latex.codecogs.com/png.image?\dpi{110}&space;\bg_white&space;R_J=\frac{Muskcoins&space;In&space;Doge}{muskcoins}\cdot&space;R_1&space;&plus;\frac{Muskcoins&space;In&space;Nft}{muskcoins}\cdot&space;R_2" title="\bg_white R_J=\frac{Muskcoins In Doge}{muskcoins}\cdot R_1 +\frac{Muskcoins In Nft}{muskcoins}\cdot R_2" />
bzw.  

<img src="https://latex.codecogs.com/png.image?\dpi{110}&space;\bg_white&space;R_J=\frac{Muskcoins&space;In&space;Doge}{muskcoins}\cdot&space;R_1&space;&plus;\frac{Musnkcoins-Muskcoins&space;In&space;Doge}{muskcoins}\cdot&space;R_2&space;&space;" title="\bg_white R_J=\frac{Muskcoins In Doge}{muskcoins}\cdot R_1 +\frac{Musnkcoins-Muskcoins In Doge}{muskcoins}\cdot R_2 " />

<img src="https://latex.codecogs.com/png.image?\dpi{110}&space;\bg_white&space;R_J=\frac{Muskcoins&space;In&space;Doge}{muskcoins}\cdot&space;\mathcal{U}(6,8)&space;&plus;\frac{Musnkcoins-Muskcoins&space;In&space;Doge}{muskcoins}\cdot&space;\mathcal{N}(8,4)" title="\bg_white R_J=\frac{Muskcoins In Doge}{muskcoins}\cdot \mathcal{U}(6,8) +\frac{Musnkcoins-Muskcoins In Doge}{muskcoins}\cdot \mathcal{N}(8,4)" /> 

In R:  

```
x <- seq(0, 100, by = 0.001)

set.seed(1)
den<-density(Muskcoins_In_Doge/muskcoins*runif(x, min = 6, max = 8)+
    (muskcoins-Muskcoins_In_Doge)/muskcoins*rnorm(x, mean = 8, sd = 2))

```

Durch das Integral von der Dichtefunktion, können wir nun die Wahrscheinlichkeit für
die insgesamte prozentuale Jahresrendite <img src="https://latex.codecogs.com/png.image?\dpi{110}&space;\bg_white&space;\inline&space;R_J" title="\bg_white \inline R_J" />: 

<img src="https://latex.codecogs.com/png.image?\dpi{110}&space;\bg_white&space;P(l\%&space;\leq&space;X&space;\leq&space;h\%)=\int_{l\%}^{h\%}f_{R_J}(x)dx&space;\\P(l\%&space;\leq&space;X&space;\leq&space;h\%)=\\\\\int_{l\%}^{h\%}(\frac{Muskcoins&space;In&space;Doge}{muskcoins}\cdot&space;R_1&space;&plus;\frac{Musnkcoins-Muskcoins&space;In&space;Doge}{muskcoins}\cdot&space;R_2)&space;dx&space;" title="\bg_white P(l\% \leq X \leq h\%)=\int_{l\%}^{h\%}f_{R_J}(x)dx \\P(l\% \leq X \leq h\%)=\\\\\int_{l\%}^{h\%}(\frac{Muskcoins In Doge}{muskcoins}\cdot R_1 +\frac{Musnkcoins-Muskcoins In Doge}{muskcoins}\cdot R_2) dx " />
In R:  

```
library(sfsmisc)
# integrate.xy(from library "sfsmisc") density
area <- integrate.xy(den$x, den$y, l_percent, h_percent%)
```

Konzept visualisiert mit R Shiny:

![R Shiny Demo](https://raw.githubusercontent.com/czycs/deskr_stat_13_3_b/main/pictures/r_shiny_demo.gif)
