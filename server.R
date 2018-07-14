library(shiny)
MyVls<- read.csv("vlsacum.csv", header=TRUE, sep=";")
#MyVls<- read.csv("vlsacum.csv", header=TRUE, sep=";")
vlsh <- data.frame(MyVls)
shinyServer(function(input, output) {
  model <- reactive({
    brushed_data <- brushedPoints(vlsh, input$brush1,
                                  xvar = "week", yvar = "vls")
    if(nrow(brushed_data) < 2 ){
      return(NULL)
    }
    lm(vls ~ week, data = brushed_data)
  })
  output$realvalue <- renderText({
    vlsh$vls[input$sliderweek2]-vlsh$vls[input$sliderweek1]
  })
  output$adjrs <- renderText({
    if(is.null(model())){
      "No Model Found"
    } else {
      summary(model())$adj.r.squared
    }
    
  })  
  # ...
  output$slopeOut <- renderText({
    if(is.null(model())){
      "No Model Found"
    } else {
      model()[[1]][2]
    }
    
  })
  # ...Intercept value = model()[[1]][1]
  output$intOut <- renderText({
    if(is.null(model())){
      "No Model Found"
    } else {
      model()[[1]][2]*(input$sliderweek2-input$sliderweek1+1)
    }
  })
  output$plot1 <- renderPlot({
    plot(vlsh$week, vlsh$vls, xlab = "Weeks",
         ylab = "NPL Reduction", main = "NPL Stock Reduction Jan 2017-Jun 2018",
         cex = 1.0, pch = 16,col=vlsh$year,bty = "n")
    if(!is.null(model())){
      abline(model(), col = "blue", lwd = 2)
    }
  })
})