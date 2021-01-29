using Test

include("minesweeper.jl")

@testset "no rows" begin
    @test annotate([]) == []
end

@testset "no columns" begin
    @test annotate([""]) == [""]
end

@testset "no mines" begin
    minefield = ["   ",
                 "   ",
                 "   "]
    out = ["   ",
           "   ",
           "   "]
    @test annotate(minefield) == out
end

@testset "minefield only mines" begin
    minefield = ["***",
                 "***",
                 "***"]
    out = ["***",
           "***",
           "***"]
    @test annotate(minefield) == out
end

@testset "mine surrounded by spaces" begin
    minefield = ["   ",
                 " * ",
                 "   "]
    out = ["111",
           "1*1",
           "111"]
    @test annotate(minefield) == out
end

@testset "space surrounded by mines" begin
    minefield = ["***",
                 "* *",
                 "***"]
    out = ["***",
           "*8*",
           "***"]
    @test annotate(minefield) == out
end

@testset "horizontal line" begin
    minefield = [" * * "]
    out = ["1*2*1"]
    @test annotate(minefield) == out
end

@testset "horizontal line mines at edges" begin
    minefield = ["*   *"]
    out = ["*1 1*"]
    @test annotate(minefield) == out
end

@testset "vertical line" begin
    minefield = [" ",
                 "*",
                 " ",
                 "*",
                 " "]
    out = ["1",
           "*",
           "2",
           "*",
           "1"]
    @test annotate(minefield) == out
end

@testset "vertical line mines at edges" begin
    minefield = ["*",
                 " ",
                 " ",
                 " ",
                 "*"]
    out = ["*",
           "1",
           " ",
           "1",
           "*"]
    @test annotate(minefield) == out
end

@testset "cross" begin
    minefield = ["  *  ",
                 "  *  ",
                 "*****",
                 "  *  ",
                 "  *  "]
    out = [" 2*2 ",
           "25*52",
           "*****",
           "25*52",
           " 2*2 "]
    @test annotate(minefield) == out
end

@testset "large minefield" begin
    minefield = [" *  * ",
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
    @test annotate(minefield) == out
end
