using Test

include("two-fer.jl")

@testset verbose = true "tests" begin
    @testset "no name given" begin
        @test twofer() == "One for you, one for me."
    end

    @testset "a name given" begin
        @test twofer("Alice") == "One for Alice, one for me."
    end

    @testset "another name given" begin
        @test twofer("Bob") == "One for Bob, one for me."
    end
end
