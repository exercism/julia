# Instructions

In this exercise, you are going to do a bit of data engineering by preprocessing some grading data.
A school with many, many, many (too many?) students is trying to do some data analysis on the grades received by students and is looking to do so efficiently, so the idea is to minimize and organize the data.

The grading scale is usually from 0-10, so it is most efficient to use a data type with only eight bits per grade.
With that in mind, some professors use real numbers (as they are sticklers for precision), and you will need to convert these to the `UInt8` data type.
Other professors use integers with negative numbers (to punish especially unruly students), and you will need to convert these to the `Int8` data type in these situations.

Once you have implemented the function to convert the grades, you will need to write another to handle the collections that they are held in by demoting the grades and returning them in descending order.

Some professors use `Vector`s sorted in ascending order to store their grades because they are meticulous about their data.
Since sorting would be unnecessary and more expensive, you should only worry about reversing the order of the vector.
Other professors are a bit lazier and use `Set`s to store their grades, so you will have to deal with sorting.

In both functions, you will need to handle invlalid inputs by returning a string alerting the user of the error.

## 1. Demote the grades

Implement the `demote` method.
With a `Float64` input, it should round up to the nearest whole number and return a `UInt8` data type.
With an arbitrary `Integer`, it should return the same integer in a `Int8` data type.
All other inputs should return the string `"MethodError: no method matching preprocess(::T)", where `T` is the type that has been passed as input.

## 2. Preprocess the data

Implement the `preprocess` method.
With a `Vector` input, it should demote all the numbers and reverse the vector.
With a `Set` input, it should demote all the numbers and return a sorted vector in descending order.
All other inputs should return the string `"MethodError: no method matching preprocess(::T)", where `T` is the type that has been passed as input.
