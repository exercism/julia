# Hints

## 1. Create a vector of all wagons

- The [`collect()`][collect] function is useful here.

## 2. Fix the vector of wagons

- It is useful to split the front wagons and the engine from everything else, so that they can be reassembled in the correct order.
- Multiple assignment with splatting may help you.

## 3. Add missing stops

- Only the stop name is needed, not the stop number, so each pair must be split.
- There are multiple ways to assemple the vector of names: list comprehension, broadcasting of an anonymous function, map...

## 4. Extend routing information

- After slurping, `more_route_information` is a `Pairs()` collection.
- The [`merge()`][merge] function will combine two or more `Dicts`, but will also accept a `Pairs()` collection.
  Explicit conversion to a `Dict` is possible but unnecessary.


[collect]: https://docs.julialang.org/en/v1/base/collections/#Base.collect-Tuple{Any}
[merge]: https://docs.julialang.org/en/v1/base/collections/#Base.merge
