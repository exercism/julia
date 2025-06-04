# Instructions

In this exercise, you are going to do a bit of data engineering by preprocessing some grading data.
A school with many, many, many (too many?) students is trying to do some data analysis on the grades received by students and is looking to do so efficiently, so the idea is to minimize and organize the data.

The grading scale is usually from 0-10, so it is most efficient to use a data type with only eight bits per grade.
- Some professors use real numbers (as they are sticklers for precision), and you will need to convert these to the `UInt8` data type.
- Other professors use integers with negative numbers (to punish especially unruly students), and you will need to convert these to the `Int8` data type in these situations.

Once you have implemented the function to convert the grades, you will need to write another to handle the collections that they are held in by demoting the grades and returning them in descending order.
- Some professors use `Vector`s sorted in ascending order to store their grades, because they are meticulous about their data.
- Other professors use `Set`s, which are unsorted, to store their grades, because they are a bit lazier.

In both functions, you will need to handle invlalid inputs by throwing a MethodError.

~~~~exercism/note
Exception handling will be covered in a later Concept, so for the purposes of this exercise, you can use the following syntax:
```julia
throw(MethodError(f, args))
```
Where `f` is the function, and `args` is a tuple of the arguments input into the function.
With the `demote(n)` function, `f` is `demote` and `args` is `(n,)`:
```julia
throw(MethodError(demote, (n,)))
```
~~~~

## 1. Demote the grades

Implement the `demote(n)` method.
- With a `Float64` input, it should round up to the nearest whole number and return a `UInt8` data type.
- With an arbitrary `Integer`, it should return the same integer in a `Int8` data type.
- All other inputs should throw a MethodError.

```julia-repl
julia> demote(4.2)::UInt8
5

julia> demote(4)::Int8
4

julia> demote("hi")
MethodError: no method matching demote(::String)     #output truncated
```

## 2. Preprocess the data

Implement the `preprocess(coll)` method.
- With a `Vector` input, it should demote all the numbers and reverse the vector.
- With a `Set` input, it should demote all the numbers and return a sorted vector in descending order.
- All other inputs should throw a MethodError.

```julia-repl
julia> preprocess([1, 2, 3])
3-element Vector{Int8}:
 3
 2
 1

julia> preprocess(Set([2.2, 5.8, 3.4]))
3-element Vector{UInt8}:
 6
 4
 3

julia> preprocess(42)
MethodError: no method matching preprocess(::Int64)     #output truncated
```
