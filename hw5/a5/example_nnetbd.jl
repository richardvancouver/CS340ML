# Load X and y variable
using JLD
using PyPlot
include("misc.jl")
include("findMin.jl")
data = load("basisData.jld")
(X,y) = (data["X"],data["y"])
n = size(X,1)

#standardize data
XOld=X
yOld=y
minX=minimum(X)
X=X-minimum(X)
maxX=maximum(X)
X=X./maximum(X)
minY=minimum(y)
y=y-minimum(y)
maxY=maximum(y)
y=y./maximum(y)

#(X,mu,sigma) = standardizeCols(X)
#(y,mu1,sigma1) = standardizeCols(y)

X = [ones(n,1) X]
d = 2

# Choose network structure and randomly initialize weights
include("NeuralNet.jl")
nHidden = [65 203 65]#[15]#[15,30,15]#[27 40 27]#[15]
nParams = NeuralNet_nParams(d,nHidden)
w = randn(nParams,1)
@show(size(w))

# funobjw(w)=NeuralNet_backprop(w,X,y,nHidden)
# w[:] = findMin(funobjw,w[:],verbose=false,maxIter=20)

# Xhat = -10:.05:10
# yhat = NeuralNet_predict(w,[ones(length(Xhat),1) Xhat],nHidden)
# plot(X[:,2],y,".")
# plot(Xhat,yhat,"g-")



# Train with stochastic gradient
maxIter = 10000*3
stepSize = 1e-4*5



for t in 1:maxIter
    if t > maxIter/2
        stepSize = stepSize * (1-2/maxIter)^2;
    end
    wOld = w
    wOldOld= wOld	
	# The stochastic gradient update:
	trials=10
	sg=0
	for kk in 1:trials #minibatch
		i = rand(1:n)
		(f,g) = NeuralNet_backprop(w,X[i,:],y[i],nHidden)
		sg=sg+g
		#@show(g)
	end
		g=sg/trials

		w = w - stepSize*g+ stepSize.^2*(w-wOldOld)

	#Every few iterations, plot the data/model:
	if (mod(t-1,round(maxIter/50)) == 0)
		@printf("Training iteration = %d\n",t-1)
		figure(1)
		clf()


		# Xhat = -10:.05:10
		# yhat = NeuralNet_predict(w,[ones(length(Xhat),1) Xhat],nHidden)
		# plot(X[:,2],y,".")
		# plot(Xhat,yhat,"g-")


		XhatOld = minX:.05:(maxX+minX)
        Xhat=(XhatOld - minX)./maxX
        yhat = NeuralNet_predict(w,[ones(length(Xhat),1) Xhat],nHidden)
        plot(XOld,yOld,".");
        plot(XhatOld,((yhat.*maxY)+minY),"g-");



		sleep(.1)
	end
end


