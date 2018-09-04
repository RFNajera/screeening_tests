# Screening Tests. Why?
{:.no_toc}
Have you ever been to a healthcare provider for a sore throat or flu-like symptoms? Have you had a swab inserted into your nose or put into your throat and then tested? How confident was your healthcare that the test was valid?

Most of the tests done in medical offices or small clinics are called "screening tests.” This is because they screen the patient for a disease or condition in order to aid in the diagnosis. (You can find a [list of approved screening tests in the United States here](https://www.cms.gov/Regulations-and-Guidance/Legislation/CLIA/downloads/waivetbl.pdf).) More advanced laboratory tests are called ["diagnostic tests,"](https://medlineplus.gov/diagnostictests.html) and they're very definitive in diagnosing a disease or condition. Diagnostic tests are generally more invasive or complicated (and expensive).

Before you have any kind of testing done, your healthcare provider will ask several questions. Those questions are meant to make sure that the test you're about to be given is the right one, of course. But there is one more way in which these initial "screening" questions favor the reliability of the screening results. By weeding out the patients who might not have the disease, the healthcare provider is increasing the prevalence of the disease/condition in the group that is being tested. This is important because prevalence plays a part in the mathematical and scientific relationship between prevalence and the probability of a screening test result being the real deal.

In this exercise, we will learn to create a Shiny Dashboard in R that uses only the data the user inputs. There are some calculations involved in the output that goes into the two graphs, but they're not very complicated once you understand the math behind it. This app can then be used to help public health students understand the relationship between disease prevalence and the reliability of screening tests.

# What We'll Cover
{:.no_toc}

* Will be replaced with the ToC, excluding the "Contents" header
{:toc}

# The Math of It All
The relationship between the prevalence of a disease/condition and the reliability of a screening test is mathematical. You see it when you set up a 2-by-2 table to look at your results. For the following example, we'll assume that we have a population of 10,000 people and a screening test that is 90% **sensitive** and 80% **specific**. We'll look at two situations, one where the **prevalence** of the disease is 5% and another where the prevalence is 15%.

First, some definitions:
*Sensitivity* is the probability that someone who is trully sick will test positive (a **true positive**). *Specificity* is the probability that someone who is not sick will test negative (a **true negative**). Prevalence is the existing number of cases of a disease divided by the total population.

So let's set up our 2-by-2 table:

| Test Result | Sick  | Not Sick |       |
|-------------|-------|----------|-------|
| Positive    |   A   |     B    | A + B |
| Negative    |   C   |     D    | C + D |
|             | A + C |   B + D  | Total |

Now, let's start filling it in. We know that we have a total population of 10,000. So we'll put that in the "Total" cell.

| Test Result | Sick  | Not Sick |        |
|-------------|-------|----------|--------|
| Positive    |   A   |     B    |  A + B |
| Negative    |   C   |     D    |  C + D |
|             | A + C |   B + D  | 10,000 |

In cell A + C we're going to put the number of sick people. We know this number because the prevalence is 5%, and 5% of 10,000 is 500.

| Test Result | Sick | Not Sick |        |
|-------------|------|----------|--------|
| Positive    |   A  |     B    |  A + B |
| Negative    |   C  |     D    |  C + D |
|             |  500 |   B + D  | 10,000 |

From there, cell A and cell C can be quickly filled in. Cell A is 90% of 500 because the sensitivity is 90%, so cell A is 450. Cell C is the difference, 50.

| Test Result | Sick | Not Sick |        |
|-------------|------|----------|--------|
| Positive    |  450 |     B    |  A + B |
| Negative    |  50  |     D    |  C + D |
|             |  500 |   B + D  | 10,000 |

We also know that B + D is 9,500, and that D is 80% of 9,500.

| Test Result | Sick | Not Sick |        |
|-------------|------|----------|--------|
| Positive    |  450 |     B    |  A + B |
| Negative    |  50  |   7,600  |  C + D |
|             |  500 |   9,500  | 10,000 |

A little more math and we get the rest of the table values.

| Test Result | Sick | Not Sick |        |
|-------------|------|----------|--------|
| Positive    |  450 |   1,900  |  2,350 |
| Negative    |  50  |   7,600  |  7,650 |
|             |  500 |   9,500  | 10,000 |

So now we answer two questions. With 5% prevalence, what is the probability that someone who tests positive is a true positive? Using the table above, we see that the answer is 450/2,350, which is about 19%. This is also known as the **positive predictive value**. And what is the probability that a negative test is a true negative? The answere there is 7,600/7,650, or about 99%. This is also known as the **negative predictive value**. So you see that the chance that a positive is really a positive is about 1 in 5, whereas the chance of a negative being trully negative is almost certain.

What about 15% prevalence? The final table looks like this:

| Test Result | Sick  | Not Sick |        |
|-------------|-------|----------|--------|
| Positive    | 1,350 |   1,700  |  3,050 |
| Negative    |  150  |   6,800  |  6,950 |
|             | 1,500 |   8,500  | 10,000 |

From this table, we see that the positive predictive value is about 39% while the negative predictive value is about 98%. An increased prevalence from 5% to 15% almost doubled the positive predictive value while lowering the negative predictive value just a pinch. Can you guess what happens when prevalence hits 50%

# Creating a Shiny Dashboard
You could try to do all this by hand, or you could set up an Excel sheet to do it. In fact, I set up an Excel sheet with some formulas to learn about all this. But what if you could set up a [Shiny](https://shiny.rstudio.com/) dashboard that could graphically show you how positive and negative predictive value change with prevalence, and how this also influences the number of true/false positives and true/false negatives.

The app is very simple. There is no data processing going on in the background. It uses your input to calculate the values that go in the table above, and then it uses those values to calculate the positive and negiative predictive values. The app also shows you graphically what your screened population will look like in terms of true/false positives and true/false negatives.

# Writing the Code
The basic structure of a Shiny application is simple:
````r
library(shiny)
ui <- fluidPage()
server <- function(input, output) {}
shinyApp(ui = ui, server = server)
````
That's it. You install the shiny library, you create a user interface (ui) and a server function (server), and then you tell the app to run and declare which script is the user interface and which script is the server. You can find [more detailed instructions online](https://deanattali.com/blog/building-shiny-apps-tutorial/), of course. I recommend trail and error to learn how each line of code works (or doesn't). It's very much how we humans learn best, and you won't break a thing is you do it in the comfort and safety of your own R console.

So let me show you how I constructed the app. First, the user interface. Make sure to read the comments in the code:

````r
# Load the libraries we'll need
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
                ), # Input the population number we want to use, with 10,000 as the default
    sliderInput("prevalence",
                label = h4("Prevalence"),
                min = 0, 
                max = 100,
                value = 50,
                round = 0,
                post = "%"
                ), # Input the prevalence we want to use, with 50% as the default
    sliderInput("sensitivity",
                label = h4("Test Sensitivity"),
                min = 0, 
                max = 100,
                value = 99,
                post = "%"
                ), # Input the sensitivity we want to use, with 99% as the default
    sliderInput("specificity",
                label = h4("Test Specificity"),
                min = 0, 
                max = 100,
                value = 99,
                post = "%"
                ) # Input the specificity we want to use, with 99% as the default
  ),
  dashboardBody(
    fluidRow(
      column(4,
             box(
               plotOutput("plot1"),
               width = 100)
             ), # One column with the first plot
      column(4,
             box(
               plotOutput("plot2"),
               width = 100)
            ), # Another column with the second plot
      column(4,
             box(
               tableOutput("values"),
               width = 100
             ))
            ) # A third column with a table with the results of the calculations
    )
  )
````
So that's the front end. That's what the user will see. And you can see where some of the output of the calculations we're going to make in the server will be shown.

# Making it work
For the server logic, I'm going to go step by step. First, let's create a dataframe that we'll use for one of the plots. We do this in a reactive expression. It's reactive because it will react to the input from the user on the user interface. You can see some values with "input$" in them, meaning they come from the inputs mentioned above. For example, `input$prevalence` comes from the slider where you would pick the size of the population being tested. Here's the code:
````r
 plot_data <- reactive(
      data.frame(
        prevalence = input$prevalence,
        ppv = (((input$population*(input$prevalence/100))*(input$sensitivity/100))/(((input$population*(input$prevalence/100))*(input$sensitivity/100))+((input$population -(input$population*(input$prevalence/100)))-((input$population-(input$population*(input$prevalence/100)))*(input$specificity/100))))*100),
        npv = (((input$population-(input$population*(input$prevalence/100)))*(input$specificity/100))/(((input$population - (input$population*(input$prevalence/100)))*(input$specificity/100))+((input$population*(input$prevalence/100))-((input$population*(input$prevalence/100))*(input$sensitivity/100))))*100)
      )
    ) # End reactive for point plot data
````
It looks complicated because of the mathematical calculations that go into the positive predictive value and negative predictive value calculations. Embedded in those calculations are the calculations for true/false positives and true/false negatives. For example, true positives are the product of sensitivity multiplied by number sick, and the number sick is the product of the population number multiplied by the prevalence. Get it?

Next, an observeEvent function that looks at the inputs and creates the first plot accordingly. Again, look at the comments in the code:
````r
observeEvent(
      {
      input$sensitivity # Looks for changes in the sensitivity slider
      input$specificity # Looks for changes in the specificity slider
      input$prevalence # Looks for changes in the prevalence slider
      },
    (output$plot1 <- renderPlot
     ({
      ggplot(
        data = plot_data(),
        aes(prevalence, ppv)
             ) +
         geom_point(aes(x = prevalence, y = ppv), # Plots PPV as a blue dot
                   color = "blue",
                   size = 4) +
         geom_point(aes(x = prevalence, y = npv), # Plots NPV as a red dot
                    color = "red",
                    size = 4) +
         labs(title = "Prevalence vs. Positive Predictive Value\nand Negative Predictive Value",
             subtitle = "Note that PPV (blue) and NPV (red) go up and down based on prevalence",
             x = "Prevalence",
             y = "Positive Predictive Value"
        ) +
        xlim(0,100) + 
        ylim(0,100) + 
        theme_bw() # You can use an assortment of themes using ggthemes: https://ggplot2.tidyverse.org/reference/ggtheme.html
    })
    )
    ) # End of ObserveEvent plot1
````
Now, let's make a bar plot that shows you how many true and false positives and how many true and false negatives you have based on the population you are testing and, as before, your inputs for prevalence, sensitivity and specificity. First, the data:
````r
graph_data <- reactive(
      data.frame(
        "resultado" = as.factor(
          c("True Positive", "False Negative", "False Positive", "True Negative") # Names the bars
        ),
        "valor" = as.numeric(
          c(
            ((input$population*(input$prevalence/100))*
               (input$sensitivity/100)), # Calculates the true positive number
            ((input$population*(input$prevalence/100))-
               ((input$population*(input$prevalence/100))*(input$sensitivity/100))), # Calculates the false negative number
            ( (input$population - (input$population*(input$prevalence/100)))-
                ((input$population - (input$population*(input$prevalence/100)))*(input$specificity/100))), # Calculates false positive number
            ((input$population - (input$population*(input$prevalence/100)))*
               (input$specificity/100)) # Calculates true negative number
          )
        )
      )
    ) # End reactive for bar plot data
````
Now, let's create the bar plot:
````r
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
          theme(legend.position="none") +
          theme(axis.text.x  = element_text(angle=90, vjust=0.5, size=16))
         })
       )
      )# End of ObserveEvent plot2
````
Again, just a very simple bar plot with nothing fancy on it.

Finally, I created an HTML table where the results of the calculations would be posted. This one is a little long because of all the calculations that go into it:
````r
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
          paste(
            round(
              input$population*
                (input$prevalence/100), digits = 0)
            ),
          paste(
            round(
              input$population - 
                (input$population*(input$prevalence/100)),
              digits = 0
            )
          ),
          paste(
            round(
              (input$population*(input$prevalence/100))*
                (input$sensitivity/100), digits = 0
            )
          ),
          paste(
            round(
              (input$population - (input$population*(input$prevalence/100)))*
                (input$specificity/100), digits = 0
            )
          ),
          paste(
            round(
              (input$population - (input$population*(input$prevalence/100)))-
                ((input$population - (input$population*(input$prevalence/100)))*(input$specificity/100)), digits = 0
            )
          ),
          paste(
            round(
              (input$population*(input$prevalence/100))-
                ((input$population*(input$prevalence/100))*(input$sensitivity/100)), digits = 0
            )
          ),
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
````
So there you have it. You get a Shiny App that shows you graphically see how different prevalence values, and different sensitivity and specificity values, affect the chances of a test result being the real deal.

# See It for Yourself
I've uploaded the app to Shinyapps.io. [Go ahead and play with it](https://rfnajera.shinyapps.io/screening_tests/).

# A Quick Example
On page 29 of [this package insert for a rapid influenza screening test](https://www.cliawaived.com/web/items/pdf/Alere%20i%20Influenza%20A%20B%20Test%20Product%20In~4586file2.pdf), the sensitivity and specificity of the test using a nasal swab are listed as 97.9% and 86.2% respectively. [According to CDC](https://www.cdc.gov/flu/about/disease/burden.htm), between 9.2 million and 35.6 million people in the United States get the flu. Let's use the lower number, resulting in a prevalence of 2.8%. With that prevalence, and the performance of that test, the probability of a positive being a true positive is about 18%. The probability of a negative being a true negative is almost certain at 99.9%.

A healthcare provider then has to ask themselves which they want to see, [a true positive or a true negative](https://epidemiological.net/2018/08/28/which-is-better-a-false-positive-a-false-negative-a-true-positive-or-a-true-negative/)? The provider may say something like, "You tested positive, so you might have the flu." Or, "You tested negative, so you don't have the flu." But that's a whole other discussion for a later time.

Now, let's look at the higher number, 35.6 million. That's a prevalence of 10.9%. With that prevalence, the positive predictive value gets better, rising to 46.4%, while the negative predictive value stays fairly high at 99.7%. To have a better than 50/50 shot of a positive being a real positive, you have to have a prevalence of about 13%. As I explained above, healthcare providers push the prevalence of the population being tested by asking about signs, symptoms, exposures, and [taking into account what is happening in the community](https://www.cdc.gov/flu/weekly/fluactivitysurv.htm).

In essence, you don't use screening tests willy-nilly. (And that's why even the ones used at home need to be followed up, positive or negative, with a visit to a healthcare provider, in my opinion.)

# Conclusion

The coding for this was done over the last five days or so, not more than an hour each day. I sketched out the idea first, then made [an Excel spreadsheet](https://www.dropbox.com/s/u95u4kgy2ddmzn1/Screening.xlsx?dl=0) quickly to see what the app should look like. Please feel free to download the code and play with it in your own R console, or go play with the online app. If you have any questions/comments, drop me a line on [Twitter](http://twitter.com/epiren) or [Facebook](http://facebook.com/rene.f.najera).
