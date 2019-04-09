# Exercism Julia Track

[![Build Status](https://travis-ci.org/exercism/julia.svg?branch=master)](https://travis-ci.org/exercism/julia)

Exercism exercises in Julia.

## Contributing Guide

Please see the [contributing guide](https://github.com/exercism/docs/blob/master/contributing-to-language-tracks/README.md).

## Working on the Exercises

### Implementing an exercise

A pool of exercises can be found in the [problem-specifications repo](https://github.com/exercism/problem-specifications).

Exercises for the Julia track go in the `exercises` directory and should follow the following filename conventions:

`exercises/<slug>/<slug>.jl` Skeleton for the function that is called by the test suite. If necessary, provide (abstract) parameter and return types.

`exercises/<slug>/runtests.jl` Test suite for the exercise. Group related tests using [testsets](http://docs.julialang.org/en/release-0.5/stdlib/test/#working-with-test-sets).

`exercises/<slug>/example.jl` Example solution for the exercise. It should follow the [Julia Style Guide](http://docs.julialang.org/en/release-0.5/manual/style-guide/) and the code formatting guidelines specified [below](#code-formatting-guidelines).

Replace `<slug>` with the exercise slug of the exercise you're working on.

See [Issue #2](https://github.com/exercism/julia/issues/2) for discussion on the structure and style guidelines.

### Adding the README
If you are porting an existing exercise, you need to generate the exercise `README.md` using the configlet. The process is described here: https://github.com/exercism/docs/blob/master/maintaining-a-track/regenerating-exercise-readmes.md

### Adding it to config

Make sure to add the exercise to the `config.json` file, by adding an entry to the `exercises` array:
```json
"exercises": [
  {
    "uuid": "a668410d-41aa-4710-a68f-54521da6486d",
    "slug": "hello-world",
    "core": true,
    "unlocked_by": null,
    "difficulty": 1,
    "topics": [
      "strings"
    ]
  },
]
```
If possible, add info on which topics the exercise is about and estimate a difficulty level from 1 to 10. We can adjust these later on when we know more about the exercises and how users solve them.

You can generate the uuid with the [configlet](https://github.com/exercism/configlet). It can be installed easily by running `bin/fetch-configlet`. Simply run `configlet uuid` to generate an exercise uuid.

By default, you can leave `"core": false` and `"unlocked_by: null"`. We can discuss in the PR where the exercise should be added to the progression.

### Testing the example solutions
Test your example solutions by running `julia runtests.jl` in the project directory. Specify exercise slugs as arguments to run only certain exercises: `julia runtests.jl <slug>`.

## Code Formatting Guidelines
Your example solutions should adhere to the following guidelines:
- 4 spaces per indentation level, no tabs
- use whitespace to make the code more readable
- no whitespace at the end of a line (trailing whitespace)
- comments are good, especially when they explain the algorithm
- try to adhere to a 92 character line length limit
- use upper camel case convention for type names
- use lower case with underscores for method names
- it is generally preferred to use ASCII operators and identifiers over Unicode equivalents whenever possible

These are based on the [General Formatting Guidelines](https://github.com/JuliaLang/julia/blob/master/CONTRIBUTING.md#general-formatting-guidelines-for-julia-code-contributions) for contributions to the Julia codebase.
