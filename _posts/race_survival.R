
## prep data ##########

# load necessary packages and data
library(magrittr)  # data processing / pipe operator
library(reshape2)  # data processing
library(survival)  # fit survival curves
library(survminer) # plot survival curves
d <- read.csv("heartland_data.csv", stringsAsFactors=F)

# quick function to convert HH:MM:SS format to total time in hours format
convert_time <- function(dat){
  d <- as.numeric(substr(dat,1,1)) + as.numeric(substr(dat,3,4))/60 + as.numeric(substr(dat,6,7))/3600
  return(d)
}

# apply quick function to data
d$Rtp.Time %<>% convert_time()
d$Garmin.Time %<>% convert_time()
# d$Rwtc.Time %<>% convert_time()
# d$Avg.Time %<>% convert_time()
# d$Chip.Time %<>% convert_time()

# fix missing values
# d$Chip.Time[is.na(d$Chip.Time)] <- apply(d[is.na(d$Chip.Time),c(2,3,4)],1,sum)

# splice off Parkway/Garmin data and rename columns and melt down dataset (for boxplot and survival analysis)
d2 <- d
names(d2) <- c("Division", "Rock the Parkway", "Garmin", "Cows", "Average Time", "Total Time")
d2 <- melt(d2, id.vars=1, measure.vars=2:3, variable.name="Race", value.name="Time")



## summary statistics ##########

# sum stats
summary(d$Rtp.Time)
summary(d$Garmin)

# how often was Parkway time faster than Garmin time?
nrow(d[d$Rtp.Time < d$Garmin,])           # count
nrow(d[d$Rtp.Time < d$Garmin,]) / nrow(d) # frequency

# average differential
avg_diff <- 60*(mean(d$Garmin.Time) - mean(d$Rtp.Time))
avg_diff <- print(paste0(floor(avg_diff),":", round((avg_diff-floor(avg_diff))*60)))
avg_diff

# t-test: how significant are the differences?
# null hypothesis: both series come from the same distribution
t.test(d$Rtp.Time, d$Garmin.Time) # fail to reject null

# custom color palette
my_palette <- c("#2E9FDF", "darkorange")

# box plot
ggplot(d2, aes(x=Race, y=Time, fill=Race)) + 
  geom_boxplot(alpha=.5) + 
  scale_fill_manual(values=my_palette) + 
  theme(legend.position="none") + 
  coord_flip()



## survival analysis ##########

# fit survival model
fit <- survfit(Surv(Time) ~ Race, data = d2)

# survival plot
ggsurvplot(fit, conf.int=T, break.time.by=0.5, palette=my_palette, xlim=c(1.5, 4), pval=T)
