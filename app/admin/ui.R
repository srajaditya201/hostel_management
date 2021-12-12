getOpsUi <- function (loan_status_choices){
    fluidPage(
        fluidRow(
            h2(strong("Ops"), align = "center")
        ),
        hr(),
        fluidRow(
            column(3,
                    dateRangeInput(
                        inputId = "date",
                        label = "Select The Date Range",
                        start = format(Sys.Date() - 2, '%Y-%m-%d'),
                        end = format(Sys.Date(), '%Y-%m-%d')
            ))
        )
    )
}