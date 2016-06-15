
## prep data ##########

# load necessary packages and data
library(stringi)   # string processing
library(magrittr)  # data processing / pipe operator
library(reshape2)  # data processing
library(survival)  # fit survival curves
library(survminer) # plot survival curves
d1 <- read.csv("2016_parkway.csv", stringsAsFactors=F)
d2 <- read.csv("2016_garmin.csv", stringsAsFactors=F)
d2 <- subset(d2, TIME != "-")
d3 <- read.csv("2016_cows.csv", stringsAsFactors=F)
d <- read.csv("heartland_data.csv", stringsAsFactors=F)

# quick function to convert HH:MM:SS format to total time in hours format
convert_time <- function(dat){
  d <- as.numeric(substr(dat,1,1)) + as.numeric(substr(dat,3,4))/60 + as.numeric(substr(dat,6,7))/3600
  return(d)
}

# cleanup for demographics
d1$Age <- as.numeric(substr(stri_reverse(substr(stri_reverse(d1$Age.Group.Place),1,5)),1,2)) + 2
d1$Age[d1$Age==3] <- 14
d1$Age[d1$Age==82] <- 80
d1$Gender <- substr(stri_reverse(substr(stri_reverse(d1$Age.Group.Place),1,7)),1,1)
d1$Gender[d1$Gender=="T"] <- "M"
d2$Age <- as.numeric(substr(d2$DIVISION,2,3)) + 2
d2$Age[substr(d2$DIVISION,2,3)=="18"] <- 16
d2$Age[substr(d2$DIVISION,2,3)=="70"] <- 75
d2$Gender <- substr(d2$DIVISION,1,1)
d2$Gender[d2$Gender %in% c("_", "P")] <- NA
d3$Age <- as.numeric(substr(stri_reverse(substr(stri_reverse(d3$Age.Group.Place),1,5)),1,2)) + 2
d3$Age[d3$Age==3] <- 14
d3$Age[d3$Age==82] <- 80
d3$Gender <- substr(stri_reverse(substr(stri_reverse(d3$Age.Group.Place),1,7)),1,1)
d3$Gender[d3$Gender=="T"] <- "M"

# apply quick function to data
d1$Time <- convert_time(d1$Chip.Time)
d2$Time <- convert_time(d2$TIME)
d3$Time <- convert_time(d3$Chip.Time)
d$Rtp.Time %<>% convert_time()
d$Garmin.Time %<>% convert_time()
d$Rwtc.Time %<>% convert_time()

# splice off Parkway/Garmin data and rename columns and melt down dataset (for boxplot and survival analysis)
m <- rbind(data.frame(Time=d1$Time, Race="Rock the Parkway"),
           data.frame(Time=d2$Time, Race="Garmin"))
m2 <- d
names(m2) <- c("Division", "Rock the Parkway", "Garmin", "Cows", "Average Time", "Total Time")
m2 <- melt(m2, id.vars=1, measure.vars=2:3, variable.name="Race", value.name="Time")



## summary statistics ##########

# race summary stats
mean(d1$Time)
2+.168*.60 # 2:
mean(d2$Time)
2+.326*.60 # 2:
mean(d3$Time)


# race demographics
mean(d1$Age[!is.na(d1$Age)])
mean(d2$Age[!is.na(d2$Age)])
mean(d3$Age[!is.na(d3$Age)])
table(d1$Age, d1$Gender)
table(d2$Age, d2$Gender)
table(d3$Age, d3$Gender)
nrow(d1[d1$Gender=="M",]) / nrow(d1)
nrow(d2[d2$Gender=="M",]) / nrow(d2)
nrow(d3[d3$Gender=="M",]) / nrow(d3)

# how often was Parkway time faster than Garmin time?
nrow(d[d$Rtp.Time < d$Garmin,])           # count
nrow(d[d$Rtp.Time < d$Garmin,]) / nrow(d) # frequency

# average differential
mean(d2$Time) - mean(d1$Time)
(mean(d2$Time) - mean(d1$Time))*60

avg_diff <- 60*(mean(d$Garmin.Time) - mean(d$Rtp.Time))
avg_diff <- print(paste0(floor(avg_diff),":", round((avg_diff-floor(avg_diff))*60)))
avg_diff

summary(d$Rtp.Time)
2+.245*.60 # 2:15
summary(d$Garmin.Time)
2+.288*.60 # 2:17
summary(d$Rwtc.Time)
2+.541*.60 # 2:32



# t-test: how significant are the differences?
# null hypothesis: both series come from the same distribution
t.test(d1$Time, d2$Time)           # reject null hypothesis
t.test(d$Rtp.Time, d$Garmin.Time)  # fail to reject null

# custom color palette
my_palette <- c("#2E9FDF", "darkorange")

# box plot
## plots #####
png("2016-survival-boxplot-01.png", height=240)
ggplot(m, aes(x=Race, y=Time, fill=Race)) + 
  geom_boxplot(alpha=.5) + 
  scale_fill_manual(values=my_palette) + 
  theme(legend.position="none") + 
  labs(y="Time (Hours)") + 
  coord_flip()
dev.off()

png("2016-survival-boxplot-02.png", height=240)
ggplot(m2, aes(x=Race, y=Time, fill=Race)) + 
  geom_boxplot(alpha=.5) + 
  scale_fill_manual(values=my_palette) + 
  theme(legend.position="none") + 
  labs(y="Time (Hours)") + 
  coord_flip()
dev.off()



## survival analysis ##########

# fit survival model
fit_01 <- survfit(Surv(Time) ~ Race, data = m)
fit_02 <- survfit(Surv(Time) ~ Race, data = m2)

# survival curves
png("2016-survival-curve-01.png", height=400, width=400)
ggsurvplot(fit_01, conf.int=T, surv.scale="percent", break.time.by=0.5, xlim=c(1.25, 4), font.legend=14, 
           palette=my_palette, legend.title="", xlab="Time (Hours)", ylab="Racers Still Running", 
           pval=T, pval.coord=c(3.5, .5))
dev.off()

png("2016-survival-curve-02.png", height=400, width=400)
ggsurvplot(fit_02, conf.int=T, surv.scale="percent", break.time.by=0.5, xlim=c(1.25, 4), font.legend=14,
           palette=my_palette, legend.title="", xlab="Time (Hours)", ylab="Racers Still Running", 
           pval=T, pval.coord=c(3.5, .5))
dev.off()
