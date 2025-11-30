# Hints

## 1. Create a vector of all wagons

- The [`collect()`][collect] function is useful here.
- Alternatively, splatting works within a vector constructor:

```julia-repl
julia> input = (1, 5, 9)
(1, 5, 9)

julia> [input...]
3-element Vector{Int64}:
 1
 5
 9
```

## 2. Fix the vector of wagons

- It is useful to split the front wagons and the engine from everything else, so that they can be reassembled in the correct order.
- Multiple assignment with splatting may help you (see introduction).

## 3. Add missing stops

- Remember, this function doesn't mutate the input!
- Only the stop name is needed, not the stop number, so each pair must be split.
- There are multiple ways to assemple the vector of names:
  -  Array [comprehension][comprehensions]
  -  [`map()`][map] a function over the vector.
  -  [Broadcasting][broadcasting] of an [anonymous][anonymous] function is possible:

 ```julia-repl
julia> (x -> x^4).([1, 2, 3]) == [1, 16, 81]
true
 ```

## 4. Extend routing information

- After slurping, `more_route_information` is a `Pairs()` collection.
- The [`merge()`][merge] function will combine two or more `Dicts`, but will also accept a `Pairs()` collection.
  Explicit conversion to a `Dict` is possible but unnecessary.


[collect]: https://docs.julialang.org/en/v1/base/collections/#Base.collect-Tuple{Any}
[merge]: https://docs.julialang.org/en/v1/base/collections/#Base.merge
[comprehensions]: https://docs.julialang.org/en/v1/manual/arrays/#man-comprehensions
[map]: https://docs.julialang.org/en/v1/base/collections/#Base.map
[broadcasting]: https://docs.julialang.org/en/v1/manual/arrays/#Broadcasting
[anonymous]: https://docs.julialang.org/en/v1/manual/functions/#man-anonymous-functions
