library(shiny)
# use mpg dataset from ggplot2 package
library(ggplot2)
data(mpg)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    mpgModelPrediction <- reactive({
        minDisp <- input$displacement[1]
        maxDisp <- input$displacement[2]
        mpg <- subset(mpg, displ >= minDisp & displ <= maxDisp & manufacturer %in% input$manufacturer)
        mpgModel <- lm(cty ~ displ, data = mpg)
        predict(mpgModel, newdata = data.frame(displ = input$displacementPrediction))
    })
    
    output$mpgPlot <- renderPlot({
        mpgInput <- input$displacementPrediction
        minDisp <- input$displacement[1]
        maxDisp <- input$displacement[2]
        mpgData <- subset(mpg, displ >= minDisp & displ <= maxDisp & manufacturer %in% input$manufacturer)
        plot(x = mpgData$displ, y = mpgData$cty, col = 'darkgray', xlab = "Displacement", ylab = "MPG", main = "City MPG depending on engine displacement")
        if(input$showPredictionInPlot){
            points(mpgInput, mpgModelPrediction(), col = "red", pch = 16, cex = 2)
        }
        
    })
    
    output$manufacturers <- renderText({
        paste(input$manufacturer)
    })
    
    output$prediction <- renderText({
        paste("Predicted MPG for your combination is: ", round(mpgModelPrediction(), digits = 2))
    })

})


