# Instructions

Elyse, magician-to-be, continues her training.
She will be given several decks of cards that she needs to perform her tricks.
To make things a bit easier, she only uses the cards 1 to 10.
She only has one of each card, there are no duplicates in her decks of cards.

In this exercise, use methods from Julia's Base library to analyse the contents of an array.

## 1. Determine if a card is present

Elyse wants to determine if a card is present in the deck -- in other words, if the deck contains a specific number.

```julia
julia> card = 3;

julia> has_card([2, 3, 4, 5], card)
true
```

## 2. Find the position of a card

Elyse wants to know the position (index) of a card in the deck.
If the card is not in the deck, return `nothing`.

```julia
julia> card = 2;

julia> find_card([9, 7, 3, 2], card)
4
```

## 3. Determine if each card is even

Elyse wants to know if every card is even -- in other words, if each number in the deck is even.

```julia
julia> all_cards_even([2, 4, 6, 7])
false
```

## 4. Check if the deck contains an odd-value card

Elyse wants to know if there is an odd number in the deck.

```julia
julia> any_odd_cards([3, 2, 6, 4, 8])
true
```

## 5. Determine the position of the first card that is even

Elyse wants to know the position of the first card that is even.
If there are no even cards in the deck, return `nothing`.

```julia
julia> first_even_card_idx([5, 2, 3, 1])
2
```

## 6. Get the first odd card from the deck

Elyse wants to know the value of the first card that is odd.
If there are no odd cards in the deck, return `nothing`.

```julia
julia> first_odd_card([4, 2, 8, 7, 9])
7
```
