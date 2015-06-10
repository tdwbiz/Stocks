# Developing Data Products Course Project
# tdwbiz
#
# 2015/06/08
#

require(shiny); require(quantmod); require(rCharts)

shinyUI(fluidPage(
        titlePanel("Stocks Technical Analysis"),
        
        sidebarLayout(
                sidebarPanel(
                        helpText("Select Stock Market Ticker to see several time series plots,
                                 on a daily or weekly timeframe with some Technical indicators 
                                like Moving Averages, MACD and Bollinger Bands. 
                                 Data  from Yahoo Finance."),
                        
                        # Select data series
                        selectInput("ticker", "Ticker", "", 
                                    choices=c(                                                                                      
                                            "S&P 500"="SPY",
                                            "Dow"="DIA",
                                            "Nasdaq"="QQQ",
                                            "Apple"="AAPL",
                                            "Visa"="V",
                                            "Mastercard"="MA"
                                    ), 
                        ),
  
                        # Select chart type
                        selectInput("charttype", "Chart Type", "", 
                                    choices=c( 
                                            "Candlesticks" ="candlesticks", 
                                            "MatchSticks" = "matchsticks", 
                                            "Barchart" = "bars",
                                            "Line" = "line"
                                    ), 
                        ),                      
                        
                        dateRangeInput("dates", 
                                       "Date range:",                                 
                                       start= as.character(Sys.Date()-365*1),
                                       end = as.character(Sys.Date())
                                       )
                ),
                
                mainPanel(tabsetPanel(type = "tabs", 
                                      tabPanel("Daily - Moving Averages", plotOutput("plot")), 
                                      tabPanel("Daily - Bollinger Bands/MACD",plotOutput("plot2")),
                                      tabPanel("Weekly - Moving Averages",plotOutput("plot3")),
                                      tabPanel("Weekly - Bollinger Bands/MACD",plotOutput("plot4")),
                                      tabPanel("Returns Data", tableOutput("table"))
                ),
                h4("Latest dividend :"),
                verbatimTextOutput("lastDividend")
                )
        )))