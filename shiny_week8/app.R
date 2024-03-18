# Load libraries
library(shiny)
library(tidyverse)

# Define UI for application that make the select panel
ui = fluidPage(
  # Title
  titlePanel("PSY 8721 Shiny App"),
  # Make sidebar with select panel - gender, 
  sidebarLayout(
    sidebarPanel(
      selectInput("gender", "Choose gender",
                  selected = "All",
                  choices = c("Male", "Female", "All")),
      selectInput("error_band", "Choose Error band",
                  selected = "Display Error Band",
                  choices = c("Display Error Band", "Suppress Error Band")),
      selectInput("date_include", "Choose completed date",
                  selected = "Include",
                  choices = c("Include", "Exclude"))),
    # Display plot
    mainPanel(
      plotOutput("plot"))
  ) 
)

server = function(input, output){
  # Input: Load RDS file making rmd file
  shinyapp_data <- readRDS("week8_data.rds")
  # Output: If function
  output$plot = renderPlot({# By using the if function, when users select Exclusion, app excludes participants that completed the assessment before July 1, 2017.
    if(input$date_include == "Exclude") {
      shinyapp_data %>% 
        filter(timeEnd >= "2017-07-01 00:00:00")
    }  else {}
    # By using the if function, when users select Female or male, app shows Female or male according they selected.
    if(input$gender != "All"){ 
      shinyapp_data %>% 
        filter(gender == input$gender)
    }  else {}
    # By using the if and else function, when users select Suppress Error Band, app doesn't show the shaded error band around the regression line.
    if(input$error_band == "Display Error Band") {
      shinyapp_data %>% 
        ggplot(aes(x = meanQ1_6, y = meanQ8_10)) +
        geom_point() + 
        geom_smooth(method = "lm", color = "purple", se = TRUE) + 
        labs(x = "Average scores of Q1 ~ Q6", y = "Average scores of Q8 ~ Q10")
    } else {
      shinyapp_data %>% 
        ggplot(aes(x = meanQ1_6, y = meanQ8_10)) +
        geom_point() + 
        geom_smooth(method = "lm", color = "purple", se = FALSE) + 
        labs(x = "Average scores of Q1 ~ Q6", y = "Average scores of Q8 ~ Q10")}})}

shinyApp(ui = ui , server = server)