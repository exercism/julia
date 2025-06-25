using Test

include("flower-field.jl")

@testset verbose = true "tests" begin
    @testset "no rows" begin
        @test annotate([]) == []
    end

    @testset "no columns" begin
        @test annotate([""]) == [""]
    end

    @testset "no flowers" begin
        flowerfield = ["   ",
                       "   ",
                       "   "]
        out = ["   ",
               "   ",
               "   "]
        @test annotate(flowerfield) == out
    end

    @testset "garden full of flowers" begin
        flowerfield = ["***",
                       "***",
                       "***"]
        out = ["***",
               "***",
               "***"]
        @test annotate(flowerfield) == out
    end

    @testset "flower surrounded by spaces" begin
        flowerfield = ["   ",
                       " * ",
                       "   "]
        out = ["111",
               "1*1",
               "111"]
        @test annotate(flowerfield) == out
    end

    @testset "space surrounded by flowers" begin
        flowerfield = ["***",
                       "* *",
                       "***"]
        out = ["***",
               "*8*",
               "***"]
        @test annotate(flowerfield) == out
    end

    @testset "horizontal line" begin
        flowerfield = [" * * "]
        out = ["1*2*1"]
        @test annotate(flowerfield) == out
    end

    @testset "horizontal line, flowers at edges" begin
        flowerfield = ["*   *"]
        out = ["*1 1*"]
        @test annotate(flowerfield) == out
    end

    @testset "vertical line" begin
        flowerfield = [" ",
                       "*",
                       " ",
                       "*",
                       " "]
        out = ["1",
               "*",
               "2",
               "*",
               "1"]
        @test annotate(flowerfield) == out
    end

    @testset "vertical line, flowers at edges" begin
        flowerfield = ["*",
                       " ",
                       " ",
                       " ",
                       "*"]
        out = ["*",
               "1",
               " ",
               "1",
               "*"]
        @test annotate(flowerfield) == out
    end

    @testset "cross" begin
        flowerfield = ["  *  ",
                       "  *  ",
                       "*****",
                       "  *  ",
                       "  *  "]
        out = [" 2*2 ",
               "25*52",
               "*****",
               "25*52",
               " 2*2 "]
        @test annotate(flowerfield) == out
    end

    @testset "large garden" begin
        flowerfield = [" *  * ",
                       "  *   ",
                       "    * ",
                       "   * *",
                       " *  * ",
                       "      "]
        out = ["1*22*1",
               "12*322",
               " 123*2",
               "112*4*",
               "1*22*2",
               "111111"]
        @test annotate(flowerfield) == out
    end
end
