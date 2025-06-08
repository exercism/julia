shift_back(value, amount) = value >>> amount

set_bits(value, mask) = value | mask

flip_bits(value, mask) = value ⊻ mask  # or `xor(value, mask)`

clear_bits(value, mask) = value & ~mask
