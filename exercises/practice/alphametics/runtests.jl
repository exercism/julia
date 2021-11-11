using Test

include("alphametics.jl")

@testset "puzzle with three letters" begin
    @test solve("I + BB == ILL") == Dict(
        'I' => 1,
        'B' => 9,
        'L' => 0
    )
end

@testset "solution must have unique value for each letter" begin
    @test solve("A == B") === nothing
end

@testset "leading zero solution is invalid" begin
    @test solve("ACA + DD == BD") === nothing
end

@testset "puzzle with two digits final carry" begin
    @test solve("A + A + A + A + A + A + A + A + A + A + A + B == BCC") == Dict(
        'A' => 9,
        'B' => 1,
        'C' => 0
    )
end

@testset "puzzle with four letters" begin
    @test solve("AS + A == MOM") == Dict(
        'A' => 9,
        'S' => 2,
        'M' => 1,
        'O' => 0
    )
end

@testset "puzzle with six letters" begin
    @test solve("NO + NO + TOO == LATE") == Dict(
        'N' => 7,
        'O' => 4,
        'T' => 9,
        'L' => 1,
        'A' => 0,
        'E' => 2
    )
end

@testset "puzzle with seven letters" begin
    @test solve("HE + SEES + THE == LIGHT") == Dict(
        'E' => 4,
        'G' => 2,
        'H' => 5,
        'I' => 0,
        'L' => 1,
        'S' => 9,
        'T' => 7
    )
end

@testset "puzzle with eight letters" begin
    @test solve("SEND + MORE == MONEY") == Dict(
        'S' => 9,
        'E' => 5,
        'N' => 6,
        'D' => 7,
        'M' => 1,
        'O' => 0,
        'R' => 8,
        'Y' => 2
    )
end

@testset "puzzle with ten letters" begin
    @test solve("AND + A + STRONG + OFFENSE + AS + A + GOOD == DEFENSE") == Dict(
        'A' => 5,
        'D' => 3,
        'E' => 4,
        'F' => 7,
        'G' => 8,
        'N' => 0,
        'O' => 2,
        'R' => 1,
        'S' => 6,
        'T' => 9
    )
end

@testset "puzzle with ten letters and 199 addends" begin
    @test solve("THIS + A + FIRE + THEREFORE + FOR + ALL + HISTORIES + I + TELL + A + TALE + THAT + FALSIFIES + ITS + TITLE + TIS + A + LIE + THE + TALE + OF + THE + LAST + FIRE + HORSES + LATE + AFTER + THE + FIRST + FATHERS + FORESEE + THE + HORRORS + THE + LAST + FREE + TROLL + TERRIFIES + THE + HORSES + OF + FIRE + THE + TROLL + RESTS + AT + THE + HOLE + OF + LOSSES + IT + IS + THERE + THAT + SHE + STORES + ROLES + OF + LEATHERS + AFTER + SHE + SATISFIES + HER + HATE + OFF + THOSE + FEARS + A + TASTE + RISES + AS + SHE + HEARS + THE + LEAST + FAR + HORSE + THOSE + FAST + HORSES + THAT + FIRST + HEAR + THE + TROLL + FLEE + OFF + TO + THE + FOREST + THE + HORSES + THAT + ALERTS + RAISE + THE + STARES + OF + THE + OTHERS + AS + THE + TROLL + ASSAILS + AT + THE + TOTAL + SHIFT + HER + TEETH + TEAR + HOOF + OFF + TORSO + AS + THE + LAST + HORSE + FORFEITS + ITS + LIFE + THE + FIRST + FATHERS + HEAR + OF + THE + HORRORS + THEIR + FEARS + THAT + THE + FIRES + FOR + THEIR + FEASTS + ARREST + AS + THE + FIRST + FATHERS + RESETTLE + THE + LAST + OF + THE + FIRE + HORSES + THE + LAST + TROLL + HARASSES + THE + FOREST + HEART + FREE + AT + LAST + OF + THE + LAST + TROLL + ALL + OFFER + THEIR + FIRE + HEAT + TO + THE + ASSISTERS + FAR + OFF + THE + TROLL + FASTS + ITS + LIFE + SHORTER + AS + STARS + RISE + THE + HORSES + REST + SAFE + AFTER + ALL + SHARE + HOT + FISH + AS + THEIR + AFFILIATES + TAILOR + A + ROOFS + FOR + THEIR + SAFE == FORTRESSES") == Dict(
        'A' => 1,
        'E' => 0,
        'F' => 5,
        'H' => 8,
        'I' => 7,
        'L' => 2,
        'O' => 6,
        'R' => 3,
        'S' => 4,
        'T' => 9
    )
end
