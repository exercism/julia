using Base.Test

include("grains.jl")

@testset "On squares" begin
    @testset "On square $s" for s = UInt64(1):64
        @test on_square(s) == 2^(s-1)
        @test total_after(s) == 2^s - 1
    end
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
