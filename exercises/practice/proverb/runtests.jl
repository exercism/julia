using Test
include("proverb.jl")

@testset verbose = true "tests" begin
    @testset "zero pieces" begin
        pieces = []
        expected = ""
        @test recite(pieces) == expected
    end

    @testset "one piece" begin
        pieces = ["nail"]
        expected = "And all for the want of a nail."
        @test recite(pieces) == expected
    end

    @testset "two pieces" begin
        pieces = ["nail", "shoe"]
        expected = """
            For want of a nail the shoe was lost.
            And all for the want of a nail."""
        @test recite(pieces) == expected
    end

    @testset "three pieces" begin
        pieces = ["nail", "shoe", "horse"]
        expected = """
            For want of a nail the shoe was lost.
            For want of a shoe the horse was lost.
            And all for the want of a nail."""
        @test recite(pieces) == expected
    end

    @testset "full proverb" begin
        pieces = ["nail", "shoe", "horse", "rider", "message", "battle", "kingdom"]
        expected = """
            For want of a nail the shoe was lost.
            For want of a shoe the horse was lost.
            For want of a horse the rider was lost.
            For want of a rider the message was lost.
            For want of a message the battle was lost.
            For want of a battle the kingdom was lost.
            And all for the want of a nail."""
        @test recite(pieces) == expected
    end

    @testset "four pieces modernized" begin
        pieces = ["pin", "gun", "soldier", "battle"]
        expected = """
            For want of a pin the gun was lost.
            For want of a gun the soldier was lost.
            For want of a soldier the battle was lost.
            And all for the want of a pin."""
        @test recite(pieces) == expected
    end
end
