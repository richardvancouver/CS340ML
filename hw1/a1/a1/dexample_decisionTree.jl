# Load X and y variable
using JLD
X = load("citiesSmall.jld","X")
y = load("citiesSmall.jld","y")
n = size(X,1)


include("test1.jl")

p1 = dtreeprediction(X)

#include("test2.jl")

#p1 = test2(X)


#yhat =p1.dtreeprediction(X)




