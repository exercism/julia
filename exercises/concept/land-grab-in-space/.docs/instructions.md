# Instructions

You have been tasked by the claims department of Isaac's Asteroid Exploration Co. to improve the performance of their land claim system.

Every time a asteroid is ready for exploitation speculators are invited to stake their claim to a plot of land. 
The asteroid's land is divided into non-overlapping rectangular plots.
Dimensions differ, but all have sides parallel to the coordinate axes.
Speculators claim one of the plots of land by specifying its coordinates.

Your goal is to develop a performant system to handle the land rush that has in the past caused the website to crash.

The unit of measure is 100 meters but can be ignored in these tasks.

## 1. Define a Point

Define a `struct` to hold `x` and `y` coordinates.
These are fairly small non-negative integers, so use the type `UInt16`.

```julia-repl
julia> Coord(7, 3)
Coord(0x0007, 0x0003)  # unsigned integers display in hex format by default
```

## 2. Define a Plot

Because all plots must be rectangular, with horizontal and vertical sides, only two opposite corners are needed to define them.

Implement the `Plot` struct, taking two Coord structs in its constructor.

`Plot` should be a keyword struct, with fields `bottom_left` and `top_right`.

```julia-repl
julia> plot = Plot(bottom_left=Coord(10, 1), top_right=Coord(20, 2))
Plot(Coord(0x000a, 0x0001), Coord(0x0014, 0x0002))

julia> plot.top_right
Coord(0x0014, 0x0002)
```

## 3. Check whether your claim has already been filed

There is competition for these claims, so before your claim is allowed it will be checked against existing claims in the register.

Implement the `is_claim_staked()` function to determine whether a claim has already been staked.

```julia-repl
julia> claim = Plot(bottom_left=Coord(10, 1), top_right=Coord(20, 2));
julia> register = Set{Plot}();
julia> is_claim_staked(claim, register)
false
```

## 4. Speculators can stake their claim by specifying a plot identified by its corner coordinates

Implement the `stake_claim!()` mutating function to allow a claim to be registered.

If the same claim has already been staked, return `false`.

If a new claim is possible, add it to the register and return `true`.

```julia_repl
julia> claim = Plot(bottom_left=Coord(10, 1), top_right=Coord(20, 2));
julia> register = Set{Plot}();
julia> stake_claim!(claim, register)
true
```

## 5. Find the length of a plot's longer side.

Implement the `get_longest_side()` function to get the longer side (horizontal or vertical) of a claim.

```julia-repl
claim = Plot(bottom_left=Coord(10, 1), top_right=Coord(20, 2));

julia> get_longest_side(claim)
0x000a
```

## 6. Find the plot claimed that has the longest side, for research purposes

Implement the `get_claim_with_longest_side()` function to examine all registered claims and return the claim(s) with the longest side. 

```julia-repl
julia> plot1 = Plot(bottom_left=Coord(5, 3), top_right=Coord(10, 5));
julia> plot2 = Plot(bottom_left=Coord(0, 0), top_right=Coord(3, 3));
julia> register = Set{Plot}([plot1, plot2]);

julia> get_claim_with_longest_side(register)
Plot(Coord(0x0005, 0x0003), Coord(0x000a, 0x0005))
```

Return the Plot(s) as a `Set`, with one element if there is a single longest plot, multiple in the event of a tie.
