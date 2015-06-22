library(shiny)

shinyUI(fluidPage(
  titlePanel("Mean Inference Simulation"),
  
  sidebarLayout(
    sidebarPanel(
      
      numericInput("mean", label = h5("Enter the mean of the normal distribution"), value = 50),
      numericInput("std", label = h5("Enter the standard deviation of the normal distribution"), value = 10, min = 1),
      numericInput("draws", label = h5("Enter the sample size to draw"), value = 10, min = 1),
      numericInput("nsim", label = h5("Enter number of samples to draw"), value = 1000, min = 2),
      
      br(),
      
      checkboxInput("normal", "Plot the normal distribution that was sampled from", value = TRUE),
      checkboxInput("density", "Plot density estimate of sampled histogram", value = TRUE),
      checkboxInput("scale", "Scale x axis to normal distribution", value = TRUE)
    ),
    
    mainPanel(
      p("This is a simple app to simulate the relationship between a normal distribution to be sampled from, the sample size, and the number of samples."),
      tags$ul(
        tags$li("Enter the mean, standard deviation, sample size, and number of samples on the left."), 
        tags$li("As the sample size approaches 1, the distribution of the samples approaches that of the normal being sampled if the number of samples is sufficient."), 
        tags$li("As the sample size gets large (100+), the sample distribution gets sharply peaked at the mean, while the density of the normal being sampled from is much more spread out (this is when toggling off the x scaling can help visualize the distribution of the sample means)."),
        tags$li("As the number of simulations gets large, the central limit theorem kicks in and the distribution of the sampled means itself becomes more normally distributed."),
        tags$li("It's best to keep the number of samples times the sample size under ten million.")
      ),
      plotOutput("plot")
      
    )
  )
))