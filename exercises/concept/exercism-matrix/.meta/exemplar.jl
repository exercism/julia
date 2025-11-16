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

function frown!(E)
    E[7, 7] = E[7, 12] = E[9, 9] = E[9, 10] = 0
    E[9, 7] = E[9, 12] = E[7, 9] = E[7, 10] = 1
    E
end

frown(E) = frown!(copy(E))

stickerwall(E) = vcat(hcat(E, frown(E)), ones(Int, (1, 2size(E, 2))), hcat(frown(E), E))

function colpixelcount(E)
    E .* sum(E, dims=1)
end

function render(E)
    join([join(el == 0 ? " " : "X" for el in row) for row in eachrow(E)], "\n")
end
