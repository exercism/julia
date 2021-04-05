# Instructions

Elyse, magician-to-be, continues her training.
She will be given several stacks of cards that she needs to perform her tricks.
To make things a bit easier, she only uses the cards 1 to 10.
She only has one of each card, there are no duplicates in her stacks of cards.

In this exercise, use methods from Julia's Base library to analyse the contents of an array.

## 1. Determine if a card is present

Elyse wants to determine if a card is present in the stack -- in other words, if the stack contains a specific number:

```julia
julia> card = 2;

julia> find_card([9, 7, 3, 2], card)
4
```

## 2. Find the position of a card

Elyse wants to know the position (index) of a card in the stack:

```julia
julia> card = 3;

julia> has_card([2, 3, 4, 5], card)
true
```

## 3. Determine if each card is even

Elyse wants to know if every card is even -- in other words, if each number in the stack is even:

```julia
julia> all_cards_even([2, 4, 6, 7])
false
```

## 4. Check if the stack contains an odd-value card

Elyse wants to know if there is an odd number in the stack:

```julia
julia> any_odd_cards([3, 2, 6, 4, 8])
true
```

## 5. Determine the position of the first card that is even

Elyse wants to know the position of the first card that is even:

```julia
julia> first_even_card_idx([5, 2, 3, 1])
2
```

## 6. Get the first odd card from the stack

Elyse wants to know the value of the first card that is odd:

```julia
julia> first_odd_card([4, 2, 8, 7, 9])
7
```
