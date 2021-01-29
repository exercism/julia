using Test

include("resistor-color-trio.jl")

@testset "Orange and orange and black" begin
    @test label(["orange", "orange", "black"]) == "33 ohms"
end

@testset "Blue and grey and brown" begin
    @test label(["blue", "grey", "brown"]) == "680 ohms"
end

@testset "Red and black and red" begin
    @test label(["red", "black", "red"]) == "2 kiloohms"
end

@testset "Green and brown and orange" begin
    @test label(["green", "brown", "orange"]) == "51 kiloohms"
end

@testset "Yellow and violet and yellow" begin
    @test label(["yellow", "violet", "yellow"]) == "470 kiloohms"
end

@testset "Orange and orange and red" begin
    @test label(["orange", "orange", "red"]) == "3300 ohms"
end
