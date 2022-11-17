using Test

include("enchantments.jl")

@testset "Determine if a card is present" begin
    @test has_card([2, 3, 4, 5], 3)
end

@testset "Find the position of a card" begin
    @test find_card([3], 3) == 1
    @test find_card([9, 7, 3, 2], 2) == 4
    @test find_card([8, 3, 9, 5], 8) == 1
    @test isnothing(find_card([5, 3, 1, 9], 2))
end

@testset "Determine if each card is even" begin
    @test !all_cards_even([1])
    @test !all_cards_even([2, 5])
    @test  all_cards_even([2, 4, 8, 6])
end

@testset "Check if the deck contains an odd-value card" begin
    @test !any_odd_cards([2, 4, 6])
    @test  any_odd_cards([2, 5])
    @test  any_odd_cards([1, 3, 5, 7])
end

@testset "Determine the position of the first card that is even" begin
    @test first_even_card_idx([2, 4, 1, 3]) == 1
    @test first_even_card_idx([1, 2]) == 2
    @test isnothing(first_even_card_idx([1, 3, 5]))
end

@testset "Get the first odd card from the deck" begin
    @test first_odd_card([2, 4, 1, 3]) == 1
    @test first_odd_card([1, 2]) == 1
    @test isnothing(first_odd_card([4, 2, 6]))
end
