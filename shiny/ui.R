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
#  titlePanel("Razvitost slovenskih pokrajin"),
#  sidebarLayout(
#    sidebarPanel(
      
      # Select type of trend to plot3
#      selectInput(inputId = "type", label = strong("Kategorija"),
#                  choices = unique(tabela4$Vrsta)
#                  )
#    ),
    
    # Output: Description, lineplot, and reference
#    mainPanel(
#      plotOutput("distPlot")
#      )
#  )))
