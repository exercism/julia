# Introduction

By this point in the syllabus, you have already seen a lot of function definitions.
Usually, these were presented without much comment about the output in the REPL:

```julia-repl
julia> f(x) = x^2
f (generic function with 1 method)
```

Why _"generic function with 1 method"_ ?

Suppose we want to be more specific about the argument types.

```julia-repl
julia> f(x::Integer) = x^2
f (generic function with 2 methods)

julia> f(x::Real) = x^2
f (generic function with 3 methods)
```

Or we could change the number of arguments:

```julia-repl
julia> f(x, y) = x * y
f (generic function with 4 methods)
```

It appears that new definitions of the same function are called "methods".
Methods are added to a list, instead of overwriting the old definition.

We can easily list the methods:

```julia-repl
julia> methods(f)  # output edited for brevity
# 4 methods for generic function "f" from Main:
 [1] f(x, y)
 [2] f(x::Integer)
 [3] f(x::Real)
 [4] f(x)
 ```

If we call the function `f`, Julia somehow knows which method to use:

```julia-repl
julia> f(2.5)  # Float64
6.25

julia> f(2)  # Int64
4

julia> f(2, 3)  # Int64, Int64
6
```

## What is a function?

According to the manual, a function is an object which maps a tuple of arguments to a return value.

We normally think of the function arguments in `f(2, 3)` as two separate items, but the compiler sees them as one tuple.
This is true even for a single argument (though we need to add a comma to make this clearer):

```julia-repl
julia> typeof( (2, 3) )
Tuple{Int64, Int64}

julia> typeof( (2,) )
Tuple{Int64}
```

Viewing the function as a black box, we can say that a tuple goes in and a return value comes out.
More formally, the tuple is _mapped_ to a return value.

## How do functions handle different numbers and types of arguments?

This is usually referred to as "polymorphism"

This has been a big topic in computer science for several decades, and different approaches have been adopted.

Julia's approach is unusual, though not unique.

- Functions are "generic", meaning they can have multiple methods attached to them.
- Functions are just names, until they have methods attached.
- Methods can be added as required, potentially in large numbers (the `+` operator is a function with 161 methods, currently).
- When a function is called, Julia examines the call signature: the number of arguments and the current type of each.
- The method most closely matching the call signature is selected.
  - In general, the number of arguments must match exactly (though the splat/slurp operator `...` can partially bypass this).
  - Methods with types exactly matching the call signature are preferred.
  - If necessary, Julia will look at supertypes of each argument in the call signature to find the most closely matching, most specific, method.
- The chosen method is `dispatched` with the given arguments, and returns a result.
- If no suitable method is found, a `MethodError` is raised.

Note that Julia is dynamically typed, so method dispatch happens at _run time_.

## Multiple Dispatch: an example

The previous section had a lot of words, so let's translate those ideas into code.
For simplicity, the functions below have only one argument, but it is not unusual to find functions with dozens of arguments (such as in plotting packages, or machine learning).

Start by defining some custom types, to represent geometric shapes.

```julia-repl
julia> abstract type Shape end

julia> struct Circle <: Shape
           radius::Float64
       end

julia> struct Square <: Shape
           side::Float64
       end

julia> struct Rectangle <: Shape
           length::Float64
           width::Float64
       end
```

Next we can define methods to calculate the area of each shape.
Each takes one argument, of a different concrete, user-defined type in each case.

```julia-repl
julia> area(c::Circle) = π * c.radius^2
area (generic function with 1 method)

julia> area(s::Square) = s.side^2
area (generic function with 2 methods)

julia> area(r::Rectangle) = r.length * r.width
area (generic function with 3 methods)
```

Now we can create some shapes and calculate the areas, relying on Julia's dispatch mechanism to use the correct formula for each.

```julia-repl
julia> circle = Circle(2.3)
Circle(2.3)

julia> area(circle)  # call signature Tuple{Circle}
16.619025137490002

julia> square = Square(1.6)
Square(1.6)

julia> area(square)  # call signature Tuple{Square}
2.5600000000000005

julia> rectangle = Rectangle(1.4, 2.1)
Rectangle(1.4, 2.1)

julia> area(rectangle)  # call signature Tuple{Rectangle}
2.94
```

## Parametric methods

Method signatures can take dummy type values, in roughly the same way as parametric types.

The syntax is distinctive, requiring a `where` clause:

```julia-repl
julia> same_type(v::Vector{T}, x::T) where {T} = true
same_type (generic function with 1 method)

julia> same_type([1, 2], 3)
true

julia> same_type([1, 2], "three")
ERROR: MethodError: no method matching same_type(::Vector{Int64}, ::String)
```

The above example requires both arguments to use the same type `T`, whatever that is.

We can be more specific by putting a constraint on `T`:

```julia-repl
julia> same_type(v::Vector{T}, x::T) where {T<:Number} = true
same_type (generic function with 2 methods)
```

With this method, only identical numeric types return `true`.

Multiple dummy variables are possible, comma-separated in the `where` clause.

```julia-repl
julia> myfunc(a::S, b::T) where {S, T} = true
myfunc (generic function with 1 method)
```


## Conclusion

Multiple dispatch is very flexible and highly performant in Julia, so is used very widely.

As the example of 161 methods for `+` suggest, Julia programmers aim to define methods with narrowly-specified types. 
Adding two integers is very different to adding two floats at the bytecode level, and adding an integer to a float adds an addition complication of type promotion.

The more specific the type, the more optimization the compiler can do: of marginal importance in a toy exercise in Exercism, but vital for perfomance in the big numerical simulations that Julia is designed for.

_If you know what inputs a method will receive, please tell the compiler!_
