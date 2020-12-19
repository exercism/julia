using Test

include("complex-numbers.jl")

@test ComplexNumber <: Number

@test ComplexNumber(0, 1)^2 == ComplexNumber(-1, 0)

@testset "Arithmetic" begin
    @testset "Addition" begin
        @test ComplexNumber(1, 0) + ComplexNumber(2, 0) == ComplexNumber(3, 0)
        @test ComplexNumber(0, 1) + ComplexNumber(0, 2) == ComplexNumber(0, 3)
        @test ComplexNumber(1, 2) + ComplexNumber(3, 4) == ComplexNumber(4, 6)
    end

    @testset "Subtraction" begin
        @test ComplexNumber(1, 0) - ComplexNumber(2, 0) == ComplexNumber(-1, 0)
        @test ComplexNumber(0, 1) - ComplexNumber(0, 2) == ComplexNumber(0, -1)
        @test ComplexNumber(1, 2) - ComplexNumber(3, 4) == ComplexNumber(-2, -2)
    end

    @testset "Multiplication" begin
        @test ComplexNumber(1, 0) * ComplexNumber(2, 0) == ComplexNumber(2, 0)
        @test ComplexNumber(0, 1) * ComplexNumber(0, 2) == ComplexNumber(-2, 0)
        @test ComplexNumber(1, 2) * ComplexNumber(3, 4) == ComplexNumber(-5, 10)
    end

    @testset "Division" begin
        @test ComplexNumber(1, 0) / ComplexNumber(2, 0) == ComplexNumber(0.5, 0)
        @test ComplexNumber(0, 1) / ComplexNumber(0, 2) == ComplexNumber(0.5, 0)
        @test ComplexNumber(1, 2) / ComplexNumber(3, 4) ≈ ComplexNumber(0.44, 0.08)
    end
end

@testset "Absolute value" begin
    @test abs(ComplexNumber(5, 0))  == 5
    @test abs(ComplexNumber(-5, 0)) == 5
    @test abs(ComplexNumber(0, 5))  == 5
    @test abs(ComplexNumber(0, -5)) == 5
    @test abs(ComplexNumber(3, 4))  == 5
end

@testset "Complex conjugate" begin
    @test conj(ComplexNumber(5, 0))  == ComplexNumber(5, 0)
    @test conj(ComplexNumber(0, 5))  == ComplexNumber(0, -5)
    @test conj(ComplexNumber(1, 1))  == ComplexNumber(1, -1)
end

@testset "Real part" begin
    @test real(ComplexNumber(1, 0)) == 1
    @test real(ComplexNumber(0, 1)) == 0
    @test real(ComplexNumber(1, 2)) == 1
end

@testset "Imaginary part" begin
    @test imag(ComplexNumber(1, 0)) == 0
    @test imag(ComplexNumber(0, 1)) == 1
    @test imag(ComplexNumber(1, 2)) == 2
end

# Bonus A
@testset "Complex exponential" begin
    @test_skip exp(ComplexNumber(0, π)) ≈ ComplexNumber(-1, 0)
    @test_skip exp(ComplexNumber(0, 0)) == ComplexNumber(1, 0)
    @test_skip exp(ComplexNumber(1, 0)) ≈ ComplexNumber(ℯ, 0)
    @test_skip exp(ComplexNumber(log(2), π)) ≈ ComplexNumber(-2, 0)
end

# Bonus B
@testset "Syntax sugar jm" begin
    @test_skip ComplexNumber(0, 1)  == jm
    @test_skip ComplexNumber(1, 0)  == 1 + 0jm
    @test_skip ComplexNumber(1, 1)  == 1 + 1jm
    @test_skip ComplexNumber(-1, 0) == jm^2
end
