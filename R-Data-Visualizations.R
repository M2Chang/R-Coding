#Data Visualization R Project

library(ggplot2)
library(data.table)

#importing the data
df <- fread('Economist_Assignment_Data.csv',drop=1)

head(df)

#creating the intial layers for graph
pl <- ggplot(df, aes(x = CPI , y = HDI, color = Region)) + geom_point(shape = 1, size = 5) 

#adding a trend line to the graph
pl2 <- pl + geom_smooth((aes(group=1)), method = 'lm' , formula = y ~ log(x), se = FALSE, color = 'red')


#Adding labels
pl2 + geom_text(aes(label = Country))

#creating the label subset
pointsToLabel <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                   "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                   "India", "Italy", "China", "South Africa", "Spane",
                   "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                   "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                   "New Zealand", "Singapore")

#creating the subway for the labels
pl3 <- pl2 + geom_text(aes(label = Country), color = "gray20", 
                       data = subset(df, Country %in% pointsToLabel),check_overlap = TRUE)
#adding a theme
pl4 <- pl3 + theme_bw()

#adding a  X continuous scale 
pl5 <- pl4 + scale_x_continuous(name = "Corruption Perceptions Index, 2011 (10=least corrupt)", limits = c(0.9, 10.5) , breaks = 1:10)

#adding a  Y continuous scale 
pl6 <- pl5 + scale_y_continuous(name = "Human Development Index, 2011 (1=Best)", limits = c(0.2, 1.0))

#adding a title
pl7 <- pl6 + ggtitle("Corruption and Human Development")


print(pl7)
