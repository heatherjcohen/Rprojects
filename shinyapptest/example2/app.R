library(shiny)
library(shinydashboard)


#Dashboard header carrying the title of the dashboard
header <- dashboardHeader(title = "Basic Dashboard")  
#Sidebar content of the dashboard
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("Visit-us", icon = icon("send",lib='glyphicon'), 
             href = "https://www.salesforce.com")
  )
)

frow1 <- fluidRow(
  valueBoxOutput("value1")
  ,valueBoxOutput("value2")
  ,valueBoxOutput("value3")
)
frow2 <- fluidRow( 
  box(
    title = "Revenue per Account"
    ,status = "primary"
    ,solidHeader = TRUE 
    ,collapsible = TRUE 
    ,plotOutput("revenuebyPrd", height = "300px")
  )
  ,box(
    title = "Revenue per Product"
    ,status = "primary"
    ,solidHeader = TRUE 
    ,collapsible = TRUE 
    ,plotOutput("revenuebyRegion", height = "300px")
  ) 
)
# combine the two fluid rows to make the body
body <- dashboardBody(frow1, frow2)

#completing the ui part with dashboardPage
ui <- dashboardPage(title = 'This is my Page title', header, sidebar, body, skin='red')


formatC(prof.prod$value, format="d", big.mark=',')
,paste('Top Product:',prof.prod$Product)
,icon = icon("menu-hamburger",lib='glyphicon')
,color = "yellow")   
})
#creating the plotOutput content
output$revenuebyPrd <- renderPlot({
  ggplot(data = recommendation, 
         aes(x=Product, y=Revenue, fill=factor(Region))) + 
    geom_bar(position = "dodge", stat = "identity") + ylab("Revenue (in Euros)") + 
    xlab("Product") + theme(legend.position="bottom" 
                            ,plot.title = element_text(size=15, face="bold")) + 
    ggtitle("Revenue by Product") + labs(fill = "Region")
})
output$revenuebyRegion <- renderPlot({
  ggplot(data = recommendation, 
         aes(x=Account, y=Revenue, fill=factor(Region))) + 
    geom_bar(position = "dodge", stat = "identity") + ylab("Revenue (in Euros)") + 
    xlab("Account") + theme(legend.position="bottom" 
                            ,plot.title = element_text(size=15, face="bold")) + 
    ggtitle("Revenue by Region") + labs(fill = "Region")
})
}

#run/call the shiny app
shinyApp(ui, server)
Listening on http://127.0.0.1:5101