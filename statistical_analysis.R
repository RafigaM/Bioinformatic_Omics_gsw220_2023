###
##
##
#
#
#
#
#create 100 random numbers from uniform distribution 
x=runif(100)
# calculate mean
mean(x)
hist(x)
# calculate median
median(x)
#create 100 random numbers from normal distribution 
x=rnorm(100)
# calculate mean
mean(x)
hist(x)
x=rnorm(10000)
hist(x)
#Variance is a quantity that shows how variable the values are.
#A value around zero indicates there is not much variation in the values of the data points, and a high value indicates high variation in the values.
#The variance is the squared distance of data points from the mean.
var(x)
#The sample standard deviation is simply the square root of the sample variance
x=rnorm(20,mean=6,sd=0.7)
var(x)
sd(x)
#The interquartile range, and can be easily calculated using R via the IQR() function 
#and the quantiles of a vector are calculated with the quantile() function.
x=rnorm(200000,mean=6,sd=0.7)
IQR(x)
quantile(x)
boxplot(x,horizontal = T)
# In R, the family of *norm functions (rnorm,dnorm,qnorm and pnorm) can be used to operate with the normal distribution, 
# such as calculating probabilities and generating random numbers drawn from a normal distribution. We show some of those capabilities below.
# get the value of probability density function when X= -2,
# where mean=0 and sd=2
dnorm(-2, mean=0, sd=2)
# get the probability of P(X =< -2) where mean=0 and sd=2
pnorm(-2, mean=0, sd=2)
# get 5 random numbers from normal dist with  mean=0 and sd=2
rnorm(5, mean=0 , sd=2)
# get y value corresponding to P(X > y) = 0.15 with  mean=0 and sd=2
qnorm( 0.15, mean=0 , sd=2)

###
###
set.seed(100)
gene1=rnorm(30,mean=4,sd=2)
gene2=rnorm(30,mean=2,sd=2)
org.diff=mean(gene1)-mean(gene2)
gene.df=data.frame(exp=c(gene1,gene2),
                   group=c( rep("test",30),rep("control",30) ) )

install.packages("mosaic")
library(mosaic)

exp.null <- do(1000) * diff(mosaic::mean(exp ~ shuffle(group), data=gene.df))
#The null distribution for differences of means obtained via randomization.
#The original difference is marked via the blue line. The red line marks the value that corresponds to P-value of 0.05
hist(exp.null[,1],xlab="null distribution | no difference in samples",
     main=expression(paste(H[0]," :no difference in means") ),
     xlim=c(-2,2),col="cornflowerblue",border="white")
abline(v=quantile(exp.null[,1],0.95),col="red" )
abline(v=org.diff,col="blue" )
text(x=quantile(exp.null[,1],0.95),y=200,"0.05",adj=c(1,0),col="red")
text(x=org.diff,y=200,"org. diff.",adj=c(1,0),col="blue")

p.val=sum(exp.null[,1]>org.diff)/length(exp.null[,1])
p.val

#We can also calculate the difference between means using a t-test.
stats::t.test(gene1,gene2)

### Fitting the line
# set random number seed, so that the random numbers from the text
# is the same when you run the code.
set.seed(32)

# get 50 X values between 1 and 100
x = runif(50,1,100)

# set b0,b1 and variance (sigma)
b0 = 10
b1 = 2
sigma = 20
# simulate error terms from normal distribution
eps = rnorm(50,0,sigma)
# get y values from the linear equation and addition of error terms
y = b0 + b1*x+ eps
# Now let us fit a line using the lm() function. The function requires a formula, and optionally a data frame.
# We need to pass the following expression within the lm() function, y~x, where y is the simulated Y
# values and x is the explanatory variables X. We will then use the abline() function to draw the fit.
mod1=lm(y~x)
# plot the data points
plot(x,y,pch=20,
     ylab="Gene Expression",xlab="Histone modification score")
# plot the linear fit
abline(mod1,col="blue")

###How to estimate the error of the coefficients
mod1=lm(y~x)
summary(mod1)
# get confidence intervals 
confint(mod1)
# pull out coefficients from the model
coef(mod1)

### Regression with categorical variables
set.seed(100)
gene1=rnorm(30,mean=4,sd=2)
gene2=rnorm(30,mean=2,sd=2)
gene.df=data.frame(exp=c(gene1,gene2),
                   group=c( rep(1,30),rep(0,30) ) )

mod2=lm(exp~group,data=gene.df)
summary(mod2)

require(mosaic)
plotModel(mod2)

### ANOVA in R
install.packages("palmerpenguins")
library(palmerpenguins)
dat <- penguins[, c("species", "flipper_length_mm")]
summary(dat)
library(ggplot2)

ggplot(dat) +
  aes(x = species, y = flipper_length_mm, color = species) +
  geom_jitter() +
  theme(legend.position = "none")
#H0 hypothesis: Av(Adeline)=Av(Chinstrap)=Av(Gentoo)
#H1 hypothesis: at least one mean is different
#
#compute the ANOVA 
anova <- aov(flipper_length_mm ~ species,
               data = dat
)

#We can now check normality visually:
par(mfrow = c(1, 2)) # combine plots

# histogram
hist(anova$residuals)

# QQ-plot
install.packages("car")
library(car)
qqPlot(anova$residuals,
       id = FALSE # id = FALSE to remove point identification
)
#After normality test we can chexck whether the variances are equal across species or not.
# Boxplot
boxplot(flipper_length_mm ~ species,
        data = dat
)
library(ggplot2)

ggplot(dat) +
  aes(x = species, y = flipper_length_mm) +
  geom_boxplot()
#Besides a boxplot for each species, it is also a good practice to compute some 
#descriptive statistics such as the mean and standard deviation by species.
aggregate(flipper_length_mm ~ species,
          data = dat,
          function(x) round(c(mean = mean(x), sd = sd(x)), 2)
)
#or with the summarise() and group_by() functions from the {dplyr} package:
library(dplyr)
group_by(dat, species) %>%
  summarise(
    mean = mean(flipper_length_mm, na.rm = TRUE),
    sd = sd(flipper_length_mm, na.rm = TRUE)
  )

## Two methods to test anova
# 1st : ona way test
oneway.test(flipper_length_mm ~ species,
            data = dat,
            var.equal = TRUE # assuming equal variances
)
# 2nd : summary() and aov() functions:
anova <- aov(flipper_length_mm ~ species,
               data = dat
)
summary(anova)
#you can observe that F values from both methods are the same
#
#A nice and easy way to report results of an ANOVA in R is with the report() function from the {report} package:
install.packages("remotes")
remotes::install_github("easystats/report") # You only need to do that once
library("report") # Load the package every time you start R
report(anova)
#
#
#
#
TukeyHSD(anova)
plot(TukeyHSD(anova))

