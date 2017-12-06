library(shiny)
library(DT)

shinyServer(function(input, output, session) {

  cur_bf <- data.frame()

  output$entries <- DT::renderDataTable({

    burp_file <- input$burpfile
    # burp_file <- list(datapath = "~/Desktop/hannaford.burp")

    if (is.null(burp_file)) return(NULL)

    cur_bf <<- read_burp(burp_file$datapath)

    cur_bf[,c("time", "url", "host", "port", "protocol", "method", "path",
              "extension", "request", "status")]

  }, server=TRUE, selection = 'single')

  output$rawText <- shiny::renderText({

    radio <- input$dataView
    entry <- input$entries_rows_selected

    r_col <- if (radio == "req") "raw_request" else "raw_response"

    as.character(cur_bf[entry, r_col][[1]])

  })

})


