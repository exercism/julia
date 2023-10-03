using Random

function dotest(points, labels, hyperplane, reference)
    # Tests if a hyperplane linearly separates labeled points
    # Returns true or false

    points = vcat.(1, points)
    test = reduce(hcat, points)' * hyperplane .* labels
    if all(>(0), test)
        println("Reference hyperplane = $reference\nYour hyperplane = $hyperplane\nSeparated! And the normal points towards the positively labeled side\n")
        return true
    elseif all(<(0), test)
        println("Reference hyperplane = $reference\nYour hyperplane = $hyperplane\nSeparated! But the normal points towards the negatively labeled side\n")
        return true
    else
        println("Reference hyperplane = $reference\nYour hyperplane = $hyperplane\nThe sides are not properly separated...\n")
        return false
    end
end

Random.seed!(42) # set seed for deterministic test set

function population(n, bound)
    # Builds a population of n points with labels {1, -1} in area bound x bound around a reference hyperplane
    # Returns linearly separable points, labels and reference hyperplane

    vertical = !iszero(n % 10) #every tenth test has vertical reference hyperplane
    x, y, b = rand(-bound:bound), rand(-bound:bound)*vertical, rand(-bound÷2:bound÷2)
    y_intercept = -b ÷ (iszero(y) ? 1 : y)
    points, labels, hyperplane = [], [], [b, x, y]
    while n > 0
        # points are centered on y-intercept, but not x-intercept so distributions can be lopsided
        point = [rand(-bound:bound), y_intercept + rand(-bound:bound)]
        label = point' * [x, y] + b
        if !iszero(label)
            push!(points, point)
            push!(labels, sign(label))
            n -= 1
        end
    end

    points, labels, hyperplane
end