function all_15(ratings)
    all(rating -> rating ∈ (1,5), ratings)
end

function emphatics(customers)
    filter(customer -> all_15(customer.second), customers)
end

function tobinary(ratings)
    map(rating -> isone(rating) ? 0 : 1, ratings)
end

function tobinarymatrix(ratings)
    mapreduce(transpose ∘ tobinary, vcat, ratings)
end
