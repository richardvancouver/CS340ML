# Load X and y variable
using JLD
data = load("basisData.jld")
(X,y,Xtest,ytest) = (data["X"],data["y"],data["Xtest"],data["ytest"])

# (tt,nn)=size(X)
# intercept=ones(tt)

# Xnn=hcat(intercept,X)


# Fit a least squares model
include("leastSquaresc.jl")
model = leastSquares(X,y,3)

# Evaluate training error
yhat = model.predict(X)
trainError = mean((yhat - y).^2)
@printf("Squared train Error with least squares: %.3f\n",trainError)

# Evaluate test error
# (ttb,nnb)=size(Xtest)
# intb=ones(ttb)
# Xtestnn=hcat(intb, Xtest)
yhat = model.predict(Xtest)
testError = mean((yhat - ytest).^2)
@printf("Squared test Error with least squares: %.3f\n",testError)

# Plot model
using PyPlot
figure()
plot(X,y,"b.")
Xhat = minimum(X):.1:maximum(X)
yhat = model.predict(Xhat)
plot(Xhat,yhat,"g")