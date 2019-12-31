using Test

include("matching-brackets.jl")

@testset "Determine if brackets in expression are correctly matched" begin
    @test matching_brackets("[]")::Bool == true  
    @test matching_brackets("")::Bool == true
    @test matching_brackets("[[")::Bool == false
    @test matching_brackets("}{")::Bool == false
    @test matching_brackets("{]")::Bool == false
    @test matching_brackets("{ }")::Bool == true
    @test matching_brackets("{[])")::Bool == false
    @test matching_brackets("{[]}")::Bool == true
    @test matching_brackets("{}[]")::Bool == true
    @test matching_brackets("([{}({}[])])")::Bool == true
    @test matching_brackets("{[)][]}")::Bool == false
    @test matching_brackets("([{])")::Bool == false
    @test matching_brackets("[({]})")::Bool == false
    @test matching_brackets("{}[")::Bool == false
    @test matching_brackets("[]]")::Bool == false
    @test matching_brackets("(((185 + 223.85) * 15) - 543)/2")::Bool == true
    @test matching_brackets("\\left(\\begin{array}{cc} \\frac{1}{3} & x\\\\ \\mathrm{e}^{x} &... x^2 \\end{array}\\right)")::Bool == true
end
