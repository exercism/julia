## Tasks

Define a parametric composite type `CircularBuffer{T}` that holds elements of type `T`, and
write a constructor
```julia
CircularBuffer{T}(capacity::Integer) where {T} -> CircularBuffer{T}
```
that creates an instance that can store up to `capacity` elements.

Extend the following functions from `Base` to work on `CircularBuffer`s:
- `Base.push!(cb::CircularBuffer, item; overwrite::Bool=false)`: Insert the element `item`
  to the end of `cb`, then return `cb`. If `cb` is already full, then throw a `BoundsErrors`
  if `overwrite` is `false` (the default value); otherwise remove the first element to make
  space for `item` if `overwrite` is `true`.
- `Base.popfirst!(cb::CircularBuffer)`: Remove and return the first element of `cb`.
- `Base.empty!(cb::CircularBuffer)`: Remove all elements from `cb`, then return the empty
  `cb`.

## Bonus tasks

Extend your `CircularBuffer` to pass all tests for both `CircularBuffer` and `CircularDeque`
from the `DataStructures.jl` package. These tests are included but disabled in the provided
tests for this Exercism exercise; to enable these tests, simply add the top-level line
```julia
enable_bonus_tests = true
```
anywhere in your file or notebook.

Concretely, to pass the tests you first need to declare `CircularBuffer` as a subtype of
`AbstractVector` and define two functions:
- `capacity(cb::CircularBuffer)`: Return the capacity of `cb`.
- `isfull(cb::CircularBuffer)`: Return `true` is `cb` is full.

Then you must ensure that the following functions from `Base` work correctly with
`CircularBuffer`s:
```julia
Base.append!
Base.empty!
Base.pop!
Base.pushfirst!
Base.setindex!
Base.collect
Base.eltype
Base.first
Base.getindex
Base.isempty
Base.iterate
Base.last
Base.length
Base.size
```

Hint: You don't need to—and should not—extend all of these functions! By defining
`CircularBuffer` to be a subtype of `AbstractVector`, generic functions that were defined
for `AbstractVector` will now accept `CircularBuffer` as input. See the section on
[interfaces](https://docs.julialang.org/en/v1/manual/interfaces/#man-interface-array-1) in
the Julia manual:
> A lot of the power and extensibility in Julia comes from a collection of informal
> interfaces. By extending a few specific methods to work for a custom type, objects of that
> type not only receive those functionalities, but they are also able to be used in other
> methods that are written to generically build upon those behaviors.

You will have to look through the source code for Julia's
[`Base`](https://github.com/JuliaLang/julia/tree/master/base) module to see function
definitions and figure out which ones to extend. To locate the relevant code for a function
call, you can use the
[@which](https://docs.julialang.org/en/v1/stdlib/InteractiveUtils/#InteractiveUtils.@which)
macro to identify the specific method to which a function call is dispatched. It also shows
you the file and line number at which that method is defined (in a Jupyter Notebook through
IJulia, it even gives you a link to the relevant code on GitHub).
