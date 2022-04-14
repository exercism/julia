using Test

include("rational-numbers.jl")

@test RationalNumber <: Real
@test_throws ArgumentError RationalNumber(0, 0)

@testset "One- & Zero-elements" begin
    @test zero(RationalNumber{Int}) == RationalNumber(0, 1)
    @test one(RationalNumber{Int})  == RationalNumber(1, 1)
end

@testset "Arithmetic" begin
    @testset "Addition" begin
        @test RationalNumber( 1, 2) + RationalNumber( 2, 3) == RationalNumber( 7, 6)
        @test RationalNumber( 1, 2) + RationalNumber(-2, 3) == RationalNumber(-1, 6)
        @test RationalNumber(-1, 2) + RationalNumber(-2, 3) == RationalNumber(-7, 6)
        @test RationalNumber( 1, 2) + RationalNumber(-1, 2) == RationalNumber( 0, 1)
    end

    @testset "Subtraction" begin
        @test RationalNumber( 1, 2) - RationalNumber( 2, 3) == RationalNumber(-1, 6)
        @test RationalNumber( 1, 2) - RationalNumber(-2, 3) == RationalNumber( 7, 6)
        @test RationalNumber(-1, 2) - RationalNumber(-2, 3) == RationalNumber( 1, 6)
        @test RationalNumber( 1, 2) - RationalNumber( 1, 2) == RationalNumber( 0, 1)
    end

    @testset "Multiplication" begin
        @test RationalNumber( 1, 2) * RationalNumber( 2, 3) == RationalNumber( 1, 3)
        @test RationalNumber(-1, 2) * RationalNumber( 2, 3) == RationalNumber(-1, 3)
        @test RationalNumber(-1, 2) * RationalNumber(-2, 3) == RationalNumber( 1, 3)
        @test RationalNumber( 1, 2) * RationalNumber( 2, 1) == RationalNumber( 1, 1)
        @test RationalNumber( 1, 2) * RationalNumber( 1, 1) == RationalNumber( 1, 2)
        @test RationalNumber( 1, 2) * RationalNumber( 0, 1) == RationalNumber( 0, 1)
    end

    @testset "Exponentiation" begin
        @testset "Exponentiation of a rational number" begin
            @test RationalNumber( 1, 2)^3  == RationalNumber(   1,  8)
            @test RationalNumber(-1, 2)^3  == RationalNumber(  -1,  8)
            @test RationalNumber( 0, 1)^5  == RationalNumber(   0,  1)
            @test RationalNumber( 1, 1)^4  == RationalNumber(   1,  1)
            @test RationalNumber( 1, 2)^0  == RationalNumber(   1,  1)
            @test RationalNumber(-1, 2)^0  == RationalNumber(   1,  1)
            @test RationalNumber( 3, 5)^-2 == RationalNumber(  25,  9)
            @test RationalNumber(-3, 5)^-3 == RationalNumber(-125, 27)
        end

        @testset "Exponentiation of a real number to a rational number" begin
            @test 8^RationalNumber( 4, 3) ≈ 15.999999999999998
            @test 9^RationalNumber(-1, 2) ≈ 0.3333333333333333
            @test 2^RationalNumber( 0, 1) ≈ 1.0
        end
    end

    @testset "Division" begin
        @test RationalNumber( 1, 2) / RationalNumber( 2, 3) == RationalNumber( 3, 4)
        @test RationalNumber( 1, 2) / RationalNumber(-2, 3) == RationalNumber(-3, 4)
        @test RationalNumber(-1, 2) / RationalNumber(-2, 3) == RationalNumber( 3, 4)
        @test RationalNumber( 1, 2) / RationalNumber( 1, 1) == RationalNumber( 1, 2)
    end
end

@testset "Absolute value" begin
    @test abs(RationalNumber( 1,  2)) == RationalNumber(1, 2)
    @test abs(RationalNumber(-1,  2)) == RationalNumber(1, 2)
    @test abs(RationalNumber( 0,  1)) == RationalNumber(0, 1)
    @test abs(RationalNumber( 1, -2)) == RationalNumber(1, 2)
    @test abs(RationalNumber( 2,  4)) == RationalNumber(1, 2)
end

@testset "Reduction to lowest terms" begin
    r = RationalNumber(2, 4)
    @test numerator(r)   == 1
    @test denominator(r) == 2
    
    r = RationalNumber(-4, 6)
    @test numerator(r)   == -2
    @test denominator(r) ==  3
    
    r = RationalNumber(3, -9)
    @test numerator(r)   == -1
    @test denominator(r) ==  3
    
    r = RationalNumber(0, 6)
    @test numerator(r)   == 0
    @test denominator(r) == 1
    
    r = RationalNumber(-14, 7)
    @test numerator(r)   == -2
    @test denominator(r) ==  1
    
    r = RationalNumber(13, 13)
    @test numerator(r)   == 1
    @test denominator(r) == 1
    
    r = RationalNumber(1, -1)
    @test numerator(r)   == -1
    @test denominator(r) ==  1

    r = RationalNumber(3, -4)
    @test numerator(r)   == -3
    @test denominator(r) ==  4
end

# TODO add to problem spec
# The following testset is based on the tests for rational numbers in Julia Base (MIT license)
# https://github.com/JuliaLang/julia/blob/52bafeb981bac548afd2264edb518d8d86944dca/test/rational.jl
# https://github.com/JuliaLang/julia/blob/52bafeb981bac548afd2264edb518d8d86944dca/LICENSE.md
@testset "Ordering" begin
    for a in -5:5, b in -5:5, c in -5:5
        a == b == 0 && continue
        
        r = RationalNumber(a, b)

        @test (r == c) == (a / b == c)
        @test (r != c) == (a / b != c)
        @test (r <= c) == (a / b <= c)
        @test (r <  c) == (a / b <  c)
        @test (r >= c) == (a / b >= c)
        @test (r >  c) == (a / b >  c)

        for d in -5:5
            c == d == 0 && continue

            s = RationalNumber(c, d)

            @test (r == s) == (a / b == c / d)
            @test (r != s) == (a / b != c / d)
            @test (r <= s) == (a / b <= c / d)
            @test (r <  s) == (a / b <  c / d)
            @test (r >= s) == (a / b >= c / d)
            @test (r >  s) == (a / b >  c / d)
        end
    end
end

@testset "Showing RationalNumbers" begin
    @test sprint(show, RationalNumber(23, 42)) == "23//42"
    @test sprint(show, RationalNumber(-2500, 5000)) == "-1//2"
end
