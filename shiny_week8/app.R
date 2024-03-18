# Load library
library(shiny)
library(tidyverse)

# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("PSY 8712 shiny app"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("gender", "Select your gender", value = "All", choices = c("All", "Female", "Male")),
      sliderInput("Errorband", "Error band", value = "Display Error Band", choices = c("Display Error Band", "Suppress Error Band")),
      sliderInput("date", "Date inclusion or exclusion", value = "Inclusion", choices = c("Inclusion", "Disclusion"))
    ),
    mainPanel(
      plotOutput("plot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  # Load data
  data_1 <- readRDS("week8_data.rds")
  # By using the if and else function, when users select Exclusion, app excludes participants that completed the assessment before July 1, 2017.
  if (input$Date_Participant == c("Exclusion")) {
    data_1 %>% 
      filter(timeEnd >= c("2017-07-01"))
  } else {}
  # By using the if and else function, when users select Suppress Error Band, app doesn't show the shaded error band around the regression line.
  if (input$Errorband == c("Suppress Error Band")) {
    data_1 %>%
      ggplot(aes(x = meanQ1_6, y = meanQ8_10)) +
      geom_smooth(method = "lm", color = "purple", se = FALSE) +
      geom_point()
  } else {
    data_1 %>%
      ggplot(aes(x = meanQ1_6, y = meanQ8_10)) +
      geom_smooth(method = "lm", color = "purple", se = TRUE) +
      geom_point()
  }
}

# Run the application 
shinyApp(ui = ui, server = server)
