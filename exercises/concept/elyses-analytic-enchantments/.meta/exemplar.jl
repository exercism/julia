"""
    has_card(stack, card)

Return true if `stack` contains `card`.
"""
has_card(stack, card) = card ∈ stack

"""
    find_card(stack, card)

Return the index of `card` in `stack`.
"""
find_card(stack, card) = findfirst(==(card), stack)

"""
    all_cards_even(stack)

Return true if all cards in `stack` are even.
"""
all_cards_even(stack) = all(iseven, stack)

"""
    any_odd_cards(stack)

Return true if any cards in `stack` are odd.
"""
any_odd_cards(stack) = any(isodd, stack)

"""
    first_even_card_idx(stack)

Return the index of the first even card in `stack`.
"""
first_even_card_idx(stack) = findfirst(iseven, stack)

"""
    first_odd_card(stack)

Return the first odd card in `stack`, and `nothing` if the stack does not contain any odd cards.
"""
function first_odd_card(stack)
    idx = findfirst(isodd, stack)
    idx === nothing ? nothing : stack[idx]
end
