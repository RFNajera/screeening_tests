library(shiny)
library(shinydashboard)
library(leaflet)
library(ggthemes)
library(scales)

ui <- dashboardPage(
  dashboardHeader(title = "Screening Tests"),
  dashboardSidebar(
    sliderInput("population",
                label = h4("Total Population"),
                min = 0, 
                max = 100000,
                value = 10000
                ),
    sliderInput("prevalence",
                label = h4("Prevalence"),
                min = 0, 
                max = 100,
                value = 50,
                round = 0,
                post = "%"
                ),
    sliderInput("sensitivity",
                label = h4("Test Sensitivity"),
                min = 0, 
                max = 100,
                value = 99,
                post = "%"
                ),
    sliderInput("specificity",
                label = h4("Test Specificity"),
                min = 0, 
                max = 100,
                value = 99,
                post = "%"
                )
  ),
  dashboardBody(
    fluidRow(
      column(4,
             box(
               plotOutput("plot1"),
               width = 100)
             ),
      column(4,
             box(
               plotOutput("plot2"),
               width = 100)
            ),
      column(4,
             box(
               tableOutput("values"),
               width = 100
             ))
            )
    )
  )