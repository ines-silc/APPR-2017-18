library(shiny)
library(datasets)

shinyServer(function(input, output) {
  output$box <- renderPlot({
    if(input$type == "Poraba vode"){
      print(zemljevid.vode)}
    else if (input$type == "Količina odpadkov"){
      print(zemljevid.odpadki)}
    else if (input$type == "Število avtomobilov"){
      print(zemljevid.avto)}
    else if (input$type == "Delež obsojenih"){
      print(zemljevid.obsojenih)}
    else if (input$type == "Število prebivalcev na enega zdravnika"){
      print(zemljevid.zdravniki)}
    else if (input$type == "Stopnja brezposelnosti"){
      print(zemljevid.stopnje)}
    })
  }
)