# Hints

## General

- The runtime of this exercise is highly dependent on the algorithm used, so plan for speed.
- The tests deliberately test for a big prime, and badly-designed solutions will time out.
- Julia code can often run faster if frequently-used lines are split to a separate function (which can optionally be nested within the main function).
  - Unlike some other languages, in Julia pre-compilation is more important than any function-call overhead.
- _Which values must be tested to ensure they are not factors, before declaring a number prime?_ Keep this group to a minimum!
