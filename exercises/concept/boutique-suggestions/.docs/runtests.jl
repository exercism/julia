using Test

include("boutique-suggestions.jl")

@testset verbose = true "tests" begin

    @testset "Dicts plus comprehensions" begin

        @testset "1a. Generates one pair from one top and one bottom" begin
            top = Dict(
                "item_name" => "Long Sleeve T-shirt",
                "price" => 19.95,
                "color" => "Deep Red",
                "base_color" => "red"
            )

            bottom = Dict(
                "item_name" => "Wonderwall Pants",
                "price" => 48.97,
                "color" => "French Navy",
                "base_color" => "blue"
            )

            @test get_combinations([top], [bottom]) == [(top, bottom);;]
        end

        @testset "1b. Generates nine pairs from three tops and three bottoms" begin
            top1 = Dict(
                "item_name" => "Long Sleeve T-shirt",
                "price" => 19.95,
                "color" => "Deep Red",
                "base_color" => "red"
            )

            top2 = Dict(
                "item_name" => "Brushwood Shirt",
                "price" => 19.10,
                "color" => "Camel-Sandstone Woodland Plaid",
                "base_color" => "brown"
            )

            top3 = Dict(
                "item_name" => "Sano Long Sleeve Shirt",
                "price" => 45.47,
                "color" => "Linen Chambray",
                "base_color" => "yellow"
            )

            bottom1 = Dict(
                "item_name" => "Wonderwall Pants",
                "price" => 48.97,
                "color" => "French Navy",
                "base_color" => "blue"
            )

            bottom2 = Dict(
                "item_name" => "Terrena Stretch Pants",
                "price" => 79.95,
                "color" => "Cast Iron",
                "base_color" => "grey"
            )

            bottom3 = Dict(
                "item_name" => "Happy Hike Studio Pants",
                "price" => 99.00,
                "color" => "Ochre Red",
                "base_color" => "red"
            )

            tops = [top1, top2, top3]
            bottoms = [bottom1, bottom2, bottom3]
            expected = [(top1, bottom1) (top1, bottom2) (top1, bottom3) 
                        (top2, bottom1) (top2, bottom2) (top2, bottom3)
                        (top3, bottom1) (top3, bottom2) (top3, bottom3)]
            @test get_combinations(tops, bottoms) == expected
       end

        @testset "2. Does not create suggestions that 'clash'" begin
            top = Dict(
                "item_name" => "Long Sleeve T-shirt",
                "price" => 19.95,
                "color" => "Deep Red",
                "base_color" => "red"
            )

            bottom = Dict(
                "item_name" => "Happy Hike Studio Pants",
                "price" => 19.00,
                "color" => "Ochre Red",
                "base_color" => "red"
            )

            @test filter_combinations([top], [bottom]) == []
        end

        @testset "3a. Filter rejects combinations based on combined maximum price" begin
            top = Dict(
                "item_name" => "Sano Long Sleeve Shirt",
                "price" => 45.47,
                "color" => "Linen Chambray",
                "base_color" => "yellow"
            )

            bottom = Dict(
                "item_name" => "Happy Hike Studio Pants",
                "price" => 99.00,
                "color" => "Ochre Red",
                "base_color" => "red"
            )

            @test filter_combinations([top], [bottom], maximum_price = 100.00) == []
       end

        @testset "3b. Filter accepts combinations based on combined maximum price" begin
            top = Dict(
                "item_name" => "Sano Long Sleeve Shirt",
                "price" => 45.47,
                "color" => "Linen Chambray",
                "base_color" => "yellow"
            )

            bottom = Dict(
                "item_name" => "Happy Hike Studio Pants",
                "price" => 99.00,
                "color" => "Ochre Red",
                "base_color" => "red"
            )

            @test filter_combinations([top], [bottom], maximum_price = 200.00) == [(top, bottom)]
       end

       @testset "3c. Provides default when maximum_price option not specified" begin
            top = Dict(
                "item_name" => "Sano Long Sleeve Shirt",
                "price" => 45.47,
                "color" => "Linen Chambray",
                "base_color" => "yellow"
            )

            bottom = Dict(
                "item_name" => "Happy Hike Studio Pants",
                "price" => 99.00,
                "color" => "Ochre Red",
                "base_color" => "red"
            )

            @test filter_combinations([top], [bottom]) == []        
       end

       @testset "3d. Putting it all together" begin
            top1 = Dict(
                "item_name" => "Long Sleeve T-shirt",
                "price" => 19.95,
                "color" => "Deep Red",
                "base_color" => "red"
            )

            top2 = Dict(
                "item_name" => "Brushwood Shirt",
                "price" => 19.10,
                "color" => "Camel-Sandstone Woodland Plaid",
                "base_color" => "brown"
            )

            top3 = Dict(
                "item_name" => "Sano Long Sleeve Shirt",
                "price" => 45.47,
                "color" => "Linen Chambray",
                "base_color" => "yellow"
            )

            bottom1 = Dict(
                "item_name" => "Wonderwall Pants",
                "price" => 48.97,
                "color" => "French Navy",
                "base_color" => "blue"
            )

            bottom2 = Dict(
                "item_name" => "Terrena Stretch Pants",
                "price" => 79.95,
                "color" => "Cast Iron",
                "base_color" => "grey"
            )

            bottom3 = Dict(
                "item_name" => "Happy Hike Studio Pants",
                "price" => 99.00,
                "color" => "Ochre Red",
                "base_color" => "red"
            )

            tops = [top1, top2, top3]
            bottoms = [bottom1, bottom2, bottom3]
            expected = [
                (top2, bottom1),
                (top1, bottom1),
                (top3, bottom1),
                (top2, bottom2),
                (top1, bottom2)
           ]
            @test filter_combinations(tops, bottoms) == expected
       end
    end

    @testset "Composite types plus comprehensions" begin

        @testset "1a. Generates one pair from one top and one bottom" begin
            top = Garment("Long Sleeve T-shirt", 19.95, "Deep Red", "red")
            bottom = Garment("Wonderwall Pants", 48.97, "French Navy", "blue")

            @test get_combinations2([top], [bottom]) == [(top, bottom);;]
        end

        @testset "1b. Generates nine pairs from three tops and three bottoms" begin
            top1 = Garment("Long Sleeve T-shirt", 19.95, "Deep Red", "red")
            top2 = Garment("Brushwood Shirt", 19.10, "Camel-Sandstone Woodland Plaid", "brown")
            top3 = Garment("Sano Long Sleeve Shirt", 45.47, "Linen Chambray", "yellow")
            bottom1 = Garment("Wonderwall Pants", 48.97, "French Navy", "blue")
            bottom2 = Garment("Terrena Stretch Pants", 79.95, "Cast Iron", "grey")
            bottom3 = Garment("Happy Hike Studio Pants", 99.00, "Ochre Red", "red")

            tops = [top1, top2, top3]
            bottoms = [bottom1, bottom2, bottom3]
            expected = [(top1, bottom1) (top1, bottom2) (top1, bottom3) 
                        (top2, bottom1) (top2, bottom2) (top2, bottom3)
                        (top3, bottom1) (top3, bottom2) (top3, bottom3)]
            @test get_combinations2(tops, bottoms) == expected
       end

        @testset "2. Does not create suggestions that 'clash'" begin
            top = Garment("Long Sleeve T-shirt", 19.95, "Deep Red", "red")
            bottom = Garment("Happy Hike Studio Pants", 19.00, "Ochre Red", "red")

            @test filter_combinations2([top], [bottom]) == []
        end

        @testset "3a. Filter rejects combinations based on combined maximum price" begin
            top = Garment("Sano Long Sleeve Shirt", 45.47, "Linen Chambray", "yellow")
            bottom = Garment("Happy Hike Studio Pants", 99.00, "Ochre Red", "red")

            @test filter_combinations2([top], [bottom], maximum_price = 100.00) == []
       end

        @testset "3b. Filter accepts combinations based on combined maximum price" begin
            top = Garment( "Sano Long Sleeve Shirt", 45.47, "Linen Chambray", "yellow")
            bottom = Garment( "Happy Hike Studio Pants", 99.00, "Ochre Red", "red")

            @test filter_combinations2([top], [bottom], maximum_price = 200.00) == [(top, bottom)]
       end

       @testset "3c. Provides default when maximum_price option not specified" begin
            top = Garment( "Sano Long Sleeve Shirt", 45.47, "Linen Chambray", "yellow")
            bottom = Garment("Happy Hike Studio Pants", 99.00, "Ochre Red", "red" )

            @test filter_combinations2([top], [bottom]) == []        
       end

       @testset "4. Putting it all together, with sort" begin
            top1 = Garment("Long Sleeve T-shirt", 19.95, "Deep Red", "red")
            top2 = Garment("Brushwood Shirt", 19.10, "Camel-Sandstone Woodland Plaid", "brown")
            top3 = Garment("Sano Long Sleeve Shirt", 45.47, "Linen Chambray", "yellow")
            bottom1 = Garment("Wonderwall Pants", 48.97, "French Navy", "blue")
            bottom2 = Garment("Terrena Stretch Pants", 79.95, "Cast Iron", "grey")
            bottom3 = Garment("Happy Hike Studio Pants", 99.00, "Ochre Red", "red")

            tops = [top1, top2, top3]
            bottoms = [bottom1, bottom2, bottom3]
            expected = [
                (top2, bottom1),
                (top1, bottom1),
                (top3, bottom1),
                (top2, bottom2),
                (top1, bottom2)
           ]
            @test filter_combinations2(tops, bottoms) == expected
       end
    end
end
