# Exercism Julia Track

![Exercise CI](https://github.com/exercism/julia/workflows/Exercise%20CI/badge.svg)
![Configlet](https://github.com/exercism/julia/workflows/Configlet/badge.svg)


Exercism exercises in Julia.

## Contributing Guide

Please see the [contributing guide](CONTRIBUTING.md).

Please read and adhere to the [Code of Conduct](CODE_OF_CONDUCT.md).

## Code Formatting Guidelines
Your example solutions should adhere to the following guidelines:
- 4 spaces per indentation level, no tabs
- use whitespace to make the code more readable
- no whitespace at the end of a line (trailing whitespace)
- comments are good, especially when they explain the algorithm
- use upper camel case convention for type names
- use lower case for method names, add underscores if necessary

These are based on the [General Formatting Guidelines](https://github.com/JuliaLang/julia/blob/master/CONTRIBUTING.md#general-formatting-guidelines-for-julia-code-contributions) for contributions to the Julia codebase.

## Exercise Formatting Guidelines

### stub.jl
The solution file `stub.jl` takes the exercise name by defaul, in kebab case if necessary (e.g. `exercise-name.jl`).
- The content of `concept exercise` stubs have function skeletons by defalut, (some of) which can be omitted if the exercise emphasizes manual coding of new concepts.
- The content of `practice exercise` stubs is left to the discretion of the author.

When function skeletons are provided, they should include a blank new line with a four space indentation for the body.

```julia
function fun1(arg1)

end

function fun2(arg2, arg3)
    
end
```

### runtests.jl
*Every* `runtests.jl` file should have the following skeleton:

```julia
using Test

include("stub.jl")

@testset verbose = true "tests" begin
    
    # Exercise specific testing: @testset / @test

end
```
Where the `"tests"` testset is a *verbose* wrapper for *non-verbose* exercise specific testing (used for formatting testing output).
In other words, all (exercise specific) inner `testset` should omit `verbose = true` (e.g. first line: `@testset "testset name" begin`).

If helper files are needed for testing or boilerplate, place them in the same top-level folder as `runtests.jl` and explicitly `include` them in `runtests.jl`:
```julia
using Test

include("stub.jl")
include("testtools.jl")
include("boilerplate.jl")

@testset verbose = true "tests" begin
    
    # Exercise specific testing: @testset / @test

end
```
**Note**: Students will not need to `import`/`include` any boilerplate for use in `stub.jl`, but this can be encouraged for instructional purposes if desired.
Likewise, `.meta/example.jl` or `.meta/exemplar.jl` does not need to `import`/`include` any boilerplate.

### config.json
If helper files are needed, `.meta/config.json` should then take an entry under the `"files"` property.
1. If the file is meant to be visible to the student (e.g. [Alphametics](https://github.com/exercism/julia/tree/main/exercises/practice/alphametics)), use `editor`:
```json
  "files": {
    "solution": [
      "stub.jl"
    ],
    "test": [
      "runtests.jl"
    ],
    "example": [
      ".meta/example.jl"
    ],
    "editor": [
      "boilerplate.jl"
    ]
  },
```
2. If the file is *not* meant to be visible to the student (e.g. [Cater Waiter](https://github.com/exercism/julia/tree/main/exercises/concept/cater-waiter)), use `auxiliary`:
```json
  "files": {
    "solution": [
      "stub.jl"
    ],
    "test": [
      "runtests.jl"
    ],
    "example": [
      ".meta/example.jl"
    ],
    "auxiliary": [
      "testtools.jl"
    ]
  },
```
