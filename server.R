library(shiny)
library(shinydashboard)
library(ggplot2)

#Server Logic
server <- function(input, output) {
    
    # Point Graph ----
    plot_data <- reactive(
      data.frame(
        prevalence = input$prevalence,
        ppv = (((input$population*(input$prevalence/100))*(input$sensitivity/100))/(((input$population*(input$prevalence/100))*(input$sensitivity/100))+((input$population -(input$population*(input$prevalence/100)))-((input$population-(input$population*(input$prevalence/100)))*(input$specificity/100))))*100),
        npv = (((input$population-(input$population*(input$prevalence/100)))*(input$specificity/100))/(((input$population - (input$population*(input$prevalence/100)))*(input$specificity/100))+((input$population*(input$prevalence/100))-((input$population*(input$prevalence/100))*(input$sensitivity/100))))*100)
      )
    ) # End reactive for point plot data
    
    observeEvent(
      {
      input$sensitivity
      input$specificity
      input$prevalence
      },
    (output$plot1 <- renderPlot
     ({
      ggplot(
        data = plot_data(),
        aes(prevalence, ppv)
             ) +
         geom_point(aes(x = prevalence, y = ppv),
                   color = "blue",
                   size = 4) +
         geom_point(aes(x = prevalence, y = npv),
                    color = "red",
                    size = 4) +
         labs(title = "Prevalence vs. Positive Predictive Value\nand Negative Predictive Value",
             subtitle = "Note that PPV (blue) and NPV (red) go up and down based on prevalence",
             x = "Prevalence",
             y = "Positive Predictive Value"
        ) +
        xlim(0,100)+
        ylim(0,100)+
        theme_bw()
    })
    )
    ) # End of ObserveEvent plot1
    
 # Bar Plot ----
    
    graph_data <- reactive(
      data.frame(
        "resultado" = as.factor(
          c("True Positive", "False Negative", "False Positive", "True Negative")
        ),
        "valor" = as.numeric(
          c(
            ((input$population*(input$prevalence/100))*
               (input$sensitivity/100)),
            ((input$population*(input$prevalence/100))-
               ((input$population*(input$prevalence/100))*(input$sensitivity/100))),
            ( (input$population - (input$population*(input$prevalence/100)))-
                ((input$population - (input$population*(input$prevalence/100)))*(input$specificity/100))),
            ((input$population - (input$population*(input$prevalence/100)))*
               (input$specificity/100))
          )
        )
      )
    ) # End reactive for bar plot data
    
    observeEvent(
      {
        input$population
        input$sensitivity
        input$specificity
        input$prevalence
      },
      (output$plot2 <- renderPlot({
        ggplot(graph_data(),
               aes(x = resultado,
                   y = valor,
                   fill = factor(resultado))
               ) +
          geom_col(
                   color = "black"
                   ) +
          scale_fill_manual( values=c("red","red","blue","blue")) +
          scale_y_continuous(labels = comma) +
          labs(title="Number of People by Positive/Negative Result",
               subtitle = "Data Updates With Inputs",
               x = "Type of Result",
               y = "Number of Results"
          ) +
          theme_bw() +
          theme(legend.position="none")
         })
       )
      )# End of ObserveEvent plot2
    
    # Reactive expression to create data frame of all input values ----
    sliderValues <- reactive({
      data.frame(
        Result = c(
          "True Cases",
          "True Non-Cases",
          "True Positives",
          "True Negatives",
          "False Positives",
          "False Negatives",
          "Positive Predictive Value",
          "Negative Predictive Value"
        ),
        Value = as.character(c(
          input$population*
            (input$prevalence/100),
          input$population - 
            (input$population*(input$prevalence/100)),
          (input$population*(input$prevalence/100))*
            (input$sensitivity/100),
          (input$population - (input$population*(input$prevalence/100)))*
            (input$specificity/100),
          (input$population - (input$population*(input$prevalence/100)))-
            ((input$population - (input$population*(input$prevalence/100)))*(input$specificity/100)),
          (input$population*(input$prevalence/100))-
            ((input$population*(input$prevalence/100))*(input$sensitivity/100)),
          paste(round((((input$population*(input$prevalence/100))*
                          (input$sensitivity/100))/
                         (((input$population*(input$prevalence/100))*
                             (input$sensitivity/100))+((input$population - (input$population*(input$prevalence/100)))-
                                                         ((input$population - (input$population*(input$prevalence/100)))*(input$specificity/100))))*100), digits = 1),"%"),
          paste(
            round(
              (((input$population - (input$population*(input$prevalence/100)))*
                  (input$specificity/100))/(((input$population - (input$population*(input$prevalence/100)))*
                                               (input$specificity/100))+((input$population*(input$prevalence/100))-
                                                                           ((input$population*(input$prevalence/100))*(input$sensitivity/100))))*100)
              , digits = 1
            ),
            "%"
          )
        )),
        stringsAsFactors = FALSE)
    })
    
    # Show the values in an HTML table ----
    output$values <- renderTable({
      sliderValues()
    })
}
