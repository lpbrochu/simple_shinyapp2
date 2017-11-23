library(shiny)
library(datasets)
library(accelerometry)


# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {

  # Return the requested dataset
  datasetInput <- reactive({
    switch(input$dataset,
           "rock" = rock,
           "pressure" = pressure,
           "cars" = cars)
  })

  # Generate a summary of the dataset
  output$summary <- renderPrint({
    dataset <- datasetInput()
    data(unidata)
    weartime.flag <- accel.weartime(counts = counts.part1)
    counts.part1 <- unidata[unidata[, "seqn"] == 21005, "paxinten"]
    summary(dataset)
  })

  # Show the first "n" observations
  output$view <- renderTable({
    head(datasetInput(), n = input$obs)
  })
})

