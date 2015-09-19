lang <- "ru"
dateRangeInputSepar <- "до"


library(shinydashboard)
library(shiny)
library(DT)
library(lubridate)
library(dygraphs)
library(datasets)

dashboardPage(skin = "black",
              dashboardHeader(title = "Демприложение"),
              dashboardSidebar(
                tags$head(
                  tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
                ),
                sidebarMenu(
                  #menuItem("Tengen rate", tabName = "tengen", icon = icon("money")),
                  menuItem("Индекс KASE", tabName = "kase", icon = icon("table")),
                  menuItem("Акции", tabName = "stock", icon = icon("line-chart"))
                )
                
                
              ),
              dashboardBody(
                tabItems(
                  tabItem(tabName = "tengen"#,
                          
                          # Nothing for tengen
                          
                          ),
                  
                  tabItem(tabName = "kase",
                          
                          
                          
                          fluidRow(
                            column(12,
                            dateRangeInput(inputId = "daterange_kase", 
                                           label = "Интервал дат",
                                           start = Sys.Date() - 365, 
                                           end = Sys.Date(),
                                           language = lang,
                                           separator = dateRangeInputSepar,
                                           format = "dd.mm.yyyy"),
                            checkboxInput("showgrid", 
                                          label = "Показывать сетку", 
                                          value = TRUE)

                            )
                            ),
                            tags$hr(),

                          fluidRow(
                            column(12, 
                                   dygraphOutput("dygraph")
                            )
                          ),
                          tags$br(),
                          fluidRow(
                            infoBoxOutput("box_high",  width=6),
                            infoBoxOutput("box_low",  width=6)
                          ),
                          tags$hr(),
                          fluidRow(
                            column(12, 
                                   dataTableOutput("table_kase")
                            )
                          )
                          
                  ),
                  
                
              
                tabItem(tabName = "stock",
                        
                        
                        fluidRow(
                          column(4,
                                 checkboxInput(inputId = "stock_aapl", label = "Apple (AAPL)",     value = TRUE),
                                 checkboxInput(inputId = "stock_msft", label = "Microsoft (MSFT)", value = FALSE),
                                 checkboxInput(inputId = "stock_ibm",  label = "IBM (IBM)",        value = FALSE)
                                 ),
                          column(4,
                                 checkboxInput(inputId = "stock_goog", label = "Google (GOOG)",    value = TRUE),
                                 checkboxInput(inputId = "stock_yhoo", label = "Yahoo (YHOO)",     value = FALSE)
                          ),
                          column(4,
                                 selectInput(inputId = "chart_type",
                                             label = "Тип графика",
                                             choices = c("Японские свечи" = "candlesticks",
                                                         "Спичечный" = "matchsticks",
                                                         "Bar" = "bars",
                                                         "Line" = "line")
                                 ),
                                 dateRangeInput(inputId = "daterange", label = "Интервал дат",
                                                start = Sys.Date() - 365, end = Sys.Date(),
                                                language = lang,
                                                separator = dateRangeInputSepar),
                                 
                                 checkboxInput(inputId = "log_y", label = "Логарифм по вертикали", value = FALSE)
                          )
                          ),
                        fluidRow(
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
                       )
                )
              )
              )
)
