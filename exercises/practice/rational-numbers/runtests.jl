# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/rational-numbers/canonical-data.json
# File last updated on 2026-10-25

using Test

include("rational-numbers.jl")

@testset verbose = true "tests" begin
    @testset "Arithmetic" begin
        @testset "Addition" begin
            @testset "Add two positive rational numbers" begin
                @test RationalNumber(1, 2) + RationalNumber(2, 3) == RationalNumber(7, 6)
            end

            @testset "Add a positive rational number and a negative rational number" begin
                @test RationalNumber(1, 2) + RationalNumber(-2, 3) == RationalNumber(-1, 6)
            end

            @testset "Add two negative rational numbers" begin
                @test RationalNumber(-1, 2) + RationalNumber(-2, 3) == RationalNumber(-7, 6)
            end

            @testset "Add a rational number to its additive inverse" begin
                @test RationalNumber(1, 2) + RationalNumber(-1, 2) == RationalNumber(0, 1)
            end
        end

        @testset "Subtraction" begin
            @testset "Subtract two positive rational numbers" begin
                @test RationalNumber(1, 2) - RationalNumber(2, 3) == RationalNumber(-1, 6)
            end

            @testset "Subtract a positive rational number and a negative rational number" begin
                @test RationalNumber(1, 2) - RationalNumber(-2, 3) == RationalNumber(7, 6)
            end

            @testset "Subtract two negative rational numbers" begin
                @test RationalNumber(-1, 2) - RationalNumber(-2, 3) == RationalNumber(1, 6)
            end

            @testset "Subtract a rational number from itself" begin
                @test RationalNumber(1, 2) - RationalNumber(1, 2) == RationalNumber(0, 1)
            end
        end

        @testset "Multiplication" begin
            @testset "Multiply two positive rational numbers" begin
                @test RationalNumber(1, 2) * RationalNumber(2, 3) == RationalNumber(1, 3)
            end

            @testset "Multiply a negative rational number by a positive rational number" begin
                @test RationalNumber(-1, 2) * RationalNumber(2, 3) == RationalNumber(-1, 3)
            end

            @testset "Multiply two negative rational numbers" begin
                @test RationalNumber(-1, 2) * RationalNumber(-2, 3) == RationalNumber(1, 3)
            end

            @testset "Multiply a rational number by its reciprocal" begin
                @test RationalNumber(1, 2) * RationalNumber(2, 1) == RationalNumber(1, 1)
            end

            @testset "Multiply a rational number by 1" begin
                @test RationalNumber(1, 2) * RationalNumber(1, 1) == RationalNumber(1, 2)
            end

            @testset "Multiply a rational number by 0" begin
                @test RationalNumber(1, 2) * RationalNumber(0, 1) == RationalNumber(0, 1)
            end
        end

        @testset "Division" begin
            @testset "Divide two positive rational numbers" begin
                @test RationalNumber(1, 2) / RationalNumber(2, 3) == RationalNumber(3, 4)
            end

            @testset "Divide a positive rational number by a negative rational number" begin
                @test RationalNumber(1, 2) / RationalNumber(-2, 3) == RationalNumber(-3, 4)
            end

            @testset "Divide two negative rational numbers" begin
                @test RationalNumber(-1, 2) / RationalNumber(-2, 3) == RationalNumber(3, 4)
            end

            @testset "Divide a rational number by 1" begin
                @test RationalNumber(1, 2) / RationalNumber(1, 1) == RationalNumber(1, 2)
            end
        end
    end

    @testset "Absolute value" begin
        @testset "Absolute value of a positive rational number" begin
            @test abs(RationalNumber(1, 2)) == RationalNumber(1, 2)
        end

        @testset "Absolute value of a positive rational number with negative numerator and denominator" begin
            @test abs(RationalNumber(-1, -2)) == RationalNumber(1, 2)
        end

        @testset "Absolute value of a negative rational number" begin
            @test abs(RationalNumber(-1, 2)) == RationalNumber(1, 2)
        end

        @testset "Absolute value of a negative rational number with negative denominator" begin
            @test abs(RationalNumber(1, -2)) == RationalNumber(1, 2)
        end

        @testset "Absolute value of zero" begin
            @test abs(RationalNumber(0, 1)) == RationalNumber(0, 1)
        end

        @testset "Absolute value of a rational number is reduced to lowest terms" begin
            @test abs(RationalNumber(2, 4)) == RationalNumber(1, 2)
        end
    end

    @testset "Exponentiation of a rational number" begin
        @testset "Raise a positive rational number to a positive integer power" begin
            @test RationalNumber(1, 2)^3 == RationalNumber(1, 8)
        end

        @testset "Raise a negative rational number to a positive integer power" begin
            @test RationalNumber(-1, 2)^3 == RationalNumber(-1, 8)
        end

        @testset "Raise a positive rational number to a negative integer power" begin
            @test RationalNumber(3, 5)^-2 == RationalNumber(25, 9)
        end

        @testset "Raise a negative rational number to an even negative integer power" begin
            @test RationalNumber(-3, 5)^-2 == RationalNumber(25, 9)
        end

        @testset "Raise a negative rational number to an odd negative integer power" begin
            @test RationalNumber(-3, 5)^-3 == RationalNumber(-125, 27)
        end

        @testset "Raise zero to an integer power" begin
            @test RationalNumber(0, 1)^5 == RationalNumber(0, 1)
        end

        @testset "Raise one to an integer power" begin
            @test RationalNumber(1, 1)^4 == RationalNumber(1, 1)
        end

        @testset "Raise a positive rational number to the power of zero" begin
            @test RationalNumber(1, 2)^0 == RationalNumber(1, 1)
        end

        @testset "Raise a negative rational number to the power of zero" begin
            @test RationalNumber(-1, 2)^0 == RationalNumber(1, 1)
        end
    end

    @testset "Exponentiation of a real number to a rational number" begin
        @testset "Raise a real number to a positive rational number" begin
            @test 8^RationalNumber(4, 3) ≈ 16.0
        end

        @testset "Raise a real number to a negative rational number" begin
            @test 9^RationalNumber(-1, 2) ≈ 0.3333333333333333
        end

        @testset "Raise a real number to a zero rational number" begin
            @test 2^RationalNumber(0, 1) ≈ 1.0
        end
    end

    @testset "Reduction to lowest terms" begin
        @testset "Reduce a positive rational number to lowest terms" begin
            r = RationalNumber(2, 4)
            @test numerator(r) == 1
            @test denominator(r) == 2
        end

        @testset "Reduce places the minus sign on the numerator" begin
            r = RationalNumber(3, -4)
            @test numerator(r) == -3
            @test denominator(r) == 4
        end

        @testset "Reduce a negative rational number to lowest terms" begin
            r = RationalNumber(-4, 6)
            @test numerator(r) == -2
            @test denominator(r) == 3
        end

        @testset "Reduce a rational number with a negative denominator to lowest terms" begin
            r = RationalNumber(3, -9)
            @test numerator(r) == -1
            @test denominator(r) == 3
        end

        @testset "Reduce zero to lowest terms" begin
            r = RationalNumber(0, 6)
            @test numerator(r) == 0
            @test denominator(r) == 1
        end

        @testset "Reduce an integer to lowest terms" begin
            r = RationalNumber(-14, 7)
            @test numerator(r) == -2
            @test denominator(r) == 1
        end

        @testset "Reduce one to lowest terms" begin
            r = RationalNumber(13, 13)
            @test numerator(r) == 1
            @test denominator(r) == 1
        end
    end

    # To enable bonus tests for Julia's number interfaces, uncomment the
    # `enable_bonus_tests = true` line in your solution file
    if @isdefined(enable_bonus_tests) && enable_bonus_tests
        println("\nBonus tests enabled.\n")

        @testset "Bonus: Julia number interfaces" begin
            @testset "Subtype of Real" begin
                @test RationalNumber <: Real
            end

            @testset "Zero denominator and zero numerator" begin
                @test_throws ArgumentError RationalNumber(0, 0)
            end

            @testset "Conversion and promotion" begin
                # To pass these tests you should define a promote_rule method and a
                # constructor, you don't need to define methods such as
                # `==(a::RationalNumber{Int}, b::Int)`, `promote_type`, `convert`, etc.
                #
                # Read the manual for how to do this and why:
                # https://docs.julialang.org/en/v1/manual/conversion-and-promotion/
                @test RationalNumber{Int}(10) == 10
                @test promote_type(Int, RationalNumber{Int}) == RationalNumber{Int}
                @test convert(RationalNumber{Int8}, 2) isa RationalNumber{Int8}
            end

            @testset "One- & Zero-elements" begin
                @test zero(RationalNumber{Int}) == RationalNumber(0, 1)
                @test one(RationalNumber{Int}) == RationalNumber(1, 1)
            end

            @testset "Arithmetic with integers" begin
                @test RationalNumber(1, 2) + 4 == RationalNumber(9, 2)
                @test 4 + RationalNumber(1, 2) == RationalNumber(9, 2)
            end

            # The following testset is based on the tests for rational numbers in Julia Base (MIT license)
            # https://github.com/JuliaLang/julia/blob/52bafeb981bac548afd2264edb518d8d86944dca/test/rational.jl
            # https://github.com/JuliaLang/julia/blob/52bafeb981bac548afd2264edb518d8d86944dca/LICENSE.md
            @testset "Ordering" begin
                for a in -5:5, b in -5:5, c in -5:5
                    b == 0 && continue

                    r = RationalNumber(a, b)

                    @test (r == c) == (a / b == c)
                    @test (r != c) == (a / b != c)
                    @test (r <= c) == (a / b <= c)
                    @test (r < c) == (a / b < c)
                    @test (r >= c) == (a / b >= c)
                    @test (r > c) == (a / b > c)

                    for d in -5:5
                        d == 0 && continue

                        s = RationalNumber(c, d)

                        @test (r == s) == (a / b == c / d)
                        @test (r != s) == (a / b != c / d)
                        @test (r <= s) == (a / b <= c / d)
                        @test (r < s) == (a / b < c / d)
                        @test (r >= s) == (a / b >= c / d)
                        @test (r > s) == (a / b > c / d)
                    end
                end
            end
        end
    end
end
