% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mlifeTable.R
\name{mlifeTable}
\alias{mlifeTable}
\title{Multistate Life Table Method}
\usage{
mlifeTable(
  y,
  X,
  trans,
  states,
  file_path,
  groupby = NA,
  no_control = NA,
  values = NA,
  status = 0,
  startages = 0,
  endages = 110,
  age.gap = 1,
  nums = dim(trans)[1],
  mlifeTable_plot = FALSE,
  state.names = NA,
  ...
)
}
\arguments{
\item{y}{A vector of transitions.}

\item{X}{A matrix of covariates. Note that \code{X} must include age as a convariate.}

\item{trans}{The posterior samples generated using \code{?bayesmlogit()}.}

\item{states}{The total number of states in data.}

\item{file_path}{The file path for outputs.}

\item{groupby}{A vector that contains the covariates for subgroup comparisons. Default is NA, which means that we won't make subgroups.}

\item{no_control}{The covariates that we don't want to control in subgroup analysis. Default is NA, which means we will control all covariates in X. As an example, in Lynch and Zang's study (2022), they incorporated education into the multinomial logit model. However, in the life table calculation, if one does not want to control for education, one could opt to use its region-specific mean rather than the sample mean using no_control.}

\item{values}{A list that specifies values for covariates. Default is NA. If both no_control and values are specified, the option values takes precedence.}

\item{status}{A numeric value. The option allows producing status-based life tables. Default is 0, produces population-based life tables.}

\item{startages}{Start age of the life table. Default is 0.}

\item{endages}{End age of the life table. Default is 110.}

\item{age.gap}{This option allows users to specify the age interval of the life table. Default is 1. For example, if the survey data were sampled every 2 years, users can specify the age interval to be 2 in the life table.}

\item{nums}{Number of life tables generated for each subgroup. Default is the size of posterior samples we used.}

\item{mlifeTable_plot}{If TRUE, this option will create a new directory \code{mplotResults} under given \code{file_path} and output corresponding plots and tables for posterior means and credible intervals. Default is FALSE.}

\item{state.names}{A vector used to specify names of each state except death. You can also specify them in the output files.}

\item{...}{Extra parameters for \code{mlifeTable_plot()}. See more details using \code{?mlifeTable_plot()}.}
}
\value{
Life tables for each subgroup.
}
\description{
A Bayesian Multistate Life Table Method for survey data, developed by Lynch and Zang (2022), allowing for large state spaces with quasi-absorbing states (i.e., structural zeros in a transition matrix).
}
\details{
This function generates life tables based on the estimates from the Bayesian multinomial logit regressions, which can be obtained using the \code{bayesmlogit()} function. The values in the generated life table represent the expected remaining years to be spent in each state conditional on a give age. Current version was designed to only generate life tables based on data with a death state.
}
\examples{
\dontrun{
#The life tables generated in the example have 3 columns, which correspond to 3 states: 
#1: health; 2: unhealthiness; 3: death;

data <- lifedata
y <- data[,1]
X <- data[,-1]

# This example will take about 30 mins.

out <- bayesmlogit(y, X ,samp=1000, burn=500,verbose=10) 

trans <- out$outwstepwidth
mlifeTable(y,X,trans =trans,
           groupby = c("male","black","hispanic"),
           no_control = "mar",
           startages=50,
           age.gap=1,
           states=3,
           file_path=".")

# To name each subgroup, try the subgroup.names option.
mlifeTable(y,X,trans =trans,
           groupby = c("male","black","hispanic"),
           no_control = "mar",
           states=3,
           startages=50,
           age.gap=1,
           file_path=".",
           subgroup.names= c("F-W","M-W","M-B","F-B","F-H","M-H"))
           
# To generate plots, try the mlifeTable_plot option
mlifeTable(y,X,trans =trans,
           groupby = c("male","black","hispanic"),
           no_control = "mar",
           states=3,
           startages=50,
           age.gap=1,
           nums = 400,
           file_path=".",
           subgroup.names= c("F-W","M-W","M-B","F-B","F-H","M-H"),
           mlifeTable_plot = T,
           cred = 0.84)
           
# To specify a variable at a fixed value other than the mean value. Try option "values".
mlifeTable(y,X,trans =trans,
           groupby = c("male","black","hispanic"),
           no_control = "mar",
           values = list("cohort" = 36),
           states=3,
           startages=50,
           age.gap=1,
           nums = 400,
           file_path=".",
           subgroup.names= c("F-W","M-W","M-B","F-B","F-H","M-H"),
           mlifeTable_plot = T,
           cred = 0.84)       
                           
}
}
\seealso{
\code{\link{bayesmlogit}}, \code{\link{mlifeTable_plot}}
}
