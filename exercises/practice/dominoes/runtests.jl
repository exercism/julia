using Test

include("dominoes.jl")

@testset verbose = true "tests" begin
    function runtestset()
        @testset "empty input = empty output" begin
            @test dominoes([]) == []
        end

        @testset "singleton input = singleton output" begin
            chain = dominoes([1, 1])
            @test isvalidchain(chain, true)
        end

        @testset "singleton that can't be chained" begin
            chain = dominoes([1, 2])
            @test isvalidchain(chain, false)
        end

        @testset "three elements" begin
            chain = dominoes([[1, 2], [3, 1], [2, 3]])
            @test isvalidchain(chain, true)
        end

        @testset "can reverse dominoes" begin
            chain = dominoes([[1, 2], [1, 3], [2, 3]])
            @test isvalidchain(chain, true)
        end

        @testset "can't be chained" begin
            chain = dominoes([[1, 2], [4, 1], [2, 3]])
            @test isvalidchain(chain, false)
        end

        @testset "disconnected - simple" begin
            chain = dominoes([[1, 1], [2, 2]])
            @test isvalidchain(chain, false)
        end

        @testset "disconnected - double loop" begin
            chain = dominoes([[1, 2], [2, 1], [3, 4], [4, 3]])
            @test isvalidchain(chain, false)
        end

        @testset "disconnected - single isolated" begin
            chain = dominoes([[1, 2], [2, 3], [3, 1], [4, 4]])
            @test isvalidchain(chain, false)
        end

        @testset "need backtrack" begin
            chain = dominoes([[1, 2], [2, 3], [3, 1], [2, 4], [2, 4]])
            @test isvalidchain(chain, true)
        end

        @testset "separate loops" begin
            chain = dominoes([[1, 2], [2, 3], [3, 1], [1, 1], [2, 2], [3, 3]])
            @test isvalidchain(chain, true)
        end

        @testset "nine elements" begin
            chain = dominoes([[1, 2], [5, 3], [3, 1], [1, 2], [2, 4], [1, 6], [2, 3], [3, 4], [5, 6]])
            @test isvalidchain(chain, true)
        end

        @testset "separate three-domino loops" begin
            chain = dominoes([[1, 2], [2, 3], [3, 1], [4, 5], [5, 6], [6, 4]])
            @test isvalidchain(chain, false)
        end
    end

    function isvalidchain(chain, valid)
        !valid && return isa(chain, Bool) ? !chain : false
        first(first(chain)) != last(last(chain)) && return false
        for i in 1:length(chain)-1
            last(chain[i]) != first(chain[i+1]) && return false
        end
        true
    end

    runtestset()
end
