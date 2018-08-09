# Custom Set

Create a custom set type.

Sometimes it is necessary to define a custom data structure of some
type, like a set. In this exercise you will define your own set. How it
works internally doesn't matter, as long as it behaves like a set of
unique elements.

The tests require a constructor that takes an array. The internals of your custom set implementation can use other data structures but you may have to implement an outer constructor that takes exactly one array for the tests to pass.

Certain methods have a unicode operator equivalent. E.g. `intersect(CustomSet([1, 2, 3, 4]), CustomSet([]))` is equivalent to `CustomSet([1, 2, 3, 4]) ∩ CustomSet([])`.



## Version compatibility
Julia 1.0 and 0.7 are the only supported Julia versions on Exercism.
For the most part, the test suites and solutions should be compatible to 0.6, but you will have to change `using Test` back to `using Base.Test` in the `runtests.jl` file.
Note that 0.7 and 1.0 are almost identical, except for deprecation warnings, which have all been removed in 1.0.

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.
