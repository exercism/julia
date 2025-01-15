# Instructions

In this exercise you're going to write some code to help you cook a brilliant lasagna from your favorite cooking book.

You have four tasks, all related to the time spent cooking the lasagna.

## 1. Store the expected bake time in a constant

Define the `expected_bake_time` constant that returns how many minutes the lasagna should bake in the oven.

According to the cooking book, lasagna needs to be in the oven for a total of 60 minutes.

```julia-repl
julia> expected_bake_time
60
```

## 2. Calculate the preparation time in minutes

Define the `preparation_time` function that takes the number of layers you added to the lasagna as an argument and returns how many minutes you spent preparing the lasagna, assuming each layer takes you 2 minutes to prepare.

```julia-repl
julia> preparation_time(4)
8
```

## 3. Calculate the remaining oven time in minutes

Define the `remaining_time` function that takes the actual minutes the lasagna has been in the oven as a parameter and returns how many minutes the lasagna still has to remain in the oven.

```julia-repl
julia> remaining_time(50)
10
```

## 4. Calculate the total working time in minutes

Define the `total_working_time` function that takes two arguments: the first argument is the number of layers you added to the lasagna, and the second argument is the number of minutes the lasagna has been in the oven.

The function should return how many minutes in total you've worked on cooking the lasagna, which is the sum of the preparation time in minutes, and the time in minutes the lasagna has spent in the oven at the moment.

```julia-repl
julia> total_working_time(3, 20)
26
```
