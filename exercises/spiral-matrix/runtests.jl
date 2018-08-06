using Test

include("spiral-matrix.jl")


@testset "Different valid values" begin
    @testset "Empty spiral" begin
        @test spiral_matrix(0) == Matrix{Int}(undef,0,0)
    end
    @testset "Trivial spiral" begin
        @test spiral_matrix(1) == reshape([1],(1,1))
    end
    @testset "Spiral of size 2" begin
        @test spiral_matrix(2) == [1 2; 4 3]
    end
    @testset "Spiral of size 3" begin
        @test spiral_matrix(3) == [1 2 3; 8 9 4; 7 6 5]
    end
    @testset "Spiral of size 4" begin
        @test spiral_matrix(4) == [1 2 3 4; 12 13 14 5; 11 16 15 6; 10 9 8 7]
    end
    @testset "Spiral of size 5" begin
        @test spiral_matrix(5) == [1 2 3 4 5; 16 17 18 19 6; 15 24 25 20 7; 14 23 22 21 8; 13 12 11 10 9]
    end
end
