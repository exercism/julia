# iterator-protocol

<!-- TODO: Motivate why iterators are useful -->
<!-- TODO: Add explanation why the Base.-prefix or import is necessary -->

To implement the informal iteration interface, you need to define two methods `iterate(iter::MyIter)` and `iterate(iter::MyIter, state)`.
Both methods must return a tuple of an item and the state of the iterator.
The first method will return the first item and state, while the second method will return the next item and state.
The iteration ends if `iterate` returns `nothing`.

~~~~exercism/note
Julia currently doesn't have a way to formally define interfaces.
To implement an interface, you need to look up which methods need to be defined in the Manual, or in the documentation of the package that "defines" the interface.
Alternatively, you can work your way through `MethodErrors` to find out which methods you need to implement:
<!-- TODO check if code blocks work within info boxes -->
```julia-repl
julia> struct MyIter end;

julia> for i in MyIter()
        println(i)
    end
ERROR: MethodError: no method matching iterate(::MyIter)
...
```
~~~~

~~~~exercism/note
The iterator object itself is usually not mutated by iteration.
~~~~

To make it clearer when the `iterate` methods are called, one can look at the translation of the `for`-loop syntax:

```julia
for item in iter
    println(item)
end
```

will be translated to

```julia
next_item = iterate(iter)

while !isnothing(next_item)
    (item, state) = next_item

    println(item)

    next_item = iterate(iter, state)
end
```

## Example

We want to define an iterator `Squares(n)` to iterate the sequence of [square numbers](https://en.wikipedia.org/wiki/Square_number) smaller than `n`. Square numbers are numbers that are the square of an integer. For example, 9 is a square number, since it can be written as `3 * 3`. The end result should look like:

```julia-repl
julia> for i in Squares(20)
           println(i)
       end
1
4
9
16
```

To do that we need to define a type `Squares` and two `iterate` methods.
We will have the `Squares` type remember `n` and the `state` will simply be the next number to square.

```julia
struct Squares
    n::Int
end

function Base.iterate(S::Squares, state)
    item = state^2
    if item < S.n
        return (item, state + 1)
    end
    return nothing
end

Base.iterate(S::Squares) = iterate(S, 1)
```

You may find it useful to combine these two definitions into one using optional arguments:

## Making use of optional arguments

In a [previous exercise](https://exercism.io/tracks/julia/exercises/high-score) you have learned how to define several methods at once by making use of optional arguments.

Recall that

```julia-repl
julia> f(a, b=1) = a + b
f (generic function with 2 methods)
```

is equivalent to

```julia-repl
julia> f(a, b) = a + b
f (generic function with 1 method)

julia> f(a) = f(a, 1)
f (generic function with 2 methods)
```

For some iterators, optional arguments can simplify your `iterate` method to a single definition.
This is particularly useful when the computation of the next item is identical regardless if it's the first or a consecutive iteration.
Some iterators may require a more extensive initialisation, in which case it can be better to split them into two separate definitions.

## Source

This entire section is based on the Julia Manual section on the [Iteration Interface](https://docs.julialang.org/en/v1/manual/interfaces/#man-interface-iteration)[^1].

[^1]: accessed November 10, 2020
