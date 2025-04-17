# Julia 1.0 compat
if VERSION < v"1.1"
    @eval isnothing(::Any) = false
    @eval isnothing(::Nothing) = true
end

"""
    has_card(deck, card)

Return true if `deck` contains `card`.
"""
has_card(deck, card) = card ∈ deck

"""
    find_card(deck, card)

Return the index of `card` in `deck`.
"""
find_card(deck, card) = findfirst(==(card), deck)

"""
    all_cards_even(deck)

Return true if all cards in `deck` are even.
"""
all_cards_even(deck) = all(iseven, deck)

"""
    any_odd_cards(deck)

Return true if any cards in `deck` are odd.
"""
any_odd_cards(deck) = any(isodd, deck)

"""
    first_even_card_idx(deck)

Return the index of the first even card in `deck`.
"""
first_even_card_idx(deck) = findfirst(iseven, deck)

"""
    first_odd_card(deck)

Return the first odd card in `deck`, and `nothing` if the deck does not contain any odd cards.
"""
function first_odd_card(deck)
    idx = findfirst(isodd, deck)
    isnothing(idx) ? nothing : deck[idx]
end
