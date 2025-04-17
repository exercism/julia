"The Exercism logo matrix."
const E = [
    0 0 1 1 0 0 0 0 0 0 0 0 0 0 1 1 0 0;
    0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0;
    0 1 0 0 0 1 0 0 0 0 0 0 1 0 0 0 1 0;
    0 1 0 0 1 0 1 0 0 0 0 1 0 1 0 0 1 0;
    0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0;
    1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1;
    0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0;
    0 1 0 0 0 0 0 1 0 0 1 0 0 0 0 0 1 0;
    0 1 0 0 0 0 0 0 1 1 0 0 0 0 0 0 1 0;
    0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0;
    0 0 1 1 0 0 0 0 0 0 0 0 0 0 1 1 0 0;
]

"""
    frown!(E)

Change the smiling mouth of an Exercism logo matrix `E` to a frowning mouth, mutating `E`.
"""
function frown!(E)
    E[7, 7] = E[7, 12] = E[9, 9] = E[9, 10] = 0
    E[9, 7] = E[9, 12] = E[7, 9] = E[7, 10] = 1
    E
end

"""
    frown(E)

Return a copy of the Exercism logo matrix `E` with a frowning mouth.
"""
frown(E) = frown!(copy(E))

"""
    rot270(E)

Rotate the matrix `E` by 270° to the right.
"""
rot270(E) = E'

# TODO This should probably be written out since rotr90 is unlike to be the solution a student would come up with
"""
    rot90(E)

Rotate the matrix `E` by 90° to the right.
"""
rot90(E) = rotr90(E)

"""
    stickerwall(E)

Return a stickerwall of the given matrix E.
"""
stickerwall(E) = vcat(
    hcat(E, zeros(Int, size(E, 1)), ones(Int, size(E, 1)), zeros(Int, size(E, 1)), vcat(frown(E))),
    hcat(zeros(Int, size(E, 2) + 1)', [1], zeros(Int, size(E, 2) + 1)'),
    ones(Int, 2size(E, 2) + 3)',
    hcat(zeros(Int, size(E, 2) + 1)', [1], zeros(Int, size(E, 2) + 1)'),
    hcat(vcat(frown(E)), zeros(Int, size(E, 1)), ones(Int, size(E, 1)), zeros(Int, size(E, 1)), E)
)
