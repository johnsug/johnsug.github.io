
library(sqldf)
d <- read.csv("race_names.csv", stringsAsFactors=F)
d1 <- subset(d, Race=="Parkway")
#d2 <- subset(d, Race=="Garmin")
#d3 <- subset(d, Race=="Cows")

## first name -- male
m <- sqldf("select first, count(first) as count from d1 where gender = 'M' group by 1 order by 2 desc limit 20")
m$First <- factor(m$First, levels=m[order(m$count), "First"])
png("2016-parkway-names-male.png", height=480, width=480)
ggplot(m, aes(x=First, y=count)) + 
  geom_bar(stat="identity", col=1, fill=5, alpha=.5) + 
  geom_text(aes(label=count, y=-1.5)) + 
  labs(title="Rock the Parkway Male Runners", x="First Name", y="Count") + 
  coord_flip()
dev.off()

## first name -- female
f <- sqldf("select first, count(first) as count from d1 where gender = 'F' group by 1 order by 2 desc limit 20")
f$First <- factor(f$First, levels=f[order(f$count), "First"])
png("2016-parkway-names-female.png", height=480, width=480)
ggplot(f, aes(x=First, y=count)) + 
  geom_bar(stat="identity", col=1, fill=6, alpha=.25) + 
  geom_text(aes(label=count, y=-2.5)) + 
  labs(title="Rock the Parkway Female Runners", x="First Name", y="Count") + 
  coord_flip()
dev.off()

## first name, first letter -- male
mm <- sqldf("select substr(first,1,1) as letter, count(substr(first,1,1)) as count from d1 where gender = 'M' group by 1")
mm$letter <- as.factor(mm$letter)
mm$letter <- factor(mm$letter,levels(mm$letter)[nrow(mm):1])
png("2016-parkway-letters-male.png", height=480, width=480)
ggplot(mm, aes(x=letter, y=count)) + 
  geom_bar(stat="identity", col=1, fill=5, alpha=.5) + 
  geom_text(aes(label=count, y=-10)) + 
  labs(title="Rock the Parkway Male Runners", x="First Name First Letter", y="Count") + 
  coord_flip()
dev.off()

## first name, first letter -- female
ff <- sqldf("select substr(first,1,1) as letter, count(substr(first,1,1)) as count from d1 where gender = 'F' group by 1 order by 2 desc")
ff$letter <- as.factor(ff$letter)
ff$letter <- factor(ff$letter,levels(ff$letter)[nrow(ff):1])
png("2016-parkway-letters-female.png", height=480, width=480)
ggplot(ff, aes(x=letter, y=count)) + 
  geom_bar(stat="identity", col=1, fill=6, alpha=.25) + 
  geom_text(aes(label=count, y=-10)) + 
  labs(title="Rock the Parkway Female Runners", x="First Name First Letter", y="Count") + 
  coord_flip()
dev.off()

# ## last name
# sqldf("select last, count(last) as count from d1 where gender = 'M' group by 1 order by 2 desc limit 10")
# sqldf("select last, count(last) as count from d1 where gender = 'F' group by 1 order by 2 desc limit 10")
# sqldf("select last, count(last) as count from d1 group by 1 order by 2 desc limit 10")
# sqldf("select substr(last,1,1) as letter, count(substr(last,1,1)) as count from d1 where gender = 'M' group by 1 order by 2 desc")
# sqldf("select substr(last,1,1) as letter, count(substr(last,1,1)) as count from d1 where gender = 'F' group by 1 order by 2 desc")
