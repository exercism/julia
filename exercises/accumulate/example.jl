"""
    accumulate(collection, operation)
Takes in a collection and applies the operation on that collection then returns
a new collection.
"""
function accumulate(collection, operation)

    new_colletion = []

    if operation == *
        new_colletion = collection .* collection
    elseif operation == +
        new_colletion = collection .+ collection
    elseif operation == -
        new_colletion = collection .- collection
    elseif operation == /
        new_colletion = collection ./ collection
    elseif operation == %
        new_colletion = collection .% collection
    end

    return new_colletion
end
