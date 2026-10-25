# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/complex-numbers/canonical-data.json
# File last updated on 2026-10-25

using Test

include("complex-numbers.jl")

@testset verbose = true "tests" begin
    @testset "Real part" begin
        @testset "Real part of a purely real number" begin
            @test real(ComplexNumber(1, 0)) == 1
        end

        @testset "Real part of a purely imaginary number" begin
            @test real(ComplexNumber(0, 1)) == 0
        end

        @testset "Real part of a number with real and imaginary part" begin
            @test real(ComplexNumber(1, 2)) == 1
        end
    end

    @testset "Imaginary part" begin
        @testset "Imaginary part of a purely real number" begin
            @test imag(ComplexNumber(1, 0)) == 0
        end

        @testset "Imaginary part of a purely imaginary number" begin
            @test imag(ComplexNumber(0, 1)) == 1
        end

        @testset "Imaginary part of a number with real and imaginary part" begin
            @test imag(ComplexNumber(1, 2)) == 2
        end
    end

    @testset "Imaginary unit" begin
        @test ComplexNumber(0, 1) * ComplexNumber(0, 1) == ComplexNumber(-1, 0)
    end

    @testset "Arithmetic" begin
        @testset "Addition" begin
            @testset "Add purely real numbers" begin
                @test ComplexNumber(1, 0) + ComplexNumber(2, 0) == ComplexNumber(3, 0)
            end

            @testset "Add purely imaginary numbers" begin
                @test ComplexNumber(0, 1) + ComplexNumber(0, 2) == ComplexNumber(0, 3)
            end

            @testset "Add numbers with real and imaginary part" begin
                @test ComplexNumber(1, 2) + ComplexNumber(3, 4) == ComplexNumber(4, 6)
            end
        end

        @testset "Subtraction" begin
            @testset "Subtract purely real numbers" begin
                @test ComplexNumber(1, 0) - ComplexNumber(2, 0) == ComplexNumber(-1, 0)
            end

            @testset "Subtract purely imaginary numbers" begin
                @test ComplexNumber(0, 1) - ComplexNumber(0, 2) == ComplexNumber(0, -1)
            end

            @testset "Subtract numbers with real and imaginary part" begin
                @test ComplexNumber(1, 2) - ComplexNumber(3, 4) == ComplexNumber(-2, -2)
            end
        end

        @testset "Multiplication" begin
            @testset "Multiply purely real numbers" begin
                @test ComplexNumber(1, 0) * ComplexNumber(2, 0) == ComplexNumber(2, 0)
            end

            @testset "Multiply purely imaginary numbers" begin
                @test ComplexNumber(0, 1) * ComplexNumber(0, 2) == ComplexNumber(-2, 0)
            end

            @testset "Multiply numbers with real and imaginary part" begin
                @test ComplexNumber(1, 2) * ComplexNumber(3, 4) == ComplexNumber(-5, 10)
            end
        end

        @testset "Division" begin
            @testset "Divide purely real numbers" begin
                @test ComplexNumber(1, 0) / ComplexNumber(2, 0) ≈ ComplexNumber(0.5, 0)
            end

            @testset "Divide purely imaginary numbers" begin
                @test ComplexNumber(0, 1) / ComplexNumber(0, 2) ≈ ComplexNumber(0.5, 0)
            end

            @testset "Divide numbers with real and imaginary part" begin
                @test ComplexNumber(1, 2) / ComplexNumber(3, 4) ≈ ComplexNumber(0.44, 0.08)
            end
        end
    end

    @testset "Absolute value" begin
        @testset "Absolute value of a positive purely real number" begin
            @test abs(ComplexNumber(5, 0)) == 5
        end

        @testset "Absolute value of a negative purely real number" begin
            @test abs(ComplexNumber(-5, 0)) == 5
        end

        @testset "Absolute value of a purely imaginary number with positive imaginary part" begin
            @test abs(ComplexNumber(0, 5)) == 5
        end

        @testset "Absolute value of a purely imaginary number with negative imaginary part" begin
            @test abs(ComplexNumber(0, -5)) == 5
        end

        @testset "Absolute value of a number with real and imaginary part" begin
            @test abs(ComplexNumber(3, 4)) == 5
        end
    end

    @testset "Complex conjugate" begin
        @testset "Conjugate a purely real number" begin
            @test conj(ComplexNumber(5, 0)) == ComplexNumber(5, 0)
        end

        @testset "Conjugate a purely imaginary number" begin
            @test conj(ComplexNumber(0, 5)) == ComplexNumber(0, -5)
        end

        @testset "Conjugate a number with real and imaginary part" begin
            @test conj(ComplexNumber(1, 1)) == ComplexNumber(1, -1)
        end
    end

    @testset "Complex exponential function" begin
        @testset "Euler's identity/formula" begin
            @test exp(ComplexNumber(0, π)) ≈ ComplexNumber(-1, 0) atol = 1e-15
        end

        @testset "Exponential of 0" begin
            @test exp(ComplexNumber(0, 0)) ≈ ComplexNumber(1, 0) atol = 1e-15
        end

        @testset "Exponential of a purely real number" begin
            @test exp(ComplexNumber(1, 0)) ≈ ComplexNumber(ℯ, 0) atol = 1e-15
        end

        @testset "Exponential of a number with real and imaginary part" begin
            @test exp(ComplexNumber(log(2), π)) ≈ ComplexNumber(-2, 0) atol = 1e-15
        end

        @testset "Exponential resulting in a number with real and imaginary part" begin
            @test exp(ComplexNumber(log(2)/2, π/4)) ≈ ComplexNumber(1, 1) atol = 1e-15
        end
    end

    # Bonus A
    # Uncomment the following line to enable bonus tests involving arithmetic between real numbers and complex numbers.
    # enable_realcomplex_tests = true
    if @isdefined(enable_realcomplex_tests) && enable_realcomplex_tests
        println("\nBonus real/complex tests enabled.\n")

        @testset "Operations between real numbers and complex numbers" begin
            @testset "Add real number to complex number" begin
                @test ComplexNumber(1, 2) + 5 == ComplexNumber(6, 2)
            end

            @testset "Add complex number to real number" begin
                @test 5 + ComplexNumber(1, 2) == ComplexNumber(6, 2)
            end

            @testset "Subtract real number from complex number" begin
                @test ComplexNumber(5, 7) - 4 == ComplexNumber(1, 7)
            end

            @testset "Subtract complex number from real number" begin
                @test 4 - ComplexNumber(5, 7) == ComplexNumber(-1, -7)
            end

            @testset "Multiply complex number by real number" begin
                @test ComplexNumber(2, 5) * 5 == ComplexNumber(10, 25)
            end

            @testset "Multiply real number by complex number" begin
                @test 5 * ComplexNumber(2, 5) == ComplexNumber(10, 25)
            end

            @testset "Divide complex number by real number" begin
                @test ComplexNumber(10, 100) / 10 ≈ ComplexNumber(1, 10)
            end

            @testset "Divide real number by complex number" begin
                @test 5 / ComplexNumber(1, 1) ≈ ComplexNumber(2.5, -2.5)
            end
        end
    end

    # Bonus B
    # Uncomment the following line to enable bonus tests for syntax sugar.
    # enable_syntaxsugar_tests = true
    if @isdefined(enable_syntaxsugar_tests) && enable_syntaxsugar_tests
        println("\nBonus syntax sugar tests enabled.\n")

        @testset "Syntax sugar jm" begin
            @test ComplexNumber(0, 1) == jm
            @test ComplexNumber(1, 0) == 1 + 0jm
            @test ComplexNumber(1, 1) == 1 + 1jm
            @test ComplexNumber(-1, 0) == jm^2
        end
    end
end
