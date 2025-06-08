# Hints

Some (not all) of the tests assume the value is `Int32`, so please avoid forcing it to be anything else.

## 1. Shift back the bits

- This is a right-shift.
- Note the instruction that the results should be left-filled with zeros.

## 2. Set some bits

- Bits are set by bitwise OR with a mask. This is extremely common.

## 3. Flip specific bits

- There is an old joke among programmers that cryptographers discovered XOR and forgot to read the rest of the manual.

## 4. Clear specific bits

- Simple AND logic will do the opposite of what you need.
- How do you flip all the bits in the mask?
  