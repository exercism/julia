using Test

include("knapsack.jl")

struct Item
    weight
    value
end

@testset verbose = true "tests" begin
    @testset "no items" begin
        @test maximum_value(100, []) == 0
    end

    @testset "one item, too heavy" begin
        @test maximum_value(10, [Item(100, 1),]) == 0
    end

    @testset "five items (cannot be greedy by weight)" begin
        items = [Item(2, 5), Item(2, 5), Item(2, 5), Item(2, 5), Item(10, 21)]
        @test maximum_value(10, items) == 21
    end

    @testset "five items (cannot be greedy by value)" begin
        items = [Item(2, 20), Item(2, 20), Item(2, 20), Item(2, 20), Item(10, 50)]
        @test maximum_value(10, items) == 80
    end

    @testset "example knapsack" begin
        items = [Item(5, 10), Item(4, 40), Item(6, 30), Item(4, 50)]
        @test maximum_value(10, items) == 90
    end

    @testset "8 items" begin
        items = [Item(25, 350), Item(35, 400), Item(45, 450), Item(5, 20), 
        Item(25, 70), Item(3, 8), Item(2, 5), Item(2, 5)]
        @test maximum_value(104, items) == 900
    end

    @testset "15 items" begin
        items = [Item(70, 135), Item(73, 139), Item(77, 149), Item(80, 150), 
                 Item(82, 156), Item(87, 163), Item(90, 173), Item(94, 184),
                 Item(98, 192), Item(106, 201), Item(110, 210), Item(113, 214), 
                 Item(115, 221), Item(118, 229), Item(120, 240)]
        @test maximum_value(750, items) == 1458
    end
end
