# About

There are basically two types of loops:

1. Loop until a condition is satisfied.
2. Loop over the elements in a collection.

Both are [possible in Julia][loops], though the second may be more common.

## The `while` loop

For open-ended problems where the number of times round the loop is unknown in advance, Julia has the `while` loop.

The basic form is fairly simple:

```julia
while condition
    do_something()
end
```

In this case, the program will keep going round the loop until `condition` is no longer `true`.

Two ways to exit the loop early are available:

- A `break` causes the loop to exit, with execution continuing at the next line after the loop `end`.
- A `return x` stops execution of the current function, passing the return value `x` back to the caller.

With these options available, it can sometimes be convenient to create an "infinite" loop with `while true ... end`, then rely on finding a stopping condition within the loop body to trigger a `break` or `return`.

## Loop over a collection

The simplest illustration is to loop over a range.

If we want to do something 10 times:

```julia
for n in 1:10
    do_something(n)
end
```

If the current iteration fails to satisfy some condition, it is possible to skip immediately to the next iteration with a `continue`:

```julia
for n in 1:10
    if is_useless(n)
        continue
    end
    
    # we decided this iteration could be useful
    do_something_slow(n)
end
```

In a shorter form, the `if` block could be replaced by `is_useless(n) && continue`.

Many other collection types can be looped over: elements in an array, characters in a string, keys in a dictionary...

The requirement is that the collection must be `iterable`.
This will be explained in more detail in a later Concept, but in essence the collection must have a way to yield the next item when asked, plus a way to indicate the end is reached and there are no more items.

The examples so far loop over the range `1:10`, where the value is also the loop index.

More generally, the index may be needed and not just the value.
For this, the [`eachindex()`][eachindex] function is used, for example `for i in eachindex(my_array) ... end`.

## Comprehensions

Writing explicit loops tends to be less common in Julia than in many traditional languages, because there are various more concise options.

A particularly common situation is when we need to build a new vector from the elements of some other collection (vector, string, set ... there are many possibilities).

Anyone who likes list comprehensions in Python will be pleased to know that Julia can use [similar syntax][comprehensions].

The essence of this is to set up a very compact loop inside a vector.

The simplest syntax is of the form `result = [f(x) for x in some_collection]`.

With a traditional loop, that might be written:

```julia
result = []
for x in some_collection
    push!(result, f(x))
end
```

Optionally, a conditional can be added at the end, to select only matching elements in the collection:

```julia-repl
# multiples of 3
julia> [n^2 for n in 1:10 if n%3 == 0]
3-element Vector{Int64}:
  9
 36
 81

# letters beyond 'h' in the alphabet
julia> [uppercase(c) for c in "Julia" if c > 'h']
3-element Vector{Char}:
 'U': ASCII/Unicode U+0055 (category Lu: Letter, uppercase)
 'L': ASCII/Unicode U+004C (category Lu: Letter, uppercase)
 'I': ASCII/Unicode U+0049 (category Lu: Letter, uppercase)
```

The syntax is _similar_ to Python, but not _identical_.
There is some divergence for multiple variables and/or multi-dimensional arrays, so this topic will be covered in more detail in a later Concept.

## Other options

As a modern, mostly-functional language, Julia (of course) has a variety of ways to operate on collections, not just an explicit loop, or a compacted loop in a comprehension.

Later concepts will look at alternatives such as broadcasting and higher-order functions.

[loops]: https://docs.julialang.org/en/v1/manual/control-flow/#man-loops
[eachindex]: https://docs.julialang.org/en/v1/base/arrays/#Base.eachindex
[comprehensions]: https://docs.julialang.org/en/v1/manual/arrays/#man-comprehensions
