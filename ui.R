library(shinydashboard)
library(shiny)
library(DT)

dashboardPage(skin = "blue",
              
              
              
              dashboardHeader(title = "Stocks"),
              dashboardSidebar(
                tags$head(
                  tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
                ),
                sidebarMenu(
                        checkboxInput(inputId = "stock_aapl", label = "Apple (AAPL)",     value = TRUE),
                        checkboxInput(inputId = "stock_msft", label = "Microsoft (MSFT)", value = FALSE),
                        checkboxInput(inputId = "stock_ibm",  label = "IBM (IBM)",        value = FALSE),
                        checkboxInput(inputId = "stock_goog", label = "Google (GOOG)",    value = TRUE),
                        checkboxInput(inputId = "stock_yhoo", label = "Yahoo (YHOO)",     value = FALSE),
                        selectInput(inputId = "chart_type",
                                    label = "Chart type",
                                    choices = c("Candlestick" = "candlesticks",
                                                "Matchstick" = "matchsticks",
                                                "Bar" = "bars",
                                                "Line" = "line")
                        ),
                        dateRangeInput(inputId = "daterange", label = "Date range",
                                       start = Sys.Date() - 365, end = Sys.Date()),
                        
                        checkboxInput(inputId = "log_y", label = "log y axis", value = FALSE),
                        menuItem("Source code", icon = icon("github"),
                           href = "https://github.com/unfaostatistics/faodash")
                )
                
                
              ),
              dashboardBody(
                
              
                tabItem(tabName = "production_and_trade",

                            
                        tags$hr(),
                        # mainPanel(
                          conditionalPanel(condition = "input.stock_aapl",
                                                              br(),
                                                              div(plotOutput(outputId = "plot_aapl"))),

                         conditionalPanel(condition = "input.stock_msft",
                                          br(),
                                          div(plotOutput(outputId = "plot_msft"))),

                         conditionalPanel(condition = "input.stock_ibm",
                                          br(),
                                          div(plotOutput(outputId = "plot_ibm"))),

                         conditionalPanel(condition = "input.stock_goog",
                                          br(),
                                          div(plotOutput(outputId = "plot_goog"))),

                         conditionalPanel(condition = "input.stock_yhoo",
                                          br(),
                                          plotOutput(outputId = "plot_yhoo"))
                       # )
                       )
                )
              )



# shinyUI(pageWithSidebar(
#   headerPanel("Kazak Stocks"),
#   
#   sidebarPanel(
#     wellPanel(
#       p(strong("Stocks")),
#       checkboxInput(inputId = "stock_aapl", label = "Apple (AAPL)",     value = TRUE),
#       checkboxInput(inputId = "stock_msft", label = "Microsoft (MSFT)", value = FALSE),
#       checkboxInput(inputId = "stock_ibm",  label = "IBM (IBM)",        value = FALSE),
#       checkboxInput(inputId = "stock_goog", label = "Google (GOOG)",    value = TRUE),
#       checkboxInput(inputId = "stock_yhoo", label = "Yahoo (YHOO)",     value = FALSE)
#     ),
#     
#     selectInput(inputId = "chart_type",
#                 label = "Chart type",
#                 choices = c("Candlestick" = "candlesticks",
#                             "Matchstick" = "matchsticks",
#                             "Bar" = "bars",
#                             "Line" = "line")
#     ),
#     
#     dateRangeInput(inputId = "daterange", label = "Date range",
#                    start = Sys.Date() - 365, end = Sys.Date()),
#     
#     checkboxInput(inputId = "log_y", label = "log y axis", value = FALSE)
#   ),
#   
#   mainPanel(
#     conditionalPanel(condition = "input.stock_aapl",
#                      br(),
#                      div(plotOutput(outputId = "plot_aapl"))),
#     
#     conditionalPanel(condition = "input.stock_msft",
#                      br(),
#                      div(plotOutput(outputId = "plot_msft"))),
#     
#     conditionalPanel(condition = "input.stock_ibm",
#                      br(),
#                      div(plotOutput(outputId = "plot_ibm"))),
#     
#     conditionalPanel(condition = "input.stock_goog",
#                      br(),
#                      div(plotOutput(outputId = "plot_goog"))),
#     
#     conditionalPanel(condition = "input.stock_yhoo",
#                      br(),
#                      plotOutput(outputId = "plot_yhoo"))
#   )
# ))