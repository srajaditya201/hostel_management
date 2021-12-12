authenticateUser <- function(username, password, state_user) {
  type <- "query"
  user_details <- verify_creds(username, password)
  if (user_details$valid){
    otp <- generate_otp()
    number <- user_details$phone_num
    state_user$token <- toupper(sha256(paste0(password, username)))
    response <- GET(
      glue(
          paste0(
            'https://http.myvfirst.com/smpp/sendsms?',
            'username={myvalue_user}',
            '&password={myvalue_pw}',
            '&from=JUSPAY',
            '&to={number}',
            '&text=%3C%23%3E{otp}%20is%20your%20OTP%20to%20log%20into%20GeM-Sahay%20apppPIsAfv6B8A',
            '&coding=0'
          )
      )
    )

    otp_status_code <- response$status
    if (otp_status_code == 200) {
      state_user$user <- username
      state_user$otp <- otp
      state_user$lender_name <- user_details$lender_name
      state_user$user_tabs <- user_details$user_tabs
    } else {
      output$error_message <- renderUI({
        tags$div(
          class = "error_msg",
          "OTP could not sent"
        )
      })
    }
  } else {
    output$error_message <- renderUI({
        tags$div(
          class = "error_msg",
          "User not found"
        )
    })
  }
}

sessionResume <- function (token_credit_ops){
  user_details <- retrieve_session(token_credit_ops)
  if(user_details$valid){
    state_user$lender_name <- user_details$lender_name
    state_user$user_tabs <- user_details$user_tabs
    state_user$login <- T
  }
  else {
      output$main_page <- renderUI({
        getLoginPage()
      })
    }
}

observeEvent(input$get_cookie_trigger, {
    getTokenlist <-list(
      getToken <- "tata_capital_token"
    )
    session$sendCustomMessage("shinyCookieGetParam",getTokenlist)
    
    observeEvent(input$cookie_resp,{
      if(input$cookie_resp=="NA"){
        output$main_page <- renderUI(getLoginPage())
      }
      else{
        sessionResume(input$cookie_resp)
      }
    })

})

observeEvent(input$logout,{
       state_user$login = FALSE 
       remList <- list(
         Token_rem <- "tata_capital_token"
       )
       session$sendCustomMessage("shinyCookieRem",Token_rem)     
  })

observeEvent(input$cookie_removed,{
    output$main_page <- renderUI({
            getLoginPage()
          })
  })

observeEvent(input$otp_gen_btn,{
    authenticateUser(input$username,input$password, state_user)
    if(!is.null(state_user$otp)){
        shinyjs::hide("otp_gen_btn")
        output$otp_input <- renderUI({
            fluidRow(
                id = "otp-section",
                textInput("otp","OTP",value = ""),
                actionButton("submit","Securely Login",icon = icon("lock"),style = "color: #fff; background-color: #0275d8;"),
            )
        })
    }
})

observeEvent(input$submit,{
    if(!is.na(as.numeric(input$otp)) && state_user$otp == input$otp){
        # Store token in cookie
        li <- list(
          name = "tata_capital_token",
          value = state_user$token,
          parameters = list(expires = 1, sameSite = 'strict')
        )
        session$sendCustomMessage("shinyCookieParam", li)
        # Loading dashboard content in logged in state
        output$main_page <- renderUI(dashboardPage(header, getSidebarFromAcl(state_user$user_tabs), body))
    }else{
        output$error_message <- renderUI({
            tags$div(
                class = "error_msg",
                "Invalid OTP"
            )
        })
    }
})