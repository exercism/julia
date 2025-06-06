# Introduction

We saw in previous Concepts that types in Julia form a hierarchy, with `Any` at the top.

Abstract types such as `Number` have subtypes, but cannot themselves be instantiated.
Setting a variable to an abstract type _constrains_ values of the variable to be any subtype of the abstract type.
For example:

```julia-repl
julia> x::Number = 3
3

julia> typeof(x)  # one subtype of Number
Int64

julia> x = 4.2
4.2

julia> typeof(x) # another subtype of Number
Float64

julia> x = "fail" # not a number type!
ERROR: MethodError: Cannot `convert` an object of type String to an object of type Number
```

This gives us one type of flexibility in constraining which inputs are valid.

However, suppose we want a variable to accept both integer and string values?
These types are not in the same branch of the hierarchy.

We could set the type to `Any`, or let it default to that, but then we lose all control of the allowed types.

For a better approach, we have the `Union{ }` syntax, with two or more types listed inside the braces.

```julia-repl
julia> y::Union{Integer, String} = 4
4

julia> typeof(y)
Int64

julia> y = "works"
"works"

julia> typeof(y)
String

julia> y = 5.3
ERROR: MethodError: Cannot `convert` an object of type 
  Float64 to an object of type 
  Union{Integer, String}
```

Another example uses the same type union in a function signature:

```julia-repl
julia> IntOrString = Union{Integer, String}
Union{Integer, String}

julia> f(z::IntOrString) = z^3
f (generic function with 1 method)

julia> f(2) # integers are cubed
8

julia> f("ab") # strings are repeated 3 times
"ababab"
```

Here, we gave the type a name, which can provide convenient shorthand but is not strictly necessary.
The function `g(z::Union{Integer, String}) = z^3` behaves the same way.

There will be much more to say about function signatures in the Multiple Dispatch Concept.

## Unions with nothing

Several other languages have types that may or may not contain a value, with names such as `Option`, `Nullable` or `Maybe`.

Julia has no specific syntax for this, but type unions are a generalization of the same idea.

We saw in the `Nothingness` Concept that Julia has various ways to represent non-values, including `nothing` and `missing`.
Either of these can be included in a type Union.

For example, in defining some sort of linked list, we need a way to terminate the list if there are no further nodes.
`Nothing` is the type with singleton value `nothing`, and this Node definition makes it possible to signal the end of the chain:

```julia-repl
julia> struct Node
           value::Any
           next::Union{Node, Nothing}
       end
```

Similarly, `missing` can be used as a placeholder for absent values, especially in collections such as vectors.
The example below is very contrived, but missing values are common in real-world data sets.

```julia-repl
julia> q(x::Real) = x >= 0 ? sqrt(x) : missing  # skip negative values
q (generic function with 1 method)

julia> vals::Vector{Union{Real, Missing}} = q.([4, 3.1, -1, 0])
4-element Vector{Union{Missing, Float64}}:
 2.0
 1.760681686165901
  missing
 0.0
```
