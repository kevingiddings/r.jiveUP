\name{sJIVE.predict}
\alias{sjive.predict}
\alias{sJIVE.predict}
\title{
sJIVE predict
}
\description{
Predict new outcomes from multi-source data using sJIVE.
}
\usage{
sJIVE.predict <- function(sJIVE.fit, newdata, threshold = 0.001, max.iter=2000)
}
\arguments{
  \item{sJIVE.fit}{
Output from an application of sJIVE to training data.
}
\item{newdata}{
A list with the same predictors and number of datasets as used in sJIVE.fit, with m observations to predict (columns).
}
  \item{threshold}{
Threshold for convergence
}
  \item{max.iter}{
Maximum number of iterations.
}
}

\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
\item{Ypred}{A vector of m predicted outcomes.}
\item{Sj}{a matrix containing the new scores for joint structure.}
\item{Si}{a list of matrices containing the new scores for each individual structure.}
\item{iter}{Iteration when the algorithm converges}
  \item{error}{Squared error in newdata}
}
\references{
Palzer EF, Wendt C, Bowler R, Hersh C, Safo SE, Lock EF. sJIVE: Supervised Joint and Individual Variation Explained. Preprint.
}
\author{
Elise Palzer
}

\seealso{
\code{\link{sjive}}
}
\examples{
\dontrun{
set.seed(10)
##Load data with rank 1 joint structure, and rank 1 individual structure for each dataset
##p=100 for each dataset, and n=100 for training, n=100 for test.
data(SimData_sJIVE) 
#Run sJIVE on training set
fit <- sJIVE(SimData$x.train, SimData$y.train)

#Predict Y on test set
y.hat <- sJIVE.predict(fit, newdata = SimData$x.test)

#Let's see how we did
test.mse <- sum((y.hat$Ypred - SimData$y.test)^2)/50

plot(y.hat$Ypred, SimData$y.test, ylab = "True Y value", 
     xlab="Predicted Y value", pch=19, col=rgb(0,0,0,alpha=0.4),
     main=paste0("Avg Test MSE = ", round(test.mse,3)))
}


