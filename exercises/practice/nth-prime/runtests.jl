using Test

include("nth-prime.jl")

@testset verbose = true "tests" begin
    @testset "first prime" begin
        @test prime(1) ==  2
    end

    @testset "second prime" begin
        @test prime(2) ==  3
    end

    @testset "sixth prime" begin
        @test prime(6) ==  13
    end

    @testset "big prime" begin
        @test prime(10001) ==  104743
    end

    @testset "there is no zeroth prime" begin
        @test_throws ErrorException("No such prime!") prime(0)
    end
end
