environment <- Sys.getenv("SENV")

psql_db_name <- ifelse(
                    Sys.getenv("PG_DATABASE") == "",
                    "",
                    Sys.getenv("PG_DATABASE")
                )

psql_host <- ifelse(
                environment == "",
                "",
                Sys.getenv("PG_HOST")
            )

psql_user <- ifelse(
                environment == "",
                "",
                Sys.getenv("PG_USER")
            )

psql_pw <- ifelse(
                environment == "",
                "",
                Sys.getenv("PG_PASSWD")
            )

tab_list <- c('Ops','Rules')
