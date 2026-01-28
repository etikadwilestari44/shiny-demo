library(shiny)
library(leaflet)

# WAJIB: load dataset
data("quakes")

ui <- fluidPage(
  titlePanel("Demo R Shiny - Leaflet"),
  leafletOutput("map", height = 500)
)

server <- function(input, output, session) {
  
  output$map <- renderLeaflet({
    leaflet(quakes) %>%
      addProviderTiles(providers$CartoDB.Positron) %>%
      addCircleMarkers(
        lng = ~long,
        lat = ~lat,
        radius = ~mag * 2,
        fillOpacity = 0.6,
        stroke = FALSE
      )
  })
  
}

shinyApp(ui, server)
