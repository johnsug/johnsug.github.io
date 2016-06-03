---
layout: post
title: Non-Linear Forecasts
subtitle: Modeling Noisy Weight-Loss Data
---

2014 was a good year for me. With diet and discipline (mostly running and P90x) I lost about 25 pounds. However, the following year, I became lazy, drank too much soda at work, and hit up the vending machine more than I'd like to admit. I quickly found the weight I lost in 2014. So, with renewed discipline and diligence, I've lost nearly 25 pounds this year (2016).  It took about a month to get going, but once I did, I was doing really well... until my wife had another baby and my intensity went out the window.

My weight over the last three years looks like this:

![Weight Loss](img/weightloss_2014_2016.png)

(Sparce data during 2015 -- I knew I was gaining wait and didn't want to be accountable to my scale!)

I set a goal to be down to 160, what I consider "good marathon shape", by the end of the year. So, let's use analytics to estimate how my weight loss will shake out over the rest of the year.

First, let's look at a simple regression analysis to fit a line through the data (statistical modeling performed in R):

## Linear Regression

[talk about linear regression]

![Simple Regression](regression_2014_2016.png)

So, obviously, it doesn't make much sense to draw a line through all three years, because I was worthless in 2015. Let's look at just 2016, and use this to forecast out the rest of the year.

![Simple Regression 2](regression_2016.png)

The only problem of chopping out 2014 is that I now have less data to learn from. So, let's consider some time-series forecasting methods to learn off more available data. (Again, modeling to be performed in R, but this time, I'll use the [forecast](https://cran.r-project.org/web/packages/forecast/index.html) package.)

## ARIMA

## Holt

## TBATS

## Neural Network

## MARS



## Conclusion

Modeling weight loss is one thing. Actually losing weight (to say nothing about keeping it off) is another. So, where do I expect my weight to be by the end of the year? I imagine I'll gain some weight back, but I intent to maintain something between 160 and 170. This might prove to be more difficult. The rececnt [Biggest Loser weight loss](http://www.scientificamerican.com/article/6-years-after-the-biggest-loser-metabolism-is-slower-and-weight-is-back-up/) study suggests that rapid weight loss (more than the suggested 1-2 pounds per week) is harmful to ones metabolism. 






