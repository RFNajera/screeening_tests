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
You could try to do all this by hand, or you could set up an Excel sheet to do it. In fact, I set up an Excel sheet with some formulas to learn about all this. But what if you could set up a [Shiny](https://shiny.rstudio.com/) dashboard  

# Adding Inputs
Coming soon...

# Making it work
