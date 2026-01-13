# Hints

## 1. Sort quantity!

- Your returned sort permutation needs to be in descending order.
- Make sure to sort the quantities in descending order in-place.
- The order in which you perform the two above operations is important.

## 2. Sort customer

- A new array with the customers ordered should be returned (i.e. do not sort in-place)
- An sort permutation (i.e. index array) can be used like indices.

## 3. Production Schedule

- You can use your `sortquantity!()` and `sortcustomer()` functions here.
- Remember that a sort permutation is just a permutation of the indices.
- For an inverse sort permutation:
    - Think about what the original ordering of indices is for an arbitrary `Vector`.
    - What can be done to *any* permutation of indices to return it to this starting point?
