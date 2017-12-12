include("misc.jl")

function leastSquares(X,y)

	# Find regression weights minimizing squared error
	w = (X'*X)\(X'*y)

	# Make linear prediction function
	predict(Xhat) = Xhat*w
	#predict(Xhat) = hcat(ones(size(Xhat)[1]),Xhat)*w
	# Return model
	return GenericModel(predict)
end