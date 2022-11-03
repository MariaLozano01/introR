############### Intro to R ####################
############# PART 1 ##########################
### 1.1  ###

#to see where our current working directory is, this is where RStudio will first look for files we bring in 
#and save files we create 
getwd()

3 + 5

# Intro to R Lesson
# Feb 16th, 2016

# Interacting with R

## I am adding 3 and 5. R is fun!
3+5
x <- 3
y <- 5
x + y
number <- x + y
x <- 5
y <- 10
number <- x + y
number 

############### Intro to R ####################
############# PART 1 ##########################
############## 1.2 R Syntax and Data Structure ########3

# Create a numeric vector and store the vector as a variable called 'glengths'
glengths <- c(4.6, 3000, 50000)
glengths

# Create a character vector and store the vector as a variable called 'species'
species <- c("ecoli", "human", "corn")
species

combined <- c(glengths,species) #to combine both vectors, all elements become characters 
combined

# Create a character vector and store the vector as a variable called 'expression'
expression <- c("low", "high", "medium", "high", "low", "medium", "high")
# Turn 'expression' vector into a factor
expression <- factor(expression)

samplegroup <-c("CTL","CLT","KO","CLT","KO","KO","OE","OE","OE")
samplegroup <-factor(samplegroup)

# Create a data frame and store it as a variable called 'df'
df <- data.frame(species, glengths)
df

titles <- c("Catch-22", "Pride and Prejudice", "Nineteen Eighty Four")
pages <- c(453, 432, 328)

df2  <- data.frame(titles,pages)

#create a list to combine different data
list1 <- list(species, df, number)
list2 <- list(species,glengths,number)

############### 1.3 Functions in R ##########
glengths <- c(glengths, 90) # adding at the end	
glengths <- c(30, glengths) # adding at the beginning

sqrt(81)
sqrt(glengths)
round(3.14159)
args(round) #to see the name of the argument
example("round") #shows examples of what it would look like to run the command

round(3.14159, digits=2)
mean(glengths)
test <- c(1, NA, 2, 3, NA, 4)  
mean(test, na.rm= TRUE)
sort(glengths) #organizes vector in descending order 

square_it <- function(x) {
  square <- x * x
  return(square)
}
square_it(5)

multiply_it <- function(x,y) {
  multiply <- x * y
  return(multiply)
}

multiply_it(x=4,y=6)

########### 1.4 Reading and inspecting data #############
###Data subsetting with base R: vectors and factors##
?read.csv
metadata <- read.csv(file="mouse_exp_design.csv")
proj_summary <-read.table(file= "project-summary.txt", header= TRUE,sep = '\t') #"sep= '\t') blocks the separation of the header line and columns resulting in a single column and allows the document to read
proj_summary
metadata
head(metadata)

class(glengths)
class(metadata)

summary(proj_summary)
length(samplegroup) 
dim(proj_summary) #show dimensions 
rownames(metadata) #data structure = character 
ncol(proj_summary)

############### 2.1 Data subsetting with base R: vectors and factors ###########
age <- c(15, 22, 45, 52, 73, 81)
age[5] #select the fifth item on the list
age[-5] #select all values except the 5th one on the list
age[c(3,5,6)]   ## select multiple elements from the vector
# OR
## create a vector first then select
idx <- c(3,5,6) # create vector of the elements of interest
age[idx]
age[1:4] #To select a sequence of continuous values from a vector

alphabets <- c("C", "D", "X", "L", "F")
alphabets[c(1,2,5)] #select only C,D and F
alphabets[-3] #display all except x
alphabets[5:1]

age
age > 50

#Select all values in the age vector over 50 or age less than 18
age > 50 | age < 18

age

age[age > 50 | age < 18]  ## nested

# OR

## create a vector first then select
idx <- age > 50 | age < 18
age[idx]

expression[expression == "high"]## This will only return those elements in the factor equal to "high"

samplegroup[which(samplegroup != "KO")] #shows all elements that are not KO

expression

str(expression)

expression <- factor(expression, levels=c("low", "medium", "high"))     # you can re-factor a factor 

str(expression)

samplegroup <- factor(samplegroup, levels=c("KO","CTL","OE"))
str(samplegroup)

######################2.2 Packages and libraries #####################
sessionInfo() #Print version information about R, the OS and attached or loaded packages

# OR

search() #Gives a list of attached packages
install.packages("ggplot2")
library(ggplot2)
sessionInfo()
install.packages("tidyverse")

########### 2.3 Data wrangling: dataframes, matrices, and lists ##############
metadata[1, 1]
metadata[1, 3] 
metadata[3, ]
metadata[ , 3]
# Extract third column as a data frame
metadata[ , 3, drop = FALSE] # to keep the output as a data frame instead of a list
# Dataframe containing first two columns
metadata[ , 1:2] 
# Data frame containing first, third and sixth rows
metadata[c(1,3,6), ] 
# Extract the celltype column for the first three samples
metadata[c("sample1", "sample2", "sample3") , "celltype"] 
# Check column names of metadata data frame
colnames(metadata)

# Check row names of metadata data frame
rownames(metadata)
# Extract the genotype column
metadata$genotype 
# Extract the first five values/elements of the genotype column
metadata$genotype[1:5]

metadata[c("sample2", "sample8"), c("genotype", "replicate")]
metadata$replicate[c(4,9)]
metadata[ , 3, drop = FALSE]

metadata$celltype == "typeA"
logical_idx <- metadata$celltype == "typeA"
metadata[logical_idx, ] #extract the rows that correspond to the TRUE values from the metadata data frame. #make sure we put the logical_idx in the row’s space, since those TRUE and FALSE values correspond to the ROWS for which the expression is TRUE/FALSE
which(metadata$celltype == "typeA") #This returns the values one through six, indicating that the first 6 values or rows are true, or equal to typeA. 
idx <- which(metadata$celltype == "typeA") #save into a variable
metadata[idx, ]
which(metadata$replicate > 1)
idx <- which(metadata$replicate > 1)
metadata[idx, ]
metadata[which(metadata$replicate > 1), ]
sub_meta <- metadata[which(metadata$replicate > 1), ]
metadata[which(metadata$genotype == "KO"), ]

list1[[2]]
comp2 <- list1[[2]]
class(comp2)
list1[[1]]
list1[[1]][1]
list1
random <- NULL
random
random <- list(c(metadata, age, list1, samplegroup, number))
random[[4]]

names(list1)
# Name components of the list
names(list1) <- c("species", "df", "number")
names(list1)
# Extract 'df' component
list1$df
names(random)
names(random) <- c("data")
names(random)




