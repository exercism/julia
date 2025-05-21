using Test 

include("treasure-chest.jl")

@testset verbose = true "tests" begin
    @testset "1. Define TreasureChest type" begin
        @testset "Treasure can be a string" begin
            chest = TreasureChest{String}("password", "gold")
            @test chest == TreasureChest{String}("password", "gold")
            @test typeof(chest) == TreasureChest{String}
            @test typeof(chest.treasure) == String
        end

        @testset "Treasure can be an integer" begin
            chest = TreasureChest{Int64}("password", 42)
            @test chest == TreasureChest{Int64}("password", 42)
            @test typeof(chest) == TreasureChest{Int64}
            @test typeof(chest.treasure) == Int64
        end
    end

    @testset "2. get_treasure" begin
        @testset "Correct password returns treasure" begin
            chest = TreasureChest{String}("password", "gold")
            @test get_treasure("password", chest) == "gold"
        end

        @testset "Incorrect password returns nothing" begin
            chest = TreasureChest{String}("password", "gold")
            @test isnothing(get_treasure("wrong-password", chest))
        end
    end

    @testset "3. Multiply treasure" begin
        @testset "Treasure is multiplied correctly" begin
            chest = TreasureChest{String}("password", "gold")
            multiplier = 3
            expected_treasure = ["gold", "gold", "gold"]
            multiplied_chest = multiply_treasure(multiplier, chest)
            @test typeof(multiplied_chest) == TreasureChest{Vector{String}}
            @test multiplied_chest.password == "password"
            @test multiplied_chest.treasure == expected_treasure
        end
    end
end
