header <- dashboardHeader(

  title = "TATA CAPITAL",
  
  dropdownMenu(
    headerText = "My Account",
    icon = icon("user-circle"),
    badgeStatus = NULL,
    tags$li(
      class = "dropdown",
      (
        actionButton("logout","Logout")  
      )
    )
  )
)

beautify <- function(x) {
  paste(x ,
        sep = "",
        collapse = " ")
}

body <- dashboardBody(
  tags$head(
    includeCSS(path = "www/css/styles.css")
  ),
  tabItems(
    tabItem(
      "Ops",
      uiOutput("Ops_ui")
    ),
    tabItem(
      "Rules",
      uiOutput("Rules_ui")
    )
  )
)


ui <- tags$div(
  useShinyjs(),
  tags$head(
      includeScript("www/js/app.js"),
      includeScript("www/js/js.cookie.js")
  ),
  uiOutput("main_page")
)