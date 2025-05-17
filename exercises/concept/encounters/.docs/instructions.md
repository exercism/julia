# Instructions

In this exercise you will be implementing a simulation of encounters.
This will familiarise you with the basics of multiple dispatch, Julia's main paradigm.

~~~~exercism-important
For this exercise, all function definitions should be a single-line declaration with no if/else logic.
~~~~

In general, encounters involve one entity `a` meeting another entity `b` and reacting to it.

```julia
encounter(a, b) = "$(name(a)) meets $(name(b)) and $(meets(a, b))."
```

At first, we will simulate what happens when cats and dogs meet.

## 1. Define custom types

First add an abstract type `Pet`.

Then define types `Cat` and `Dog` as subtypes of `Pet`.
Each has a single field `name`.

## 2. Get the name of the pet.

Implement a function `name()` which returns the name of a pet.

```julia-repl
julia> fido = Dog("Fido")
Dog("Fido")

julia> name(fido)
"Fido"
```

## 3. Define what happens when cats and dogs meet

Implement `meets()` methods for the following encounters:

- When two dogs meet, they **sniff** each other.
- When a cat meets a dog, it **hisses** at the dog.
- When a dog meets a cat, it **chases** the cat.
- When two cats meet, they **slink**.

```julia-repl
julia> ginger = Cat("Ginger")
Cat("Ginger")

julia> meets(ginger, fido)
"hisses"
```

## 4. Define an encounter between two entities.

Implement the `encounter()` function with one method, to report what happens when two named entities meet.

```julia-repl
julia> encounter(ginger, fido)
"Ginger meets Fido and hisses."
```

## 5. Define a fallback reaction for encounters between pets

What happens if they encounter a different pet on their walk, like a [horse](https://www.dw.com/en/horse-takes-daily-stroll-through-frankfurt-without-owner/a-47833431)?

- If a pet meets another pet that it doesn't recognize, it **is cautious**.

```julia-repl
julia> bella = Horse("Bella")
Horse("Bella")

julia> encounter(fido, bella)
"Fido meets Bella and is cautious."
```

## 6. Define a fallback if a pet encounters something it doesn't know

There are many other things that pets may encounter that aren't pets: cars, humans, plants, natural disasters, asteroids… What happens then?

- If a pet meets something it has never seen before, it **runs away**.

```julia-repl
julia> colnago = Bicycle("Colnago")
Bicycle("Colnago")

julia> encounter(ginger, colnago)
"Ginger meets Colnago and runs away."
```

## 7. Define a generic fallback

There are many other encounters that could occur in our simulation.
A car meets a dog, two electrons encounter each other and interact…

It is impossible to cover all encounters in advance, therefore we will implement a generic fallback.

- If two unknown things or beings encounter each other, **nothing happens**.

```julia-repl
julia> γ1 = Photon("γ1")
Photon("γ1")

julia> γ2 = Photon("γ2")
Photon("γ2")

julia> encounter(γ1, γ2)
"γ1 meets γ2 and nothing happens." 
# This is true, photons just pass through each other.
```
