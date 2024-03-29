# Load data
using JLD
X = load("clusterData.jld","X")
(t,d)=size(X)
@printf("size %d, %d\n",t,d)


k = 4
@printf("k is %d\n",k)
yy=zeros(t, 50)
ww=zeros(k, d, 50)
erary=zeros(50)
include("kMeans.jl")
include("kMeansc.jl")

for  kk in 1:50
		# K-means clustering
		
		#include("kMeans.jl")
		model = kMeans(X,k,doPlot=false)
		y = model.predict(X)

		#include("clustering2Dplot.jl")
		#clustering2Dplot(X,y,model.W)



			# D = distancesSquared(X,model.W)

			# erro=0

			# for i in 1:n
			# 	erro=erro+D[i, y[i]]
			# end
			
		#include("kMeansc.jl")
		yy[:, kk]=y
		ww[:,:,kk]=model.W
		err=KMeansError(X,y,model.W)	
		@printf("Error %.3f\n",err)
		erary[kk]=err



end

		(aa, bb)=findmin(erary)

		@printf("Minimum %d\n",bb)
		ww[:,:,bb]
		include("clustering2Dplot.jl")
		clustering2Dplot(X,yy[:,bb],ww[:,:,bb])