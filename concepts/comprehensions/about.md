# About

Anyone who has used Python has almost certainly used list comprehensions, which have been central to Python syntax since early versions.

Something so convenient gradually finds its way into other languages, including Julia.

[Comprehensions][wikibook] are an option rather than a necessity for Julia programmers, as there are usually alternatives (broadcasting, higher-order functions, etc).

However, a [comprehension][comprehensions] will often provide a simple, readable and performant way to construct an array.
Use is ultimately a matter of personal taste, and how you feel about Python versus functional languages.

The syntax is mostly a direct copy of Python, but with extensions for higher-dimensional arrays.

## Single variable

Very Pythonic, including the optional `if` clause.

```julia-repl
ulia> [x^2 for x in 1:3]
3-element Vector{Int64}:
 1
 4
 9

julia> [x^2 for x in 1:3 if isodd(x^2)]
2-element Vector{Int64}:
 1
 9
```

Output shape depends on the details of the comprehension: typically the same as the input collection in simple cases, but flattened to a Vector by an `if` clause.

```julia-repl
julia> m
2×3 Matrix{Int64}:
 1  2  3
 4  5  6

julia> [x^2 for x in m]
2×3 Matrix{Int64}:
  1   4   9
 16  25  36

julia> [x^2 for x in m if isodd(x^2)] 
3-element Vector{Int64}:
  1
 25
  9
```

## Multi-variable, Vector output

Like Python, we can have multiple `for` clauses with different variables, with the same or different collections.

```julia-repl
julia> [x * y for x in 1:3 for y in 4:6]
9-element Vector{Int64}:
  4
  5
  6
  8
 10
 12
 12
 15
 18

julia> [x * y for x in 1:3 for y in 4:6 if isodd(x * y)]
2-element Vector{Int64}:
  5
 15
```

This is equivalent to nested loops.
The output is one-dimensional, even with matrix input.

```julia-repl
julia> m
2×3 Matrix{Int64}:
 1  2  3
 4  5  6

julia> [x*y for x in m for y in m]
36-element Vector{Int64}:
  1
  4
  2
  5
(truncated output...)
```

## Multi-variable, multi-dimensional output

The previous section described multiple `for` clauses separated only by spaces.

In this section, there is a single `for` and the variables are comma-separated.

```julia-repl
julia> [(x, y) for x in 1:3, y in 4:6]
3×3 Matrix{Tuple{Int64, Int64}}:
 (1, 4)  (1, 5)  (1, 6)
 (2, 4)  (2, 5)  (2, 6)
 (3, 4)  (3, 5)  (3, 6)
```

Each variable in the comprehension creates a new dimension in the output, with an entry for each possible combination of the variables.

In the example above, `x` increases down the rows, `y` increases across the columns.
Higher dimensions are possible, with the usual warnings about readability of the output.

## Generator expressions

The previous sections have concentrated on array output, with the comprehension placed inside brackets `[ ... ]`.

Omitting the brackets gives a [`generator expression`][generators]: a lazily-evaluated iterator which can yield the next value on demand.

When the result of the comprehension is immediately used for further processing, a generator can be memory-efficient, avoiding the need to store a large intermediate array.

```julia-repl
# inefficient
julia> v = [x^2 for x in 1:1e6];

julia> sum(v)
3.333338333335e17

# better
julia> sum(x^2 for x in 1:1e6)
3.3333383333312755e17
```

Syntax is identical to comprehensions, other than the surrounding brackets.

Generators can also be convenient in dictionary constructors.

```julia-repl
julia> Dict(x => x^2 for x in 1:5)
Dict{Int64, Int64} with 5 entries:
  5 => 25
  4 => 16
  2 => 4
  3 => 9
  1 => 1
```

[comprehensions]: https://docs.julialang.org/en/v1/manual/arrays/#man-comprehensions
[generators]: https://docs.julialang.org/en/v1/manual/arrays/#man-generators
[wikibook]: https://en.wikibooks.org/wiki/Introducing_Julia/Controlling_the_flow#Comprehensions
