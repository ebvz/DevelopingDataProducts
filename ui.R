#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.

MyVls<- read.csv("vlsacum.csv", header=TRUE, sep=";")
vlsh <- data.frame(MyVls)

shinyUI(fluidPage(
  navbarPage("Main",
  tabPanel("Simulate",           
  titlePanel("Simulate Many Models"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("sliderweek1", "Choose Initial week", 1, 77, value = 1),
      sliderInput("sliderweek2", "Choose Final week", 1, 77, value = 52),
      h3("Slope"),
      textOutput("slopeOut"),
      h3("Predicted Value"),
      textOutput("intOut"),
      h3("Real Value"),
      textOutput("realvalue"),
      h3("Adjusted R Squared"),
      textOutput("adjrs")
    ),
  
    mainPanel(
      plotOutput("plot1", brush = brushOpts(
        id = "brush1"
    
      ))
    )
    )
  ),
  tabPanel("About",
           h3('Main Description'),
           p("This App simulate models using simple linear regression.",
             
   "The dataset is the acumulated stock reduction of NPLs (non-performance-loans) in Mio Eur ",
   "during the years of 2017 and the first 6 months on 2018.   ",
   h3('How to use the App'),
   "You choose the analysis period using the initial and final week.  ",
   "Then with the mouse select/grab the correspondent period in points (weeks) on the ploted points. " ,
   "The black points represent the year 2017 and the red points the 2018.",
   "                                                                  ",
   "Anytime you grab diferent points the model is recalculated, and new values appear. " ,
   "If you do not select any plotted points a message of 'No Model Found' appears",
   h3('Understanding the Results'),
   "This App is a tool to predict the amount of NPL week reduction, for the next half.",
   "The Slope is the week mean reduction for the period  chosen by the user.",
   " The R Squared Value, is a number between 0 and 1, where 1  is the maximum.",
  " This represents the accuracy of the model, in other words: ",
  "represents the proportion of the variance for a dependent variable that's explained by an independent variable.",
  h3('Example with numbers'),
  "If we choose the whole year, we get a slope of -12,088 and a R Squared of 99%.",
  " The model is calculating a week average reduction of NPL of -12,088 and 99% of the dependen variable variation is explained by the model."
  
  
  )
           )
)))