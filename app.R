library(shiny)
library(plotly)

# Define UI

ui <- fluidPage(
  titlePanel("POC R SHINY"),
  sidebarLayout(
    sidebarPanel(
      selectInput("chartType","Select Chart Type",
                  choices = c("Pie Chart","Histogram"))
    ),
    mainPanel(
      plotlyOutput("myChart")
    )
  )
)

# Define Server
server <- function(input, output) {
  
  # Fake Data set
  myData <- data.frame(
    Category = c("A","B","C","D","E"),
    Value = c(25,20,15,10,30)
  )
  
  # Render pie chart or histogram based on user input
  output$myChart <- renderPlotly({
    if (input$chartType == "Pie Chart") {
      fig <- plot_ly(myData, labels = ~Category, values = ~Value, type = "pie")
    } else {
      fig <- plot_ly(myData, x = ~Category, y = ~Value, type = "histogram")
    }
    fig
  })
}

# Run the app
shinyApp(ui = ui, server = server)