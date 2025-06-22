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

    @testset "average check" begin
        successes, trials = [8, 1, 4, 4, 4], [13, 24, 16, 23, 18]
        @test checkmean(successes, trials)

        successes, trials = [9, 8, 6, 8, 3], [18, 15, 23, 19, 14]
        @test checkmean(successes, trials)
        
        successes, trials = [1, 9, 7, 7, 8], [13, 16, 13, 12, 21]
        @test checkmean(successes, trials) == 3119//7280

        successes, trials = [1, 6, 8, 6, 5], [20, 15, 18, 11, 25]
        @test checkmean(successes, trials) == 3247//9900
    end

    @testset "probability check" begin
        successes, trials = [4, 2, 4, 3, 2], [18, 20, 18, 25, 22]
        @test checkprob(successes, trials)

        successes, trials = [9, 1, 8, 4, 3], [14, 22, 15, 15, 20]
        @test checkprob(successes, trials)

        successes, trials = [6, 2, 2, 9, 8], [18, 23, 12, 18, 16]
        @test checkprob(successes, trials) == 1//828

        successes, trials = [9, 3, 7, 6, 7], [11, 17, 13, 13, 17]
        @test checkprob(successes, trials) == 7938//537251
    end
end
