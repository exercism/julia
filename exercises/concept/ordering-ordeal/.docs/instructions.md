# Instructions

You have been hired as a Assistant Production Engineer in a company that produces quilts for turtles.

Orders come in throughout the day as a customer name or number and an order quantity. 
These are then processed in the morning before the day's production starts.

You get to go home with full pay as soon as all the day's orders are filled, so there's incentive to shorten the workday as much as possible.
Since each order is handled by a single machine, scheduling the largest orders first allows the overhead of starting a job to be pushed onto the smaller orders, shortening the total production time.
Therefore, you have decided to provide some sorting functions to help with this scheduling speed-up, so you can get home to knit a sweater for your turtle.

## 1. Sort quantity!

As noted, the array of quantities will need to be sorted from largest to smallest.
Due to the potentially large size of these arrays, they should be sorted in-place.
To keep track of everything correctly, you will also need to be able to sort the array of customers to match the quantities.
Write a function `sortquantity!(qty)` which takes a `Vector` of `Integer` quantities.
This function sorts the input `qty` in-place in descending order and returns a sort permutation of this ordering.

```julia-repl
julia> qty = [8, 9, 5, 6]
4-element Vector{Int64}:
 8
 9
 5
 6

julia> sortquantity!(qty)
4-element Vector{Int64}:
 2
 1
 4
 3

julia> qty
4-element Vector{Int64}:
 9
 8
 6
 5
```

## 2. Sort customer

As stated above, you need to keep track of the customers in a defined order.

Write a function `sortcustomer(cust, srtperm)` which takes a `Vector` of customers `cust` and a `Vector` sort permutation `srtperm`.
This function returns a new array with the customers in the order prescribed by the sort permutation.

```julia-repl
julia> cust = ["a", "b", "c"]
3-element Vector{String}:
 "a"
 "b"
 "c"

julia> sortcustomer(cust, [2, 3, 1])
3-element Vector{String}:
 "b"
 "c"
 "a"

julia> cust
3-element Vector{String}:
 "a"
 "b"
 "c"
```

## 3. Production Schedule

Now you can put it all together to help keep those turtles warm!
You can now sort the quantities and customers properly, but you need to recover the original ordering for shipping.
This can be done with an inverse sort permutation.

Write a function `production_schedule(cust, qty)` which takes a `Vector` of customers and a `Vector` of quantities.
This function sorts the quantities in-place in descending order.
It returns a new `Vector` of customers sorted in the same order as the quantities and an inverse sort permutation which can be used to restore the original ordering.

```julia-repl
julia> cust, qty = ["a", "b", "c"], [2, 3, 1]
(["a", "b", "c"], [2, 3, 1])

julia> orderedcust, invperm = production_schedule(cust, qty)
(["b", "a", "c"], [2, 1, 3])

julia> qty
3-element Vector{Int64}:
 3
 2
 1

julia> orderedcust[invperm], qty[invperm]
(["a", "b", "c"], [2, 3, 1])
```
