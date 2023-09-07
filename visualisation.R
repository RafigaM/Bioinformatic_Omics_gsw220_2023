# Most of the genomics data sets are in the form of genomic intervals associated with a score.
# That means mostly the data will be in table format with columns denoting chromosome, start positions, end positions, strand and score. 
# One of the popular formats is the BED format, which is used primarily by the UCSC genome browser but most other genome browsers 
# and tools will support the BED file format. We have all the annotation data in BED format. 
# You will read more about data formats in Chapter 6. In R, you can easily read tabular format data with the read.table() function.

install.packages("grangers")

enhancerFilePath="./subset.enhancers.hg18.bed"
cpgiFilePath=system.file="./subset.cpgi.hg18.bed"
# read enhancer marker BED file
enh.df <- read.table(enhancerFilePath, header = FALSE) 

# read CpG island BED file
cpgi.df <- read.table(cpgiFilePath, header = FALSE) 

# check first lines to see how the data looks like
head(enh.df)
head(cpgi.df)

# You can save your data by writing it to disk as a text file. 
# A data frame or matrix can be written out by using the write.table() function. 
# Now let us write out cpgi.df. We will write it out as a tab-separated file; pay attention to the arguments.
write.table(cpgi.df,file="cpgi.txt",quote=FALSE,
            row.names=FALSE,col.names=FALSE,sep="\t")

# You can save your R objects directly into a file using save() and saveRDS() and load them back in with load() and readRDS().
# By using these functions you can save any R object whether or not it is in data frame or matrix classes.
save(cpgi.df,enh.df,file="mydata.RData")
load("mydata.RData")
# saveRDS() can save one object at a type
saveRDS(cpgi.df,file="cpgi.rds")
x=readRDS("cpgi.rds")
head(x)

#The basic capability for plotting in R is referred to as “base graphics” or “R base graphics”
#A histogram is an approximate representation of a distribution. 
# sample 50 values from normal distribution
# and store them in vector x
x<-rnorm(50)
hist(x) # plot the histogram of those values
#We can modify all the plots by providing certain arguments to the plotting function.
hist(x,main="Hello histogram!!!",col="red")
#The scatter plot shows values of two variables for a set of data points.
#It is useful to visualize relationships between two variables.
# randomly sample 50 points from normal distribution
y<-rnorm(50)
#plot a scatter plot
# control x-axis and y-axis labels
plot(x,y,main="scatterplot of random samples",
     ylab="y values",xlab="x values")
# Boxplots depict groups of numerical data through their quartiles. 
# The edges of the box denote the 1st and 3rd quartiles, and the line that crosses the box is the median.
# The distance between the 1st and the 3rd quartiles is called interquartile tange.
boxplot(x,y,main="boxplots of random samples")
#Now we are going to plot four imaginary percentage values and color them with two colors,
#and this time we will also show how to draw a legend on the plot using the legend() function.
perc=c(50,70,35,25)
barplot(height=perc,
        names.arg=c("CpGi","exon","CpGi","exon"),
        ylab="percentages",main="imagine %s",
        col=c("red","red","blue","blue"))
legend("topright",legend=c("test","control"),
       fill=c("red","blue"))

#In R, we can combine multiple plots in the same graphic.
par(mfrow=c(1,2)) # 
# then make the plots and you will have them combined
hist(x,main="Hello histogram!!!",col="red")
plot(x,y,main="scatterplot",
     ylab="y values",xlab="x values")

# If you want to save your plots to an image file normally, you will have to do the following:
# 1. Open a graphics device.
# 2. Create the plot.
# 3. Close the graphics device.

pdf("./myplot.pdf",width=5,height=5)
plot(x,y)
dev.off()

### Plotting in R with ggplot2
###
#In R, there are other plotting systems besides “base graphics”, which is called ggplot2
#which implements a different logic when constructing the plots. 
library(ggplot2)

myData=data.frame(col1=x,col2=y)
# the data is myData and I’m using col1 and col2 columns on x and y axes
ggplot(myData, aes(x=col1, y=col2)) +
  geom_point() # map x and y as points
#The second thing you will notice is the aes() function in the ggplot() function.
#This function defines which columns in the data frame map to x and y coordinates 
#and if they should be colored or have different shapes based on the values in a different column.
ggplot(myData, aes(x=col1)) +
  geom_histogram() + # map x and y as points
  labs(title="Histogram for a random variable", x="my variable", y="Count")

#We can also plot boxplots using ggplot2
# data frame with group column showing which groups the vector x and y belong
myData2=rbind(data.frame(values=x,group="x"),
              data.frame(values=y,group="y"))

# x-axis will be group and y-axis will be values
ggplot(myData2, aes(x=group,y=values)) + 
  geom_boxplot()

##combining ggplots 1.
ggplot(myData2, aes(x=values)) + 
  geom_histogram() +facet_grid(.~group)
##combining ggplots 2.
library(cowplot)
# histogram
p1 <- ggplot(myData2, aes(x=values,fill=group)) + 
  geom_histogram()
# scatterplot
p2 <- ggplot(myData, aes(x=col1, y=col2)) +
  geom_point() 
# plot two plots in a grid and label them as A and B
plot_grid(p1, p2, labels = c('A', 'B'), label_size = 12)




