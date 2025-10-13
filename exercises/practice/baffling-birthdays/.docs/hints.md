# Hints

- Input for `shared_birthday` can be a `String `or a `Date `type.
- Output for `random_birthdays` is `Vector{Date}`
- Number of trials in `estimate_probability_of_shared_birthday` should be at least 10,000, to get a reasonably accurate estimate of probability.
- Functionality that could be useful includes [isleapyear][isleapyear] and [monthday][monthday],
- The Learning Track has concept documentation that may be a useful introduction:
  - [Dates & Times][dates-times]
  - [Randomness][randomness]
  - [Function Composition][function-composition]
  - [Higer-Order Functions][hof]


[isleapyear]: https://docs.julialang.org/en/v1/stdlib/Dates/#Dates.isleapyear
[monthday]: https://docs.julialang.org/en/v1/stdlib/Dates/#Dates.monthday
[dates-times]: https://exercism.org/tracks/julia/concepts/dates-times
[randomness]: https://exercism.org/tracks/julia/concepts/randomness
[function-composition]: https://exercism.org/tracks/julia/concepts/function-composition
[hof]: https://exercism.org/tracks/julia/concepts/higher-order-functions
