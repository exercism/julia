"""Calculate the number of grains on square `square`."""
function on_square(square)
    check_square_input(square)
    2 ^ (square - 1)
end

"""Calculate the total number of grains after square `square`."""
function total_after(square)
    check_square_input(square)
    sum(map(on_square, 1:square))
end

"""Validate an arbitrary square."""
function check_square_input(square)
    square == 0 && throw(DomainError())
    square <  0 && throw(DomainError())
    square > 64 && throw(DomainError())
end
