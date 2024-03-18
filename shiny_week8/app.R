# Load library
library(shiny)
library(tidyverse)

# Define UI for application that draws a histogram
ui <- fluidPage(
    # Application title
    titlePanel("Old Faithful Geyser Data"),
    # Select gender, error band, and date inclusion or exclusion
    sidebarLayout(
        sidebarPanel(
            sliderInput(inputId = "gender", label = "Select your gender", selected = "All", choices = c("All", "Male", "Female")),
            sliderInput(inputId = "error_band", label = "Error band", selected = "Display Error Band", choices = c("Display Error Band", "Suppress Error Band")),
            sliderInput(inputId = "date", label = "Date inclusion or exclusion", selected = "Inclusion", choices = c("Inclusion", "Disclusion")))
        ),
        # Display plot
        mainPanel(
           plotOutput("plot")
        )
    )

# Define server logic
server <- function(input, output) {
  # Load data
  
}

# Run the application 
shinyApp(ui = ui, server = server)
