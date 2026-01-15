# Hints

Remember, turtles are cold-blooded animals, so make sure they are warm before giving them a quilt or sweater.

## 1. Sort quantity!

- Your returned sort permutation needs to be in descending order.
- Make sure to sort the quantities in descending order in-place.
- `sortperm` can take similar arguments to `sort`.
- The order in which you perform the two above operations is very important!

## 2. Sort customer

- A new array with the customers ordered should be returned (i.e. do not sort in-place)
- Remember, a sort permutation (i.e. index array) can be used like indices.

## 3. Production schedule!

- You can use your `sortquantity!()` and `sortcustomer()` functions here.
- Remember that a sort permutation is just a permutation of the indices.
- For an [inverse sort permutation][invperm]:
    - Think about what the original ordering of indices is for an arbitrary `Vector`.
    - What can be done to *any* permutation of indices to return it to this starting point?
    - Final hint... What does the sort permutation of a sort permutation do?
 
[invperm]: https://docs.julialang.org/en/v1/base/arrays/#Base.invperm
