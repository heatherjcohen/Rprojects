library(shiny)
library(DT)
ui <- fluidPage(
  # App title ----
  titlePanel("Hello Shiny!"),
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      uiOutput("codePanel") 
    ),
    
    mainPanel(
      
      DT::dataTableOutput("text")
      
    )
  )
)

server <- function(input, output) {
  
  
  filt <- selectInput("codeInput",label ="choose code",
                      choices = as.list(unique(data$show_name)))
  
  output$codePanel <- renderUI({ filt
    
  })
  
  dataset<-reactive({ 
    
    subset(data, show_name == input$codeInput)  
    
  })
  
  
  output$text<-renderDataTable(dataset())
  
  
}

shinyApp(ui = ui, server = server)