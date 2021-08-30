# Instructions append

The tests require a constructor that takes an array. The internals of your custom set implementation can use other data structures but you may have to implement an outer constructor that takes exactly one array for the tests to pass.

Certain methods have a unicode operator equivalent. E.g. `intersect(CustomSet([1, 2, 3, 4]), CustomSet([]))` is equivalent to `CustomSet([1, 2, 3, 4]) ∩ CustomSet([])`.
