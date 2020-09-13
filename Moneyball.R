batting <- read.csv('Batting.csv')
head(batting)
str(batting)
head(batting$AB)
head(batting$X2B)
batting$BA <- batting$H / batting$AB
tail(batting$BA,5)
batting$OBP <- (batting$H + batting$BB + batting$HBP)/(batting$AB + batting$BB + batting$HBP + batting$SF)
batting$X1B <- (batting$H-batting$X2B-batting$X3B-batting$HR)
batting$SLG <- (batting$X1B + 2*batting$X2B + 3*batting$X3B + 4*batting$HR)/batting$AB
salary <- read.csv('Salaries.csv')
summary(salary)
subbat <- subset(batting, yearID >= 1985)
summary(subbat)
combo <- merge(subbat, salary, by = c('playerID','yearID'))
summary(combo)
lost_player <- subset(combo, playerID %in% c('giambja01', 'damonjo01', 'saenzol01'))
lost_player <- subset(lost_player , yearID == 2001)
lost_player <- lost_player[,c('playerID','H','X2B','X3B','HR','OBP','SLG','BA','AB')]
lost_player
library(dplyr)
library(ggplot2)

avail.players <- filter(combo , yearID == 2001)

pl <- ggplot(avail.players, aes(x= OBP, y = salary)) + geom_point()
print(pl)

avail.players <- filter(avail.players , OBP > 0, salary <8000000)

avail.players <- filter(avail.players, AB >= 500)

possible <- head(arrange(avail.players, desc(OBP), 10))

possible <- possible[,c('playerID', 'OBP', 'AB', 'salary')]

possible[2:4,]
