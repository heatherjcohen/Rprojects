library(shiny)
library(DT)

ui <- fluidPage(
  fluidRow(
    column(4,
           selectInput(inputId = "inci",
                       label = "See Top 5 Incidence: Choose a variable to compare:",
                       choices = c("genre", "show_name", "network_name"))),
          
    
    column(4, actionButton("button", "Apply"))),
  
  fluidRow(        
    dataTableOutput('table')
    
  ))


server = function(input, output) {
  
  observeEvent(input$button, {
    cat("Showing", input$inci, "as min value\n")

    
  })
  
 df<-aggregate(data$incidence, list(data$genre), mean)
  
  output$table <- renderTable({
    df
  })
}

shinyApp(ui, server) 