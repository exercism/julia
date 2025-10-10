# Instructions

We are starting up a cheese club, which will use ML to select new cheeses to offer our cheese-loving customers based on their histories and tastes.

New members are required to fill out an initial survey so we can gather some basic data to start with.
Through this, it's been found that there is a subset of emphatic clients who lack nuance in their critiques.
As this can end up irrevocably biasing a more nuanced algorithm, there is a separate algorithm set up to handle their needs.
You are asked to provide some helper functions to wrangle their data.

~~~~exercism/note
While there may be different ways to solve the following tasks, each can be solved with a different single higher order function.
~~~~

## 1. Classify customers

The rating system has a five star basis, which is simply consists of integers `1:5`.
The emphatic customers will only give ratings of `1` or `5`, and we want to know if a customer exhibits this behavior.

Implement `all_15()` which takes a vector of ratings and returns `true` if all ratings are either `1` or `5`, and false otherwise.

```julia-repl
julia> ratings = [2, 3, 4, 4, 1];

julia> all_15(ratings)
false

julia> ratings = [1, 5, 5, 1, 5];

julia> all_15(ratings)
true
```

## 2. Separate out emphatic customers

We need to separate the more emphatic customers from the others.

Implement `emphatics()` which takes a dictionary of customers and ratings.
Returns a similar dictionary with those who only use only `1` or `5` star ratings.

```julia-repl
julia> ratings = ([2, 3, 5, 1, 1], [1, 1, 5, 5, 1], [4, 5, 5, 3, 2], [5, 5, 1, 1, 5]);

julia> names = ("c1", "c2", "c3", "c4");

julia> customers = Dict(zip(names, ratings))
Dict{String, Vector{Int64}} with 4 entries:
  "c2" => [1, 1, 5, 5, 1]
  "c1" => [2, 3, 5, 1, 1]
  "c3" => [4, 5, 5, 3, 2]
  "c4" => [5, 5, 1, 1, 5]

julia> emphatics(customers)
Dict{String, Vector{Int64}} with 2 entries:
  "c2" => [1, 1, 5, 5, 1]
  "c4" => [5, 5, 1, 1, 5]
```

## 3. Change ratings to binary

Since the emphatic customers only use `1` and `5` ratings, it will more computationally convenient if these are changed these to `0` and `1`.

Implement `tobinary()` which takes vector of emphatic ratings.
Returns binary ratings, where `1` has been changed to `0` and `5` has been changed to `1`.

```julia-repl
julia> ratings = [1, 1, 5, 5, 1];

julia> tobinary(ratings)
5-element Vector{Int64}:
 0
 0
 1
 1
 0
```

## 4. Make ratings into a matrix

Our algorithms use `Matrix` inputs, so we will need to transform the data into one.

Implement `tobinarymatrix()` which takes a vector of emphatic rating vectors.
Returns a `Matrix` of the transformed data, with each rating vector a *row* in the matrix.

```julia-repl
julia> customersratings = [[1, 1, 5, 5, 1],[5, 5, 1, 1, 5]];

julia> tobinarymatrix(customersratings)
2×5 Matrix{Int64}:
 0  0  1  1  0
 1  1  0  0  1
```
