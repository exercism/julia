using Test

include("isbn-verifier.jl")

"""
    @test_nothrow expr

Test that the expression `expr` does not throw an exception.
"""
# Julia doesn't include this because you would usually test some property of
# your object (as we do later) rather than checking if an exception was thrown.
# We define this anyway so that you can focus on the validation logic before
# working out how to make the structs compare equal.
macro test_nothrow(expr)
    :(@test ( $expr; true ))
end

@testset "valid ISBNs don't throw" begin
    # ISBN number
    @test_nothrow ISBN("3-598-21508-8")
    # ISBN number with a check digit of 10
    @test_nothrow ISBN("3-598-21507-X")
    # ISBN without separating dashes
    @test_nothrow ISBN("3598215088")
    # ISBN without separating dashes and X as check digit
    @test_nothrow ISBN("359821507X")
end

@testset "invalid ISBNs throw DomainError" begin
    # invalid ISBN check digit
    @test_throws DomainError ISBN("3-598-21508-9")
    # check digit is a character other than X
    @test_throws DomainError ISBN("3-598-21507-A")
    # invalid character in ISBN
    @test_throws DomainError ISBN("3-598-2K507-0")
    # X is only valid as a check isdigit
    @test_throws DomainError ISBN("3-598-2X507-9")
    # ISBN without check digit and dashes
    @test_throws DomainError ISBN("359821507")
    # too long ISBN and no dashes
    @test_throws DomainError ISBN("3598215078X")
    # ISBN without check digit
    @test_throws DomainError ISBN("3-598-21507")
    # too long ISBN
    @test_throws DomainError ISBN("3-598-21507-XX")
    # check digit of X should not be used for 0
    @test_throws DomainError ISBN("3-598-21515-X")
    # empty ISBN
    @test_throws DomainError ISBN("")
    # invalid character in ISBN
    @test_throws DomainError ISBN("3-598-P1581-X")
    # too short ISBN
    @test_throws DomainError ISBN("00")
    # input is 9 characters
    @test_throws DomainError ISBN("134456729")
    # invalid characters are not ignored
    @test_throws DomainError ISBN("3132P34035")
    # input is too long but contains a valid ISBN
    @test_throws DomainError ISBN("98245726788")
end

@testset "ISBNs compare equal when they're the same number" begin
    @test ISBN("3-598-21508-8") == ISBN("3598215088") != ISBN("3-598-21507-X")
end
