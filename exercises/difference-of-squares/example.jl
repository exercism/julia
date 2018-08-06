# This uses reduce instead of sum because sum can't handle empty collections properly.
# There is no universal zero-element, so it has to be specified manually and cannot
# be determined automatically. Otherwise, n=0 will cause an error.
sum_of_squares(n::Int) = reduce(+, i^2 for i in 1:n; init=0)

# However, sum{T<:Real}(r::Range{T}) can handle "empty" ranges.
square_of_sum(n::Int) = sum(1:n)^2

difference(n::Int) = square_of_sum(n) - sum_of_squares(n)
