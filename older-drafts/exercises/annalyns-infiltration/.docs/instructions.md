# Instructions

In this exercise, you'll be writing some logic for a video game a friend is developing. The game's main character is Annalyn, a brave girl with a fierce and loyal pet dog. Unfortunately, disaster strikes, as her best friend Nóra is kidnapped while searching for berries in the forest. Annalyn will try to find and free Nóra, optionally taking her dog with her on this quest.

Annalyn eventually finds the camp in which Nóra is imprisoned and it turns out there are two kidnappers: a mighty knight and a cunning archer.
The player is presented with some options for what to do next.
For each of the four possible options you need to write a function that tells the game whether it should show that option or not.

## 1. Check if the 'Fast Attack' option should be shown

If the knight is sleeping, then Annalyn will be able to make a quick attack into the camp before he can wake up properly and get his armour on.

Implement a function named `can_do_fast_attack` that takes a boolean value which indicates if the knight is awake. This function returns `true` if the 'Fast Attack' action is available based on the state of the character. Otherwise, returns `false`:

```julia-repl
julia> knight_awake = true;

julia> can_do_fast_attack(knight_awake)
false
```

<!-- _Note: A trailing semicolon suppresses the output of an expression in the top level of the REPL or other interactive contexts (such as Jupyter notebook cells). The output of an expression is only printed by default in the top level of the REPL, not within functions, scripts or other files._ (unlike what you may expect if you've used Matlab in the past)._ TODO: Move this to the exercise where the semicolon is first used in examples. Somehow show the Matlab hint only to students who have used Matlab before, when that'll be possible.-->

## 2. Check if the 'Spy' option should be shown

The group can be spied upon if at least one of them is awake. Otherwise, spying is a waste of time.

Implement a function named `can_spy` that takes three boolean values, indicating if the knight, archer and Nóra, respectively, are awake. The function returns `true` if the 'Spy' action is available based on the state of the characters. Otherwise, returns `false`:

```julia-repl
julia> knight_awake = false; archer_awake = true; nóra_awake = false;

julia> can_spy(knight_awake, archer_awake, nóra_awake)
true
```

## 3. Check if the 'Signal Prisoner' option should be shown

Nóra can be signalled using bird sounds if she is awake and the archer is sleeping. If the archer is awake then Nóra can't be safely signaled because the archer is also trained in bird signalling!

Implement a function named `can_signal_prisoner` that takes two boolean values, indicating if the archer and Nóra, respectively, are awake. The function returns `true` if the 'Signal Prisoner' action is available based on the state of the characters. Otherwise, returns `false`:

```julia-repl
julia> archer_awake = false; nóra_awake = true;

julia> can_signal_prisoner(archer_awake, nóra_awake)
true
```

## 4. Check if the 'Free Prisoner' option should be shown

Annalyn can try sneaking into the camp to free Nóra. This is a risky thing to do and can only succeed in one of two ways:
  - If Annalyn has her pet dog with her she can rescue Nóra if the archer is asleep.
    The knight is scared of the dog and the archer will not have time to get ready before Annalyn and Nóra can escape.
  - If Annalyn does not have her dog then she and Nóra must be very sneaky!
    Annalyn can free Nóra if they are awake and the knight and archer are both sleeping, but if Nóra is sleeping they can't be rescued: they would be startled by Annalyn's sudden appearance and wake up the knight and archer.

Implement a function named `can_free_prisoner` that takes four boolean values. The first three parameters indicate if the knight, archer and Nóra, respectively, are awake. The last parameter indicates if Annalyn's pet dog is present. The function returns `true` if the 'Free Prisoner' action is available based on the state of the characters. Otherwise, it returns `false`:

```julia-repl
julia> knight_awake = false; archer_awake = true; nóra_awake = false; dog_present = false;

julia> can_free_prisoner(knight_awake, archer_awake, nóra_awake, dog_present)
false
```
