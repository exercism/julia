"""
    can_do_fast_attack(knight_awake)

Return if a fast attack is possible.
"""
can_do_fast_attack(knight_awake) = !knight_awake

"""
    can_spy(knight_awake, archer_awake, prisoner_awake)

Return if the spy action is possible.
"""
can_spy(knight_awake, archer_awake, prisoner_awake) = knight_awake || archer_awake || prisoner_awake

"""
    can_signal_prisoner(archer_awake, prisoner_awake)

Return if signaling the prisoner is possible.
"""
can_signal_prisoner(archer_awake, prisoner_awake) = prisoner_awake && !archer_awake

"""
    can_free_prisoner(knight_awake, archer_awake, prisoner_awake, dog_present)

Return if the prisoner can be freed.
"""
can_free_prisoner(knight_awake, archer_awake, prisoner_awake, dog_present) = !knight_awake && !archer_awake && prisoner_awake || dog_present && !archer_awake
