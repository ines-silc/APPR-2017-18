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
    })
  }
)
  
#} )
#  output$druzine <- DT::renderDataTable({
#    dcast(druzine, obcina ~ velikost.druzine, value.var = "stevilo.druzin") %>%
#      rename(`Občina` = obcina)
#  })
  
#  output$pokrajine <- renderUI(
#    selectInput("pokrajina", label="Izberi pokrajino",
#                choices=c("Vse", levels(obcine$pokrajina)))
#  )
#  output$odpadki <- renderPlot({
#    print(zemljevid.odpadki)
#    main <- "Pogostost števila naselij"
#    if (!is.null(input$pokrajina) && input$pokrajina %in% levels(obcine$pokrajina)) {
#      t <- obcine %>% filter(pokrajina == input$pokrajina)
#      main <- paste(main, "v regiji", input$pokrajina)
#    } else {
#      t <- obcine
#    }
#    ggplot(t, aes(x = naselja)) + geom_histogram() +
#      ggtitle(main) + xlab("Število naselij") + ylab("Število občin")
#  })
#  })
