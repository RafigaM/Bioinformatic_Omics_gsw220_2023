# Getting started with R
# Download and install R (http://cran.r-project.org/) and RStudio (http://www.rstudio.com/) if you do not have them already.

# install package named "randomForests" from CRAN
install.packages("randomForests")

##You can install bioconductor packages with a specific installer script.

# get the installer package if you don't have
install.packages("BiocManager")

# install bioconductor package "DESeq2"
BiocManager::install("DESeq2")

# updating CRAN packages
update.packages()

# updating bioconductor packages
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install()
###

#You can get help on functions by using help() and help.search() functions. 
#You can list the functions in a package with the ls() function

library(MASS)
ls("package:MASS") # functions in the package
ls() # objects in your R enviroment
# get help on hist() function
?hist
help("hist")
# search the word "hist" in help pages
help.search("hist")
??hist

### Computations in R
2 + 3 * 5       # Note the order of operations.
log(10)        # Natural logarithm with base e
5^2            # 5 raised to the second power
3/2            # Division
sqrt(16)      # Square root
abs(3-7)      # Absolute value of 3-7
pi             # The number
exp(2)        # exponential function

### if and for
# if (test_expression) {
#   statement1
# } else {
#   statement2
# }
x <- -5
if(x > 0){
  print("Non-negative number")
} else {
  print("Negative number")
}

#Creat multiplication table with "for" iterator
for(x in 1:10) {
  y=2*x
  print(paste("2 x ", x, " = ", y), sep="")
}

###
### Data structures

# I Vectors
#create a vector named x with 5 components
x<-c(1,3,2,10,5)    
x = c(1,3,2,10,5)  
x
#create a vector of consecutive integers y
y<-1:5
#scalar addition
y+5
#scalar multiplication
3*y
#raise each component to the second power
y^2
#raise 2 to the first through fifth power
2^y
# create a vector of 1s, length 3
r1<-rep(1,3)
#length of the vector
length(r1)

# II Matrices
#create a matrix
x<-c(1,2,3,4)
y<-c(4,5,6,7)
m1<-cbind(x,y);m1
# transpose of m1
t(m1)
#show dimentionality
dim(m1)
#You can also directly list the elements and specify the matrix:
m2<-matrix(c(1,3,2,5,-1,2,2,3,9),nrow=3)
m2
#Matrices and the next data structure, data frames, are tabular data structures.
#You can subset them using [] and providing desired rows and columns to subset.
m1[1,]
m1[,2]

# III Data frames

#A data frame is more general than a matrix, in that different columns can have different modes (numeric, character, factor, etc.). 
#A data frame can be constructed by the data.frame() function. 
#For example, we illustrate how to construct a data frame from genomic intervals or coordinates.
chr <- c("chr1", "chr1", "chr2", "chr2")
strand <- c("-","-","+","+")
start<- c(200,4000,100,400)
end<-c(250,410,200,450)
mydata <- data.frame(chr,start,end,strand)
#mydata <- data.frame(chr=chr,start=start,end=end,strand=strand)
#change column names
names(mydata) <- c("chr","start","end","strand")
mydata 
#different ways to extract the elements of a data frame
mydata[,2:4] # columns 2,3,4 of data frame
mydata[,c("chr","start")] # columns chr and start from data frame
mydata$start # variable start in the data frame
mydata[c(1,3),] # get 1st and 3rd rows
mydata[mydata$start>400,] # get all rows where start>400

# IV Lists
# example of a list with 4 components
# a string, a numeric vector, a matrix, and a scalar
w <- list(name="Fred",
          mynumbers=c(1,2,3),
          mymatrix=matrix(1:4,ncol=2),
          age=5.3)
w
#You can extract elements of a list using the [[]], the double square-bracket, convention using either its position in the list or its name.
w[[3]] # 3rd component of the list
w[["mynumbers"]] # component named mynumbers in list
w$age

# V Factors
# Factors are used to store categorical data. 
features=c("promoter","exon","intron")
f=factor(features)
print(f)
f[1]


#There are four common data types in R, they are numeric, logical, character and integer. 
#All these data types can be used to create vectors.
#create a numeric vector x with 5 components
x<-c(1,3,2,10,5)
x
#create a logical vector x
x<-c(TRUE,FALSE,TRUE)
x
# create a character vector
x<-c("sds","sd","as")
x
class(x)
# create an integer vector
x<-c(1L,2L,3L)
x
typeof(x)


### Writing functions in R
####
# Here is the main syntax on functions in R:
# function_name <- function(parameters){
#   function body 
# }

vec=c(1,2,4,5,6,7,8,9)
power2=function(x){
  x_power2=x^2
  return(x_power2)
}
vec_power2=power2(vec)
lapply(vec,power2)









