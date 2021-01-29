using Test

include("isogram.jl")

@testset "empty string" begin
    @test isisogram("")
end

@testset "isogram with only lower case characters" begin
    @test isisogram("isogram")
end

@testset "word with one duplicated character" begin
    @test !isisogram("eleven")
end

@testset "longest reported english isogram" begin
    @test isisogram("subdermatoglyphic")
end

@testset "word with duplicated character in mixed case" begin
    @test !isisogram("Alphabet")
end

@testset "hypothetical isogrammic word with hyphen" begin
    @test isisogram("thumbscrew-japingly")
end

@testset "isogram with duplicated non letter character" begin
    @test isisogram("Hjelmqvist-Gryb-Zock-Pfund-Wax")
end

@testset "made-up name that is an isogram" begin
    @test isisogram("Emily Jung Schwartzkopf")
end

@testset "word with one duplicated character from the end of the alphabet" begin
    @test !isisogram("zzyzx")
end

@testset "word with duplicated character in mixed case, lowercase first" begin
    @test !isisogram("alphAbet")
end

@testset "hypothetical word with duplicated character following hyphen" begin
    @test !isisogram("thumbscrew-jappingly")
end

@testset "isogram with duplicated hyphen" begin
    @test isisogram("six-year-old")
end

@testset "duplicated character in the middle" begin
    @test !isisogram("accentor")
end

@testset "same first and last characters" begin
    @test !isisogram("angola")
end
