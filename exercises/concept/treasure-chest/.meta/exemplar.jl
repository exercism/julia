struct TreasureChest{T}
    password::String
    treasure::T
end

get_treasure(password_attempt, chest) = 
    password_attempt == chest.password ? chest.treasure : nothing

multiply_treasure(multiplier, chest) =  
    TreasureChest{Vector{typeof(chest.treasure)}}(chest.password, fill(chest.treasure, multiplier))

# alternative solution
# multiply_treasure(multiplier, chest) =  
#     TreasureChest(chest.password, fill(chest.treasure, multiplier))
