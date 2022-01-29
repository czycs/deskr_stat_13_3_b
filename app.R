library(shiny)
library(sfsmisc)

# UI 
ui <- fluidPage(
  # Title
  titlePanel("3b "),
  
  # Sidebar
  sidebarLayout(
    sidebarPanel(
      # SliderInput
      uiOutput(outputId = "slider"),
      
      # MuskcoinsInput
      numericInput(
        "input_num",
        "Muskcoins:",
        200,
        min = 0,
        max = 2000000,
        step = 1,
        width = NULL
      ),
      # CryptoInput
      uiOutput(outputId = "num_2"),
      # NFT_number
      textOutput("Wert")
    ),
    
    # Mainpanel
    mainPanel(
      # display plot
      plotOutput("distPlot"),
      # display Integral
      textOutput("integ"),
      # display Retruns
      textOutput("Return")
      
    )
  ))

# Define server logic 
server <- function(input, output) {
  
  # Create Plot
  output$distPlot <- renderPlot({
    
    # get slider input
    value1 <- input$slider[1]
    value2 <- input$slider[2]
    
    # get numeric inputs
    muskcoins <- input$input_num
    doge <- input$Num_2
    # input check
    if (muskcoins<1) {
      stop("muskcoins must be positve (atleast 1)")
    }
    if (doge<0) {
      stop("Dogetherum must be positive or 0")
    }
    
    # calculate split and muskcoins in nft
    nft <- muskcoins - doge
    verteilung <- doge / muskcoins
    # input check
    if (nft<0) {
      stop("Dogetherum must be lower or equal to muskcoins")
    }
    
    x <- seq(0, 100, by = 0.001)
    set.seed(1)
    # density of unif + nrom; by split of muskcoins
    den <-
      density((runif(x, min = 6, max = 8)) * verteilung + 
                (rnorm(x, mean = 8, sd = 2) *(1 - verteilung)))
    
    # create  plot of density
    plot(den,
         ylim = c(0, 0.65),
         lwd = 3,
         col = "red",
         xlab = "X",
         ylab = "density",
         main = "Dichtefunktionen")
    
    # Lower and higher indices on the X-axis
    l <- min(which(den$x >= value1))
    h <- max(which(den$x < value2))
    
    # draw polygon from slider
    polygon(c(den$x[c(l, l:h, h)]),
            c(0, den$y[l:h], 0),
            col = "slateblue1")
    
    # draw unif
    curve(
      dunif(x, min = 6, max = 8),
      
      from = 5,
      to = 10,
      n = 100000,
      col = "darkblue",
      lwd = 2,
      add = TRUE,
      lty = 1
    )
    
    # draw norm
    curve(
      dnorm(x, mean = 8, sd = 2),
      ylim = c(0, 1),
      from = 0,
      to = 16,
      col = "green",
      lwd = 2,
      add = TRUE,
      lty = 1
    )
    
    # legend
    legend(
      "topright",
      legend = c("unif+norm", "unif", "norm"),
      cex = 1,
      bty = "n",
      col = c("red", "darkblue", "green"),
      lty = 1,
      text.col = "black",
      horiz = F,
      inset = c(0.1, 0.1)
    )
  })
  
  # calculate integral
  output$integ <- renderText({
    
    # get slider input add/substract to avoid integrate error
    value1 <- input$slider[1] + 0.0001
    value2 <- input$slider[2] - 0.0001
    
    # get numeric input
    muskcoins <- input$input_num
    doge <- input$Num_2
    # input check
    if (muskcoins<1) {
      stop("muskcoins must be positve (atleast 1)")
    }
    if (doge<0) {
      stop("Dogetherum must be positive or 0")
    }
    
    # calculate nft and split
    nft <- muskcoins - doge
    verteilung <- doge / muskcoins
    # input check
    if (nft<0) {
      stop("Dogetherum must be lower or equal to muskcoins")
    }
    
    x <- seq(0, 100, by = 0.001)
    set.seed(1)
    # density of unif + nrom; by split of muskcoins
    den <-
      density((runif(x, min = 6, max = 8)) * verteilung +
                (rnorm(x, mean = 8, sd = 2) * (1 - verteilung)))
    
    # integrate(from library "sfsmisc") density from sliderinput
    area <- integrate.xy(den$x, den$y, value1, value2)
    
    # output for ui
    paste("P(",
          round(value1, 2),
          "<=X<=",
          round(value2, 2),
          ") =",
          round(area, 2))
  })
  
  # Slider Input
  output$slider <- renderUI({
    # get numeric inputs
    muskcoins <- input$input_num
    doge <- input$Num_2
    # input check
    if (muskcoins<1) {
      stop("muskcoins must be positve (atleast 1)")
    }
    if (doge<0) {
      stop("Dogetherum must be positive or 0")
    }
    
    # calculate split and muskcoins in nft
    nft <- muskcoins - doge
    verteilung <- doge / muskcoins
 
    x <- seq(0, 100, by = 0.001)
    set.seed(1)
    # density of unif + nrom; by split of muskcoins
    den <-
      density((runif(x, min = 6, max = 8)) * verteilung + 
                (rnorm(x, mean = 8, sd = 2) *(1 - verteilung)))
    
    # set default and max value for slider
    #   round for better visuals
    min_slid <- ceiling(min(den$x) * 100) / 100
    max_slid <- floor(max(den$x) * 100) / 100
    # output for ui
    sliderInput(
      "slider",
      paste(
        "Prozentuale Jahresrendite zwischen mindestens l% und höchstens h%:"
      ),
      min = min_slid,
      max = max_slid,
      value = c(min_slid, max_slid),
      sep = "",
      step = .1
    )
  })
  # Dogetherum input
  output$num_2 <- renderUI({
    # get muskcoin input
    all <- input$input_num
    # input check
    if (all<1) {
      stop("muskcoins must be positve (atleast 1)")
    }
    # outppput ui; with max= muskcoins
    numericInput(
      inputId = "Num_2",
      label = "Dogethereum:",
      value = 0.75 * all,
      min = 0,
      max = all
    ) 
  })
  # NFT text
  output$Wert <- renderText({
    # get numeric inputs
    all <- input$input_num
    dogetherum <- input$Num_2
    # calulate nft value
    nft <- all - dogetherum
    # input check
    if (nft<0) {
      stop("Error: Dogetherum must be lower or equal to muskcoins")
    }
    if (dogetherum<0) {
      stop("Error: Dogetherum must be positve or 0")
    }
    # for ui
    paste("Enefftetteff:", nft)
  })
  # Return Text
  output$Return <- renderText({
    # get numeric inputs
    muskcoins <- input$input_num
    doge <- input$Num_2
    # calculate split and muskcoins in nft
    nft <- muskcoins - doge
    verteilung <- doge / muskcoins
    # input check
    if (nft<0) {
      stop("Dogetherum must be lower or equal to muskcoins")
    }
    if (doge<0) {
      stop("Dogetherum must be positive or 0")
    }
    
    x <- seq(0, 100, by = 0.001)
    set.seed(1)
    # density of unif + nrom; by split of muskcoins
    den <-
      density((runif(x, min = 6, max = 8)) * verteilung + 
                (rnorm(x, mean = 8, sd = 2) *(1 - verteilung)))

    # calculate mean of density
    mean_den <- mean(den$x)
    # for ui
    paste("Expected Return:",
          round(((mean_den / 100) + 1) * muskcoins, 2),
          "Rendite: ",
          round((mean_den / 100) * muskcoins),
          2)
  })
  
}

# Run the application


shinyApp(ui = ui, server = server)
