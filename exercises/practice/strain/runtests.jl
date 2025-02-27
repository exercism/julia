using Test

include("strain.jl")

@testset verbose = true "tests" begin
    @testset "keep" begin
        @testset "keep on empty list returns empty list" begin
            values = []
            predicate = x -> true
            result = keep(values, predicate)
            expected = []
            @test result == expected
        end

        @testset "keeps everything" begin
            values = [1, 3, 5]
            predicate = x -> true
            result = keep(values, predicate)
            expected = [1, 3, 5]
            @test result == expected
        end

        @testset "keeps nothing" begin
            values = [1, 3, 5]
            predicate = x -> false
            result = keep(values, predicate)
            expected = []
            @test result == expected
        end

        @testset "keeps first and last" begin
            values = [1, 2, 3]
            predicate = x -> x % 2 == 1
            result = keep(values, predicate)
            expected = [1, 3]
            @test result == expected
        end

        @testset "keeps neither first nor last" begin
            values = [1, 2, 3]
            predicate = x -> x % 2 == 0
            result = keep(values, predicate)
            expected = [2]
            @test result == expected
        end

        @testset "keeps strings" begin
            values = ["apple", "zebra", "banana", "zombies", "cherimoya", "zealot"]
            predicate = x -> startswith(x, 'z')
            result = keep(values, predicate)
            expected = ["zebra", "zombies", "zealot"]
            @test result == expected
        end

        @testset "keeps lists" begin
            values = [
                [1, 2, 3],
                [5, 5, 5],
                [5, 1, 2],
                [2, 1, 2],
                [1, 5, 2],
                [2, 2, 1],
                [1, 2, 5]
            ]
            predicate = x -> in(5, x)
            result = keep(values, predicate)
            expected = [
                [5, 5, 5],
                [5, 1, 2],
                [1, 5, 2],
                [1, 2, 5]
            ]
            @test result == expected
        end
    end

    @testset "discard" begin
        @testset "discard on empty list returns empty list" begin
            values = []
            predicate = x -> true
            result = discard(values, predicate)
            expected = []
            @test result == expected
        end

        @testset "discards everything" begin
            values = [1, 3, 5]
            predicate = x -> true
            result = discard(values, predicate)
            expected = []
            @test result == expected
        end

        @testset "discards nothing" begin
            values = [1, 3, 5]
            predicate = x -> false
            result = discard(values, predicate)
            expected = [1, 3, 5]
            @test result == expected
        end

        @testset "discards first and last" begin
            values = [1, 2, 3]
            predicate = x -> x % 2 == 1
            result = discard(values, predicate)
            expected = [2]
            @test result == expected
        end

        @testset "discards neither first nor last" begin
            values = [1, 2, 3]
            predicate = x -> x % 2 == 0
            result = discard(values, predicate)
            expected = [1, 3]
            @test result == expected
        end

        @testset "discards strings" begin
            values = ["apple", "zebra", "banana", "zombies", "cherimoya", "zealot"]
            predicate = x -> startswith(x, 'z')
            result = discard(values, predicate)
            expected = ["apple", "banana", "cherimoya"]
            @test result == expected
        end

        @testset "discards lists" begin
            values = [
                [1, 2, 3],
                [5, 5, 5],
                [5, 1, 2],
                [2, 1, 2],
                [1, 5, 2],
                [2, 2, 1],
                [1, 2, 5]
            ]
            predicate = x -> in(5, x)
            result = discard(values, predicate)
            expected = [
                [1, 2, 3],
                [2, 1, 2],
                [2, 2, 1]
            ]
            @test result == expected
        end
    end
end
