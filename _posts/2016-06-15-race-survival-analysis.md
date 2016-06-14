---
layout: post
title: Spring 2016 Race Survival Analysis
---

As I had already compiled a rich data set from my last post, I wanted to use it again and use [survival analysis](https://en.wikipedia.org/wiki/Survival_analysis) to contrast the first two races of the [Heartland 39.3 half marathon series](http://www.heartland393.com) -- the Rock the Parkway and Garmin half marathons (which were one week apart).

Specifically, I wanted to see if runners tended to finish one race faster than the other. (I sure did, I ran the first race 9 minutes faster. I know I was somewhat fatigued, but I can't speak for the 4,500+ people who ran the first race, and the 2,000+ people who ran the second.) While I could just take average values and be done with it, the average values only speak to one point in the distribution and do not give any further information on the spread, tails, etc. Therefore, I'll present three views of the data 1) a statistical evaluation, using a pairwised T-test, 2) a boxplot representation of the distribution, and 3) a survival plot visualization.

According to a pairwise t-test, 

The one flaw of this anaylsis is that I'm not isolating the runners who participated in both races. Perhaps more athletic runners self-select the first race every year, or there was just a different age/gender mix in registrants. These possibilities may ultimately misrepresent what I am trying to accomplish here. But, to correct for this, we can look at just the runners who raced both races. 

This suggest that, while statisticall signifiant, the statistcal significance has greatly been reduced (nearly by half).

![Box Plot](https://raw.githubusercontent.com/johnsug/johnsug.github.io/master/_posts/race_survival_analysis/2016-survival-boxplot.png)

![Survival Plot](https://raw.githubusercontent.com/johnsug/johnsug.github.io/master/_posts/race_survival_analysis/2016-survival-plot.png)




