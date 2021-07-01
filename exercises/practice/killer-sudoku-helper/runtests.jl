using Test

include("sudoku-util.jl")

@testset "Trivial 1-digit cages" begin
    for n in 1:9
        @test combinations_in_cage(n, 1) == [[n]]
    end
end

@testset "Cage with sum 45 contains all digits 1:9" begin
    @test combinations_in_cage(45, 9) == [[1, 2, 3, 4, 5, 6, 7, 8, 9]]
end

@testset "Cage with only 1 possible combination" begin
    @test combinations_in_cage(7, 3) == [[1, 2, 4]]
end

@testset "Cage with several combinations" begin
    @test combinations_in_cage(10, 2) == [[1, 9], [2, 8], [3, 7], [4, 6]]
end

@testset "Cage with several combinations that is restricted" begin
    @test combinations_in_cage(10, 2, [1, 4]) == [[2, 8], [3, 7]]
end
