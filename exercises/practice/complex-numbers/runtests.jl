using Test

include("complex-numbers.jl")

@testset verbose = true "tests" begin
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

    @testset "Complex exponential" begin
        @test exp(ComplexNumber(0, π)) ≈ ComplexNumber(-1.0, 0.0) atol = 1e-15
        @test exp(ComplexNumber(0, 0)) == ComplexNumber(1.0, 0.0)
        @test exp(ComplexNumber(1, 0)) ≈ ComplexNumber(ℯ, 0.0) atol = 1e-15
        @test exp(ComplexNumber(log(2), π)) ≈ ComplexNumber(-2.0, 0.0) atol = 1e-15
        @test exp(ComplexNumber(log(2)/2, π/4)) ≈ ComplexNumber(1.0, 1.0) atol = 1e-15
    end

    # Bonus A
    # Uncomment the following line to enable bonus tests involving arithmetic between real numbers and complex numbers.
    # enable_realcomplex_tests = true
    if @isdefined(enable_realcomplex_tests) && enable_realcomplex_tests
        println("\nBonus real/complex tests enabled.\n")

        @testset "Operations between real numbers and complex numbers" begin
            @test ComplexNumber(1, 2) + 5 == ComplexNumber(6, 2)
            @test 5 + ComplexNumber(1, 2) == ComplexNumber(6, 2)
            @test ComplexNumber(5, 7) - 4 == ComplexNumber(1, 7)
            @test 4 - ComplexNumber(5, 7) == ComplexNumber(-1, -7)
            @test ComplexNumber(2, 5) * 5 == ComplexNumber(10, 25)
            @test 5 * ComplexNumber(2, 5) == ComplexNumber(10, 25)
            @test ComplexNumber(10, 100) / 10 == ComplexNumber(1, 10)
            @test 5 / ComplexNumber(1, 1) == ComplexNumber(2.5, -2.5)
        end
    end

    # Bonus B
    # Uncomment the following line to enable bonus tests for syntax sugar.
    # enable_syntaxsugar_tests = true
    if @isdefined(enable_syntaxsugar_tests) && enable_syntaxsugar_tests
        println("\nBonus syntax sugar tests enabled.\n")

        @testset "Syntax sugar jm" begin
            @test ComplexNumber(0, 1)  == jm
            @test ComplexNumber(1, 0)  == 1 + 0jm
            @test ComplexNumber(1, 1)  == 1 + 1jm
            @test ComplexNumber(-1, 0) == jm^2
        end
    end
end
