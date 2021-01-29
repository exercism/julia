using Test

include("difference-of-squares.jl")

@testset "Square the sum of the numbers up to the given number" begin
    @test square_of_sum(1)::Integer == 1
    @test square_of_sum(5)::Integer == 225
    @test square_of_sum(10)::Integer == 3025
    @test square_of_sum(100)::Integer == 25502500
end

@testset "Sum the squares of the numbers up to the given number" begin
    @test sum_of_squares(1)::Integer == 1
    @test sum_of_squares(5)::Integer == 55
    @test sum_of_squares(10)::Integer == 385
    @test sum_of_squares(100)::Integer == 338350
end

@testset "Subtract sum of squares from square of sums" begin
    @test difference(0)::Integer == 0
    @test difference(1)::Integer == 0
    @test difference(5)::Integer == 170
    @test difference(10)::Integer == 2640
    @test difference(100)::Integer == 25164150
end
