using Test

include("dominoes.jl")

@testset verbose = true "tests" begin
    @testset "empty input = empty output" begin
        @test dominoes([]) == true
    end
    
    @testset "singleton input = singleton output" begin
        @test dominoes([1, 1]) == true
    end
    
    @testset "singleton that can't be chained" begin
        @test dominoes([1, 2]) == false
    end
    
    @testset "three elements" begin
        @test dominoes([[1, 2], [3, 1], [2, 3]]) == true
    end
    
    @testset "can reverse dominoes" begin 
        @test dominoes([[1, 2], [1, 3], [2, 3]]) == true
    end
    
    @testset "can't be chained" begin
        @test dominoes([[1, 2], [4, 1], [2, 3]]) == false
    end
    
    @testset "disconnected - simple" begin
        @test dominoes([[1, 1], [2, 2]]) == false
    end
    
    @testset "disconnected - double loop" begin
        @test dominoes([[1, 2], [2, 1], [3, 4], [4, 3]]) == false
    end
    
    @testset "disconnected - single isolated" begin
        @test dominoes([[1, 2], [2, 3], [3, 1], [4, 4]]) == false
    end
    
    @testset "need backtrack" begin
        @test dominoes([[1, 2], [2, 3], [3, 1], [2, 4], [2, 4]]) == true
    end
    
    @testset "separate loops" begin
        @test dominoes([[1, 2], [2, 3], [3, 1], [1, 1], [2, 2], [3, 3]]) == true
    end
    
    @testset "nine elements" begin
        @test dominoes([[1, 2], [5, 3], [3, 1], [1, 2], [2, 4], [1, 6], [2, 3], [3, 4], [5, 6]]) == true
    end
    
    @testset "separate three-domino loops" begin
        @test dominoes([[1, 2], [2, 3], [3, 1], [4, 5], [5, 6], [6, 4]]) == false
    end
end
