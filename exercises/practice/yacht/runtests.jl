using Test

include("yacht.jl")

@testset verbose = true "tests" begin
    @testset "Yacht" begin
        @test score([5, 5, 5, 5, 5], "yacht") == 50
    end

    @testset "Not Yacht" begin
        @test score([1, 3, 3, 2, 5], "yacht") == 0
    end

    @testset "Ones" begin
        @test score([1, 1, 1, 3, 5], "ones") == 3
    end

    @testset "Ones, out of order" begin
        @test score([3, 1, 1, 5, 1], "ones") == 3
    end

    @testset "No ones" begin
        @test score([4, 3, 6, 5, 5], "ones") == 0
    end

    @testset "Twos" begin
        @test score([2, 3, 4, 5, 6], "twos") == 2
    end

    @testset "Fours" begin
        @test score([1, 4, 1, 4, 1], "fours") == 8
    end

    @testset "Yacht counted as threes" begin
        @test score([3, 3, 3, 3, 3], "threes") == 15
    end

    @testset "Yacht of 3s counted as fives" begin
        @test score([3, 3, 3, 3, 3], "fives") == 0
    end

    @testset "Fives" begin
        @test score([1, 5, 3, 5, 3], "fives") == 10
    end

    @testset "Sixes" begin
        @test score([2, 3, 4, 5, 6], "sixes") == 6
    end

    @testset "Full house two small, three big" begin
        @test score([2, 2, 4, 4, 4], "full house") == 16
    end

    @testset "Full house three small, two big" begin
        @test score([5, 3, 3, 5, 3], "full house") == 19
    end

    @testset "Two pair is not a full house" begin
        @test score([2, 2, 4, 4, 5], "full house") == 0
    end

    @testset "Four of a kind is not a full house" begin
        @test score([1, 4, 4, 4, 4], "full house") == 0
    end

    @testset "Yacht is not a full house" begin
        @test score([2, 2, 2, 2, 2], "full house") == 0
    end

    @testset "Four of a Kind" begin
        @test score([6, 6, 4, 6, 6], "four of a kind") == 24
    end

    @testset "Yacht can be scored as Four of a Kind" begin
        @test score([3, 3, 3, 3, 3], "four of a kind") == 12
    end

    @testset "Full house is not Four of a Kind" begin
        @test score([3, 3, 3, 5, 5], "four of a kind") == 0
    end

    @testset "Little Straight" begin
        @test score([3, 5, 4, 1, 2], "little straight") == 30
    end

    @testset "Little Straight as Big Straight" begin
        @test score([1, 2, 3, 4, 5], "big straight") == 0
    end

    @testset "Four in order but not a little straight" begin
        @test score([1, 1, 2, 3, 4], "little straight") == 0
    end

    @testset "No pairs but not a little straight" begin
        @test score([1, 2, 3, 4, 6], "little straight") == 0
    end

    @testset "Minimum is 1, maximum is 5, but not a little straight" begin
        @test score([1, 1, 3, 4, 5], "little straight") == 0
    end

    @testset "Big Straight" begin
        @test score([4, 6, 2, 5, 3], "big straight") == 30
    end

    @testset "Big Straight as little straight" begin
        @test score([6, 5, 4, 3, 2], "little straight") == 0
    end

    @testset "No pairs but not a big straight" begin
        @test score([6, 5, 4, 3, 1], "big straight") == 0
    end

    @testset "Choice" begin
        @test score([3, 3, 5, 6, 6], "choice") == 23
    end

    @testset "Yacht as choice" begin
        @test score([2, 2, 2, 2, 2], "choice") == 10
    end
end

