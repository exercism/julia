const students = ["Alice", "Bob", "Charlie", "David", "Eve", "Fred", "Ginny",
                    "Harriet", "Ileana", "Joseph", "Kincaid", "Larry"]

const species = Dict('G' => "grass", 'C' => "clover", 'R' => "radishes", 'V' => "violets")

function plants(diagram, student)
    rows = split(diagram, '\n')
    start = 2 * index(students, student) - 1
    owns = rows[1][start:(start + 1)] * rows[2][start:(start + 1)]
    [species[p] for p in owns]
end

index(A, val) = findfirst(x -> x == val, A)
