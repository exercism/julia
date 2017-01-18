# Exercism Julia Track

Exercism exercises in Julia.

## TODO

_Document how to contribute to the Julia track._

## Contributing Guide

Please see the [contributing guide](https://github.com/exercism/x-common/blob/master/CONTRIBUTING.md).

## Working on the Exercises

A pool of exercises can be found in the [x-Common repo](https://github.com/exercism/x-common).

Exercises for the Julia track go in the `exercises` directory and should follow the following filename conventions:

`exercises/<slug>/<slug>.jl` Skeleton for the function that is called by the test suite. Provide (abstract) parameter and return types to ensure compatibility with the test suite.

`exercises/<slug>/runtests.jl` Test suite for the exercise. Group related tests using [testsets](http://docs.julialang.org/en/release-0.5/stdlib/test/#working-with-test-sets).

`exercises/<slug>/example.jl` Example solution for the exercise. It should follow the [Julia Style Guide](http://docs.julialang.org/en/release-0.5/manual/style-guide/).

Replace `<slug>` with the exercise slug of the exercise you're working on.

See [Issue #2](https://github.com/exercism/xjulia/issues/2) for discussion on the structure.

### Testing the example solutions
Test your example solutions by running `julia runtests.jl` in the project directory. Specify exercise slugs as arguments to run only certain exercises: `julia runtests.jl <slug>`.
