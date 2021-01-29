# Exercism Julia Track

![Exercise CI](https://github.com/exercism/julia/workflows/Exercise%20CI/badge.svg)
![Configlet](https://github.com/exercism/julia/workflows/Configlet/badge.svg)


Exercism exercises in Julia.

## v3: Track-specific tooling

### `make.jl`

Some files, like `.meta/config.json` contain redundant information for the Julia track.
Instead of manually updating these, `.meta/config.toml` and `make.jl` should be used.
Running `julia --project make.jl` will generate the `.meta/config.json` files based on the information given in `.meta/config.toml`.

`.meta/config.toml` will look like this for most exercises:

```toml
authors = [
    { github = "Foo", exercism = "Foo" },
]

contributors = [
    { github = "Bar", exercism = "Bar" },
]
```

If necessary, `forked_from` and `solution` keys can be used to specify the value of `forked_from` and overwrite the name of the solution file, e.g.:

```toml
forked_from = "javascript/boolean"
solution = "game.jl"
```

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
