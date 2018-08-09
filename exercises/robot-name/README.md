# Robot Name

Manage robot factory settings.

When robots come off the factory floor, they have no name.

The first time you boot them up, a random name is generated in the format
of two uppercase letters followed by three digits, such as RX837 or BC811.

Every once in a while we need to reset a robot to its factory settings,
which means that their name gets wiped. The next time you ask, it will
respond with a new random name.

The names must be random: they should not follow a predictable sequence.
Random names means a risk of collisions. Your solution must ensure that
every existing robot has a unique name.

This exercise introduces work with Julia's [type system](http://docs.julialang.org/en/stable/manual/types/)
and random [numbers](http://docs.julialang.org/en/stable/stdlib/numbers/).

Let's create a structure that will describe our robots
and then use it to create new instances and to work with them.

Generate the robot's name using randomness and don't worry about
collisions, tests sometimes will fail and that's alright.

Resetting the robot to the factory settings is like a surgery,
so we declare a method that will reset the robot's settings.
Take a note that skeleton method reset! has an exclamation mark suffix
meaning that the method changes given argument's contents.

Futhermore, experiment with testing and check out the situations when
there are lots of collisions (like when you generate name one thousand times).


## Source

A debugging session with Paul Blackwell at gSchool. [http://gschool.it](http://gschool.it)


## Version compatibility
Julia 1.0 and 0.7 are the only supported Julia versions on Exercism.
For the most part, the test suites and solutions should be compatible to 0.6, but you will have to change `using Test` back to `using Base.Test` in the `runtests.jl` file.
Note that 0.7 and 1.0 are almost identical, except for deprecation warnings, which have all been removed in 1.0.

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.
