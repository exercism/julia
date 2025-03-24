# Instructions

As a chess enthusiast, you would like to write your own version of the game. Yes, there maybe plenty of implementations of chess available online already, but yours will be unique!

But before you can let your imagination run wild, you need to take care of the basics. Let's start by generating the board.

Each square of the chessboard is identified by a letter-number pair. The vertical columns of squares, called files, are labeled A through H. The horizontal rows of squares, called ranks, are numbered 1 to 8.

## 1. Define the rank range

Implement the `rank_range()` function. It should return a range of integers, from 1 to 8.

```julia-repl
julia> rank_range()
# output omitted
```

## 2. Define the file range

Implement the `file_range()` function. 
It should return a range of integers, from the uppercase letter A, to the uppercase letter H.

```julia-repl
julia> file_range()
# output omitted
```

## 3. Transform the rank range into a vector of ranks

Implement the `ranks()` function. It should return a vector of integers, from 1 to 8. 
Do not write the vector by hand, generate it from the range returned by the `rank_range()` function.

```julia-repl
julia> ranks()
[1, 2, 3, 4, 5, 6, 7, 8]
```

## 4. Transform the file range into a vector of files

Implement the `files` function. It should return a vector of characters, from 'A' to 'H'. 
Do not write the vector by hand, generate it from the range returned by the `file_range()` function.

```julia-repl
julia> files()
['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']
```
