library(shiny)

fluidPage(

  title = 'Burp Viewer',

  h1('Burp File Viewer'),

  fluidRow(
    column(10, fileInput("burpfile", "Choose Burp File")),
    column(10, DT::dataTableOutput('entries'))
  ),

  fluidRow(
    column(
      10,
      radioButtons("dataView", "", c("Request" = "req", "Response" = "resp"), selected="resp")
    )
  ),

  fluidRow(
    column(
      10,
      tabsetPanel(
        type = "tabs",
        tabPanel(title="Raw", verbatimTextOutput("rawText")),
        tabPanel(title="Params", textOutput("paramsText")),
        tabPanel(title="Headers", textOutput("headersText")),
        tabPanel(title="Hex", textOutput("hexText"))
      )
    )
  )

)

# shiny::runApp(system.file("shinyapps", "burpviewer", package="burrp"))
# shiny::runApp("./inst/shinyapps/burpviewer")