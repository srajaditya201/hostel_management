generate_otp <- function() {
  length <- 6
  otp <- runif(length, 0, 10) %>% sapply(., floor) %>% paste(., collapse = '')
}

verify_creds <- function(username,password){
  encrypted_pass <- toupper(sha256(paste0(password, username)))
  search_query <- postgresQuery(glue("SELECT phone_num, account_type, account_ref_id, access_control, lender_name FROM log_viewer_user WHERE password = '{encrypted_pass}';"),type)
  if(nrow(search_query)>0){
    list(
      phone_num = search_query$phone_num[1], 
      account_type = search_query$account_type[1],
      account_ref_id = search_query$account_ref_id[1],
      lender_name = search_query$lender_name[1],
      user_tabs = unlist(strsplit(search_query$access_control[1],",")),
      valid = TRUE
    )
  }else{
    list(valid = FALSE)
  }
}

retrieve_session <- function(token_credit_ops){
  search_query <- postgresQuery(glue("SELECT phone_num, account_type, account_ref_id, access_control, lender_name FROM log_viewer_user WHERE password = '{token_credit_ops}';"),type)
  if(nrow(search_query)>0){
    list(
      phone_num = search_query$phone_num[1], 
      account_type = search_query$account_type[1],
      account_ref_id = search_query$account_ref_id[1],
      lender_name = search_query$lender_name[1],
      user_tabs = unlist(strsplit(search_query$access_control[1],",")),
      valid = TRUE
    )
  }else{
    list(valid = FALSE)
  }
}