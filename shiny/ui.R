library(shiny)
library(DT)

shinyUI(fluidPage(
  titlePanel("Razvitost slovenskih pokrajin"), 
  sidebarLayout(
    sidebarPanel(
      selectInput("type",label="Kategorija",
                  choice=c("Poraba vode", "Količina odpadkov", "Število avtomobilov",
                           "Delež obsojenih", "Število prebivalcev na enega zdravnika",
                           "Stopnja brezposelnosti")
                  )
    ),
    mainPanel(plotOutput("box")
              ) 

  )))