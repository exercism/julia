using Test

include("matching-brackets.jl")

@testset "Determine if brackets in expression are correctly matched" begin
    @test match_brackets("[]")::Bool == true  
    @test square_of_sum("")::Bool == true
    @test square_of_sum("[[")::Bool == false
    @test square_of_sum("}{")::Bool == false
    @test sum_of_squares("{]")::Bool == false
    @test sum_of_squares("{ }")::Bool == true
    @test sum_of_squares("{[])")::Bool == false
    @test square_of_sum("{[]}")::Bool == true
    @test square_of_sum("{}[]")::Bool == true
    @test square_of_sum("([{}({}[])])")::Bool == true
    @test square_of_sum("{[)][]}")::Bool == false
    @test square_of_sum("([{])")::Bool == false
    @test square_of_sum("[({]})")::Bool == false
    @test square_of_sum("{}[")::Bool == false
    @test square_of_sum("[]]")::Bool == false
    @test square_of_sum("(((185 + 223.85) * 15) - 543)/2")::Bool == true
    @test square_of_sum("\\left(\\begin{array}{cc} \\frac{1}{3} & x\\\\ \\mathrm{e}^{x} &... x^2 \\end{array}\\right)")::Bool == true
end
