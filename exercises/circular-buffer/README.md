# Circular Buffer

A circular buffer, cyclic buffer or ring buffer is a data structure that
uses a single, fixed-size buffer as if it were connected end-to-end.

A circular buffer first starts empty and of some predefined length. For
example, this is a 7-element buffer:

    [ ][ ][ ][ ][ ][ ][ ]

Assume that a 1 is written into the middle of the buffer (exact starting
location does not matter in a circular buffer):

    [ ][ ][ ][1][ ][ ][ ]

Then assume that two more elements are added — 2 & 3 — which get
appended after the 1:

    [ ][ ][ ][1][2][3][ ]

If two elements are then removed from the buffer, the oldest values
inside the buffer are removed. The two elements removed, in this case,
are 1 & 2, leaving the buffer with just a 3:

    [ ][ ][ ][ ][ ][3][ ]

If the buffer has 7 elements then it is completely full:

    [6][7][8][9][3][4][5]

When the buffer is full an error will be raised, alerting the client
that further writes are blocked until a slot becomes free.

When the buffer is full, the client can opt to overwrite the oldest
data with a forced write. In this case, two more elements — A & B —
are added and they overwrite the 3 & 4:

    [6][7][8][9][A][B][5]

3 & 4 have been replaced by A & B making 5 now the oldest data in the
buffer. Finally, if two elements are removed then what would be
returned is 5 & 6 yielding the buffer:

    [ ][7][8][9][A][B][ ]

Because there is space available, if the client again uses overwrite
to store C & D then the space where 5 & 6 were stored previously will
be used not the location of 7 & 8. 7 is still the oldest element and
the buffer is once again full.

    [D][7][8][9][A][B][C]

## Tasks

Define a parametric composite type `CircularBuffer{T}` that holds elements of type `T`, and
write a constructor
```julia
CircularBuffer{T}(capacity::Integer) where {T} -> CircularBuffer{T}
```
that creates an instance that can store up to `capacity` elements.

Extend the following functions from `Base` to work on `CircularBuffer`s:
- `Base.push!(cb::CircularBuffer, item; overwrite::Bool=false)`: Insert the element `item`
  to the end of `cb`, then return `cb`. If `cb` is already full, then throw a `BoundsError`
  if `overwrite` is `false` (the default value); otherwise remove the first element to make
  space for `item` if `overwrite` is `true`.
- `Base.popfirst!(cb::CircularBuffer)`: Remove and return the first element of `cb`.
- `Base.empty!(cb::CircularBuffer)`: Remove all elements from `cb`, then return the empty
  `cb`.

## Bonus tasks

This exercise is quite large and potentially complicated, and that makes it more challenging
and time-consuming to mentor. To help your mentor out, please don't submit code for the
bonus exercises until your mentor has reviewed your solution for the first part of the
exercise.

Extend your `CircularBuffer` to pass tests for `CircularBuffer` from the
[`DataStructures.jl` package](https://github.com/JuliaCollections/DataStructures.jl/). These
tests are included but disabled in the provided tests for this Exercism exercise; to enable
these tests, add the top-level line `enable_bonus_tests = true` to your file or notebook.

To pass these tests you need to declare `CircularBuffer` as a subtype of
`AbstractVector` and define two functions:
- `capacity(cb::CircularBuffer)`: Return the capacity of `cb`.
- `isfull(cb::CircularBuffer)`: Return `true` is `cb` is full.

Then you must ensure that the following functions from `Base` work correctly with
`CircularBuffer`s: `append!`, `empty!`, `pop!`, `pushfirst`, `setindex!`, `collect`,
`eltype`, `first`, `getindex`, `isempty`, `iterate`, `last`, `length`, and `size`.

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
[`@which`](https://docs.julialang.org/en/v1/stdlib/InteractiveUtils/#InteractiveUtils.@which)
macro to identify the specific method to which a function call is dispatched. It also shows
you the file and line number at which that method is defined (in a Jupyter Notebook through
IJulia, it even gives you a link to the relevant code on GitHub).

If you are working at the REPL, you may prefer to use the [`@edit`](https://docs.julialang.org/en/v1/stdlib/InteractiveUtils/#InteractiveUtils.@edit) macro to open the relevant file and line in your default text editor.

## Source

Wikipedia [http://en.wikipedia.org/wiki/Circular_buffer](http://en.wikipedia.org/wiki/Circular_buffer)

## Version compatibility
This exercise has been tested on Julia versions >=1.0.

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.
