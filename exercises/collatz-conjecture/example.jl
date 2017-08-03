function collatz(n::Integer)
    n <= 0 && throw(DomainError())
    iseven(n) ? div(n, 2) : 3n + 1
end

function collatz_steps(n::Integer)
    i = 0
    while n != 1
        n = collatz(n)
        i += 1
    end

    i
end
