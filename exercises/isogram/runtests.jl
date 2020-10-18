using Test

include("isogram.jl")

@testset "empty string" begin
    @test is_isogram("")
end

@testset "isogram with only lower case characters" begin
    @test is_isogram("isogram")
end

@testset "word with one duplicated character" begin
    @test !is_isogram("eleven")
end

@testset "longest reported english isogram" begin
    @test is_isogram("subdermatoglyphic")
end

@testset "word with duplicated character in mixed case" begin
    @test !is_isogram("Alphabet")
end

@testset "hypothetical isogrammic word with hyphen" begin
    @test is_isogram("thumbscrew-japingly")
end

@testset "isogram with duplicated non letter character" begin
    @test is_isogram("Hjelmqvist-Gryb-Zock-Pfund-Wax")
end

@testset "made-up name that is an isogram" begin
    @test is_isogram("Emily Jung Schwartzkopf")
end
