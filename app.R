# ==============================
# Demo R Shiny - Palmer Penguins
# ==============================

library(shiny)
library(dplyr)
library(ggplot2)
library(palmerpenguins)


# ==============================
# UI
# ==============================
ui <- fluidPage(
  
  titlePanel("Demo R Shiny: Palmer Penguins"),
  
  sidebarLayout(
    
    sidebarPanel(
      selectInput(
        inputId = "species_filter",
        label = "Pilih Spesies:",
        choices = c(
          "Semua",
          sort(unique(as.character(penguins_clean$species)))
        ),
        selected = "Semua"
      ),
      
      selectInput(
        inputId = "island_filter",
        label = "Pilih Pulau:",
        choices = c(
          "Semua",
          sort(unique(as.character(penguins_clean$island)))
        ),
        selected = "Semua"
      )
    ),
    
    mainPanel(
      h4("Ringkasan Data"),
      textOutput("summary_text"),
      
      hr(),
      
      h4("Tabel Data"),
      dataTableOutput("table_data"),
      
      hr(),
      
      h4("Visualisasi"),
      plotOutput("plot_data")
    )
  )
)

# ==============================
# Server
# ==============================
server <- function(input, output, session) {
  
  # === PROSES (Reactive Data) ===
  data_filtered <- reactive({
    
    df <- penguins_clean
    
    # Filter species (HANYA jika bukan "Semua")
    if (!is.null(input$species_filter) && input$species_filter != "Semua") {
      df <- df %>% filter(species == input$species_filter)
    }
    
    # Filter island (HANYA jika bukan "Semua")
    if (!is.null(input$island_filter) && input$island_filter != "Semua") {
      df <- df %>% filter(island == input$island_filter)
    }
    
    df
  })
  
  
  output$summary_text <- renderText({
    paste("Jumlah penguin:", nrow(data_filtered()))
  })
  
  
  # === OUTPUT: Tabel ===
  output$table_data <- DT::renderDataTable({
    DT::datatable(
      data_filtered()
    )
  })
  
  
  # === OUTPUT: GRAFIK ===
  output$plot_data <- renderPlot({
    ggplot(
      data_filtered(),
      aes(x = species, y = body_mass_g, fill = species)
    ) +
      geom_boxplot() +
      theme_minimal() +
      labs(
        x = "Spesies",
        y = "Berat Badan (gram)"
      )
  })
}


# ==============================
# Run App
# ==============================
shinyApp(ui, server)
