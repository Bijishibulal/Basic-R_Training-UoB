---
#R_Tutorial
#B.Shibulal@brighton.ac.uk

#13-04-2022
#--/--/--
---

#INTRO TO BASIC R----
# Diff. panes
#Know your working dir----

getwd()
setwd("C:/Users/bs774/OneDrive - University of Brighton/Desktop/R_training")

#SAVE your WORKBOOK

#Basic operators----

5+5
5-5
3*5
15/2
2^2
45/6
45%/%6
45%%6

#Assigning Variables/R objects & directionality----

#Variables are nothing but reserved memory locations to store values. This means that, when you create a variable you reserve some space in memory.

x <- 42
x


# Different R objects----
#The variables are assigned with R-Objects and the data type of the R-object becomes the data type of the variable. There are many types of R-objects. The frequently used ones are -

##1. Vectors
##2. Lists
##3. Matrices
##4. Arrays
##5. Factors
##6. Data Frames

#Create vector----

#To create a vector of more than 1 element use fn., c()=combine

numeric_vector <- c(1, 10, 49)
numeric_vector

character_vector <- c("a", "b", "c")
character_vector
#Check class
class(character_vector)

names(numeric_vector) <- character_vector
numeric_vector

#help
?names()


numeric_vector

x
x+numeric_vector

apples <- 5
oranges <- 6
apples + oranges
fruit <- apples+oranges
fruit
# #logical vector

mylogical <- FALSE
class(mylogical)

ans <- x > numeric_vector
ans

#Convert a numerical vector to character vector

oranges <- 6
class(oranges)

oranges <- "6"
class(oranges)


###There are many others such as complex (3+2i), integer (2L,1m) etc. 


#Lists and calling----

#can contain many different types of elements inside it 

list <- list(c(2,5,3),21.3,c("my new list" ))

list

x <- c(1,7,9)
x[3]

#Data types----

#MATRICES----
#Two-dimensional rectangular data set, a column can contain ONLY SAME TYPE of data

?matrix()
matrix(1:9)
matrix(1:9, byrow = FALSE, nrow = 3)
matrix(1:9, byrow = TRUE, nrow = 3)


#Matrix using list
q <- c(460, 314)
r <- c(290, 247)
w <- c(309, 165)

c(q, r, w)

mydataset <- matrix(c(q, r, w), byrow = TRUE, nrow = 3)
mydataset

#Change row names and column names using character vectors

region <- c("one", "two")
category <- c("A","B","C")

rownames(mydataset) <- category
colnames(mydataset) <- region

mydataset


#Summing using rowSums()/colSums() fn.

rowSums(mydataset)

totals <- rowSums(mydataset)
totals

#Combine 2 matrices----

#cbind
cbind(mydataset,totals)
?cbind()
?rbind()


#DEALING WITH DATAFRAMES----

##Data frames are tabular data objects. Unlike a matrix in data frame each column can contain different modes of data. The first column can be numeric while the second column can be character and third column can be logical. It is a list of vectors of equal length.

#R comes with build-in datasets
data()

# We will work with the iris database, which comes with R. This is how you load it:

data("iris")


#Get a general idea of the iris table----

#view table-click

View(iris)
str(iris)
head(iris)
nrow(iris)
ncol(iris)
colnames(iris)
rownames(iris)


#Change a columns name----
colnames(iris)[2] <- "Sep.Wid"
iris
colnames(iris)[2] <- "Sepal.Width"


#Transposing a table----
t(iris)
transpose <- t(iris)
#Assign variable to save

#Sorting the table-----
iris[order(iris$Petal.Length, decreasing=TRUE),]
#Sorting by multiple columns---- 
#Sorting petal lengths with species
iris[order(iris$Species, iris$Petal.Length),]
#Sorting by multiple columns - species and DECREASING petal length
iris[order(iris$Species, -iris$Petal.Length),]

iris[iris$Sepal.Length > 7,]
iris[iris$Species == "setosa",]

#Summing by row/column----
colSums(iris[,-ncol(iris)])

rowSums(iris[,-ncol(iris)])

#Get the mean value per column----
colMeans(iris[,-ncol(iris)])

#Using REAL DATA, eg.1----
getwd()

#Load the data----
OTUs <- read.csv("OTUtable.csv")

#check the loaded file...Any problem in the col name???csv first column name with dots+R

OTUs <- read.csv("OTUtable.csv", fileEncoding="UTF-8-BOM")

#Byte Order Mark is often present for files and webpages generated by Microsoft applications-include arguement fileEncoding=

#OR

colnames(OTUs)[1] <- "OTU_ID"

#Check import and preview data----
str(OTUs)
head(OTUs)

#Let's get some information out of this object----
OTUs$taxonomy # prints out all the taxonomies in the dataset

length(unique(OTUs$taxonomy))   # returns the number of distinct taxonomies in the data

#Subset data----
# Here's how we get the value in the second row and fifth column
OTUs[2,5]

# Here's how we get all the info for row number 6
OTUs[6, ]

# And of course you can mix it all together!
OTUs[6, ]$taxonomy   # returns the value in the column taxonomy for the sixth observation

OTUs[6,8]


#Subseting with brackets using row and column numbers can be quite tedious if you have a large dataset and you don't know where the observations you're looking for are situated! 
#(much easier calling columns by their names than figuring out where they are!)

# Let's access the values for Individual number 282
OTUs[OTUs$SPOT1012DNA == 282, ]

#REAL DATA, eg.2----
#Let's have a look at another dataset
elongation <- read.csv("EmpetrumElongation.csv", header = TRUE) 


#Subsetting with one condition----

elongation[elongation$Zone < 4, ]    # returns only the data for zones 2-3
elongation[elongation$Zone <= 4, ]   # returns only the data for zones 2-3-4


# This is completely equivalent to the last statement
elongation[!elongation$Zone >= 5, ]   # the ! means exclude

#Subseting with two conditions----
elongation[elongation$Zone == 2 | elongation$Zone == 7, ]    # returns only data for zones 2 and 7; (Alt+179)


elongation[elongation$Zone == 2 & elongation$Indiv %in% c(300:400), ]    #returns data for shrubs in zone 2 whose ID numbers are between 300 and 400; Using a colon between the two numbers means counting up from 300 to 400.

#Merge datasets---- 
#how to use the help menu to learn the usage
?merge
authors <- data.frame(
  ## I(*) : use character columns of names to get sensible sort order
  surname = I(c("Tukey", "Venables", "Tierney", "Ripley", "McNeil")),
  nationality = c("US", "Australia", "US", "UK", "Australia"),
  deceased = c("yes", rep("no", 4)))
authorN <- within(authors, { name <- surname; rm(surname) })

books <- data.frame(
  name = I(c("Tukey", "Venables", "Tierney",
             "Ripley", "Ripley", "McNeil", "R Core")),
  title = c("Exploratory Data Analysis",
            "Modern Applied Statistics ...",
            "LISP-STAT",
            "Spatial Statistics", "Stochastic Simulation",
            "Interactive Data Analysis",
            "An Introduction to R"),
  other.author = c(NA, "Ripley", NA, NA, NA, NA,
                   "Venables & Smith"))


(m0 <- merge(authorN, books))

m1 <- merge(authors, books, by.x = "surname", by.y = "name")

#REAL DATA FORMAT v/s R FORMAT---- 
#(.ppt)
#You may know how your experiment is set up, but R does not!

#TIDY DATA tidyr()----
install.packages("tidyr")
library(tidyr) 

#Wide data to long data format, gather()----

elongation <- read.csv("EmpetrumElongation.csv", header = TRUE) 

?gather()

elongation_long <- gather(elongation, Year, Length,   # in this order: data frame, key, value
c(X2007, X2008, X2009, X2010, X2011, X2012))        #we need to specify which columns to gather
#here we want the lengths (value) to be gathered by year (key)

#If you have a dataset with columns for 100 genes, for instance, you might be better off specifying the column numbers:

elongation_long1 <- gather(elongation, Year, Length, c(3:8))

#Let's reverse!---- 
#spread() is the inverse function, allowing you to go from long to wide format

elongation_wide <- spread(elongation_long, Year, Length)


#TIDY DATA dplyr()----
#the most common and useful functions of dplyr in Tidyverse package

library(dplyr)

#Rename() variables----

elongation_long <- rename(elongation_long, zone = Zone, indiv = Indiv, year = Year, length = Length)     # changes the names of the columns (getting rid of capital letters) and overwriting our data frame

#the base R equivalent would have been
names(elongation_long) <- c("zone", "indiv", "year", "length")

#Filter observations----
filter()
# Let's keep observations from zones 2 and 3 only, and from years 2009 to 2011

elong_subset <- filter(elongation_long, zone %in% c(2, 3), year %in% c("X2009", "X2010", "X2011")) # you can use multiple different conditions separated by commas

# For comparison, the base R equivalent would be (not assigned to an object here):
elongation_long[elongation_long$zone %in% c(2,3) & elongation_long$year %in% c("X2009", "X2010", "X2011"), ]

#we use %in% as a logical operator because we are looking to match a list of exact (character) values. If you want to keep observations within a range of numeric values, you either need two logical statements in your filter() function, e.g. length > 4 & length <= 6.5 or you can use the convenient between() function, e.g. between(length, 4, 6.5).

elong_subset_1 <- filter(elongation_long, zone %in% c(2, 3), year %in% c("X2009", "X2010", "X2011"), length > 4 & length <= 6.5)

?between()

elong_subset_2 <- filter(elongation_long, zone %in% c(2, 3), year %in% c("X2009", "X2010", "X2011"), between(length, 4, 6.5))

##See how dplyr is already starting to shine by avoiding repetition and calling directly the column names without needing to call the object every time?

#Remove columns----
dplyr::select()

# Let's remove the zone column just as an example

elong_no.zone <- dplyr::select(elongation_long, indiv, year, length)   # or alternatively
elong_no.zone <- dplyr::select(elongation_long, -zone) # the minus sign removes the column

# For comparison, the base R equivalent would be (not assigned to an object here):
elongation_long[ , -1]  # removes first column

#Reordering columns----

# A nice hack! select() lets you rename and reorder columns on the fly
elong_no.zone <- dplyr::select(elongation_long, Year = year, Shrub.ID = indiv, Growth = length)

#Create a new column----

#mutate() your dataset by creating new columns

elong_total <- mutate(elongation, total.growth = X2007 + X2008 + X2009 + X2010 + X2011 + X2012)

#Group data----
#Perform operations on chunks of data using group_by() certain factors to perform operations on chunks of data

elong_grouped <- group_by(elongation_long, year)   # grouping our dataset by year

#Summarize data----

#check the "elongation_long" data and "elong_grouped" data- LOOK SAME???

summary1 <- summarise(elongation_long, total.growth = sum(length))

summary2 <- summarise(elong_grouped, total.growth = sum(length))

#The first summary corresponds to the sum of all growth increments in the dataset. The second one gives us a breakdown of total growth per year, our grouping variable.

summary3 <- summarise(elong_grouped, total.growth = sum(length),
mean.growth = mean(length),
sd.growth = sd(length))


#IMPORT DATA as .xls----
#install.packages("readxl")
#library(readxl)
#import dataset= Split_col_n

#Split column by a delimiter----
  ###by using tidyr::separate

##number of columns after splitting by space (delimiter)
df_split <- data.frame(Split_col_n)

#count of space characters in a string-help to calculate the number of columns that I will get after splitting
ncols <- max(stringr::str_count(df_split$Location, " ")) + 1
?stringr
ncols

#generate necessary column names
colmn <- paste("new_col", 1:ncols)

colmn

#plit column by delimiter using the function separate() from the tidyr
Split <- tidyr::separate(data = df_split, col = Location,sep = " ", into = colmn, remove = TRUE)

#By the default separate() function will remove the original column. If you want to keep it: remove = FALSE)


  ###by using dplyr pipe
require(dplyr)
require(tidyr)

df_split_dplyr <- data.frame(Split_col_n)

ncols_dplyr <- max(stringr::str_count(df_split$Sample, ";")) + 1

ncols_dplyr

colmn <- paste("dplyr_new", 1:ncols_dplyr)

Split_1 <- df_split %>% separate(Sample, sep = ";", into = colmn, remove = FALSE)

#Split column by fixed position----

Split_2 <-
  tidyr::separate(
    data = df_split,
    col = Date,
    sep = c(2, 4),
    into = c("y", "m", "d"),
    remove = FALSE
  ) 



#DEALING WITH MISSING or NA values/ #Imputing your dataset----

#install.packages("mice")
library(mice)

head(water_param)
dim(water_param)
str(water_param)
names(water_param)
summary(water_param)

#If missing data is more than 5% then you probably should leave that feature or sample out

f_miss <- function(x){sum(is.na(x))/length(x)*100}

apply(water_param,2,f_miss) # check for features (columns)- upto 5% missing data per sample is acceptable
apply(water_param,1,f_miss) # check for features (rows) - upto 25% missing data per sample is acceptable

md.pattern(water_param)

?mice()

tempData <- mice(water_param, m=5, maxit=5, meth = "pmm", seed=NA)

tempData <- mice(water_param, remove_collinear = FALSE, m=5, maxit=5, meth = "pmm", seed=NA)



#EXPORT OUTPUT as .xls----
#install.packages("writexl")
library(writexl)

my_data <- complete(tempData)
#or
mydata <- complete(tempData,3)

write_xlsx(my_data,"mydata.xlsx")

#############################################################

#INTRO TO PLOTTING IN GGPLOT----

#install.packages("ggplot2")    
library("ggplot2")

#SCATTERplot----

head(iris)

ggplot(iris, aes(x = Sepal.Length, y = Petal.Width)) +
  geom_point()

#Change shape of the points----

ggplot(iris, aes(x = Sepal.Length, y = Petal.Width)) +
  geom_point(shape = 21)

#Change size of the points----

ggplot(iris, aes(x = Sepal.Length, y = Petal.Width)) +
  geom_point(shape = 18, size = 2)

#Grouping variable to the aesthetic of shape or color----

ggplot(iris, aes(x = Sepal.Length, y = Petal.Width, shape = Species, color = Species)) +
  geom_point(shape = 18, size = 2)

#Use different shapes and colors----

#1 given by the default settings

ggplot(iris, aes(x = Sepal.Length, y = Petal.Width, shape = Species, color = Species)) +
  geom_point() + 
  scale_shape_manual(values = c(1,2,3)) + 
  scale_colour_brewer(palette = "Set1")

#2 using a Colorblind-Friendly Palette
install.packages("viridis")
library(viridis)
plt <- ggplot(iris, aes(x = Sepal.Length, y = Petal.Width, shape = Species, fill = Species)) +
  geom_point() + 
  scale_shape_manual(values = c(21,22,23))

plt +
  scale_fill_viridis_d() 

?scale_fill_viridis_c() 
dev.off()

#3 using a Different Palette for a Discrete Variable

library(RColorBrewer)

#The ColorBrewer package provides a number of palettes
display.brewer.all()
par(mar=c(1, 1, 1, 1))

plt1 <- ggplot(iris, aes(x = Sepal.Length, y = Petal.Width, shape = Species, color = Species)) +  geom_point() 

plt1 +  
  scale_colour_brewer(palette = "Oranges")

#4 use grey scale palette for B/W figs.

plt1 +  scale_colour_grey()

#Reverse the direction and use a different range of greys
plt1 +
  scale_colour_grey(start = 0.7, end = 0)

#5 using a Manually Defined Palette for a Discrete Variable

    ## Using color names (in Rcolor_cheatsheet)
plt1 + scale_colour_manual(values = c("red", "blue", "green"))


    ## Using RGB values and add title, change X-axis label
plt1 +
  scale_colour_manual(values = c("#CC6666", "#7777DD", "#009933")) +
  labs(title = "Relation between petal width and sepal length", x = "Sepal (length)") 

#LINEgraph/BOXplot----

ggplot(iris, aes(x = Sepal.Length, y = Petal.Width, shape = Species, color = Species)) + geom_line()
 
#geom_line()
#geom_boxplot() 

##Change theme----

ggplot(iris, aes(x = Sepal.Length, y = Petal.Width, color = Species)) + geom_line() + 
theme
  
  #theme_void()
  
  #theme_minimal()
  
  #theme_dark()
  
  #theme_bw()
  
  #theme_classic()

#BARplot with std. error bars----

##Add SE to plots----

iris

Iris_se <- iris %>%
  group_by(Species) %>%
  summarise(
    Length = mean(Sepal.Length),
    sd = sd(Sepal.Length),
    n = n(),
    se = sd / sqrt(n)
  )

Iris_se

ggplot(Iris_se, aes(x = Species, y = Length)) +
  geom_col(fill = "green", colour = "black") +
  geom_errorbar(aes(ymin = Length - se, ymax = Length + se), width = .2)
 
###TASK: How will you make a line graph with se for the same data- iris_se???

ggplot(Iris_se, aes(x = Species, y = Length)) +
  geom_line(aes(group = 1), color = "deeppink") +
  geom_errorbar(aes(ymin = Length - se, ymax = Length + se), width = .2)

# ??geom_line: Each group consists of only one observation- Length = mean length of each species. So to get the geomline asked R to group all


#Add points to line graph----
ggplot(Iris_se, aes(x = Species, y = Length)) +
  geom_line(aes(group = 1), color = "deeppink") +
  geom_point(size = 2, shape = 12, color = "blue") +
  geom_errorbar(aes(ymin = Length - se, ymax = Length + se), width = .08)


###TASK- I need to change the color of error bar and also the theme of the plot

ggplot(Iris_se, aes(x = Species, y = Length)) +
  geom_line(aes(group = 1), color = "deeppink") +
  geom_point(size = 2, shape = 4, color = "darkblue") +
  geom_errorbar(aes(ymin = Length - se, ymax = Length + se), width = .08, color = "green") + 
  theme_classic2()

#DOTplot----

library(ggplot2)

ToothGrowth

head(ToothGrowth)

class(ToothGrowth$dose)

#Need to change the dose variable to a factor- otherwise R consider it as a numeric continuous variable and the Y- axis will be formed accordingly.

#To correct this, we can either change our dataframe to make dose a character or factor vector

ToothGrowth$dose <- as.factor(ToothGrowth$dose) #OR
ToothGrowth$dose <- as.character(ToothGrowth$dose)

head(ToothGrowth)

?geom_dotplot


#Basic dot plot----

p <- ggplot(ToothGrowth, aes(x = dose, y = len)) + 
  geom_dotplot(binaxis = 'y', stackdir = 'center')

p

# Change dotsize and stack ratio----
ggplot(ToothGrowth, aes(x = dose, y = len)) + 
  geom_dotplot(binaxis = 'y', stackdir = 'center', stackratio = 0.5, dotsize = 1.2)

# Rotate the dot plot----
p + coord_flip()                                

# Function to produce summary statistics (mean and +/- sd)----

data_summary <- function(x) {
  m <- mean(x)
  ymin <- m-sd(x)
  ymax <- m+sd(x)
  return(c(y=m,ymin=ymin,ymax=ymax))
}                       

p + stat_summary(fun.data=data_summary, color="blue")


#Add boxplot with dot plot----
p + geom_boxplot() + stat_summary(fun.data=data_summary, color="red")

#Dot color by Group---- 

e <- ggplot(ToothGrowth, aes(x = dose, y = len))

my_plot <-e + geom_boxplot() +
  geom_dotplot(aes(fill = supp), binaxis='y', stackdir='center', stackratio = 1, dotsize = 1)+
  scale_fill_manual(values = c("#00AFBB", "#E7B800"))+ stat_summary(fun.data=data_summary, color="blue")

my_plot

#Save the plots----
##To save a plot, we use the function ggsave() where you can specify the dimensions and resolution of your plot. You could also change the file ending with .png to .pdf to save your image as a PDF document. Note that this file will be saved into your working directory. (If you've forgotten where that is, you can find it by running the code getwd().)

ggsave("my_plot.png", width = 7, height = 5, dpi = 600)

# use export fn

#BASIC STAT ANALYSIS----

#T-TEST(s)----

#One-sample t-test----
library(tidyverse)
library(ggpubr)
library(rstatix)
#install.packages("datarium")
library(datarium)

# Load and inspect the data
data(mice, package = "datarium")
head(mice, 3)

#Get summary stat of variable, weight
mice %>% get_summary_stats(weight, type = "mean_sd")
?get_summary_stats()

#difference
summary(mice)

#Using the R base function----

?t.test()
test_res <- t.test(mice$weight, mu = 25)
test_res

#Using the rstatix package----

?t_test()
stat.test <- mice %>% t_test(weight ~ 1, mu = 25)
stat.test

# Cohen's d Measure_T-test Effect Size using ----

mice %>% cohens_d(weight ~ 1, mu = 25)

#Two-sample t-test----

# Load the data

data("genderweight", package = "datarium")

# Show a sample of the data by group

genderweight

genderweight %>% sample_n_by(group, size = 3)

#Summary statistics
genderweight %>%
  group_by(group) %>%
  get_summary_stats(weight, type = "mean_sd")

#Using R base----
res <- t.test(weight ~ group, data = genderweight)
res

# The only difference in the result from paired t- test is - it provided 2 means as we provided 2 variables 

#Using the rstatix package----
stat.test <- genderweight %>% 
  t_test(weight ~ group) %>%
  add_significance()
stat.test

#Cohen's d test----

#for student t- test
genderweight %>%  cohens_d(weight ~ group, var.equal = TRUE)

#for Welch t-test
genderweight %>% cohens_d(weight ~ group, var.equal = FALSE)

#Paired t-test----

data("mice2", package = "datarium")
head(mice2, 3)

# It is in wide format- need to transform to long format

mice2.long <- mice2 %>%
  gather(key = "group", value = "weight", before, after)
head(mice2.long, 5)

#Summary statistics

mice2.long %>%
  group_by(group) %>%
  get_summary_stats(weight, type = "mean_sd")

#Using the R base function----

reslt <- t.test(weight ~ group, data = mice2.long, paired = TRUE)

reslt

#Using the rstatix package----

stat.test.reslt <- mice2.long  %>% 
  t_test(weight ~ group, paired = TRUE) %>%
  add_significance()

stat.test.reslt

#Cohen's d test----

mice2.long  %>% cohens_d(weight ~ group, paired = TRUE)

#ANOVA(s)----

#load data
anov.data <- read.csv("crop.data_anova.csv", header = TRUE) 

#One-way ANOVA----
#modeling crop yield as a function of the type of fertilizer used

one.way <- aov(yield ~ fertilizer, data = anov.data)

summary(one.way)

#Two-way ANOVA----
#modeling crop yield as a function of type of fertilizer and planting density

two.way <- aov(yield ~ fertilizer + density, data = anov.data)

summary(two.way)

#Adding interactions between variables----
#Sometimes you have reason to think that two of your independent variables have an interaction effect rather than an additive effect.

#For eg., in our crop yield experiment, it is possible that planting density affects the plants' ability to take up fertilizer. This might influence the effect of fertilizer type in a way that isn't accounted for in the two-way model.

interaction <- aov(yield ~ fertilizer*density, data = anov.data)

summary(interaction)

#Post-hoc test----
  
#Tukey HSD (Honestly Significant Difference )----

tukey.two.way<-TukeyHSD(two.way) # ERROR why?????

tukey.two.way


class(anov.data$yield)
class(anov.data$fertilizer)
class(anov.data$density)


two_way <- aov(yield ~ as.factor(fertilizer) + as.factor(density), data = anov.data)

Tukey <-TukeyHSD(two_way)

Tukey

#Regression Analysis----

#Simple regression----

#Load data

summary(income.data)

income.data

#1. Because we only have one independent variable and one dependent variable, we don't need to test for any hidden relationships among variables.

#2. To check whether the dependent variable follows a normal distribution, use the hist() function.
hist(income.data$happiness)

#3. The relationship between the independent and dependent variable must be linear.use scatterplot
plot(happiness ~ income, data = income.data)

#4. Homoscedasticity- Will check this after we make the model.

# Make the linear model

lm = lm(income~happiness, data = income.data) 

#Review the results
summary(lm)

#Check for homoscedasticity


par(mfrow=c(2,2))
plot(lm)

#Note that the par(mfrow()) command will divide the Plots window into the number of rows and columns specified in the brackets. So par(mfrow=c(2,2)) divides it up into two rows and two columns. To go back to plotting one graph in the entire window, set the parameters again and replace the (2,2) with (1,1).

par(mfrow=c(1,1))


#Residuals are the unexplained variance. They are not exactly the same as model error, but they are calculated from it, so seeing a bias in the residuals would also indicate a bias in the error.

#The most important thing to look for is that the red lines representing the mean of the residuals are all basically horizontal and centered around zero. This means there are no outliers or biases in the data that would make a linear regression invalid.

#In the Normal Q-Qplot in the top right, we can see that the real residuals from our model form an almost perfectly one-to-one line with the theoretical residuals from a perfect model.

#Based on these residuals, we can say that our model meets the assumption of homoscedasticity.

income.graph<-ggplot(income.data, aes(x=income, y=happiness))+
  geom_point()

income.graph

#Add the linear regression line to the plotted data


income.graph <- income.graph + geom_smooth(method="lm", col="blue")

income.graph

#Add the equation for the regression line.

library(ggpubr)
income.graph <- income.graph +
  theme_bw() + 
  stat_regline_equation(label.x = 3, label.y = 7)

income.graph

#Correlation----

#use the "swiss" data from R

head(swiss)
corr_dat <- swiss

#Determining the association between Fertility and Infant Mortality Rate


##Check Linearity


library(ggplot2)

ggplot(corr_dat, aes(x = Fertility, y = Infant.Mortality)) + geom_point() +
    geom_smooth(method = "lm", se = TRUE, color = 'black')

#Check Normality: Using Shapiro test

shapiro.test(corr_dat$Fertility)

shapiro.test(corr_dat$Infant.Mortality)

#p-value is greater than 0.05, so we can assume the normality


##Correlation Coefficient

cor(corr_dat$Fertility,corr_dat$Infant.Mortality)


#Checking for the significance

Corr_test <- cor.test(corr_dat$Fertility,corr_dat$Infant.Mortality,method = "pearson")

Corr_test

#Since the p-value is less than 0.05 (here it is 0.003585, we can conclude that Fertility and Infant Mortality are significantly correlated with a value of 0.41 and a p-value of 0.003585.