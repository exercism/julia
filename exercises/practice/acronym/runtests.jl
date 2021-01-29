using Test

include("acronym.jl")


@testset "basic" begin
    @test acronym("Portable Network Graphics") == "PNG"
end

@testset "lowercase words" begin
    @test acronym("Ruby on Rails") == "ROR"
end

@testset "punctuation" begin
    @test acronym("First In, First Out") == "FIFO"
end

@testset "all caps word" begin
    @test acronym("GNU Image Manipulation Program") == "GIMP"
end

@testset "punctuation without whitespace" begin
    @test acronym("Complementary metal-oxide semiconductor") == "CMOS"
end

@testset "very long abbreviation" begin
    @test acronym("Rolling On The Floor Laughing So Hard That My Dogs Came Over And Licked Me") == "ROTFLSHTMDCOALM"
end

@testset "consecutive delimiters" begin
    @test acronym("Something - I made up from thin air") == "SIMUFTA"
end

@testset "apostrophes" begin
    @test acronym("Halley's Comet") == "HC"
end

@testset "underscore emphasis" begin
    @test acronym("The Road _Not_ Taken") == "TRNT"
end
