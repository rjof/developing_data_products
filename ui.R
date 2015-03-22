library(shiny)
shinyUI(pageWithSidebar(
                        headerPanel("Persons who were served by the organization in 2014."),
                        sidebarPanel(
                                     radioButtons("topX", "How many nationalities to show",
                                                        c("Top 10 nationalities" = 10,
                                                          "Top 20 nationalities" = 20,
                                                          "Top 30 nationalities" = 30,
                                                          "Top 40 nationalities" = 40)
                                                  )
                                     ),
                        mainPanel(
                                  tabsetPanel(
                                              tabPanel("Summary",
                                                       h3("What is the data about?"),
                                                       p("The data is about the work of a mexican organization which receive foreign persons (not mexicans) who need any kind of advise about their migratory situation."),
                                                       h3("What it shows?"),
                                                       h4("The Plot tab"),
                                                       p("There are two plots."),
                                                       p("One is the top X nationalities of the persons who required the services of the organization in 2014."),
                                                       p("The other is a pie chart with the sex of the persons"),
                                                       h4("The Data plot"),
                                                       p("It shows the data from which the plots are created."),
                                                       h3("What are the radio buttons for?"),
                                                       p("With these radio buttons you choose how many nationalities to show in the Plot and Data tabs.")
                                                       ),
                                              tabPanel("Plot",
                                                       p("Top X nationalities been followed up"),
                                                       verbatimTextOutput("topX"),
                                                       plotOutput("histAtt"),
                                                       plotOutput("pieSex")
                                                       ), 
                                              tabPanel("Data",
                                                       tableOutput("table2"),
                                                       tableOutput("table")
                                                       )
                                              )
                                  )
                        )
        )
