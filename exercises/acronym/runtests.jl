# canonical test version 1.7.0

using Test

include("acronym.jl")


@testset "basic" begin
    @test myacronym("Portable Network Graphics") == "PNG"
end

@testset "lowercase words" begin
    @test myacronym("Ruby on Rails") == "ROR"
end

@testset "punctuation" begin
    @test myacronym("First In, First Out") == "FIFO"
end

@testset "all caps word" begin
    @test myacronym("GNU Image Manipulation Program") == "GIMP"
end

@testset "punctuation without whitespace" begin
    @test myacronym("Complementary metal-oxide semiconductor") == "CMOS"
end

@testset "very long abbreviation" begin
    @test myacronym("Rolling On The Floor Laughing So Hard That My Dogs Came Over And Licked Me") == "ROTFLSHTMDCOALM"
end

@testset "consecutive delimiters" begin
    @test myacronym("Something - I made up from thin air") == "SIMUFTA"
end

@testset "apostrophes" begin
    @test myacronym("Halley's Comet") == "HC"
end

@testset "underscore emphasis" begin
    @test myacronym("The Road _Not_ Taken") == "TRNT"
end