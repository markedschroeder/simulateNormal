# server.R

shinyServer(function(input, output) {

  sampledData <- reactive({
    simMatrix <- matrix(rnorm(input$draws*input$nsim, mean=input$mean, sd = input$std),
                        input$nsim, input$draws)
  })
  
  output$mean <- reactive({mean(rowMeans(sampledData()))})
  
  output$plot <- renderPlot({
    if (input$scale) {
      hist(rowMeans(sampledData()), xlim = c(input$mean-3*input$std, input$mean+3*input$std), 
           probability=TRUE, main="Histogram of sample means", xlab="histogram of sample means")
    } else {
      hist(rowMeans(sampledData()), probability=TRUE, main="Histogram of sample means")
    }
    
    if (input$normal) {
      x <-seq(input$mean-3*input$std,input$mean+3*input$std,length=100) 
      y <-dnorm(x, input$mean, sd=input$std)
      lines(x, y, type = "l", col="green", lwd=5)
    }
    abline(v=mean(rowMeans(sampledData())), col="red",lwd=3)
    if (input$density) {
      dens <- density(rowMeans(sampledData()),
                      adjust = 1)
      lines(dens, col = "blue", lwd=3)
    }
    
    if (input$normal & input$density) {
      legend("topright", 
            c("sample histogram", "sample histogram density", "sampled normal", "sample mean"), 
            lty=c(1,1,1,1), 
            lwd=c(1,3,5,3),
            col=c("black","blue","green","red"))
    } else if (input$normal) {
      legend("topright", 
             c("sample histogram", "sampled normal", "sample mean"), 
             lty=c(1,1,1), 
             lwd=c(1,5,3),
             col=c("black","green","red"))
    } else if (input$density) {
      legend("topright", 
             c("sample histogram", "sample histogram density", "sample mean"), 
             lty=c(1,1,1), 
             lwd=c(1,3,3),
             col=c("black","blue","red"))
    } else {
      legend("topright", 
             c("sample histogram","sample mean"), 
             lty=c(1,1), 
             lwd=c(1,3,5,3),
             col=c("black","red"))
    }
    
  })
})