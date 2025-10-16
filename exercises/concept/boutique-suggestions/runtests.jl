using Test

include("boutique-suggestions.jl")

@testset verbose = true "tests" begin
    testitem = Dict ∘ zip
    @testset "1. Create clothing item" begin
        @testset "Creates an item with canonical categories" begin
            categories = ("item_name", "price", "color", "base_color")
            qualities = ("Long Sleeve T-shirt", 19.95, "Deep Red", "red")
            expected = testitem(categories, qualities)
            @test clothingitem(categories, qualities) == expected
        end

        @testset "Creates an item without canonical categories" begin
            categories = ("item_name",)
            qualities = ("Long Sleeve T-shirt",)
            expected = Dict("item_name" => "Long Sleeve T-shirt")
            @test clothingitem(categories, qualities) == expected
        end
    end
    
    @testset "2. Suggest combinations" begin
        @testset "Generates one pair from one top and one bottom" begin
            categories = ("item_name", "price", "color", "base_color")

            topquals = ("Long Sleeve T-shirt", 19.95, "Deep Red", "red")
            botquals = ("Wonderwall Pants", 48.97, "French Navy", "blue")
            top = testitem(categories, topquals)
            bottom = testitem(categories, botquals)

            @test get_combinations((top,), (bottom,)) == [(top, bottom);;]
        end

        @testset "Generates nine pairs from three tops and three bottoms" begin
            categories = ("item_name", "price", "color", "base_color")

            top1quals = ("Long Sleeve T-shirt", 19.95, "Deep Red", "red")
            top2quals = ("Brushwood Shirt", 19.10, "Camel-Sandstone Woodland Plaid", "brown")
            top3quals = ("Sano Long Sleeve Shirt", 45.47, "Linen Chambray", "yellow")
            top1 = testitem(categories, top1quals)
            top2 = testitem(categories, top2quals)
            top3 = testitem(categories, top3quals)

            bot1quals = ("Wonderwall Pants", 48.97, "French Navy", "blue")
            bot2quals = ("Terrena Stretch Pants", 79.95, "Cast Iron", "grey")
            bot3quals = ("Happy Hike Studio Pants", 99.00, "Ochre Red", "red")
            bottom1 = testitem(categories, bot1quals)
            bottom2 = testitem(categories, bot2quals)
            bottom3 = testitem(categories, bot3quals)

            tops = (top1, top2, top3)
            bottoms = (bottom1, bottom2, bottom3)
            expected = [(top1, bottom1) (top1, bottom2) (top1, bottom3) 
                        (top2, bottom1) (top2, bottom2) (top2, bottom3)
                        (top3, bottom1) (top3, bottom2) (top3, bottom3)]
            @test get_combinations(tops, bottoms) == expected
       end
    end

    @testset "3. Add up outfit prices" begin
        @testset "Returns a Vector for Vector input" begin
            categories = ("item_name", "price", "color", "base_color")

            top1quals = ("Long Sleeve T-shirt", 19, "Deep Red", "red")
            top2quals = ("Brushwood Shirt", 21, "Camel-Sandstone Woodland Plaid", "brown")
            top1 = testitem(categories, top1quals)
            top2 = testitem(categories, top2quals)

            bot1quals = ("Wonderwall Pants", 48, "French Navy", "blue")
            bot2quals = ("Terrena Stretch Pants", 79, "Cast Iron", "grey")
            bottom1 = testitem(categories, bot1quals)
            bottom2 = testitem(categories, bot2quals)

            combos = [(top1, bottom1), (top1, bottom2), (top2, bottom1), (top2, bottom2)]
            expected = [67, 98, 69, 100]
            @test get_prices(combos) == expected
        end

        @testset "Returns a Matrix for Matrix input" begin
            categories = ("item_name", "price", "color", "base_color")

            top1quals = ("Long Sleeve T-shirt", 19, "Deep Red", "red")
            top2quals = ("Brushwood Shirt", 21, "Camel-Sandstone Woodland Plaid", "brown")
            top1 = testitem(categories, top1quals)
            top2 = testitem(categories, top2quals)

            bot1quals = ("Wonderwall Pants", 48, "French Navy", "blue")
            bot2quals = ("Terrena Stretch Pants", 79, "Cast Iron", "grey")
            bottom1 = testitem(categories, bot1quals)
            bottom2 = testitem(categories, bot2quals)

            combos = [(top1, bottom1) (top1, bottom2) 
                      (top2, bottom1) (top2, bottom2)]
            expected = [67 98
                        69 100]
            @test get_prices(combos) == expected
       end
    end

    @testset "4. Filter out clashing outfits" begin
        @testset "Filters suggestions that 'clash'" begin
            categories = ("item_name", "price", "color", "base_color")
            topqualities = ("Long Sleeve T-shirt", 19.95, "Deep Red", "red")
            bottomqualities = ("Happy Hike Studio Pants", 19.00, "Ochre Red", "red")
            top = testitem(categories, topqualities)
            bottom = testitem(categories, bottomqualities)
            
            combos = get_combinations((top,), (bottom,))
            @test filter_clashing(combos) == []
        end

        @testset "Flattens a matrix with clashing outfits" begin
            categories = ("item_name", "price", "color", "base_color")

            top1quals = ("Long Sleeve T-shirt", 19.95, "Deep Red", "red")
            top2quals = ("Brushwood Shirt", 19.10, "Camel-Sandstone Woodland Plaid", "brown")
            top3quals = ("Sano Long Sleeve Shirt", 45.47, "Linen Chambray", "yellow")
            top1 = testitem(categories, top1quals)
            top2 = testitem(categories, top2quals)
            top3 = testitem(categories, top3quals)

            bot1quals = ("Wonderwall Pants", 48.97, "French Navy", "blue")
            bot2quals = ("Terrena Stretch Pants", 79.95, "Cast Iron", "grey")
            bot3quals = ("Happy Hike Studio Pants", 99.00, "Ochre Red", "red")
            bottom1 = testitem(categories, bot1quals)
            bottom2 = testitem(categories, bot2quals)
            bottom3 = testitem(categories, bot3quals)

            combos = [(top1, bottom1) (top1, bottom2) (top1, bottom3) 
                      (top2, bottom1) (top2, bottom2) (top2, bottom3)
                      (top3, bottom1) (top3, bottom2) (top3, bottom3)]
            expected = [(top1, bottom1), (top2, bottom1), (top3, bottom1),
                        (top1, bottom2), (top2, bottom2), (top3, bottom2),
                                         (top2, bottom3), (top3, bottom3)]
            @test filter_clashing(combos) == expected
        end

        @testset "Flattens a matrix without clashing outfits" begin
            categories = ("item_name", "price", "color", "base_color")

            top1quals = ("Long Sleeve T-shirt", 19.95, "Deep Red", "red")
            top2quals = ("Brushwood Shirt", 19.10, "Camel-Sandstone Woodland Plaid", "brown")
            top3quals = ("Sano Long Sleeve Shirt", 45.47, "Linen Chambray", "yellow")
            top1 = testitem(categories, top1quals)
            top2 = testitem(categories, top2quals)
            top3 = testitem(categories, top3quals)

            bot1quals = ("Wonderwall Pants", 48.97, "French Navy", "blue")
            bot2quals = ("Terrena Stretch Pants", 79.95, "Cast Iron", "grey")
            bot3quals = ("Happy Hike Studio Pants", 99.00, "Ochre Red", "pink")
            bottom1 = testitem(categories, bot1quals)
            bottom2 = testitem(categories, bot2quals)
            bottom3 = testitem(categories, bot3quals)

            combos = [(top1, bottom1) (top1, bottom2) (top1, bottom3) 
                      (top2, bottom1) (top2, bottom2) (top2, bottom3)
                      (top3, bottom1) (top3, bottom2) (top3, bottom3)]
            expected = [(top1, bottom1), (top2, bottom1), (top3, bottom1),
                        (top1, bottom2), (top2, bottom2), (top3, bottom2),
                        (top1, bottom3), (top2, bottom3), (top3, bottom3)]
            @test filter_clashing(combos) == expected
       end
    end
end
