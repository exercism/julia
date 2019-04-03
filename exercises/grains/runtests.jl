using Test

include("grains.jl")

@testset "On squares" begin
    @test on_square(1) == 1
    @test on_square(2) == 2
    @test on_square(3) == 4
    @test on_square(4) == 8
    @test on_square(16) == 32768
    @test on_square(32) == 2147483648
    @test on_square(64) == 9223372036854775808
    @test total_after(64) == 18446744073709551615
end

@testset "Invalid values" begin
    @testset "Zero" begin
        @test_throws DomainError on_square(0)
        @test_throws DomainError total_after(0)
    end
    
    @testset "Negative" begin
        @test_throws DomainError on_square(-1)
        @test_throws DomainError total_after(-1)
    end
    
    @testset "Greater than 64" begin
        @test_throws DomainError on_square(65)
        @test_throws DomainError total_after(65)
    end
end
