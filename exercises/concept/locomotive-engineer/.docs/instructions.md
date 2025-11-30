# Instructions

Your friend Linus is a Locomotive Engineer who drives cargo trains between cities.
Although he is amazing at handling trains, he is not amazing at handling logistics or computers.
He would like to enlist your programming help organizing train details and correcting mistakes in route data.

~~~~exercism/note
This exercise could easily be solved using slicing, indexing, and various `Dict` methods.
However, we would like you to practice packing, unpacking, and multiple assignment in solving each of the tasks below.
~~~~

## 1. Create a vector of all wagons

Your friend has been keeping track of each wagon identifier (ID), but he is never sure how many wagons the system is going to have to process at any given time. It would be much easier for the rest of the logistics program to have this data packaged into a unified `vector`.

Implement a function `get_vector_of_wagons(args...)` that accepts an arbitrary number of wagon IDs.
Each ID will be a positive integer.
The function should then `return` the given IDs as a single `vector`.

```julia-repl
julia> get_vector_of_wagons(1, 7, 12, 3, 14, 8, 5)
7-element Vector{Int64}:
  1
  7
 12
  3
 14
  8
  5
```

## 2. Fix the vector of wagons

At this point, you are starting to get a feel for the data and how it's used in the logistics program.
The ID system always assigns the locomotive an ID of **1**, with the remainder of the wagons in the train assigned a randomly chosen ID greater than **1**.

Your friend had to connect two new wagons to the train and forgot to update the system!
Now, the first two wagons in the train `vector` have to be moved to the end, or everything will be out of order.

To make matters more complicated, your friend just uncovered a second `vector` that appears to contain missing wagon IDs.
All they can remember is that once the new wagons are moved, the IDs from this second `vector` should be placed directly after the designated locomotive.

Linus would be really grateful to you for fixing their mistakes and consolidating the data.

Implement a function `fix_vector_of_wagons(each_wagons_id, missing_wagons)` that takes two `vectors` containing wagon IDs.
It should reposition the first two items of the first `vector` to the end, and insert the values from the second `vector` behind (_on the right hand side of_) the locomotive ID (**1**).
The function should then `return` a `vector` with the modifications.

```julia-repl
julia> fix_vector_of_wagons([2, 5, 1, 7, 4, 12, 6, 3, 13], [3, 17, 6, 15])
13-element Vector{Int64}:
  1
  3
 17
  6
 15
  7
  4
 12
  6
  3
 13
  2
  5
```

## 3. Add missing stops

Now that all the wagon data is correct, Linus would like you to update the system's routing information.
Along a transport route, a train might make stops at a few different stations to pick up and/or drop off cargo.
Each journey could have a different number of these intermediary delivery points.
Your friend would like you to update the system's routing `Dict` with any missing/additional delivery information.

Implement a function `add_missing_stops(route, stops...)` that accepts a routing `Dict` followed by a variable number of `stop_number => city` Pairs.
Your function should then return the routing `Dict` updated with an additional `key` that holds a `vector` of all the added stops in order.

```julia-repl
julia> add_missing_stops(Dict("from" => "New York", "to" => "Miami"), :stop_1 => "Washington, DC", :stop_2 => "Charlotte", :stop_3 => "Atlanta", :stop_4 => "Jacksonville")
Dict{String, Any} with 3 entries:
  "stops" => ["Washington, DC", "Charlotte", "Atlanta", "Jacksonville"]
  "to"    => "Miami"
  "from"  => "New York"
```

## 4. Extend routing information

Linus has been working on the routing program and has noticed that certain routes are missing some important details.
Initial route information has been constructed as a `Dict` and your friend would like you to update that `Dict` with whatever might be missing.
Every route in the system requires slightly different details, so Linus would really prefer a generic solution.

Implement a function called `extend_route_information(route; more_route_information...)` that accepts a `Dict` which contains the origin and destination cities the train route runs between, plus a variable number of keyword arguments containing routing details such as train speed, length, or temperature.
The function should return a consolidated `Dict` with all routing information.

```julia-repl
julia> extend_route_information(Dict("from" => "Berlin", "to" => "Hamburg"); length = "100", speed = "50")
Dict{Any, String} with 5 entries:
  :temperature   => "20"
  :timeOfArrival => "10:30"
  "to"           => "London"
  "from"         => "Paris"
  :length        => "15"


julia> extend_route_information(Dict("from" => "Berlin", "to" => "Hamburg"), length = "100", speed = "50")
Dict{Any, String} with 5 entries:
  :temperature   => "20"
  :timeOfArrival => "10:30"
  "to"           => "London"
  "from"         => "Paris"
  :length        => "15"
```
