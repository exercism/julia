# Accumulate


Implement the `accumulate` operation, which, given a collection and an
operation to perform on each element of the collection, returns a new
collection containing the result of applying that operation to each element of
the input collection.

Given the collection of numbers:

- 1, 2, 3, 4, 5

And the operation:

- square a number (`x => x * x`)

Your code should be able to produce the collection of squares:

- 1, 4, 9, 16, 25

Check out the test suite to see the expected function signature. Note that in this exercise, the tests are written so you can pass in a raw operator. This means it does not have to be a string when it's passed in and can instead come in as just `*`. 

## Restrictions

Julia provides very powerful broadcasting abilities. This allows you to solve a problem of
this nature with easy compared to other languages. Feel free to use the broadcasting
ability in Julia or do it the hard way using a loop.  

You can use `collect(1:10)` as a quick way to create a collection but remember that
under the hood, collection returns an array so you can also just make an array
explicitly by doing `my_array = [1, 2, 3, 4, 5]`. 

## Source

Conversation with James Edward Gray II [https://twitter.com/jeg2](https://twitter.com/jeg2)

## Version compatibility
This exercise has been tested on Julia versions >=1.0.

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.
