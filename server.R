library(dplyr)

if (!require(quantmod)) {
  stop("This app requires the quantmod package. To install it, run 'install.packages(\"quantmod\")'.\n")
}

# Download data for a stock if needed, and return the data
require_symbol <- function(symbol, envir = parent.frame()) {
  if (is.null(envir[[symbol]])) {
    envir[[symbol]] <- getSymbols(symbol, auto.assign = FALSE)
  }
  
  envir[[symbol]]
}


shinyServer(function(input, output) {
  
  # Create an environment for storing data
  symbol_env <- new.env()
  
  # Make a chart for a symbol, with the settings from the inputs
  make_chart <- function(symbol) {
    symbol_data <- require_symbol(symbol, symbol_env)
    
    chartSeries(symbol_data,
                name      = symbol,
                type      = input$chart_type,
                subset    = paste(input$daterange, collapse = "::"),
                log.scale = input$log_y,
                theme     = "white")
  }
  output$plot_aapl <- renderPlot({ make_chart("AAPL") })
  output$plot_msft <- renderPlot({ make_chart("MSFT") })
  output$plot_ibm  <- renderPlot({ make_chart("IBM")  })
  output$plot_goog <- renderPlot({ make_chart("GOOG") })
  output$plot_yhoo <- renderPlot({ make_chart("YHOO") })
  
  
   
   
   output$dateRangeText  <- renderText({
     #paste(input$daterange_kase, collapse = "/")
     paste0("http://www.kase.kz/en/index_kase/archive/",
           paste(format(input$daterange_kase, "%d.%m.%Y"), collapse = "/"),
           "/csv")
     
     # http://www.kase.kz/en/index_kase/archive/10.09.2015/11.09.2015/csv
     
   })
  
  data_kase <- reactive({

    url <- paste0("http://www.kase.kz/en/index_kase/archive/",
           paste(format(input$daterange_kase, "%d.%m.%Y"), collapse = "/"),
           "/csv")
    # dat <- read.csv(url)
    # names(dat) <- c("open","high","low","close","vol")
    # # dat$date <- format(dmy(rownames(dat)), "%Y/%m/%d")
    # dat$date <- dmy(as.character(rownames(dat)))
    # dat <- dat[-6]
    # # dat <- arrange(dat, date)
    # # dat <- dat[-1:-10,]
    # # dat <- arrange(dat, -date)
    # # dat <- dat[-1:-10,]
    # dat
    
    dat <- read.table(url,
                      sep = ",", header = F,
                      skip = 1)
    dat$V7 <- NULL
    names(dat) <- c("date", "open","high","low","close","vol")
    dat$vol <- NULL
    dat$date <- lubridate::mdy(dat$date)
    dat
    
    })
  
  
  output$table_kase <- DT::renderDataTable({
    
    dat <- data_kase()
    dat$date <- as.Date(format(dat$date, "%Y-%m-%d"))
    DT::datatable(dat, 
                  colnames = c("Дата",
                               "Открытие",
                               "Макс",
                               "Мин",
                               "Закрытие"),
                  filter = "top",
                  options = list(language = list(
                    # url = "dataTables.russian.lang",
                    lengthMenu = "Строк на страницу: _MENU_",
                    search     = "Искать: ",
                    info       = "Показаны строки от №_START_ до №_END_ из _TOTAL_",
                    infoFiltered =  "(отфильтровано из _MAX_ записей)",
                    paginate = list(sFirst =    "Первая",
                                    sPrevious = "Предыдущая",
                                    sNext =     "Следующая",
                                    sLast =     "Последняя")
                    ),
                                 pageLength = 5
                                 )
    )
    } 
    )
  
  output$dygraph <- renderDygraph({
    d <- data_kase()
    qxts <- xts(d, order.by=d[,1])
    
    dygraph(qxts, main = "Индекс KASE") %>% 
      dyRangeSelector()
  })
  



})