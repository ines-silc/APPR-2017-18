library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Slovenske pokrajine"),
  
  tabsetPanel(
      tabPanel("Število avtomobilov",
               sidebarPanel(
                 selectInput("sprem", label="Izberi kategorijo",
                             choices=colnames(povprecja[c(-1)]))
               ),
               mainPanel(plotOutput("graf1"))),
      
      tabPanel("Število naselij",
               sidebarPanel(
                  uiOutput("pokrajine")
                ),
               mainPanel(plotOutput("naselja")))
    )
))
