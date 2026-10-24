# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/isbn-verifier/canonical-data.json
# File last updated on 2026-10-24

using Test

include("isbn-verifier.jl")

"""
    @test_nothrow expr

Test that the expression `expr` does not throw an exception.
"""
# Julia doesn't include this because you would usually test some property of
# your object rather than checking if an exception was thrown.
# We define this anyway so that you can focus on the validation logic.
macro test_nothrow(expr)
    return :(@test ($expr; true))
end

@testset verbose = true "tests" begin
    @testset "valid isbn" begin
        @test_nothrow ISBN("3-598-21508-8")
    end

    @testset "invalid isbn check digit" begin
        @test_throws DomainError ISBN("3-598-21508-9")
    end

    @testset "valid isbn with a check digit of 10" begin
        @test_nothrow ISBN("3-598-21507-X")
    end

    @testset "check digit is a character other than X" begin
        @test_throws DomainError ISBN("3-598-21507-A")
    end

    @testset "invalid check digit in isbn is not treated as zero" begin
        @test_throws DomainError ISBN("4-598-21507-B")
    end

    @testset "invalid character in isbn is not treated as zero" begin
        @test_throws DomainError ISBN("3-598-P1581-X")
    end

    @testset "X is only valid as a check digit" begin
        @test_throws DomainError ISBN("3-598-2X507-9")
    end

    @testset "only one check digit is allowed" begin
        @test_throws DomainError ISBN("3-598-21508-96")
    end

    @testset "X is not substituted by the value 10" begin
        @test_throws DomainError ISBN("3-598-2X507-5")
    end

    @testset "valid isbn without separating dashes" begin
        @test_nothrow ISBN("3598215088")
    end

    @testset "isbn without separating dashes and X as check digit" begin
        @test_nothrow ISBN("359821507X")
    end

    @testset "isbn without check digit and dashes" begin
        @test_throws DomainError ISBN("359821507")
    end

    @testset "too long isbn and no dashes" begin
        @test_throws DomainError ISBN("3598215078X")
    end

    @testset "too short isbn" begin
        @test_throws DomainError ISBN("00")
    end

    @testset "isbn without check digit" begin
        @test_throws DomainError ISBN("3-598-21507")
    end

    @testset "check digit of X should not be used for 0" begin
        @test_throws DomainError ISBN("3-598-21515-X")
    end

    @testset "empty isbn" begin
        @test_throws DomainError ISBN("")
    end

    @testset "input is 9 characters" begin
        @test_throws DomainError ISBN("134456729")
    end

    @testset "invalid characters are not ignored after checking length" begin
        @test_throws DomainError ISBN("3132P34035")
    end

    @testset "invalid characters are not ignored before checking length" begin
        @test_throws DomainError ISBN("3598P215088")
    end

    @testset "input is too long but contains a valid isbn" begin
        @test_throws DomainError ISBN("98245726788")
    end
end
