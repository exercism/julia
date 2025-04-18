using Test 

include("inventory-management.jl")

@testset verbose = true "tests" begin
    @testset "1. create_inventory" begin
        @testset "Create an inventory from a vector" begin
            expected = Dict("wood" => 1, "iron" => 2, "diamond" => 2)
            @test create_inventory(["wood", "iron", "iron", "diamond", "diamond"]) == expected
        end
    end

    @testset "2. add_items" begin
        @testset "test_add_one_item" begin
            expected = Dict("wood" => 4, "iron" => 4)
            @test add_items(Dict("wood" => 4, "iron" => 2), ["iron", "iron"]) == expected
        end

        @testset "test_add_multiple_items" begin
            inventory = Dict("wood" => 2, "gold" => 1, "diamond" => 3)
            expected = Dict("wood" => 3, "gold" => 3, "diamond" => 3)
            @test add_items(inventory, ["wood", "gold", "gold"]) == expected
        end

        @testset "test_add_new_item" begin
            inventory = Dict("iron" => 1, "diamond" => 2)
            expected = Dict("iron" => 2, "diamond" => 2, "wood" => 2)
            @test add_items(inventory, ["iron", "wood", "wood"]) == expected
        end

        @testset "test_add_from_empty_dict" begin
            inventory = Dict()
            expected = Dict("iron" => 2, "diamond" => 1)
            @test add_items(inventory, ["iron", "iron", "diamond"]) == expected
        end
    end

    @testset "3. decrement_items" begin
        @testset "test_decrement_items" begin
            inventory = Dict("iron" => 3, "diamond" => 4, "gold" => 2)
            expected = Dict("iron" => 1, "diamond" => 3, "gold" => 0)
            @test decrement_items(inventory, ["iron", "iron", "diamond", "gold", "gold"]) == expected
        end
        
        @testset "test_decrement_items" begin
            inventory = Dict("wood" => 2, "iron" => 3, "diamond" => 1)
            expected = Dict("wood" => 0, "iron" => 2, "diamond" => 0)
            @test decrement_items(inventory, ["wood", "wood", "wood", "iron", "diamond", "diamond"]) == expected
        end
        
        @testset "test_decrement_items_not_in_inventory" begin
            inventory = Dict("iron" => 3, "gold" => 2)
            expected = Dict("iron" => 1, "gold" => 2)
            @test decrement_items(inventory, ["iron", "wood", "iron", "diamond"]) == expected
        end
        
    end

    @testset "4. remove_item" begin
        @testset "test_remove_item" begin
            inventory = Dict("iron" => 1, "diamond" => 2, "gold" => 1)
            expected = Dict("iron" => 1, "gold" => 1)
            @test remove_item(inventory, "diamond") == expected
        end

        @testset "test_remove_item_not_in_inventory" begin
            inventory = Dict("iron" => 1, "diamond" => 2, "gold" => 1)
            expected = Dict("iron" => 1, "gold" => 1, "diamond" => 2)
            @test remove_item(inventory, "wood") == expected
        end
    end

    @testset "5. list_inventory" begin
        @testset "list_inventory" begin
            inventory = Dict("coal" => 15, "diamond" => 3, "wood" => 67, "silver" => 0)
            expected = ["coal" => 15, "diamond" => 3, "wood" => 67]
            @test list_inventory(inventory) == expected
        end
    end
end
