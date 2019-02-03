#This is a shiny app for exploring the correlation between various variables
#in this data set 

library(shiny)
library(ggplot2)
library(shinydashboard)
# Define UI for application that plots features of movies
ui <- fluidPage(
  
  titlePanel("Correlation Explorer"),
  
  
  # Sidebar layout with a input and output definitions
  sidebarLayout(
    # Inputs: Select variables to plot
    sidebarPanel(
      # Select variable for y-axis
      selectInput(inputId = "y", label = "Y-axis:",
                  choices = c("show_name", "network_name", "genre", "grp_lab", "grp_lev", "network_type", "incidence","involve_idx", "evaluation", "atts_raw_funny", "atts_raw_fun", "atts_raw_dramatic", "atts_raw_calming", "atts_raw_informative", "atts_raw_relatable", "atts_raw_edgy", "atts_raw_mindless", "atts_raw_intelligent", "atts_raw_scary", "atts_raw_mean", "atts_raw_disturbing", "n_size"),
                  selected = "evaluation"),
      #color
      selectInput(inputId = "h", label = "Fill-color:",
                  choices = c("show_name", "network_name", "genre", "grp_lab", "grp_lev", "network_type", "incidence","involve_idx", "evaluation", "atts_raw_funny", "atts_raw_fun", "atts_raw_dramatic", "atts_raw_calming", "atts_raw_informative", "atts_raw_relatable", "atts_raw_edgy", "atts_raw_mindless", "atts_raw_intelligent", "atts_raw_scary", "atts_raw_mean", "atts_raw_disturbing", "n_size"),
                  selected = "n_size"),
      # Select variable for x-axis
      selectInput(inputId = "x", label = "X-axis:",
                  choices = c("show_name", "network_name", "genre", "grp_lab", "grp_lev", "network_type", "incidence","involve_idx", "evaluation", "atts_raw_funny", "atts_raw_fun", "atts_raw_dramatic", "atts_raw_calming", "atts_raw_informative", "atts_raw_relatable", "atts_raw_edgy", "atts_raw_mindless", "atts_raw_intelligent", "atts_raw_scary", "atts_raw_mean", "atts_raw_disturbing", "n_size"),
                  selected = "incidence")
    ),
    
    # Output: Show scatterplot
    mainPanel(
      plotOutput(outputId = "scatterplot")
    )
  )
)
# Define server function required to create the scatterplot
server <- function(input, output) {
  # Create scatterplot object the plotOutput function is expecting
  output$scatterplot <- renderPlot({
    ggplot(data = data, aes_string(x = input$x, y = input$y, color=input$h)) + theme(axis.text.x  = element_text(angle=45, vjust=0.5)) + geom_point(shape=1) + geom_smooth(method=lm) + scale_color_gradient(low = "blue", high = "red")
  })
  
  
}

# Create the Shiny app object
shinyApp(ui = ui, server = server)
