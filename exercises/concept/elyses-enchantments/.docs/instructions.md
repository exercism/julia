# Instructions

As a magician-to-be, Elyse needs to practice some basics. 
She has a stack of cards that she wants to manipulate.

To make things a bit easier she only uses the cards 1 to 10 so her stack of cards can be represented by a vector of numbers. 
The position of a certain card corresponds to the index in the vector. 

## 1. Retrieve a card from a stack

To pick a card, return the card at index `position` from the given stack.

```julia
stack = [1, 2, 4, 1]
position = 3
get_item(stack, position)
# 4
```

## 2. Exchange a card in the stack

Perform some sleight of hand and exchange the card at index `position` with the replacement card provided.
Return the adjusted stack.

```julia
stack = [1, 2, 4, 1]
position = 3
replacement_card = 6
set_item!(stack, position, replacement_card)
# [1, 2, 6, 1]
```

## 3. Insert a card at the top of the stack

Make a card appear by inserting a new card at the top of the stack.
Return the adjusted stack.

```julia
stack = [5, 9, 7, 1]
new_card = 8
insert_item_at_top!(stack, new_card)
# [5, 9, 7, 1, 8]
```

## 4. Remove a card from the stack

Make a card disappear by removing the card at the given `position` from the stack.
Return the adjusted stack.

```julia
stack = [3, 2, 6, 4, 8]
position = 3
remove_item!(stack, position)
# [3, 2, 4, 8]
```

## 5. Remove the top card from the stack

Make a card disappear by removing the card at the top of the stack.
Return the adjusted stack.

```julia
stack = [3, 2, 6, 4, 8]
remove_item_from_top!(stack)
# [3, 2, 6, 4]
```

## 6. Insert a card at the bottom of the stack

Make a card appear by inserting a new card at the bottom of the stack.
Return the adjusted stack.

```julia
stack = [5, 9, 7, 1]
new_card = 8
insert_item_at_bottom!(stack, new_card)
# [8, 5, 9, 7, 1]
```

## 7. Remove a card from the bottom of the stack

Make a card disappear by removing the card at the bottom of the stack.
Return the adjusted stack.

```julia
stack = [8, 5, 9, 7, 1]
remove_item_at_bottom!(stack)
# [5, 9, 7, 1]
```

## 8. Check the size of the stack

Check whether the size of the stack is equal to `stack_size` or not.

```julia
stack = [3, 2, 6, 4, 8]
stack_size = 4
check_size_of_stack(stack, stack_size)
# false
```