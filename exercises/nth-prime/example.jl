function isPrime(x)
	i = 2
	if x == 1
		return false
	end
	if x == 2
		return true
	end
	if x == 3
		return true
	end
	while i <= sqrt(x)
		if x % i == 0
		return false
		end
		i =i+1
	end
	return true
end

function nthPrime(n)
	primeCount = 0
	if n == 0 
		return "there is no zeroth prime"
	end
	if typeof(n)==String
		n = parse(Int64,n)
	end
	x=2
	while primeCount <= n
		if isPrime(x)
			primeCount += 1
		end
		if primeCount == n
			return x
		end
		x+=1
	end
end	

function main(input)
	nthPrime(input)
end
