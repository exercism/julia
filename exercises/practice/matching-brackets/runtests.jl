using Test

include("matching-brackets.jl")

@testset "Determine if a pair of brackets are correctly matched" begin
    @test  matching_brackets("[]") 
    @test !matching_brackets("[[")
    @test !matching_brackets("}{")
    @test !matching_brackets("{]")
    @test  matching_brackets("{ }")
end

@testset "Determine if 3 or more brackets are correctly matched" begin
    @test !matching_brackets("[]]")
    @test !matching_brackets("{}[")
    @test  matching_brackets("{}[]")
    @test !matching_brackets("{[])")
    @test  matching_brackets("{[]}")
    @test  matching_brackets("([{}({}[])])")
    @test !matching_brackets("{[)][]}")
    @test !matching_brackets("([{])")
    @test !matching_brackets("[({]})")
    @test !matching_brackets(")()")
    @test !matching_brackets("{)()")
end
    
@testset "Determine if expressions with non-brackets are correctly matched" begin
    @test  matching_brackets("")
    @test  matching_brackets("(((185 + 223.85) * 15) - 543)/2")
    @test  matching_brackets("\\left(\\begin{array}{cc} \\frac{1}{3} & x\\\\ \\mathrm{e}^{x} &... x^2 \\end{array}\\right)")
end
