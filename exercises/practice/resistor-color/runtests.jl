using Test

include("resistor-color.jl")

@testset verbose = true "tests" begin
    @testset "Black" begin
        @test colorcode("black") == 0
    end

    @testset "White" begin
        @test colorcode("white") == 9
    end

    @testset "Orange" begin
        @test colorcode("orange") == 3
    end

    @testset "Colors" begin
        expected_colors = [
            "black",
            "brown",
            "red",
            "orange",
            "yellow",
            "green",
            "blue",
            "violet",
            "grey",
            "white"
        ]
        @test all(colors() .== expected_colors)
    end
end
