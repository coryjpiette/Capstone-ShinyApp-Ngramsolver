Capstone Project - Word Prediction
================
Cory Piette
June 12, 2020

## Shiny App

This script creates a Shiny App that takes a word or phrase input in a
text box and outputs the a predicted next word.

``` r
library(shiny)
```

    ## Warning: package 'shiny' was built under R version 3.6.3

``` r
suppressPackageStartupMessages({
   library(tidyverse)
   library(stringr)
 })
```

    ## Warning: package 'tidyverse' was built under R version 3.6.3

    ## Warning: package 'ggplot2' was built under R version 3.6.3

    ## Warning: package 'tibble' was built under R version 3.6.3

    ## Warning: package 'tidyr' was built under R version 3.6.3

    ## Warning: package 'readr' was built under R version 3.6.3

    ## Warning: package 'purrr' was built under R version 3.6.3

    ## Warning: package 'dplyr' was built under R version 3.6.3

    ## Warning: package 'stringr' was built under R version 3.6.3

    ## Warning: package 'forcats' was built under R version 3.6.3

Source ngram matching function

``` r
source("ngram.R")
```

Define UI for application that draws a histogram

``` r
ui <- fluidPage(
   
   # Application title
   titlePanel("Text Prediction Model"),
   p("This app that takes an input phrase (multiple words) in a text box and outputs a prediction of the next word."),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        h2("Instructions:"), 
        h5("1. Enter a word or words in the text box."),
        h5("2. The predicted next word prints below it in blue."),
        h5("3. No need to hit enter of submit."),
        h5("4. A question mark means no prediction, typically due to mis-spelling"),
        h5("5. Additional tabs show plots of the top ngrams in the dataset"),
        br(),
        a("Source Code", href = "https://github.com/mark-blackmore/JHU-Data-Science-Capstone/tree/master/ngram_match")
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        tabsetPanel(
          tabPanel("predict",
            textInput("user_input", h3("Your Input:"), 
                    value = "Your words"),
            h3("Predicted Next Word:"),
            h4(em(span(textOutput("ngram_output"), style="color:blue")))),
        
          tabPanel("top quadgrams",
            br(),
            img(src = "quadgrams.png", height = 500, width = 700)),
        
          tabPanel("top trigrams",
            br(),       
            img(src = "trigrams.png", height = 500, width = 700)),
      
          tabPanel("top bigrams",
            br(),
            img(src = "bigrams.png", height = 500, width = 700))
          )   
    )
  )
)
```

Define server logic required to draw a histogram

``` r
server <- function(input, output) {
   
  output$ngram_output <- renderText({
      ngrams(input$user_input)
  })
  
}
```

Run the application

``` r
shinyApp(ui = ui, server = server)
```

<!--html_preserve-->

<div class="muted well" style="width: 100% ; height: 400px ; text-align: center; box-sizing: border-box; -moz-box-sizing: border-box; -webkit-box-sizing: border-box;">

Shiny applications not supported in static R Markdown documents

</div>

<!--/html_preserve-->
