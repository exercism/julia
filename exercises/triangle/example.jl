# This problem gives practice on reusing procedures by extracting them as functions.

function is_equilateral(sides)
    sides = sort(sides)
    return verify_triangle(sides) && verify_equilateral(sides)
end

function is_isosceles(sides)
    sides = sort(sides)
    return verify_triangle(sides) && verify_isosceles(sides)
end

function is_scalene(sides)
    sides = sort(sides)
    return verify_triangle(sides) && verify_scalene(sides)
end


verify_equilateral(sorted) = (sorted[1] == sorted[3])

verify_isosceles(sorted) = (sorted[1] == sorted[2] || sorted[2] == sorted[3])

verify_scalene(sorted) = !verify_isosceles(sorted)

verify_triangle(sorted) = (sorted[3] < sorted[1] + sorted[2])
