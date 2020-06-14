#' ---
#' title: 'Text Prediction Model'
#' author: "Cory Piette"
#' date: "Created June 12, 2020"
#' output: github_document
#' ---

#' ## Shiny App 
#' This script creates a Shiny App that takes a word or phrase input in a text box
#' and outputs the a predicted next word. 

library(shiny)
suppressPackageStartupMessages({
   library(tidyverse)
   library(stringr)
 })

#' Source ngram matching function
source("ngram.R")

#' Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Text Prediction Model"),
   p("The Text Prediction Model utilizes a given word or phrase input and predicts the next word in the sequence."),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        h2("Instructions:"), 
        h5("1. Enter a word or partial phrase into the text box."),
        h5("2. The predicted next word is generated automatically."),
        h5("3. '?' means no prediction - a word is likely misspelled"),
        h5("4. Supplementsal tabs show plots of the most common ngrams in the dataset"),
        br(),
        a("Source Code", href = "https://github.com/coryjpiette/Capstone-ShinyApp-Ngramsolver")
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
#' Define server logic required to draw a histogram
server <- function(input, output) {
   
  output$ngram_output <- renderText({
      ngrams(input$user_input)
  })
  
}
  
#' Run the application 
shinyApp(ui = ui, server = server)

