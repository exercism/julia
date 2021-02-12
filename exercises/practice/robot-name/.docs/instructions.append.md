# Instructions append

The test suite only generates ~100 names by default.
There are ~700k valid names, so it will only give a small chance of collisions.
Consider testing your solution for collisions in some other way in addition to the test suite.

This exercise continues our exploration of Julia's
[type system](https://docs.julialang.org/en/v1/manual/types/),
this time with mutable types,
and introduces us to
[random number generation](https://docs.julialang.org/en/v1/stdlib/Random/).

We will imagine that resetting the robot to the factory settings is like a surgery: it makes changes to the subject, but doesn't replace it.
We could also have modeled the problem such that resetting a robot creates a new robot, but not every problem can be modeled solely with immutable data structures (even purely functional languages deal with mutability inside their runtimes!).

In Julia, functions that mutate their arguments have a suffix `!` by convention.
So our method for doing this will be called `reset!`.

This is only a convention, but almost all published Julia code follows it and you might come to agree that it's quite helpful!

## Hints

You will need to define
a method for generating unique names,
a structure to describe robots,
a method for resetting a robot,
and a method for getting the name of a robot.

You might find it helpful to design your program first to just emit a random name for a robot (without worrying about collisions) and then later to think about and design a scheme that will avoid ever issuing duplicate names.
In your design, be thoughtful about how the run time of name generation changes as names run out. What guarantees do you want to offer the caller?
