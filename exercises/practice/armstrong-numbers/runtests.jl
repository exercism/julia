using Test

include("armstrong-numbers.jl")

@testset "armstrong numbers" begin
    @test  isarmstrong(0)
    @test  isarmstrong(5)
    @test !isarmstrong(10)
    @test !isarmstrong(100)
    @test  isarmstrong(153)
    @test  isarmstrong(9474)
    @test !isarmstrong(9475)
    @test  isarmstrong(9926315)
    @test !isarmstrong(9926314)
end
