## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(message = FALSE, warning = FALSE)

## ----setup, include = FALSE---------------------------------------------------
library(bayesmlogit)

## ----echo=TRUE, eval=FALSE----------------------------------------------------
#  devtools::install_github("Xuezhixing-Zhang/bayesmlogit")

## -----------------------------------------------------------------------------
#In this example, we generate 250 observations and 6 states (including death). Based on these observations, we apply the `CreateTrans()` function and generate the transitions.

#Create subject IDs for each observation. In this example, we have 50 subjects and 250 observations in total.
ID <- rep(1:50, each = 5) 

#Create Age variable for each observation.
Age <- rep(31:35, times = 50) 

#Create the current state for each observation. Without considering the end state "Death", we assume there are five other possible states. 
State <- sample(1:5,size=250,replace=TRUE)

#Create the indicator of death. All subjects in this example are presumed to have died at the last observation.
Death <- rep(c(0,0,0,0,1),times=50)

Example <- data.frame(ID,Age,State,Death)

#Use `CreateTrans()` to create transitions of each observation. Here we have six states in total: death and the other five possible states.
Example$trans <- CreateTrans(Example$ID,Example$Age,
                             Example$State,Example$Death,states=6)

#The transition for the first observation of each subject is NA because we cannot observe their previous states. 
head(Example,10)

## ----eval = FALSE-------------------------------------------------------------
#  data <- lifedata
#  y <- data[,1]
#  X <- data[,-1]
#  
#  # This example will take about 30 mins.
#  out <- bayesmlogit(y, X ,samp=1000, burn=500, step.width = 5, verbose=10)

## ----eval = FALSE-------------------------------------------------------------
#  trans <- out$outwstepwidth
#  mlifeTable(y,X,trans =trans,
#             groupby = c("male","black","hispanic"),
#             vars = "mar",
#             startages=50,
#             age.gap=1,
#             states=3,
#             nums =200,
#             file_path=".")
#  

## ----echo = FALSE-------------------------------------------------------------

lifetable <- data.frame(V1 = c(12.26391,12.98282,11.97415,11.36613,10.32153),
                        V2 = c(12.37167, 13.26774, 13.92443, 13.62579, 13.61575),
                        V3 = c(35.37205, 33.85567, 34.11296, 35.02107, 36.06585))

head(lifetable)

## ----eval = FALSE-------------------------------------------------------------
#  #An example for generating plots with mlifeTable().
#  mlifeTable(y,X,trans =trans,
#             groupby = c("male","black","hispanic"),
#             vars = "mar",
#             states=3,
#             startages=50,
#             age.gap=1,
#             nums = 200,
#             file_path=".",
#             mlifeTable_plot = T,
#             cred = 0.84)
#  
#  #An example for generating plots with mlifeTable_plot():
#  mlifeTable_plot(X=lifedata[,-1],state.include = 0,
#        groupby = c("male","black","hispanic"),
#        cred = 0.84,
#        states = 3,
#        file_path = ".")
#  

## ----echo = FALSE-------------------------------------------------------------

totallife <- data.frame(mean = c(25.594167,20.98344555, 17.5083547, 21.7699725, 25.7521784, 19.5448111),
                        left.bound = c(23.8903564, 19.7064424, 15.7686292, 19.9670376, 21.7483432, 16.220418),
                        right.bound = c(27.237894, 22.3996896, 19.3485968, 23.5050464, 29.8415952, 23.2624656),
                        subgroup = c("group000", "group100", "group110", "group010", "group001", "group101"))

totallife

