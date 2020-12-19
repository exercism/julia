using Test

include("isbn-verifier.jl")

@test ISBN <: AbstractString

@testset "valid ISBN numbers" begin
    # ISBN number
    @test isvalid(ISBN, "3-598-21508-8")
    # ISBN number with a check digit of 10
    @test isvalid(ISBN, "3-598-21507-X")
    # ISBN without separating dashes
    @test isvalid(ISBN, "3598215088")
    # ISBN without separating dashes and X as check digit
    @test isvalid(ISBN, "359821507X")
end

@testset "invalid ISBN numbers" begin
    # invalid ISBN check digit
    @test !isvalid(ISBN, "3-598-21508-9")
    # check digit is a character other than X
    @test !isvalid(ISBN, "3-598-21507-A")
    # invalid character in ISBN
    @test !isvalid(ISBN, "3-598-2K507-0")
    # X is only valid as a check isdigit
    @test !isvalid(ISBN, "3-598-2X507-9")
    # ISBN without check digit and dashes
    @test !isvalid(ISBN, "359821507")
    # too long ISBN and no dashes
    @test !isvalid(ISBN, "3598215078X")
    # ISBN without check digit
    @test !isvalid(ISBN, "3-598-21507")
    # too long ISBN
    @test !isvalid(ISBN, "3-598-21507-XX")
    # check digit of X should not be used for 0
    @test !isvalid(ISBN, "3-598-21515-X")
    # empty ISBN
    @test !isvalid(ISBN, "")
    # invalid character in ISBN
    @test !isvalid(ISBN, "3-598-P1581-X")
    # too short ISBN
    @test !isvalid(ISBN, "00")
    # input is 9 characters
    @test !isvalid(ISBN, "134456729")
    # invalid characters are not ignored
    @test !isvalid(ISBN, "3132P34035")
    # input is too long but contains a valid ISBN
    @test !isvalid(ISBN, "98245726788")
end

@testset "constructing valid ISBN numbers" begin
    # ISBN number
    @test string(isbn"3-598-21508-8") == "3598215088"
    # ISBN number with a check digit of 10
    @test string(isbn"3-598-21507-X") == "359821507X"
    # ISBN without separating dashes
    @test string(isbn"3598215088") == "3598215088"
    # ISBN without separating dashes and X as check digit
    @test string(isbn"359821507X") == "359821507X"
end

@testset "constructing invalid ISBN numbers" begin
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
