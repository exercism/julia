As a magician-to-be, Elyse needs to practice some basics.
She has a deck of cards that she wants to manipulate.

To make things a bit easier she only uses the cards 1 to 10.

## 1. Retrieve a card from a deck

Return the card at position `idx` from the given deck.

```julia
julia> idx = 2;

julia> card([1, 3, 4, 1], idx)
3
```

## 2. Exchange a card in the deck

Exchange the card at position `idx` with the new card provided and return the adjusted deck.
Note that this will mutate (change) the input vector and this is okay.

```julia
julia> idx = 2; new_card = 6;

julia> replace_card!([1, 3, 4, 1], idx => new_card)
[1, 6, 4, 1]
```

## 3. Insert a card at the of top the deck

Insert new card at the top of the deck and return the deck.

```julia
julia> new_card = 8;

julia> insert_card_at_top!([1, 3, 4, 1], new_card)
[1, 3, 4, 1, 8]
```

## 4. Remove a card from the deck

Remove the card at position `idx` from the deck and return the deck.

```julia
julia> idx = 2;

julia> remove_card!([1, 3, 4, 1], idx)
[1, 4, 1]
```

## 5. Remove the top card from the deck

Remove the card at the top of the deck and return the deck.

```julia
julia> remove_card_from_top!([1, 3, 4, 1])
[1, 3, 4]
```

## 6. Insert a card at the bottom of the deck

Insert a new card at the bottom of the deck and return the deck.

```julia
julia> new_card = 8;

julia> insert_card_at_bottom!([1, 3, 4, 1], new_card)
[8, 1, 3, 4, 1]
```

## 7. Remove a card from the bottom of the deck

Remove the card at the bottom of the deck and return the deck.

```julia
julia> remove_card_at_bottom!([1, 3, 4, 1])
[3, 4, 1]
```

## 8. Check size of the deck

Check whether the size of the deck equals a given `deck_size` or not.

```julia
julia> deck_size = 4;

julia> check_deck_size([1, 3, 4, 1], deck_size)
true

julia> check_deck_size([1, 3, 4, 1, 5], deck_size)
false
```
