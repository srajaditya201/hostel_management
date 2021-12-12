constructOpsUi <- function(input, output, session) {
  output$Ops_ui <- renderUI(
      getOpsUi()
  )
}
observeEvent(c(input$date),
    
    if (input$date[2] < input$date[1]) {
        alertDateRange()
    }
)