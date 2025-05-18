# Introduction

So far, the syllabus has not said much about types, but clearly they exist in Julia:

```julia-repl
julia> vals = (42, 4.3, π, "hello", 'Q')
(42, 4.3, π, "hello", 'Q')

julia> typeof(vals)
Tuple{Int64, Float64, Irrational{:π}, String, Char}
```

We never specified the types, but Julia assigned them regardless.

1. Julia has `types`, which are central to its design.
2. Julia can usually "guess" the type, using `Type Inference`.

The JIT compiler will look through (all) the code, see how a variable is used, and _infer_ a suitable default type compatible with that usage.

## Type promotion

There have been many examples in previous concepts which coerce numerical types into uniformity, starting with the simplest arithmetic.

```julia-repl
julia> 2 + 1.3
3.3
```

We added an integer (Int64) and a floating-point (Float64) number and got a Float64 result.
Similarly:

```julia-repl
julia> nums = (3, 4.1, 1//4)
(3, 4.1, 1//4)

julia> typeof(nums)
Tuple{Int64, Float64, Rational{Int64}}

julia> [nums...]
3-element Vector{Float64}:
 3.0
 4.1
 0.25
```

In the case above, a tuple preserved the type of each element, but converting to a vector changed all of them to a uniform Float64.

The Julia compiler understands which type conversions are possible: integer to float is no problem, float to integer loses precision so an `InexactError` is raised.
Type promotion converts all the values in the expression to a common type, versatile enough to be compatible with all the inputs.

## Type assignment

Relying on type inference is fine for solving simple tutorial exercises, but for bigger programs you are likely to need more precise control.

On most modern processors, an integer defaults to `Int64`.
We saw in the [`Numbers`][numbers] Concept that a value can be converted to a particular non-default type.

```julia-repl
julia> x = Int16(42)
42

julia> typeof(x)
Int16
```

However, the variable `x` can still be reassigned to a different type:

```julia-repl
julia> x = "changed"
"changed"

julia> typeof(x)
String
```

This is `type instability`, which is:

- Very convenient in small scripts.
- Bad for performance and reliability in bigger programs.

Instead, we can set the type of `x` by using the `::` operator:

```julia-repl
julia> y::Int16 = 42
42

julia> typeof(y)
Int16

julia> y = "changed"
ERROR: MethodError: Cannot `convert` an object of type String to an object of type Int16
The function `convert` exists, but no method is defined for this combination of argument types.
```

Now `y` is, and always will be, of type `Int16`.
Thus, the compiler knows how many bytes to reserve for it, and can optimize the rest of the code to rely on a stable type.
In this, the variable is more or less similar to those in a statically-typed language such as C.

## Type Assertion

Type assignment, described above, is used on the left-hand side of a variable assignment to constrain the type of that variable.

Using the `::` operator with a value, or something that evaluates to a value, is generally an _assertion_ that the value must be of this type, otherwise an error should be thrown.

```julia-repl
julia> 42::Number
42

julia> "two"::Number
ERROR: TypeError: in typeassert, expected Number, got a value of type String
```

Commonly, this might be used with the return value of a function, as a simple last check that the function behaved as expected.

Note that there is an `@assert` macro for other forms of assertion.

## The Type Hierarchy

`Int64`, `Int16`, `String`, `Char`: where do these types _"come from"_.

In many object-oriented (OO) languages, each type is a class, subclassing arranges them in a class hierarchy, and class methods define the behaviors.

Java and Ruby are obvious examples of this pattern, but even Python is similar internally.

***Julia has no classes.***

The documented reason is that OO features interfere with the JIT compiler and hurt runtime performance.

And yet, look at this code:

```julia-repl
julia> y::Int16 = 42
42

julia> typeof(y)
Int16

julia> supertype(Int16)
Signed

julia> supertypes(Int16)
(Int16, Signed, Integer, Real, Number, Any)
```

Filling in some details:

- `Int16` is a type, and we can create variables of this type.
- `Int16` is a subtype of `Signed`, and the `supertype()` function shows us this.
- There is a hierarchy of types, going up through `Integer`, `Real` and `Number` to `Any` at the top, and `subtypes()` will list this branch of the hierarchy for us.

All branches end in `Any`, which is unique in being its own supertype.

```julia-repl
julia> supertypes(String)
(String, AbstractString, Any)

julia> supertype(Any)
Any
```

So, Julia has no `class` hierarchy, but it _does_ have a `type` hierarchy.

Eventually, we will try to unpick how this works, but there is much more to explore first.

## Testing for Types

We can use `typeof()` to test for equality in the usual way.

```julia-repl
julia> typeof(11)
Int64

julia> typeof(11) == Int64
true

julia> typeof(11) == Number
false
```

The type equality must be exact, as this form of comparison has no understanding of the type hierarchy.

More flexibly, `isa` will tell us if a value has either the same type as a comparator, or a subtype of it.
It can be used in either function or infix form.

```julia-repl
julia> 12 isa Int64
true

julia> 12 isa Number
true

julia> isa(12, Number)
true

julia> 12 isa String
false
```

Note that `isa` expects a `value` on the left, not a `type`.

Trying to compare two _types_ this way will give unexpected results.
The correct operator is `<:`, which we will see a lot more of in future concepts.

```julia-repl
julia> Int64 isa Number  ## Don't do this!
false

julia> Int64 <: Number
true
```

## Abstract versus Concrete Types

We saw that the type hierarchy forms a tree structure (in the CS sense, with the root at the top).

Each item in the tree is a `node`, and these can be divided into categories:

1. Nodes with subtypes are called `abstract`.
2. Leaf nodes, with no subtypes, are called `concrete`.

```julia-repl
julia> subtypes(Integer)  # an abstract type
3-element Vector{Any}:
 Bool
 Signed
 Unsigned

julia> subtypes(Int64)  # a concrete type
Type[]
```

This is an important distinction, because only concrete types can be `instantiated` as variables.


```julia-repl
julia> a::Int16 = 42
42

julia> typeof(a)
Int16

julia> b::Integer = 42
42

julia> typeof(b)
Int64
```

Note that trying to use an abstract type gives no error message (in this case), but the compiler creates an appropriate concrete type: `Int64` instead of `Integer`.
At least it prevents the variable being assigned to a non-integer:

```julia-repl
julia> f::Integer = "hello"
ERROR: MethodError: Cannot `convert` an object of type String to an object of type Integer
The function `convert` exists, but no method is defined for this combination of argument types.
```

Type assignment with an abstract type is thus a _constraint_ on the variable type, to any subtype of (in the above case) `Integer`.
This is something unusual in the world of programming languages: weaker than a type assignment in C, stronger than a type hint in recent versions of Python.

The functions `isabstracttype()` and `isconcretetype()` allow testing.
Note that these are not just negations of one another: we will see in a later Concept that some types can be neither abstract nor concrete.


```julia-repl
julia> isconcretetype(Integer), isabstracttype(Integer)
(false, true)

julia> isconcretetype(Int64), isabstracttype(Int64)
(true, false)

# Vector is neither
julia> isconcretetype(Vector), isabstracttype(Vector)
(false, false)
```

[numbers]: https://exercism.org/tracks/julia/concepts/numbers
