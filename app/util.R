postgresQuery <- function(query, type = 'query') {
  tryCatch({
    postgres_con <- dbConnect(
      RPostgres::Postgres(), 
      dbname = psql_db_name,
      host = psql_host,
      port = 5432,
      user = psql_user,
      password = psql_pw
    )
    if (type == 'query') {
      df <- dbGetQuery(postgres_con, query)
      dbDisconnect(postgres_con)
      return(df)
    }
    else {
      dbExecute(postgres_con, query)
      dbDisconnect(postgres_con)
    }
  },
  error = function(e) {
    if (type == 'query') {
      return(data.frame())
    } else {
      return(FALSE)
    }
  })
}

alertDateRange <- function(){
  shinyalert(
            title = "Oops..",
            text = "Your selected end date lies before the start date",
            closeOnClickOutside = TRUE,
            type = "error",
            showConfirmButton = TRUE,
            confirmButtonText = "OK",
            confirmButtonCol = "#AEDEF4",
            animation = TRUE
        )

}