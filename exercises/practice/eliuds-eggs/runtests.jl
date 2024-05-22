using Test

include("eliuds-eggs.jl")

@testset verbose = true "tests" begin
    @testset "0 eggs" begin
        @test eggcount(0) == 0
    end

    @testset "1 egg" begin
        @test eggcount(16) == 1
    end

    @testset "4 eggs" begin
        @test eggcount(89) == 4
    end

    @testset "13 eggs" begin
        @test eggcount(2000000000) == 13
    end
end