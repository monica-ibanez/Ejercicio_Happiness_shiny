
library(shiny)
library(ggplot2)
library(shin)
library(plotly)
library(dplyr)


data<- read.csv("C:/Users/monic/OneDrive - Mondragon Unibertsitatea/Escritorio/Business data 1/Reto 4/Visualización de Datos/Happiness - entrega3/happiness_2019.csv")

data1<- data %>% select(-Overall.rank, -Country.or.region)

ui<- fluidPage(
  titlePanel("Happiness"),
  sidebarLayout(
    sidebarPanel(
    selectInput("variable_x", "selecciona la variable x:", choices = colnames(data1), selected = "Score"),
    selectInput("variable_y", "selecciona la variable y:", choices = colnames(data1), selected = "GDP.per.capita")
    ),
  mainPanel(plotlyOutput("scatterPlot")))
)

server <- function(input, output) {
  output$scatterPlot <- renderPlotly({
    plot_ly(
      data = data1,
      x = ~get(input$variable_x),
      y = ~get(input$variable_y),
      type = 'scatter',
      name = paste(input$variable_x, "vs", input$variable_y)
    ) %>%
      layout(
        xaxis = list(title = " "),
        yaxis = list(title = " ")
      )
  })
}



shinyApp(ui=ui, server=server)
