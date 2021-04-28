# Instructions

For a game of [Dungeons & Dragons][DND] (DND), each player starts by generating a character they can play with.
This character has, among other things, six abilities:

- strength,
- dexterity,
- constitution,
- intelligence,
- wisdom,
- charisma.

These six abilities have scores that are determined randomly.
You do this by rolling four 6-sided dice and record the sum of the largest three dice.
You do this six times, once for each ability.

Your character's initial hitpoints are 10 + your character's constitution modifier.
You find your character's constitution modifier by subtracting 10 from your character's constitution, divide by 2 and round down.

~~~~exercism/advanced
If you prefer mathematical notation, the modifier is defined as

$$

\operatorname{modifier}\left(\text{constitution}\right) = \left\lfloor\frac{\text{constitution} - 10}{2}\right\rfloor

$$

and the hitpoints are defined as

$$

\operatorname{HP}\left(\text{constitution}\right) = 10 + \operatorname{modifier}\left(\text{constitution}\right)

$$
~~~~

For example, the six throws of four dice may look like:

* 5, 3, 1, 6: You discard the 1 and sum 5 + 3 + 6 = 14, which you assign to strength.
* 3, 2, 5, 3: You discard the 2 and sum 3 + 5 + 3 = 11, which you assign to dexterity.
* 1, 1, 1, 1: You discard the 1 and sum 1 + 1 + 1 = 3, which you assign to constitution.
* 2, 1, 6, 6: You discard the 1 and sum 2 + 6 + 6 = 14, which you assign to intelligence.
* 3, 5, 3, 4: You discard the 3 and sum 5 + 3 + 4 = 12, which you assign to wisdom.
* 6, 6, 6, 6: You discard the 6 and sum 6 + 6 + 6 = 18, which you assign to charisma.

Because the constitution is 3, the constitution modifier is -4, and the hitpoints are 10 - 4 = 6.

## 1. Generate valid ability values

Implement a function `ability()` that returns the value of an ability based on the rules above.

```julia
julia> ability()
14
```

~~~~exercism/note
This exercise is not about random distributions, therefore you don't have to simulate four dice rolls.
You can use random values between 3 and 18 (inclusive) for the ability values, regardless of their distribution.
~~~~

## 2. Calculate the constitution modifier

Implement a function `modifier(ability)` that returns an ability modifier based on the value of `ability` according to the rules above.
The returned value must be an integer.

```julia
julia> modifier(17)
3
``` 

## 3. Write a random character generator that follows the rules above

Implement a `DNDCharacter` struct with three constructors:

| Constructor                                                                                    | Description                                                                       |
| ---------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------- |
| `DNDCharacter()`                                                                               | Create a character with randomly generated abilities.                             |
| `DNDCharacter(strength, dexterity, constitution, intelligence, wisdom, charisma, hitpoints)`   | Create a character with given abilities using **positional arguments**. |
| `DNDCharacter(; strength, dexterity, constitution, intelligence, wisdom, charisma, hitpoints)` | Create a character with given abilities using **keyword arguments**.    |

```julia
julia> DNDCharacter()
DNDCharacter(18, 17, 18, 17, 5, 10, 14)

julia> DNDCharacter(4, 12, 13, 18, 13, 7, 11)
DNDCharacter(4, 12, 13, 18, 13, 7, 11)

julia> DNDCharacter(
           strength = 4,
           dexterity = 12,
           constitution = 13,
           intelligence = 18,
           wisdom = 13,
           charisma = 7,
           hitpoints = 11
       )
DNDCharacter(4, 12, 13, 18, 13, 7, 11)
```

[DND]: https://en.wikipedia.org/wiki/Dungeons_%26_Dragons
