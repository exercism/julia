"""
    is_foggy()

Return `true` if it's foggy.
"""
is_foggy() = rand(Bool)

"""
    is_dog_distracted()

Return `true` if Annalyn's dog has been distracted.
"""
is_dog_distracted() = rand() < 0.25

"""
    loot()

Return the number of coins Annalyn finds in the camp.
"""
loot() = rand(3:13)

"""
    loot(crate)

Return which out of the given items Annalyn finds in the chest.
"""
loot(crate) = rand(crate)
