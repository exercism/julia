# canonical data version: 2.0.0

using Test

include("matching-brackets.jl")

@testset "Determine if brackets in expression are correctly matched" begin
    @test matching_brackets("[]") 
    @test !matching_brackets("[[")
    @test !matching_brackets("}{")
    @test !matching_brackets("{]")
    @test matching_brackets("{ }")
end

@testset "Determine if brackets in expression are correctly matched" begin
    @test !matching_brackets("[]]")
    @test !matching_brackets("{}[")
    @test matching_brackets("{}[]")
    @test !matching_brackets("{[])")
    @test matching_brackets("{[]}")
    @test matching_brackets("([{}({}[])])")
    @test !matching_brackets("{[)][]}")
    @test !matching_brackets("([{])")
    @test !matching_brackets("[({]})")
end
    
@testset "Determine if brackets in expression are correctly matched" begin
    @test matching_brackets("")
    @test matching_brackets("(((185 + 223.85) * 15) - 543)/2")
    @test matching_brackets("\\left(\\begin{array}{cc} \\frac{1}{3} & x\\\\ \\mathrm{e}^{x} &... x^2 \\end{array}\\right)")
end
