using Test

include("game-of-life.jl")

@testset verbose = true "tests" begin
    @testset "empty matrix" begin
        matrix = reshape([], 0,2)
        
        expected = reshape([], 0,2)
        @test gameoflife(matrix) == expected
    end
    
    @testset "live cells with zero live neighbors die" begin
        matrix = [0 0 0;
                  0 1 0;
                  0 0 0]
     
        expected = [0 0 0;
                    0 0 0;
                    0 0 0]
        @test gameoflife(matrix) == expected 
    end
    
    @testset "live cells with only one live neighbor die" begin
        matrix = [0 0 0;
                  0 1 0;
                  0 1 0]
    
        expected = [0 0 0;
                    0 0 0;
                    0 0 0]
        @test gameoflife(matrix) == expected 
    end
    
    @testset "live cells with two live neighbors stay alive" begin
        matrix = [1 0 1;
                  1 0 1;
                  1 0 1]
    
        expected = [0 0 0;
                    1 0 1;
                    0 0 0]
        @test gameoflife(matrix) == expected             
    end
    
    @testset "live cells with three live neighbors stay alive" begin
        matrix = [0 1 0;
                  1 0 0;
                  1 1 0]
    
        expected = [0 0 0;
                    1 0 0;
                    1 1 0]
        @test gameoflife(matrix) == expected
    end
    
    @testset "dead cells with three live neighbors become alive" begin
        matrix = [1 1 0;
                  0 0 0;
                  1 0 0]
    
        expected = [0 0 0;
                    1 1 0;
                    0 0 0]
        @test gameoflife(matrix) == expected
    end
    
    @testset "live cells with four or more neighbors die" begin
        matrix = [1 1 1;
                  1 1 1;
                  1 1 1]
    
        expected = [1 0 1;
                    0 0 0;
                    1 0 1]
        @test gameoflife(matrix) == expected
    end
    
    @testset "bigger matrix" begin
        matrix = [1 1 0 1 1 0 0 0;
                  1 0 1 1 0 0 0 0;
                  1 1 1 0 0 1 1 1;
                  0 0 0 0 0 1 1 0;
                  1 0 0 0 1 1 0 0;
                  1 1 0 0 0 1 1 1;
                  0 0 1 0 1 0 0 1;
                  1 0 0 0 0 0 1 1]
    
        expected = [1 1 0 1 1 0 0 0;
                    0 0 0 0 0 1 1 0;
                    1 0 1 1 1 1 0 1;
                    1 0 0 0 0 0 0 1;
                    1 1 0 0 1 0 0 1;
                    1 1 0 1 0 0 0 1;
                    1 0 0 0 0 0 0 0;
                    0 0 0 0 0 0 1 1]
        @test gameoflife(matrix) == expected
    end
end
