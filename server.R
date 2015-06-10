# Developing Data Products Course Project
# tdwbiz
#
# 2015/06/08
#

require(shiny); require(quantmod); require(rCharts); require(devtools)

shinyServer(function(input, output) {
        
        # data
        data <- reactive({
                getSymbols(input$ticker, src = "yahoo",
                           from=input$dates[1],
                           to=input$dates[2],
                           auto.assign = FALSE,adjust=TRUE
                           ) 
         }
       )
         
        # plot 1 output 
        output$plot <- renderPlot({
                chartSeries(data(),
                            type = input$charttype,
                            name=input$ticker,
                            subset = NULL,
                            show.grid = TRUE, 
                            time.scale = NULL,
                            TA=c(addVo(),
                                 addSMA(n = 10, on = 1, with.col = Cl, overlay = TRUE, col = "brown"),
                                 addSMA(n = 50, on = 1, with.col = Cl, overlay = TRUE, col = "blue")   
                            ),
                            TAsep=';',
                            line.type = "l",
                            bar.type = "ohlc",
                            theme = chartTheme("white"),
                            layout = NA,
                            major.ticks='auto', minor.ticks=TRUE,
                            up.col="green",dn.col="red",color.vol = TRUE, multi.col = FALSE)
        })
 
        # plot 2 output 
        output$plot2 <- renderPlot({
                chartSeries(data(),
                            type = input$charttype,
                            name=input$ticker,
                            subset = NULL,
                            show.grid = TRUE, 
                             time.scale = NULL,
                            TA=c(addVo(),
                                 addMACD(),
                                 addBBands()   
                            ),
                            TAsep=';',
                            line.type = "l",
                            bar.type = "ohlc",
                            theme = chartTheme("white"),
                            layout = NA,
                            major.ticks='auto', minor.ticks=TRUE,
                            up.col="green",dn.col="red",color.vol = TRUE, multi.col = FALSE)
        })
        

        # plot 3 output 
        output$plot3 <- renderPlot({
                chartSeries(to.weekly(data()),
                            type = input$charttype,
                            name=input$ticker,
                            subset = NULL,
                            show.grid = TRUE, 
                            time.scale = NULL,
                            TA=c(addVo(),
                                 addSMA(n = 4, on = 1, with.col = Cl, overlay = TRUE, col = "brown"),
                                 addSMA(n = 20, on = 1, with.col = Cl, overlay = TRUE, col = "blue")   
                            ),
                            TAsep=';',
                            line.type = "l",
                            bar.type = "ohlc",
                            theme = chartTheme("white"),
                            layout = NA,
                            major.ticks='auto', minor.ticks=TRUE,
                            up.col="green",dn.col="red",color.vol = TRUE, multi.col = FALSE)
        })
         
# plot 4 output 
        output$plot4 <- renderPlot({
                chartSeries(to.weekly(data()),
                            type = input$charttype,
                            name=input$ticker,
                            subset = NULL,
                            show.grid = TRUE, 
                            time.scale = NULL,
                            TA=c(addVo(),
                                  addMACD(),
                                  addBBands()   
                             ),
                            TAsep=';',
                            line.type = "l",
                            bar.type = "ohlc",
                            theme = chartTheme("white"),
                            layout = NA,
                            major.ticks='auto', minor.ticks=TRUE,
                            up.col="green",dn.col="red",color.vol = TRUE, multi.col = FALSE)
        })

        # table output
        output$table <- renderTable({
                dataReturns <- allReturns(data(), type='arithmetic')              
                dataReturns
        })
        output$lastDividend <- renderText({
                dividends = getDividends(input$ticker)
        value = "None"
        if(length(dividends))
                value = paste(tail(dividends, 1), "$", sep=" ") 
        
        value
        })
})