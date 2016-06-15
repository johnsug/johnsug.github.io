---
layout: post
title: Spring 2016 Race Survival Analysis
---

As I had already compiled a rich data set from my last post, I wanted to use it again and use [survival analysis](https://en.wikipedia.org/wiki/Survival_analysis) to contrast the first two races of the [Heartland 39.3 half marathon series](http://www.heartland393.com) -- the Rock the Parkway and Garmin half marathons (which were one week apart).

Specifically, I set out to compare the two races themselves. My time was nine minutes slower the second week, but I don't if this was due to personal reasons (e.g., I wasn't completely recovered from the week before), external reasons (e.g. the terran was less flat and the hill at the end was dishearting), or a combination of the two.

A few quick summary statistics:

| Race | # Runners | Average Age | Male:Female Ratio | Elevation Gain | Average Completion Time |
|----------|----------|----------|----------|----------|----------|
| Rock the Parkway | 4,226 | 37.5  | 37:73 | 343 ft | 2:10 |
| Garmin | 1,839 | 38.8 | 38:72 | 521 ft | 2:19 |

Coinsidentally, runners of the first race were approximately nine minutes faster than those of the second race. However, this could be attributed to a few factors, including:
* the runners were younger in the first race than the second
* the course was flatter in the first race than the second
* the first race was less congested than the secocnd (despite being twice as large, the first race had multiple starting waves, meaning there was less initial bunching) 

That being said, if we only look at the average values we miss out valuable information on the spread, tails, and so forth of the population. The following boxplot helps visualize the overall distribution of the runners:

![Box Plot](https://raw.githubusercontent.com/johnsug/johnsug.github.io/master/_posts/race_survival_analysis/2016-survival-boxplot-01.png)

The first race (Rock the Parkway) population is definitely shifted to the left of the second (Garmin) population. For further insights, a survival plot can help us understand the percentage of runners who have completed the race over each point of each race.

![Survival Curve](https://raw.githubusercontent.com/johnsug/johnsug.github.io/master/_posts/race_survival_analysis/2016-survival-curve-01.png)

The p-value test of significance for the survival curve is less than 0.01%, meaning there is a very low likelihood that the differential between the two survival curves is erroneous. As the survival plot illustrates, not only were Parkway runners faster on average, they were faster consistently. I suppose this could be attributed to the flatter course and slightly younger runners participating.

But, my age didn't change over the seven days between the races, so what was my excuse? To dig deeper, I looked at just the 614 runners who completed both races. While smaller cohort size reduces the statistical power of my analysis, we should still have a sufficient population to study statistically.

The average completion times, for those who ran both races, are as follows:

| Race | Average Completion Time |
|----------|----------|
| Rock the Parkway | 2:15 |
| Garmin | 2:17 |

These average completion times were much closer, differing by just two minutes. The fact that the average times are much closer can be verified visually by looking at similar box plots and survival curves:

![Box Plot](https://raw.githubusercontent.com/johnsug/johnsug.github.io/master/_posts/race_survival_analysis/2016-survival-boxplot-02.png)

![Survival Curve](https://raw.githubusercontent.com/johnsug/johnsug.github.io/master/_posts/race_survival_analysis/2016-survival-curve-02.png)

In fact, there is a much greater chance that the 2 minute differential could be attributed to noise in the data. The p-value test of the survival model, while still being considering statisticall significant, is much higher than what we saw earlier. Perhaps most runners were adequately conditioned to run two half marathons, back to back (with me being an outlier).

In conclusion, the first race (Rock the Parkway) appears to be a slightly easier race than the second (Garmin). Perhaps that, in part, influenced more people to run it, leading to the 9 minute average differential between the two races. On average, those who ran both races had their half marathon times drop by 2 minutes the second week. As my time dropped 9 minutes, 2 could be accounted to the increased race difficulty, and I suppose 7 minutes to the additional fatigue I was experiencing that day.
