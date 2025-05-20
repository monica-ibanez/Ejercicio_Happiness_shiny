library(shiny)
library(ggplot2)
library(shin)
library(plotly)
library(dplyr)
library(DT)
library(shinyWidgets)



data<- read.csv("C:/Users/monic/OneDrive - Mondragon Unibertsitatea/Escritorio/Business data 1/Reto 4/Visualización de Datos/Happiness - entrega3/happiness_2019.csv")

data1<- data %>% select(-Overall.rank, -Country.or.region)

data2<- data %>% select(Overall.rank, Country.or.region)



ui <- fluidPage(
  titlePanel("Happines"),
  sidebarLayout(
    sidebarPanel(
      selectInput('score', 'Selecciona la variable x:', choices =  colnames(data1), 
                  selected = "Score"),
      selectInput('capita', 'Selecciona la variable y:', choices = colnames(data1), 
                  selected = "GDP.per.capita")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel('Grafico', plotlyOutput('dispersion')),
        tabPanel('Tabla', DTOutput('tabla'))
      )
    )
  )
)

server <- function(input, output) {
  output$dispersion <- renderPlotly({
    plot_ly(data1,  x = ~data1[[input$score]],
            y = ~data1[[input$capita]],
            type = 'scatter')
  })
  output$tabla <- renderDT({
    datatable(data)
  })
}

shinyApp(ui = ui, server = server)
