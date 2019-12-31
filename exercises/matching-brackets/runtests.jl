using Test

include("matching-brackets.jl")

@testset "Determine if brackets in expression are correctly matched" begin
    #correctly balanced test cases
    @test match_brackets("([])")::Bool == true  
    @test square_of_sum("{()[]}")::Bool == true
    @test square_of_sum("{()[()]}")::Bool == true
    #incorrectly balanced test cases:
    @test sum_of_squares("(")::Bool == false
    @test sum_of_squares(")[](")::Bool == false
    @test sum_of_squares("{([)]}")::Bool == false
end
