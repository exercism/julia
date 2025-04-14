# About

The [`Basics`][basics] Concept introduced two ways to define a [function][functions].

Most generally, the multiline form:

```julia
function muladd(x, y, z)
    x * y + z
end
```

The "assignment", or "single-line" form for short definitions:
```julia
muladd(x, y, z) = x * y + z
```

In a third and even shorter form, a short, single-use function can be created without a name:

```julia-repl
julia> map(x -> 2x, 1:3)
4-element Vector{Int64}:
 2
 4
 6

julia> map((x, y) -> x * y, 1:3, 4:6)
3-element Vector{Int64}:
  4
 10
 18
```

In this case, `x -> 2x` is an ["anonymous function"][anonymous-function].
This is equivalent to what some other languages call a "lambda function".

Note that multiple arguments need parentheses, as in `(x, y) -> x * y`.

Anonymous functions are common in Julia code, especially when combined with [higher-order functions][HOF] such as `map()` and `filter()`.

## Function arguments

So far in the syllabus, we have only looked at functions which have a precise number of arguments, and require function calls to supply all of them, in the correct order.
This would be limiting and inconvenient, so there are several other options.

### Optional arguments

Like many languages, Julia allows function definitions to supply default values for individual arguments.

Function call can then either supply a value for that argument, or omit it and rely on the default.

```julia-repl
julia> f(x, y=10) = x * y
f (generic function with 2 methods)

julia> f(2, 3)
6

julia> f(2)
20
```

All arguments _without_ defaults must come before any arguments _with_ defaults, meaning that `f(x=2, y)` would be invalid.

### Keyword arguments

All the examples so far use `positional arguments`, where values supplied in a function call must match the order of the corresponding arguments in the function definition.

Like many languages, Julia also allows `keyword arguments`.
Function calls must specify the argument name, but multiple keyword arguments can then be specified in any order.

A distinctive feature of Julia is that the keyword arguments (if any) in the function definition must be preceded by a semicolon `;` to separate them from any positional arguments.
A function call can use either `;` or `,` between the last positional argument and the first keyword argument.

```julia-repl
julia> b(x; y) = x + y
b (generic function with 1 method)

julia> b(2, y=3)
5

# keyword is required when calling
julia> b(2, 3)
ERROR: MethodError: no method matching b(::Int64, ::Int64)
The function `b` exists, but no method is defined for this combination of argument types.
```

Default values can optionally be specified, exactly as for positional arguments.

It is common to end up with syntax like `myarg=myarg` within a function call, when a variable with the same name as the parameter was pre-calculated.
A shorthand syntax is allowed in this situation:

```julia-repl
julia> width = 4.0
4.0

julia> height = √ width
2.0

julia> area(; width, height) = width * height
area (generic function with 1 method)

# repetition
julia> area(; width=width, height=height)
8.0

# shorthand form
julia> area(; width, height)
8.0
```

### Splat and slurp

These are the standard names for a useful aspect of Julia syntax, in case you wondered.
Both refer to the `...` operator.

#### Splat

Splatting is used in function _calls_, to expand collections into individual values required by the function.

This may be easier to demonstrate than to explain:

```julia-repl
julia> fxyz(x, y, z) = x * y * z
fxyz (generic function with 1 method)

julia> xyz = [2, 3, 4]
3-element Vector{Int64}:
 2
 3
 4

# Using the vector directly in a function call is invalid
julia> fxyz(xyz)
ERROR: MethodError: no method matching fxyz(::Vector{Int64})
The function `fxyz` exists, but no method is defined for this combination of argument types.

# splatting converts the vector to 3 numbers, used as positional argumants
julia> fxyz(xyz...)
24
```

Some "function calls" are hidden by syntactic sugar, so splatting can also be used in less obvious ways.

For example, multiple assignment uses a tuple constructor function internally:

```julia-repl
julia> first, rest... = [1, 2, 3, 4]
4-element Vector{Int64}:
 1
 2
 3
 4

julia> first
1

julia> rest
3-element Vector{Int64}:
 2
 3
 4
```

Keyword arguments can also be supplied by splatting, typically using a `named tuple`. 
A `Dict` will also work, but the keys must be symbols (strings will not work here).

```julia-repl
# function with 3 keyword arguments
julia> fabc(; a, b, c) = a + b + c
fabc (generic function with 1 method)

# named tuple
julia> abc_nt = (a=2, b=3, c=4)
(a = 2, b = 3, c = 4)

# there are no positional arguments, so need to use ; before kw argument
julia> fabc(;abc_nt...)
9

# Dict
julia> abc_dict = Dict(:a=>2, :b=>3, :c=>4)
Dict{Symbol, Int64} with 3 entries:
  :a => 2
  :b => 3
  :c => 4

julia> fabc(;abc_dict...)
9
```

#### Slurp

Slurping is used in the function _definition_, to pack an arbitrary number of individual values into a collection.

```julia-repl
julia> f_more(i, j, more...) = i + j + sum(more)
f_more (generic function with 1 method)

julia> f_more(1, 3, 5, 7, 9, 11)
36
```

The name of the slurped argument (in this case `more`) is not significant.
The type of this variable is chosen by the compiler, but for positional arguments is likely to be `tuple` or something similar.

Keyword arguments can also be slurped, giving a `Dict` (or similar).

```julia-repl
julia> f_kwslurp(x, y; switches...) = :mult in keys(switches) ? x * y : x + y
f_kwslurp (generic function with 1 method)

julia> f_kwslurp(5, 6; mult=true)
30

julia> f_kwslurp(5, 6)
11
```

Any keyword arguments can be used in the call.
It is for the function definition to decide which keywords to respond to and which to ignore.


[basics]: https://exercism.org/tracks/julia/concepts/basics
[anonymous-function]: https://docs.julialang.org/en/v1/manual/functions/#man-anonymous-functions
[HOF]: https://en.wikipedia.org/wiki/Higher-order_function
[named-tuple]: https://exercism.org/tracks/julia/concepts/sets
[dict]: https://exercism.org/tracks/julia/concepts/pairs-and-dicts
[splat]: https://docs.julialang.org/en/v1/manual/functions/#Varargs-Functions
[functions]: https://docs.julialang.org/en/v1/manual/functions/
[struct]: https://docs.julialang.org/en/v1/base/base/#struct
