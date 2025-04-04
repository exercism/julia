using Test

include("squeaky-clean.jl")

@testset verbose = true "tests" begin
    @testset "1. Hyphens" begin
        @test transform('a') == "a"
        @test transform('-') == "_"
    end

    @testset "2. Whitespace" begin
        @test transform(' ') == ""
    end

    @testset "3. camelCase" begin
        @test transform('Γ') == "-γ"
    end

    @testset "4. digits" begin
        @test transform('4') == ""
    end

    @testset "5. Greek lowercase" begin
        @test transform('ω') == "?"
    end

    @testset "6. Combine in string" begin
        @test clean("") == ""
        @test clean("àḃç") == "àḃç"
        @test clean("my   id") == "myid"
        @test clean("   my   id  ") == "myid"
        @test clean("9 cAbcĐ😀ω") == "c-abc-đ😀?"
    end
end
