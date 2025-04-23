# Hints

## 1. Generate a random planet

- How does [`rand()`][rand] behave when given a collection-type argument?

## 2. Generate a random starship registry number

- Think about [`rand()`][rand] with an integer range.
- Remember string [interpolation][interpolation].

## 3. Generate a random stardate

- What does [`rand()`][rand] return when called with no argument?
- Think about scaling and shifting the raw result.

## 4. Generate a rounded stardate

- Read the Introduction, and see what it says about floating-point ranges.

## 5. Pick some random starships from a list.

- For randomness, the input list needs to be [shuffled][shuffle].
- For safety, it is better to create a shuffled copy, leaving the input unchanged (otherwise, the function would be mutating, and called `pick_starships!`)
- Slice off what you need from the resulting vector.

## 5a. Optional: other argument types.

- How does [`Random.shuffle()`][shuffle] handle other iterable types? Check the documentation and/or experiment with it.
  - The REPL, [Pluto.jl][pluto], or [Jupyter][jupyter] are all useful for this.
- If necessary, how do you convert an arbitrary iterable to a vector?

[rand]: https://docs.julialang.org/en/v1/stdlib/Random/#Random-generation-functions
[interpolation]: https://docs.julialang.org/en/v1/manual/strings/#string-interpolation
[shuffle]: https://docs.julialang.org/en/v1/stdlib/Random/#Random.shuffle
[pluto]: https://plutojl.org/
[jupyter]: https://github.com/JuliaLang/IJulia.jl
