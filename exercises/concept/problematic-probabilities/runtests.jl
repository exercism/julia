using Test

include("problematic-probabilities.jl")

@testset verbose = true "tests" begin
    @testset "rationalize" begin
        @test rationalize([2], [4]) == [1//2]
        @test rationalize([1, 2, 3, 4], [2, 3, 4, 5]) == [1//2, 2//3, 3//4, 4//5]
    end

    @testset "probabilities" begin
        @test probabilities([2], [4]) == [2/4]
        @test probabilities([1, 2, 3, 4], [2, 3, 4, 5]) == [1/2, 2/3, 3/4, 4/5]
    end

    @testset "check mean" begin
        successes, trials = [5, 8, 6, 1, 5], [11, 16, 17, 22, 18]
        @test checkmean(successes, trials)

        successes, trials = [9, 2, 3, 9, 6], [23, 10, 15, 23, 10]
        @test checkmean(successes, trials)
        
        successes, trials = [7, 8, 1, 4, 1], [18, 25, 19, 12, 23]
        @test checkmean(successes, trials) == 223853//983250

        successes, trials = [6, 3, 1, 1, 1], [12, 10, 21, 11, 10]
        @test checkmean(successes, trials) == 2399//11550
    end

    @testset "check probability" begin
        successes, trials = [4, 2, 4, 3, 2], [18, 20, 18, 25, 22]
        @test checkprob(successes, trials)

        successes, trials = [2, 3, 4, 6, 2], [14, 24, 24, 16, 23]
        @test checkprob(successes, trials)

        successes, trials = [6, 2, 2, 9, 8], [18, 23, 12, 18, 16]
        @test checkprob(successes, trials) == 1//828

        successes, trials = [9, 3, 7, 6, 7], [11, 17, 13, 13, 17]
        @test checkprob(successes, trials) == 7938//537251
    end
end
