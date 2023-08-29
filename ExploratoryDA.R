# EDA is an iterative cycle. You:
#   
# 1. Generate questions about your data.
# 
# 2. Search for answers by visualising, transforming, and modelling your data.
# 
# 3. Use what you learn to refine your questions and/or generate new questions.
# 
# EDA is not a formal process with a strict set of rules. More than anything, EDA is a state of mind.
# During the initial phases of EDA you should feel free to investigate every idea that occurs to you. 

install.packages("tidyverse")
library(tidyverse)
#load diamonds dataset
data(diamonds)
#view first six rows of diamonds dataset
head(diamonds)
#summarize diamonds dataset
summary(diamonds)
#Calculating descriptive statistics using describe()
# The main application of the describe function is that of supplying statistical information about the contents of a vector. 
# When it is applied to a data frame it treats each column as a separate vector.
install.packages("Hmisc")
library(Hmisc)
describe(diamonds)
#display rows and columns
dim(diamonds)
#create histogram of values for price
ggplot(data=diamonds, aes(x=price)) +
  geom_histogram(fill="steelblue", color="black") +
  ggtitle("Histogram of Price Values")
#create scatterplot of carat vs. price, using cut as color variable
ggplot(data=diamonds, aes(x=carat, y=price, color=cut)) + 
  geom_point()
#create scatterplot of price, grouped by cut
ggplot(data=diamonds, aes(x=cut, y=price)) + 
  geom_boxplot(fill="steelblue")
#We can also use the cor() function to create a correlation matrix to view the correlation 
#coefficient between each pairwise combination of numeric variables in the dataset:
#create correlation matrix of (rounded to 2 decimal places)
round(cor(diamonds[c('carat', 'depth', 'table', 'price', 'x', 'y', 'z')]), 2)
#This is called Pearson Correlation Coefficient
# Absolute value of r	Strength of relationship
# r < 0.25	No relationship
# 0.25 < r < 0.5	Weak relationship
# 0.5 < r < 0.75	Moderate relationship
# r > 0.75	Strong relationship
#count total missing values in each column
sapply(diamonds, function(x) sum(is.na(x)))







