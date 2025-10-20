# Instructions

A dot matrix is a two dimensional image made up of *dots* and *whitespace*.
The dots form the intended image on the background of the whitespace.

A dot matrix image can be stored and manipulated in memory as a two dimensional `Matrix`.
In what follows, the "whitespace" in the matrices will be signified as `0` and the "dots" will be non-zero.

## 1. Define the Exercism logo `Matrix`

The `Matrix` looks as follows, with `0` as a whitespace and `1` as a dot:

```julia
[
    0 0 1 1 0 0 0 0 0 0 0 0 0 0 1 1 0 0;
    0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0;
    0 1 0 0 0 1 0 0 0 0 0 0 1 0 0 0 1 0;
    0 1 0 0 1 0 1 0 0 0 0 1 0 1 0 0 1 0;
    0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0;
    1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1;
    0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0;
    0 1 0 0 0 0 0 1 0 0 1 0 0 0 0 0 1 0;
    0 1 0 0 0 0 0 0 1 1 0 0 0 0 0 0 1 0;
    0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0;
    0 0 1 1 0 0 0 0 0 0 0 0 0 0 1 1 0 0;
]
```

If you "render" it, it looks like this:

```julia
  XX          XX  
 X              X 
 X   X      X   X 
 X  X X    X X  X 
 X              X 
X                X
 X    X    X    X 
 X     X  X     X 
 X      XX      X 
 X              X 
  XX          XX
```

## 2. Define functions that make the logo frown

Define `frown!()` and `frown()` functions that take the Exercism logo `Matrix`.
Return a `Matrix` with the smiling mouth changed to a frowning mouth.

The resulting `Matrix` would render like this:

```julia
  XX          XX
 X              X
 X   X      X   X
 X  X X    X X  X
 X              X
X                X
 X      XX      X
 X     X  X     X
 X    X    X    X
 X              X
  XX          XX
```

## 3. Put together a stickerwall

Define the function `stickerwall()`, which takes the Exercism matrix as input.
Return a `Matrix` of the dot matrix which renders as:

```julia
  XX          XX   X   XX          XX
 X              X  X  X              X
 X   X      X   X  X  X   X      X   X
 X  X X    X X  X  X  X  X X    X X  X
 X              X  X  X              X
X                X X X                X
 X    X    X    X  X  X      XX      X
 X     X  X     X  X  X     X  X     X
 X      XX      X  X  X    X    X    X
 X              X  X  X              X
  XX          XX   X   XX          XX
                   X
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                   X
  XX          XX   X   XX          XX
 X              X  X  X              X
 X   X      X   X  X  X   X      X   X
 X  X X    X X  X  X  X  X X    X X  X
 X              X  X  X              X
X                X X X                X
 X      XX      X  X  X    X    X    X
 X     X  X     X  X  X     X  X     X
 X    X    X    X  X  X      XX      X
 X              X  X  X              X
  XX          XX   X   XX          XX
```

## 4. Change dots to column pixel counts

We aren't limited to just using `1` as the dot, so we could encode other useful information if desired.
Define the function `colpixelcount()` which takes *any* dot matrix with `1` dots as input.
Return a dot matrix of the same size, with the dots in each column being the number of dots in that column.

With the Exercism logo `Matrix` as input, the output is a `Matrix` as follows:

```julia
[
    0 0 2 2 0 0 0 0 0 0 0 0 0 0 2 2 0 0;
    0 8 0 0 0 0 0 0 0 0 0 0 0 0 0 0 8 0;
    0 8 0 0 0 1 0 0 0 0 0 0 1 0 0 0 8 0;
    0 8 0 0 1 0 2 0 0 0 0 2 0 1 0 0 8 0;
    0 8 0 0 0 0 0 0 0 0 0 0 0 0 0 0 8 0;
    1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1;
    0 8 0 0 0 0 2 0 0 0 0 2 0 0 0 0 8 0;
    0 8 0 0 0 0 0 1 0 0 1 0 0 0 0 0 8 0;
    0 8 0 0 0 0 0 0 1 1 0 0 0 0 0 0 8 0;
    0 8 0 0 0 0 0 0 0 0 0 0 0 0 0 0 8 0;
    0 0 2 2 0 0 0 0 0 0 0 0 0 0 2 2 0 0;
]
```

## 5. Render a dot matrix

Rather than just talk about rendering our creations, we would like to actually be able to do that for easy viewing.
Define the function `render()` which takes a dot matrix as input.
Return a string with dots rendered as `'X'`, the `0`s as `' '`, and newlines connecting each row.

```julia-repl
julia> render(E)
"  XX          XX  \n X              X \n X   X      X   X \n X  X X    X X  X \n X              X \nX                X\n X    X    X    X \n X     X  X     X \n X      XX      X \n X              X \n  XX          XX  "
```

When printed, this should render the Exercism Matrix as expected.

```julia-repl
julia> print(render(E))
  XX          XX
 X              X
 X   X      X   X
 X  X X    X X  X
 X              X
X                X
 X    X    X    X
 X     X  X     X
 X      XX      X
 X              X
  XX          XX
```

This should also work with "dots" that are different than `1`:

```julia-repl
julia> print(render(colpixelcount(E)))
  XX          XX
 X              X
 X   X      X   X
 X  X X    X X  X
 X              X
X                X
 X    X    X    X
 X     X  X     X
 X      XX      X
 X              X
  XX          XX
```
