using Test

include("scrabble-score.jl")

@testset "lowercase letter" begin
    @test score("a") == 1
end

@testset "uppercase letter" begin
    @test score("A") == 1
end

@testset "valuable letter" begin
    @test score("f") == 4
end

@testset "short word" begin
    @test score("at") == 2
end

@testset "short, valuable word" begin
    @test score("zoo") == 12
end

@testset "medium word" begin
    @test score("street") == 6
end

@testset "medium, valuable word" begin
    @test score("quirky") == 22
end

@testset "long, mixed-case word" begin
    @test score("OxyphenButazone") == 41
end

@testset "english-like word" begin
    @test score("pinata") == 8
end

@testset "non-english letter is not scored" begin
    @test score("piñata") == 7
end

@testset "empty input" begin
    @test score("") == 0
end

@testset "entire alphabet available" begin
    @test score("abcdefghijklmnopqrstuvwxyz") == 87
end
