function pythagorean_triplets(input)
    triplets = []
    for a in 1:(ceil(input/2))
        for b in a:(ceil((input-a)/2))
            c = input - a - b
            triplet = sort([a, b, c])
            if (triplet[1]^2 + triplet[2]^2 == triplet[3]^2)
                push!(triplets, Int32.(triplet))
            end
        end
    end
    return(unique(triplets))
end
