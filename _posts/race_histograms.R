
## prep #####
library(sqldf)
library(ggplot2)

## load/prep Rock the Parkway data
d1 <- read.csv("2016_parkway.csv", stringsAsFactors=F)
d1$Time <- as.numeric(substr(d1$Chip.Time,1,1)) + as.numeric(substr(d1$Chip.Time,3,4))/60 + as.numeric(substr(d1$Chip.Time,6,7))/3600
names(d1) <- gsub("[.]", "_", names(d1))
d11 <- sqldf("select * from d1 where Age_Group_Place like '%M 30-34'")
d1$Series <- "Overall"
d11$Series <- "Division"
d1 <- rbind(d1, d11); rm(d11)

## load/prep Garmin data
d2 <- read.csv("2016_garmin.csv", stringsAsFactors=F)
d2$Time <- as.numeric(substr(d2$TIME,1,1)) + as.numeric(substr(d2$TIME,3,4))/60 + as.numeric(substr(d2$TIME,6,7))/3600
d22 <- subset(d2, DIVISION=="M3034")
d2$Series <- "Overall"
d22$Series <- "Division"
d2 <- rbind(d2, d22); rm(d22)

## load/prep Running with the Cows data
d3 <- read.csv("2016_cows.csv", stringsAsFactors=F)
d3$Time <- as.numeric(substr(d3$Chip.Time,1,1)) + as.numeric(substr(d3$Chip.Time,3,4))/60 + as.numeric(substr(d3$Chip.Time,6,7))/3600
names(d3) <- gsub("[.]", "_", names(d3))
d33 <- sqldf("select * from d3 where Age_Group_Place like '%M 30-34'")
d3$Series <- "Overall"
d33$Series <- "Division"
d3 <- rbind(d3, d33); rm(d33)

## load/prep Heartland series data
d4 <- read.csv("2016_heartland.csv", stringsAsFactors=F)
d4$Time <- as.numeric(substr(d4$Chip.Time,1,1)) + as.numeric(substr(d4$Chip.Time,3,4))/60 + as.numeric(substr(d4$Chip.Time,6,7))/3600
names(d4) <- gsub("[.]", "_", names(d4))
d44 <- sqldf("select * from d4 where Age_Group_Place like '%M 30-34'")
d4$Series <- "Overall"
d44$Series <- "Division"
d4 <- rbind(d4, d44); rm(d44)


## plots #####
png("2016-parkway-histograms.png", height=240)
ggplot(d1, aes(x=Time)) + 
  geom_histogram(col=1, fill=5, alpha=.5) + 
  geom_vline(xintercept=1+55/60+17/3600, col=4, alpha=.5, size=1.5) + 
  labs(title="Rock the Parkway", x="Time (Hours)") + 
  xlim(0,NA) + 
  facet_wrap(~Series, scales="free_y")
dev.off()

png("2016-garmin-histograms.png", height=240)
ggplot(d2, aes(x=Time)) + 
  geom_histogram(col=1, fill=5, alpha=.5) + 
  geom_vline(xintercept=2+4/60+6/3600, col=4, alpha=.5, size=1.5) + 
  labs(title="Garmin", x="Time (Hours)") + 
  xlim(0,NA) + 
  facet_wrap(~Series, scales="free_y")
dev.off()

png("2016-cows-histograms.png", height=240)
ggplot(d3, aes(x=Time)) + 
  geom_histogram(col=1, fill=5, alpha=.5) + 
  geom_vline(xintercept=1+54/60+14/3600, col=4, alpha=.5, size=1.5) + 
  labs(title="Running with the Cows", x="Time (Hours)") + 
  xlim(0,NA) + 
  facet_wrap(~Series, scales="free_y")
dev.off()

png("2016-heartland-histograms.png", height=240)
ggplot(d4, aes(x=Time)) + 
  geom_histogram(col=1, fill=5, alpha=.5) + 
  geom_vline(xintercept=5+53/60+37/3600, col=4, alpha=.5, size=1.5) + 
  labs(title="Heartland Complete Series", x="Time (Hours)") + 
  xlim(0,NA) + 
  facet_wrap(~Series, scales="free_y")
dev.off()  

