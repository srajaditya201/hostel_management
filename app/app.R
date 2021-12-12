library(RPostgres)
library(shiny)
library(tidyverse)
library(shinyalert)
library(shinyjs)
library(shinydashboard)

source("util.R")
source("ui_combined.R")
source("config.R")

# source("login_module/util.R")
# source("login_module/ui.R")

# source("loader_ui.R")

source("Ops/util.R")
source("Ops/ui.R")

# Run the application
server <- function(input, output, session) {

  source("Ops/observers.R", local = TRUE)

  sidebar <- dashboardSidebar(
                useShinyalert(),
                useShinyjs(),
                tags$head(
                    includeScript("www/js/app.js"),
                    includeScript("www/js/js.cookie.js")
                ),
                sidebarMenu(id = "tabs",
                            lapply(tab_list, 
                                function(tab) {
                                    do.call(menuItem, list(
                                        text = beautify(tab),
                                        tabName = tab,
                                        icon = icon("dashboard"))
                                    )
                                }
                            )
                )
            )

  output$main_page <- renderUI({
      dashboardPage(header ,sidebar, body)
  })

  constructOpsUi(input, output, session)
  
}

shinyApp(ui = ui, server = server)