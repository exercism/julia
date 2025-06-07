# Instructions

Josh is working on a new role-playing game and needs your help implementing some of the mechanics.

## 1. Define type unions

Define a type union of `String` and `Missing` named `StringOrMissing` which can be used in later code.
Define a type union of `Int64` and `Nothing` named `IntOrNothing` which can be used in later code.

## 2. Implement the Player composite type

The Player composite type should contain four fields, each having a type annotation and a default value:
- The `name` is a `StringOrMissing`, with a default of `missing`
- The `level` is an `Int64`, with a default of `0`
- The `health` is an `Int64`, with a default of `100`
- The `mana` is an `IntOrNothing`, with a default of `nothing`

```julia-repl
julia> defaultplayer = Player()
Player(missing, 0, 100, nothing)

julia> wealthyplayer = Player(mana=100)
Player(missing, 0, 100, 100)

julia> namedplayer = Player(name="Guilian", level=10)
Player("Guilian", 10, 100, nothing)
```

## 3. Introduce yourself

Implement the `introduce` function.

Stealthy players may be hiding their name and will be introduced as `"Mighty Magician"`.
Otherwise, just use the player's name to introduce them.

```julia-repl
julia> introduce(Player(level=2, health=8))
"Mighty Magician"

julia> introduce(Player(name="Merlin", level=2, health=8))
"Merlin"
```

## 4. Implement increment methods

The `increment` helper function has two methods, each with a different function signature.
The argument of each needs a type annotation to make the signature explicit.

The `increment` method for names should take a player's `name`.
- If the name is `missing` return the title "The Great".
- Otherwise the title " the Great" is added onto the name.

This `increment` method returns the new name.

```julia-repl
julia> player1 = Player(name="Ogre", level=5, health=49, mana=26)
Player("Ogre", 5, 49, 26)

julia> increment(player1.name)
"Ogre the Great"

julia> player2 = Player(level=32, mana=57)
Player(missing, 32, 100, 57)

julia> increment(player2.name)
"The Great"
```

The `increment` method for mana should take a player's `mana`.
- If the player's mana is `missing`, return a value of `50`.
- Otherwise the mana should be increased by `100`.

This `increment` method returns the updated mana.

```julia-repl
julia> player3 = Player(level=3)
Player(missing, 3, 100, nothing)

julia> increment(player3.mana)
50

julia> player4 = Player("Goblin", level=15, health=49, mana=26)
Player("Goblin", 5, 49, 26)

julia> increment(player4.mana)
126
```

## 5. Implement the title function

The highest level in the game is `42`.  To recognize the accomplishment of players who achieve this level, a title is attached to their names.  The `title` function updates a player's name as follows.

- If the player's level is 42, the name is updated using the `increment` function.
- Otherwise, the name remains unchanged.

In either case, the `title` function returns the player's name.

```julia-repl
julia> player1 = Player(level=42, health=12)
Player(missing, 42, 12, nothing)

julia> title(player1)
"The Great"

julia> player2 = Player(name="Svengali", level=42, health=36, mana=54)
Player("Svengali", 42, 36, 54)

julia> title(player2)
"Svengali the Great"

julia> player3 = Player(name="Rasputin", level=21, health=100, mana=54)
Player("Rasputin", 21, 100, 54)

julia> title(player3)
"Rasputin"
```

## 6. Implement the revive function

The `revive` function should check that the player's character is indeed dead (their health has reached `0`).

If the player is dead:
- The player should be revived with `100` health.
- The player's mana should be incremented using the `increment` function.

If the player is  alive, nothing happens to the player

The `revive` function should return the player.

```julia-repl
julia> deadplayer1 = Player(level=2, health=0)
Player(missing, 2, 0, nothing)

julia> revive(deadplayer1)
Player(missing, 2, 100, 50)

julia> deadplayer2 = Player(level=12, health=0, mana=5)
Player(missing, 12, 0, 5)

julia> revive(deadplayer2)
Player(missing, 12, 100, 105)

julia> aliveplayer = Player(level=23, health=1)
Player(missing, 23, 1, nothing)

julia> revive(aliveplayer)
Player(missing, 23, 1, nothing)
```
