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



# Creating a Shiny Dashboard
Coming soon...

# Adding Inputs
Coming soon...
