"""
    card(deck, idx)

Return the card at position `idx` from the given `deck`.
"""
card(deck, idx) = deck[idx]

"""
    replace_card!(deck, idx => new_card)

Exchange the card at position `idx` with `new_card` and return the adjusted `deck`.
"""
function replace_card!(deck, r)
    deck[r.first] = r.second
    deck
end

"""
    insert_card_at_top!(deck, new_card)

Insert `new_card` at the top of `deck` and return the modified `deck`.
"""
insert_card_at_top!(deck, new_card) = push!(deck, new_card)

"""
    remove_card!(deck, idx)

Remove the card at position `idx` from `deck` and return the modified `deck`.
"""
remove_card!(deck, idx) = deleteat!(deck, idx)

"""
    remove_card_from_top!(deck)

Remove the card at the top of `deck` and return the modified `deck`.
"""
function remove_card_from_top!(deck)
    pop!(deck)
    deck
end

"""
    insert_card_at_bottom!(deck, new_card)

Insert `new_card` at the bottom of `deck` and return the modified `deck`.
"""
insert_card_at_bottom!(deck, new_card) = pushfirst!(deck, new_card)

"""
    remove_card_from_bottom!(deck)

Remove the card at the bottom of `deck` and return the modified `deck`.
"""
function remove_card_from_bottom!(deck)
    popfirst!(deck)
    deck
end

"""
    check_deck_size(deck, deck_size)

Check if the size of `deck` equals the given `deck_size`.
"""
check_deck_size(deck, deck_size) = length(deck) == deck_size
