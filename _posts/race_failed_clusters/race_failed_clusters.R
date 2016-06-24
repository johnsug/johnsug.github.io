
# libraries
library(leaflet)
library(ggplot2)

# import
d <- read.csv("race_data.csv", stringsAsFactors=F)
d <- subset(d, Lat!="#N/A")    # drop missing values
d <- subset(d, Lat!="#VALUE!") # etc

# reform fields
d$Lat <- as.numeric(d$Lat)
d$Long <- as.numeric(d$Long)
d$Dist <- as.numeric(d$Dist)
d$Time <- as.numeric(substr(d$Time,1,1)) + as.numeric(substr(d$Time,3,4))/60 + as.numeric(substr(d$Time,6,7))/3600

# what I'm trying to cluster
plot(d$Time, d$Dist)

# plot for the blog
png("scatterplot.png", height=600, width=600)
ggplot(d, aes(x=Time, y=Dist)) + geom_point() + geom_jitter(color="royalblue", alpha=.8) + 
  labs(x="Run Time (Hours)", y="Distance Traveled to Race (Miles)") + 
  theme(axis.title=element_text(size=rel(1.5)), axis.text=element_text(size=rel(1.25)))
dev.off()

# correlation between race time and distance traveled
cor(d$Time, d$Dist)

# look at percentiles
quantile(d$Dist, c(.05*(0:20))

# clean values of interest, drawn from empiracal distribution
quantile(d$Dist, c(15, 40))

# leaflet plot
leaflet(data=d) %>% addTiles() %>% addCircleMarkers(~Long, ~Lat, stroke=F, color="royalblue", fillOpacity=0.75, radius=4)
