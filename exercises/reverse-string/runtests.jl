# canonical data version: 1.2.0

using Test

include(reverse-string.jl)

@testset "reverse string with one character" begin
    @test reversestring("a") == "a"
end

@testset "reverse string with two characters" begin
    @test reversestring("ab") == "ba"
end

@testset "reverse string with many characters" begin
    @test reversestring("abcdefg") == "gfedcba"
end

@testset "reverse string with spaces" begin
    @test reversestring("Hello World") == "dlroW olleH"
end
