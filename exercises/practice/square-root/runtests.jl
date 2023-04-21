using Test, Random

include("square-root.jl")


@testset "Different valid values" begin
    @testset "Square root of 1 is 1" begin
        @test square_root(1) == 1.0
    end
    @testset "Square root of 4 is 2" begin
        @test square_root(4) == 2.0
    end
    @testset "Square root of 25 is 5" begin
        @test square_root(25) == 5.0
    end
    @testset "Square root of 81 is 9" begin
        @test square_root(81) == 9.0
    end
    @testset "Square root of 196 is 14" begin
        @test square_root(196) == 14.0
    end
    @testset "Square root of 65025 is 255" begin
        @test square_root(65025) == 255.0
    end
    @testset "Domain error for negative number" begin
        @test_throws DomainError square_root(-65536)
    end
end


@testset "Random tests" begin
    for _ in 1:1000
        s = rand(1:isqrt(typemax(Int64)))
        @test square_root(s^2) == s
    end
end
