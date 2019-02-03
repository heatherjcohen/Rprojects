library(shinydashboard)
library(ggplot2)
library(DT)
library(reshape)
library(shiny)






ui <- dashboardPage(skin = "purple",
                    dashboardHeader(title = "HJC Demo Dashboard"),
                    ## Sidebar content
                    dashboardSidebar(
                      sidebarMenu(
                        menuItem("Home", tabName = "multi", icon = icon("allergies")),
                        menuItem("Correlation Explorer", tabName = "dashboard", icon = icon("chart-line")),
                        menuItem("Sex Segmentation", tabName = "sex", icon = icon("neuter")),
                        menuItem("Data Viewer", tabName = "widgets", icon = icon("chess-board")),
                        menuItem("Icons", tabName = "icons", icon = icon("ruler-horizontal")),
                        menuItem("Subset", tabName = "subset", icon = icon("user-circle")),
                        menuItem("Ranked Stats", tabName = "evaluation", icon = icon("users"))
                      )
                    ),
                    ## Body content
                    dashboardBody(
                      tabItems(
                        tabItem(tabName = "multi",
                                fluidRow(
                                  box(title = "Box title", plotOutput(outputId = "hist")),
                                  box(status = "warning", plotOutput(outputId = "hist2"))
                                ),
                                
                                fluidRow(
                                  box(
                                    title = "Mean Incidence Rating", width = 4, solidHeader = TRUE, status = "primary",
                                    mean(data$incidence)
                                  ),
                                  box(
                                    title = "Mean Involvement Rating", width = 4, solidHeader = TRUE,
                                    mean(data$involve_idx)
                                  ),
                                  box(
                                    title = "Mean Evaluation", width = 4, solidHeader = TRUE, status = "warning",
                                    mean(data$evaluation)
                                  )
                                ),
                                
                                fluidRow(
                                  box(title = "Summaries By Variable", 
                                      status="danger", 
                                      solidHeader = TRUE,
                                      width = 6,
                                      selectInput("informedDset", label="Select Category",
                                                  choices = list("Evaluation"="evaluation",
                                                                 "Incidence"="incidence",
                                                                 "Involvement"="involve_idx",
                                                                 "Funny" = "atts_raw_fun",
                                                                 "Edgy" = "atts_raw_edgy",
                                                                 "Disturbing" = "atts_raw_disturbing",
                                                                 "Dramatic"= "atts_raw_dramatic",
                                                                 "Mindless"= "atts_raw_mindless",
                                                                 "Calming"= "atts_raw_calming",
                                                                 "Intelligent"= "atts_raw_intelligent",
                                                                 "Informative"= "atts_raw_informative",
                                                                 "Scary"= "atts_raw_scary",
                                                                 "Funny"= "atts_raw_funny",
                                                                 "Relatable"= "atts_raw_relatable",
                                                                 "Mean"= "atts_raw_mean",
                                                                 "Size"="n_size"), selected = "evaluation")),
                                  box(
                                    title = "Summary", 
                                    status="danger", 
                                    solidHeader = TRUE,
                                    width = 6,
                                    height = 142,
                                    verbatimTextOutput("summaryDset"))
                                )),
                        
                        
                        # First tab content
                        tabItem(tabName = "dashboard",
                                fluidRow(status="info",
                                         box(width="40%", plotOutput(outputId = "scatterplot")),
                                         
                                         box(status="success",
                                             title = "Controls",
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
                                         )
                                )
                        ),
                        
                        # Second tab content
                        tabItem(tabName = "widgets",
                                fluidRow(
                                  column(width = 12,
                                         box( status ="info", width=NULL,solidHeader = TRUE,
                                              DT::dataTableOutput("mytable"),style = "height:500px; overflow-y: scroll;overflow-x: scroll;"))
                                  
                                )),
                        #more tabs
                        
                        tabItem(tabName = "sex",
                                fluidRow(
                                  box(title = "Sex Segmentation", plotOutput(outputId = "hist3")),
                                  box(status = "warning", plotOutput(outputId = "hist4"))
                                )),
                        tabItem(tabName = "subset",
                                fluidRow(
                                  box( uiOutput("codePanel")),
                                  box(selectInput(inputId ="groupDset", label="Select Category",
                                                  choices = list("Evaluation"="evaluation",
                                                                 "Incidence"="incidence",
                                                                 "Involvement"="involve_idx",
                                                                 "Funny" = "atts_raw_fun",
                                                                 "Edgy" = "atts_raw_edgy",
                                                                 "Disturbing" = "atts_raw_disturbing",
                                                                 "Dramatic"= "atts_raw_dramatic",
                                                                 "Mindless"= "atts_raw_mindless",
                                                                 "Calming"= "atts_raw_calming",
                                                                 "Intelligent"= "atts_raw_intelligent",
                                                                 "Informative"= "atts_raw_informative",
                                                                 "Scary"= "atts_raw_scary",
                                                                 "Funny"= "atts_raw_funny",
                                                                 "Relatable"= "atts_raw_relatable",
                                                                 "Mean"= "atts_raw_mean",
                                                                 "Size"="n_size"), selected = "evaluation")) )
                        ,
                                fluidRow(plotOutput(outputId = "bar1")),
                                fluidRow(
                                  box(width=NULL, DT::dataTableOutput("text"),style = "height:500px; overflow-y: scroll;overflow-x: scroll;"))
                                  ),
                        
                        tabItem(tabName="icons",
                                fluidRow(
                                  # A static infoBox
                                  infoBox("New Orders", 10 * 2, icon = icon("credit-card")),
                                  # Dynamic infoBoxes
                                  infoBoxOutput("progressBox"),
                                  infoBoxOutput("approvalBox")
                                ),
                                
                                # infoBoxes with fill=TRUE
                                fluidRow(
                                  infoBox("New Orders", 10 * 2, icon = icon("credit-card"), fill = TRUE),
                                  infoBoxOutput("progressBox2"),
                                  infoBoxOutput("approvalBox2")
                                ),
                                
                                fluidRow(
                                  # Clicking this will increment the progress amount
                                  box(width = 4, actionButton("count", "Increment progress"))
                                )),
                        
                        # Third tab content
                        tabItem(tabName = "evaluation",
                                fluidRow(
                                  column(width = 6,
                                         box( title = "Evaluation By Genre",status="info", width=NULL,solidHeader = TRUE,
                                              DT::dataTableOutput("eval")),
                                         
                                         box(
                                           title = "Evaluation By Network", width = NULL, solidHeader = TRUE, status = "primary",
                                           DT::dataTableOutput("eval2"))
                                  ),
                                  column(width=6,
                                         
                                         box(
                                           title = "Involvement By Genre", width = NULL, solidHeader = TRUE, status = "warning",
                                           DT::dataTableOutput("ii")),
                                         box(
                                           title = "Involvement By Network", width = NULL, solidHeader = TRUE, status = "warning",
                                           DT::dataTableOutput("ii2")))
                                  
                                  
                                  
                                ))
                        
                        
                        
                      )))

server <- function(input, output) {
  # Create scatterplot object the plotOutput function is expecting
  output$scatterplot <- renderPlot({
    ggplot(data = data, aes_string(x = input$x, y = input$y, color=input$h)) + 
      theme(axis.text.x  = element_text(angle=45, vjust=0.5)) + 
      geom_point(shape=1) + geom_smooth(method=lm) 
  })
  
  output$hist <- renderPlot({
    ggplot(data, aes(x=data$incidence)) + 
      geom_histogram(aes(y=..density..), colour="black", fill="white")+
      geom_density(alpha=.2, fill="#FF6666") 
  })
  
  
  
  output$hist2 <- renderPlot({
    ggplot(data, aes(x=data$involve_idx)) + 
      geom_histogram(aes(y=..density..), colour="black", fill="white")+
      geom_density(alpha=.2, fill="#FF6666") 
   
  })
  
  output$hist3 <- renderPlot({
    ggplot(data, aes(x=data$incidence, color=data$grp_lev)) +
      geom_histogram(fill="white", position="dodge")+
      theme(legend.position="top")
  })
  
  output$hist4 <- renderPlot({
    ggplot(data, aes(x=data$evaluation, color=data$grp_lev)) +
      geom_histogram(fill="white", position="dodge")+
      theme(legend.position="top")
  })


  ####summarizer 
  output$summaryDset <- renderPrint({
    summary(data[[input$informedDset]]) 
  })
  
  
  evalttable<-aggregate(data$evaluation, list(data$genre), mean)
  eval2ttable<-aggregate(data$evaluation, list(data$network_name), mean)
  
  itable<-aggregate(data$involve_idx, list(data$genre), mean)
  i2table<-aggregate(data$involve_idx, list(data$network_name), mean)
  
  output$eval =DT::renderDataTable({
    evalttable
  })
  
  output$eval2 =DT::renderDataTable({
    eval2ttable
  })
  
  output$ii =DT::renderDataTable({
    itable
  })
  
  output$ii2 =DT::renderDataTable({
    i2table
  })
  
  output$mytable = DT::renderDataTable({
    data
  })
  
  output$progressBox <- renderInfoBox({
    infoBox(
      "Progress", paste0(25 + input$count, "%"), icon = icon("list"),
      color = "purple"
    )
  })
  output$progressBox <- renderInfoBox({
    infoBox(
      "Progress", paste0(25 + input$count, "%"), icon = icon("list"),
      color = "purple"
    )
  })
  output$approvalBox <- renderInfoBox({
    infoBox(
      "Approval", "80%", icon = icon("thumbs-up", lib = "glyphicon"),
      color = "yellow"
    )
  })
  
  # Same as above, but with fill=TRUE
  output$progressBox2 <- renderInfoBox({
    infoBox(
      "Progress", paste0(25 + input$count, "%"), icon = icon("list"),
      color = "purple", fill = TRUE
    )
  })
  
  output$approvalBox2 <- renderInfoBox({
    infoBox(
      "Approval", "80%", icon = icon("thumbs-up", lib = "glyphicon"),
      color = "yellow", fill = TRUE)})
    

  filt <- selectInput("codeInput",label ="choose code",
                      choices = as.list(unique(data$show_name)))
  
  output$codePanel <- renderUI({ filt
    
  })
  
  dataset<-reactive({ 
    
    subset(data, show_name == input$codeInput)  
    
  })
  
  dataset2<-reactive({ 
    
    subset(dataset(), select = c(input$groupDset,"grp_lev"))
    
  })
  
 
  
  
  output$text<-renderDataTable(dataset())
  output$text2<-renderDataTable(dataset2())
  
  
  
  output$bar1<-renderPlot({
    ggplot(dataset2(), aes_string(x="grp_lev", y=input$groupDset, fill="grp_lev")) + geom_bar(stat = "identity")
    }) 

}
shinyApp(ui, server)