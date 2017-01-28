using Base.Test

include("difference-of-squares.jl")

@testset "Square the sum of the numbers up to the given number" begin
    @test square_of_sum(5) == 225
    @test square_of_sum(10) == 3025
    @test square_of_sum(100) == 25502500
end

@testset "Sum the squares of the numbers up to the given number" begin
    @test sum_of_squares(5) == 55
    @test sum_of_squares(10) == 385
    @test sum_of_squares(100) == 338350
end

@testset "Subtract sum of squares from square of sums" begin
    @test difference(0) == 0
    @test difference(5) == 170
    @test difference(10) == 2640
    @test difference(100) == 25164150
end
