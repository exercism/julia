"""
    card(stack, idx)

Return the card at position `idx` from the given `stack`.
"""
card(stack, idx) = stack[idx]

"""
    replace_card!(stack, idx => new_card)

Exchange the card at position `idx` with `new_card` and return the adjusted `stack`.
"""
function replace_card!(stack, r)
    stack[r.first] = r.second
    stack
end

"""
    insert_card_at_top!(stack, new_card)

Insert `new_card` at the top of `stack` and return the modified `stack`.
"""
insert_card_at_top!(stack, new_card) = push!(stack, new_card)

"""
    remove_card!(stack, idx)

Remove the card at position `idx` from `stack` and return the modified `stack`.
"""
remove_card!(stack, idx) = deleteat!(stack, idx)

"""
    remove_card_from_top!(stack)

Remove the card at the top of `stack` and return the modified `stack`.
"""
function remove_card_from_top!(stack)
    pop!(stack)
    stack
end

"""
    insert_card_at_bottom!(stack, new_card)

Insert `new_card` at the bottom of `stack` and return the modified `stack`.
"""
insert_card_at_bottom!(stack, new_card) = pushfirst!(stack, new_card)

"""
    remove_card_from_bottom!(stack)

Remove the card at the bottom of `stack` and return the modified `stack`.
"""
function remove_card_from_bottom!(stack)
    popfirst!(stack)
    stack
end

"""
    check_stack_size(stack, stack_size)

Check if the size of `stack` equals the given `stack_size`.
"""
check_stack_size(stack, stack_size) = length(stack) == stack_size
