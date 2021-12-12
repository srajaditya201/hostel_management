getLoginPage <- function(){
  fluidPage(
    useShinyjs(),
    tags$head(
      includeScript("www/js/app.js"),
      includeScript("www/js/js.cookie.js")
    ),
    tags$link(rel = "stylesheet", type = "text/css", href = "css/styles.css"),
    column( 
      width = 6, 
      fluidRow(
        img(id = "analytics",src = "assets/login4.svg", height = 500, width = 700)
      ),
      align = "center"
    ),
    column( 4,
      offset = 2,
      img(src = "assets/logo-group.svg", height = 100, width = 250),
      HTML("
        <br>
        One Stop for all payment solutions.
        <br>
        Please login to access the dashboard.
        <br>
      "),
      br(),
      textInput("username","Username"),
      passwordInput("password","Password"),
      actionButton("otp_gen_btn","Generate Otp",icon = icon("sms"),style = "color: #fff; background-color: #0275d8;"),
      uiOutput("otp_input"),
      uiOutput("error_message")
    ) 
  )
}
