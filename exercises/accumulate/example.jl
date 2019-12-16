"""
    accumulate(collection, operation)
Takes in a collection and applies the operation on that collection then returns
a new collection.
"""
function accumulate(collection, operation)

    new_colletion = []

    new_colletion = operation.(collection, collection)

    return new_colletion
end
