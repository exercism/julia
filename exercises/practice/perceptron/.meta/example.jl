function classify(point, hyperplane)
    # Takes a single point and a hyperplane
    # Classifies which nomrmal of hyperplane is associated with the point
    # Returns 1 for positive normal, -1 for negative normal and 0 for a point on the hyperplane
    sign(hyperplane' * point)
end

function update(point, label, hyperplane)
    # Takes one point, its label and a hyperplane
    # Updates the hyperplane conditional on classification not matching the label
    # Returns the Perceptron updated hyperplane
    (classify(point, hyperplane) != label) * label * point
end

function step(points, labels, hyperplane)
    # Takes a vector of points, a vector of their associated labels and a hyperplane
    # Iteratively updates the hyperplane for each point/label pair
    # Returns true/false if a valid decision boundary and the decision boundary/hyperplane
    decisionboundary = hyperplane
    foreach(i -> hyperplane += update(points[i], labels[i], hyperplane), eachindex(points))
    decisionboundary == hyperplane, hyperplane
end

function perceptron(points, labels)
    # Takes a vector of linearly separable points and a vector of their associated labels
    # Performs steps of the Perceptron algorithm until a valid decision boundary is found
    # Returns a valid decision boundary for the provided population of labeled points
    hyperplane, pnts = [0, 0, 0], vcat.(1, points)
    while true
        isdecisionboundary, hyperplane = step(pnts, labels, hyperplane)
        isdecisionboundary && return hyperplane
    end
end
