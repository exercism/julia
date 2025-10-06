
# Pre-allocating the vector proved slower then repeated push!()
# function prime(num)
#     num > 0 || error("No such prime!")

#     # splitting this to a function speeds up execution 9-fold
#     is_prime(n) = all([n % p > 0 for p in primes[1:found]])

#     primes = zeros(Int, num > 1 ? num : 2)
#     primes[1] = 2
#     primes[2] = 3
#     found = 2

#     n = 3
#     while found < num
#         n += 2
#         if is_prime(n)
#             found += 1
#             primes[found] = n
#         end
#     end
#     primes[num]
# end


function prime(num)
    num > 0 || error("No such prime!")

    # this function is much faster than having the test in the if statement
    is_prime(n) = all([n % p > 0 for p in primes])

    primes = [2, 3]

    n = 3
    while length(primes) < num
        n += 2
        if is_prime(n)
            push!(primes, n)
        end
    end
    primes[num]
end
