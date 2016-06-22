---
layout: post
title: (Failed) Half-Marathon Runner Clustering
subtitle: You can't win 'em all
---

I had (what I though was) a great idea that a runner's race speed might be somewhat correlated with the distance they traveled to run a race. The intuition would be that if someone were to travel, say, 500 miles to run a race, this would indicate that they were a more "serious" runner than someone who just climbed out of bed and traveled across town.

To gather the data I needed (latitude, longitude, and distance from race site), I started with all the runners who ran the Rock the Parkway half marathon this year, then used the handy [geopy](https://pypi.python.org/pypi/geopy) package in Python to gather additional geospacial data. Once I had my dataset ready, I then tried a few different clustering approaches in R. However, even though I normalized the distances and run times, the various clusters were determined just by the distance in mileage. (I probably should pick up an R book on spacial analysis. I've actually heard [this book](https://www.amazon.com/gp/product/1446272958) is pretty good -- perhaps this will be my motivation to pick it up.)

Here's what the raw race time vs distance traveled scatterplot looks like:

![Vanilla Scatterplot](https://raw.githubusercontent.com/johnsug/johnsug.github.io/master/_posts/race_failed_clusters/scatterplot.png)

As you can see, there is no (visable) trend towards shorter run-timmes, based on how far someone traveled. Which, I guess makes sense -- the majority of people who sign up for a half-marathon are going to take them serious, and put in the time to finish well, regardless of how far they live from the race site.

Not wanting to waste my Python coding, I quickly transformed my data into a spacial scatterplot overlaid on top of a U.S. map. I used the [R Leaflet](https://rstudio.github.io/leaflet/) package, which creates really high-quality javascript map plots. (My imagine will be static until I finally launch my personal Shiny server.) I should point out that I purposely chose NOT to use a [choropleth map](https://en.wikipedia.org/wiki/Choropleth_map) (shading geographic regions) as state-wide grouping would be too coarse, and county-level is (in my opinion) far too inconsistent in terms of boundary size. Therefore, I settled on just a scatterplot. (Perhaps I'll update this post later with scatterplot smoothing/raster shading.)

![Spacial Map](https://raw.githubusercontent.com/johnsug/johnsug.github.io/master/_posts/race_failed_clusters/leaflet_plot.png)

The majority of the points are around the greater Kansas City area (no surprise, this half marathon took place in Kansas City), with a few notable outliers in Mexico, Seattle, Manitobia, Maine, and Florida.
