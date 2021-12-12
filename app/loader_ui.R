getLoaderUI <- function(input,output,session){
    tags$div(
        id = "loader_page_ui", 
        fluidPage(
            fluidRow(
                id="main_loader",
                img(src="assets/loader.gif"),
                align ="center"
            )
        )
    )
}