# Hints

## 1. Calculate the success rate

- You need to translate the speed into a success rate, using the rules given in the instructions.
- The returned value is a floating-point number.
- Julia does not have the `select`/`case` syntax present in some other languages, but the Introduction discussed `if-else` syntax.

## 2. Calculate the production rate per hour

- The total theoretical production rate depends on the base production rate (a constant) and the speed.
- Return the actual production rate, which also depends on the success rate.

## 3. Calculate the number of working items produced per minute

- The hourly production rate was calculated in task 2.
- This task requires the rate per minute.
- Only complete, working cars are counted in this exercise, so you will need to remove part-complete cars from the count.
- The return value must be an integer (for example `7`, not `7.0`).
- The [Numbers][numbers] Concept already discussed ways to round values.

[numbers]: https://exercism.org/tracks/julia/concepts/numbers
