\name{sJIVE}
\alias{sjive}
\alias{sJIVE}
\alias{sJIVE.converge}
\alias{sjive.converge}
\title{
Supervised JIVE for Multi-source Data
}
\description{
Given a list of linked data sets and an outcome vector, this algorithm will return components of underlying of joint and individual structure and fit a linear model to predict the outcome. 
}
\usage{
sJIVE(X, Y, rankJ = NULL, rankA=NULL,eta=NULL, max.iter=1000,
                      threshold = 0.001,  method="permute",
                      center.scale=TRUE, reduce.dim = TRUE)
}
\arguments{
  \item{X}{
A list of 2 or more datasets, each with dimensions p_i by n.
}
\item{Y}{
A continuous vector of length n
}
  \item{rankJ}{
A value for the low-rank of the joint component
}
  \item{rankA}{
A vector of the ranks for each X dataset. When rankJ or rankA
  are NULL, a rank selection method (see method) will choose ranks. 
}
  \item{eta}{
  A tuning parameter between 0 and 1, giving the relative weight of X (vs. Y) in the objective.   When eta=NULL, a gridsearch
  is conducted to tune eta. You can specify a value of eta to use,  or supply a vector of eta values for sJIVE to consider.  
}
  \item{max.iter}{
Specifies the maximum number of iterations that will run.
}
 \item{threshold}{
Specifies the criteria to determine when the algorithm has converged.
}
  \item{method}{
If ranks are not specified, this gives the method to determine the ranks;  "permute" uses JIVE's permutation method, or "CV" uses predictive cross-validation.
}
  \item{conv}{
A value indicating the convergence criterion. 
}
  \item{maxiter}{
The maximum number of iterations for each instance of the JIVE algorithm. 
}
  \item{center.scale}{
A boolean indicating whether or not to center and scale the data prior to fitting. Default is TRUE.
}
\item{reduce.dim}{
A boolean indicating whether or not the data should be transformed by SVD prior to fitting for computational efficiency. Default is TRUE.
}
}

\value{
%%  ~Describe the value returned
Returns an object of class sJIVE.
%%  If it is a LIST, use
\item{Sj}{a matrix containing the scores for joint structure}
\item{Si}{a list of matrices containing the scores for each individual structure}
\item{U_I}{a matrix containing the loadings for joint structure}
\item{W_I}{a list of matrices containing the loadings for each individual structure}
\item{theta1}{a vector of coefficient for each joint component}
\item{theta2}{a list of vectors, with coefficients for each individual component}
\item{fittedY}{predicted values for Y}
\item{error}{value of the squared error in the objecive function}
\item{error.all}{vector of the squared error in the objecive function over the iterations of the algorithm}
\item{rankJ}{the rank of joint structure}
\item{rankA}{a vector giving the ranks of individual structures}
\item{eta}{chosen value of eta, the weight for X (vs. Y) in the objective}
}
\references{
Palzer EF, Wendt C, Bowler R, Hersh C, Safo SE, Lock EF. sJIVE: Supervised Joint and Individual Variation Explained. Preprint.
}
\author{
Elise Palzer
}

\seealso{
\code{\link{summary.jive}}, \code{\link{plot.jive}}
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


