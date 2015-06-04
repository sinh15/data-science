## Question 1. Api connection and data processing
    library(httr)
    
    # Find Oaut Settings
    oauth_endpoints("github")
    
    # Personal credentials
    myapp <- oauth_app("github", 
                      key = "33b1d4e05e0bc0b111f8",
                      secret = "8dc36b59ba80d67761ca3de8a7a532e763c05ad2")
    
    # Get OAuth credentials
    github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
    
    # Use API
    gtoken <- config(token = github_token)
    req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
    stop_for_status(req)
    content(req)
    
    ## Alternative FUCKIN EASIER W/O ERGISTERING AN APP
    req2 <- fromJSON("https://api.github.com/users/jtleek/repos")
    req3 <- req2[req2$name == "datasharing", ]
    req3[, "created_at"]
    
## Question 2-3: Easy sQL matters
    
## Question 4: Read HTML
    con = url("http://biostat.jhsph.edu/~jleek/contact.html")
    htmlCode = readLines(con)
    close(con)
    nchar(c(htmlCode[10], htmlCode[20], htmlCode[30], htmlCode[100]))
    
## Question 5: Read data of the Internet
    q5 <- read.fwf("getdata-wksst8110.for", 
                   skip=4,
                   widths=c(12, 7,4, 9,4, 9,4, 9,4))
    sum(q5[, 4])