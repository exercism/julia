# Instructions

Josh is working on a new role-playing game and needs your help implementing some of the mechanics.

## 1. Define type unions

Define a type union of `String` and `Missing` named `StringOrMissing` which can be used in later code.
Define a type union of `Int64` and `Nothing` named `IntOrNothing` which can be used in later code.

## 2. Implement the Player composite type

The Player composite type should contain four fields, having type annotations and default values:
- The `name` can be a `String`, but has a default of `missing`
- The `level` is an `Int64`, with a default of `0`
- The `health` is an `Int64`, with a default of `100`
- The `mana` is an `IntOrNothing`, with a default of `nothing`
 
```julia-repl
julia> defaultplayer = Player()
Player(missing, 0, 100, nothing)

julia> wealthyplayer = Player(mana=100)
Player(missing, 0, 100, 100)

julia> greatplayer = Player(name="Guilian the Great", level=10)
Player("Guilian the Great", 10, 100, nothing)
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
The arguments need type annotations to make the signatures explicit.

The `increment` method for giving a title should take a `name` and a `health`.
If the name is `missing` or the health is `100` the title "The Great" is given as a name.
Otherwise the title " the Great" is added onto the name.
This `increment` function returns the new name.

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
- If the player's mana is `missing`, their mana should be set to `50`.
- Otherwise their mana should be increased by `100`.
This `increment` method returns the mana.

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

The `title` function should increment a player's name based on their level.

The `increment` helper function should be used depending on the level of the player.
- If the player has the maximum level `42`, the name should be passed to the `increment` function.
- Otherwise, no title is given and the player's name remains the same.

The `title` function returns the player's name.

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

If they are dead:
- The player should be revived with `100` health.
- The player's mana should be incremented with the `increment` function.
If they are alive:
- Nothing happens to the player

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
```
