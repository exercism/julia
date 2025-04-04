using Test

include("elyses-enchantments.jl")

@testset verbose = true "tests" begin
    @testset "Retrieve a card from a deck" begin
        
        @testset "get the first card" begin
            stack = [1, 2, 3]
            position = 1
            @test get_item(stack, position) == 1
        end

        @testset "get the middle card" begin
            stack = [4, 5, 6]
            position = 2
            @test get_item(stack, position) == 5
        end

        @testset "get the last card" begin
            stack = [9, 8, 7]
            position = 3
            @test get_item(stack, position) == 7
        end

    end

    @testset "Replace a card in a deck" begin

        @testset "replace the first card with a 7" begin
            stack = [1, 2, 3]
            position = 1
            replacement_card = 7
            @test set_item!(stack, position, replacement_card) == [7, 2, 3]
        end
        
        @testset "replace the middle card with a 5" begin
            stack = [2, 2, 2]
            position = 2
            replacement_card = 5
            @test set_item!(stack, position, replacement_card) == [2, 5, 2]
        end
        
        @testset "replace the last card with a 7" begin
            stack = [7, 7, 6]
            position = 3
            replacement_card = 7
            @test set_item!(stack, position, replacement_card) == [7, 7, 7]
        end
        
    end

    @testset "Add a card at the top" begin

        @testset "adding a second card at the top" begin
            stack = [1]
            new_card = 5
            @test insert_item_at_top!(stack, new_card) == [1, 5]
        end

        @testset "adding a third card at the top" begin
            stack = [1, 5]
            new_card = 9
            @test insert_item_at_top!(stack, new_card) == [1, 5, 9]
        end

        @testset "adding a fourth card at the top" begin
            stack = [1, 5, 9]
            new_card = 2
            @test insert_item_at_top!(stack, new_card) == [1, 5, 9, 2]
        end

        @testset "adding a different fourth card at the top" begin
            stack = [1, 5, 9]
            new_card = 8
            @test insert_item_at_top!(stack, new_card) == [1, 5, 9, 8]
        end

    end

    @testset "Removing a card" begin

        @testset "remove the card at the bottom" begin
            stack = [1, 2, 3, 4]
            position = 1
            @test remove_item!(stack, position) == [2, 3, 4]
        end

        @testset "remove the card at the top" begin
            stack = [1, 2, 3, 4]
            position = 4
            @test remove_item!(stack, position) == [1, 2, 3]
        end

        @testset "remove the second card" begin
            stack = [1, 2, 3, 4]
            position = 2
            @test remove_item!(stack, position) == [1, 3, 4]
        end

    end

    @testset "Removing a card from the top" begin

        @testset "remove the only card from the top" begin
            stack = [1]
            @test remove_item_from_top!(stack) == []
        end

        @testset "remove the card from the top" begin
            stack = [1, 2, 3]
            @test remove_item_from_top!(stack) == [1, 2]
        end

    end

    @testset "Add a card at the bottom" begin

        @testset "adding a second card to the bottom" begin
            stack = [1]
            new_card = 5
            @test insert_item_at_bottom!(stack, new_card) == [5, 1]
        end

        @testset "adding a third card to the bottom" begin
            stack = [5, 1]
            new_card = 9
            @test insert_item_at_bottom!(stack, new_card) == [9, 5, 1]
        end

        @testset "adding a fourth card to the bottom" begin
            stack = [9, 5, 1]
            new_card = 2
            @test insert_item_at_bottom!(stack, new_card) == [2, 9, 5, 1]
        end

        @testset "adding a different fourth card to the bottom" begin
            stack = [9, 5, 1]
            new_card = 8
            @test insert_item_at_bottom!(stack, new_card) == [8, 9, 5, 1]
        end

    end

    @testset "Remove a card from the bottom" begin

        @testset "remove the only card from the bottom" begin
            stack = [1]
            @test remove_item_at_bottom!(stack) == []
        end

        @testset "remove the card from the bottom" begin
            stack = [1, 2, 3]
            @test remove_item_at_bottom!(stack) == [2, 3]
        end

    end

    @testset "Check size of stack" begin

        @testset "an empty stack of cards" begin
            stack = []
            stack_size = 0
            @test check_size_of_stack(stack, stack_size) == true
        end

        @testset "an empty stack of cards" begin
            stack = []
            stack_size = 1
            @test check_size_of_stack(stack, stack_size) == false
        end

        @testset "has exactly 1 card" begin
            stack = [7]
            stack_size = 0
            @test check_size_of_stack(stack, stack_size) == false
        end

        @testset "has exactly 1 card" begin
            stack = [7]
            stack_size = 1
            @test check_size_of_stack(stack, stack_size) == true
        end

        @testset "has exactly 1 card" begin
            stack = [7]
            stack_size = 2
            @test check_size_of_stack(stack, stack_size) == false
        end

        @testset "has exactly 4 cards" begin
            stack = [2, 4, 6, 8]
            stack_size = 3
            @test check_size_of_stack(stack, stack_size) == false
        end

        @testset "has exactly 4 cards" begin
            stack = [2, 4, 6, 8]
            stack_size = 4
            @test check_size_of_stack(stack, stack_size) == true
        end

        @testset "has exactly 4 cards" begin
            stack = [2, 4, 6, 8]
            stack_size = 15
            @test check_size_of_stack(stack, stack_size) == false
        end

        @testset "has exactly 5 cards" begin
            stack = [1, 3, 5, 7, 9]
            stack_size = 3
            @test check_size_of_stack(stack, stack_size) == false
        end

        @testset "has exactly 5 cards" begin
            stack = [1, 3, 5, 7, 9]
            stack_size = 4
            @test check_size_of_stack(stack, stack_size) == false
        end

        @testset "has exactly 5 cards" begin
            stack = [1, 3, 5, 7, 9]
            stack_size = 5
            @test check_size_of_stack(stack, stack_size) == true
        end

    end

end
