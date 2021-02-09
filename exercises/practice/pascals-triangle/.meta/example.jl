triangle(n::Int) = n >= 0 ? [[binomial(i, j) for j in 0:i] for i in 0:n-1] : throw(DomainError(n, "n must be strictly positive"))
