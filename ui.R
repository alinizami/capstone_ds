#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("DS Capstone Word Prediction App"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      textInput("term", "Start typing your text below:", ""),
      sliderInput("num1","number of predictions:",value=3, min=1,max = 4)
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      print("Word Prediction --"),
      print("Please wait for the initialized message before starting"),
    
      # textOutput("stat"),
      textOutput("pred"),
    # textOutput("pred2"),
      tags$head(tags$style("#pred{color: red;
                                 font-size: 16px;
                                 font-style: italic;
                                 }"
      )
      )
    

    
      
    )
  )
 
))
