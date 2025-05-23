# Hints

## 1. Define custom types

Abstract types and type inheritance were discussed in the [Composite Types][composite] Concept.

## 2. Get the name of the pet.

- This is trivial for Dogs and Cats, but helpful to the tests for fallback methods.

## 3. Define what happens when cats and dogs meet

- How many combinations for cat/dog encounters are there?
- Remember that a cat meeting a dog reacts differently to a dog meeting a cat.
- We need the response of the first argument: `a` in `meet(a, b)`.

## 4. Define an encounter between two entities.

- The return value is a longer string than for `meet()`.
- Only use a single method for `encounter()`.
- [String interpolation][interpolation] is your friend when assembling a return value.

## 5. Define a fallback reaction for encounters between pets

- The second argument is now a `Pet` other than `Cat` or `Dog`, so add a `meet` method.

## 6. Define a fallback if a pet encounters something it doesn't know

- The second argument can now be anything.

## 7. Define a generic fallback

- Both arguments can now be anything.
- At the end of the exercise, you will have 7 methods for `meet`.

[composite]: https://exercism.org/tracks/julia/concepts/composite-types
[interpolation]: https://docs.julialang.org/en/v1/manual/strings/#string-interpolation
