library(shiny)
# use mpg dataset from ggplot2 package
library(ggplot2)
data(mpg)

# Define UI for application
shinyUI(fluidPage(

    # Application title
    titlePanel("Prediction of car MPG from displacement"),

    # Sidebar with a number of input fields
    sidebarLayout(
        sidebarPanel(
            # slider for picking displacement for prediction model
            sliderInput("displacement",
                        "Displacement for model:",
                        min = min(mpg$displ),
                        max = max(mpg$displ),
                        value = c(min(mpg$displ), max(mpg$displ))),
            helpText("Choose displacement range for prediction model"),
            hr(),
            # multi select for manufacturers
            selectInput("manufacturer",
                        "Manufacturer:",
                        choices = unique(mpg$manufacturer), 
                        selected = unique(mpg$manufacturer), # choose all values by default
                        multiple = TRUE), # allow multi select
            helpText("Choose at least one manufacturer. By default all manufacturers are chosen"),
            hr(),
            # slider for picking displacement to predict MPG
            sliderInput("displacementPrediction",
                        "Displacement for prediction:",
                        min = 0.8, # no models in the maket with less
                        max = 8, # no models in the maket with more
                        value = mean(mpg$displ)), # default to mean in original data set
            helpText("Input displacement to predict MPG"),
            hr(),
            # checkbox if we should show prediction in plot
            checkboxInput("showPredictionInPlot",
                          "Show Prediction in plot",
                          value = TRUE), # checked by default
            hr(),
            helpText("Data from mpg dataset from ggplot2 library")
            # submitButton("Submit")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("mpgPlot"),
            br(),
            print("You have chosen the next auto makers:"),
            textOutput("manufacturers"),
            br(),
            strong(textOutput("prediction"))
        )
    )
))
