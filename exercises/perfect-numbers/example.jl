function classify(number)
    factors = []
    if number == 1
        return :deficient
    elseif number <= 0
        return throw(DomainError(number,"Classification is only possible for natural numbers."))
    end

    for i in 1:(number-1)
        if number%i == 0
            push!(factors, i)
        end
    end
    if sum(factors) > number
        return :abundant
    elseif sum(factors) < number
        return :deficient
    else
        return :perfect
    end
end
