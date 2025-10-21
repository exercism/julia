using Test

include("mecha-munch-management.jl")

@testset "tests" verbose = true begin
    @testset "1. Add items to cart" begin
        cart = Dict("Banana" => 3, "Apple" => 2, "Orange" => 1)
        items = ("Apple", "Apple", "Orange", "Apple", "Banana")
        @test additems!(cart, items) == cart == Dict("Banana" => 4, "Apple" => 5, "Orange" => 2)

        cart = Dict("Orange" => 1, "Raspberry" => 1, "Blueberries" => 10)
        items = ("Raspberry", "Blueberries", "Raspberry")
        @test additems!(cart, items) == cart == Dict("Orange" => 1, "Raspberry" => 3, "Blueberries" => 11)
        
        cart = Dict("Broccoli" => 1, "Banana" => 1)
        items = ("Broccoli", "Kiwi", "Kiwi", "Kiwi", "Melon", "Apple", "Banana", "Banana")
        @test additems!(cart, items) == cart == Dict("Broccoli" => 2, "Banana" => 3, "Kiwi" => 3, "Melon" => 1, "Apple" => 1)
    end

    @testset "2. Update recipe ideas" begin
        ideas = Dict(
            "Banana Bread" => Dict("Banana" => 1, "Apple" => 1, "Walnuts" => 1, "Flour" => 1, "Eggs" => 2, "Butter" => 1),
            "Raspberry Pie" => Dict("Raspberry" => 1, "Orange" => 1, "Pie Crust" => 1, "Cream Custard" => 1)
        )
        updates = Dict("Banana Bread" => Dict("Banana" => 4, "Walnuts" => 2, "Flour" => 1, "Butter" => 1, "Milk" => 2, "Eggs" => 3))
        expected = Dict(
            "Banana Bread" => Dict("Banana" => 4, "Walnuts" => 2, "Flour" => 1, "Butter" => 1, "Milk" => 2, "Eggs" => 3),
            "Raspberry Pie" => Dict("Raspberry" => 1, "Orange" => 1, "Pie Crust" => 1, "Cream Custard" => 1)
        )
        @test update_recipes!(ideas, updates) == ideas == expected

        ideas = Dict(
            "Apple Pie" => Dict("Apple" => 1, "Pie Crust" => 1, "Cream Custard" => 1),
            "Blueberry Pie" => Dict("Blueberries" => 1, "Pie Crust" => 1, "Cream Custard" => 1)
        )
        updates = Dict(
            "Blueberry Pie" => Dict("Blueberries" => 2, "Pie Crust" => 1, "Cream Custard" => 1),
            "Apple Pie" => Dict("Apple" => 1, "Pie Crust" => 1, "Cream Custard" => 1)
        )
        expected = Dict(
            "Blueberry Pie" => Dict("Blueberries" => 2, "Pie Crust" => 1, "Cream Custard" => 1),
            "Apple Pie" => Dict("Apple" => 1, "Pie Crust" => 1, "Cream Custard" => 1)
        )
        @test update_recipes!(ideas, updates) == ideas == expected

        ideas = Dict(
            "Banana Bread" => Dict("Banana" => 1, "Apple" => 1, "Walnuts" => 1, "Flour" => 1, "Eggs" => 2, "Butter" => 1),
            "Raspberry Pie" => Dict("Raspberry" => 1, "Orange" => 1, "Pie Crust" => 1, "Cream Custard" => 1),
            "Pasta Primavera" => Dict("Eggs" => 1, "Carrots" => 1, "Spinach" => 2, "Tomatoes" => 3, "Parmesan" => 2, "Milk" => 1, "Onion" => 1)
        )
        updates = Dict(
            "Raspberry Pie" => Dict("Raspberry" => 3, "Orange" => 1, "Pie Crust" => 1, "Cream Custard" => 1, "Whipped Cream" => 2),
            "Pasta Primavera" => Dict("Eggs" => 1, "Mixed Veggies" => 2, "Parmesan" => 2, "Milk" => 1, "Spinach" => 1, "Bread Crumbs" => 1),
            "Blueberry Crumble" => Dict("Blueberries" => 2, "Whipped Creme" => 2, "Granola Topping" => 2, "Yogurt" => 3)
        )
        expected = Dict(
            "Banana Bread" => Dict("Banana" => 1, "Apple" => 1, "Walnuts" => 1, "Flour" => 1, "Eggs" => 2, "Butter" => 1),
            "Raspberry Pie" => Dict("Raspberry" => 3, "Orange" => 1, "Pie Crust" => 1, "Cream Custard" => 1, "Whipped Cream" => 2),
            "Pasta Primavera" => Dict("Eggs" => 1, "Mixed Veggies" => 2, "Parmesan" => 2, "Milk" => 1, "Spinach" => 1, "Bread Crumbs" => 1),
            "Blueberry Crumble" => Dict("Blueberries" => 2, "Whipped Creme" => 2, "Granola Topping" => 2, "Yogurt" => 3)
        )
        @test update_recipes!(ideas, updates) == ideas == expected
    end

    @testset "3. Send shopping cart to store" begin
        cart = Dict("Banana" => 3, "Apple" => 2, "Orange" => 1, "Milk" => 2)
        aislecodes = Dict("Orange" => 2.4, "Milk" => 3.3, "Banana" => 2.6, "Apple" => 2.2, "Chocolate" => 5.7)
        @test send_to_store(cart, aislecodes) == [2.2 => 2, 2.4 => 1, 2.6 => 3, 3.3 => 2]

        cart = Dict("Kiwi" => 3, "Juice" => 5, "Yoghurt" => 2, "Milk" => 5)
        aislecodes = Dict("Kiwi" => 2.7, "Juice" => 3.5, "Yoghurt" => 3.2, "Milk" => 3.3)
        @test send_to_store(cart, aislecodes) == [2.7 => 3, 3.2 => 2, 3.3 => 5, 3.5 => 5]

        cart = Dict("Apple" => 2, "Raspberry" => 2, "Blueberries" => 5, "Broccoli" => 2, "Kiwi" => 1, "Melon" => 4)
        aislecodes = Dict("Apple" => 2.2, "Raspberry" => 2.8, "Blueberries" => 2.9, "Broccoli" => 1.4, "Kiwi" => 2.7, "Melon" => 2.1)
        @test send_to_store(cart, aislecodes) == [1.4 => 2, 2.1 => 4, 2.2 => 2, 2.7 => 1, 2.8 => 2, 2.9 => 5]

        cart = Dict("Orange" => 1)
        aislecodes = Dict("Orange" => 2.4, "Milk" => 3.3, "Banana" => 2.6, "Apple" => 2.2)
        @test send_to_store(cart, aislecodes) == [2.4 => 1]

        cart = Dict("Banana" => 3, "Apple" => 2, "Orange" => 1)
        aislecodes = Dict("Banana" => 2.6, "Apple" => 2.2, "Orange" => 2.4, "Milk" => 3.3)
        @test send_to_store(cart, aislecodes) == [2.2 => 2, 2.4 => 1, 2.6 => 3]
    end

    @testset "4. Update store inventory" begin
        inventory = Dict("Banana" => 15, "Apple" => 12, "Orange" => 1, "Milk" => 4)
        cart = Dict("Orange" => 1, "Milk" => 2, "Banana" => 3, "Apple" => 2)
        @test update_store_inventory!(inventory, cart) == Dict("Orange" => 0)
        @test inventory == Dict("Banana" => 12, "Apple" => 10, "Orange" => 0, "Milk" => 2)

        inventory = Dict("Kiwi" => 3, "Juice" => 5, "Yoghurt" => 2, "Milk" => 5)
        cart = Dict("Kiwi" => 3)
        @test update_store_inventory!(inventory, cart) == Dict("Kiwi" => 0)
        @test inventory == Dict("Kiwi" => 0, "Juice" => 5, "Yoghurt" => 2, "Milk" => 5)

        inventory = Dict("Apple" => 2, "Raspberry" => 5, "Blueberries" => 10, "Broccoli" => 4, "Kiwi" => 1, "Melon" => 8)
        cart =  Dict("Kiwi" => 1, "Melon" => 4, "Apple" => 2, "Raspberry" => 2, "Blueberries" => 5, "Broccoli" => 1)
        @test update_store_inventory!(inventory, cart) == Dict("Kiwi" => 0, "Apple" => 0)
        @test inventory == Dict("Apple" => 0, "Raspberry" => 3, "Blueberries" => 5, "Broccoli" => 3, "Kiwi" => 0, "Melon" => 4)

        inventory = Dict("Banana" => 15, "Apple" => 12, "Orange" => 2, "Milk" => 4)
        cart = Dict("Orange" => 1, "Milk" => 2, "Banana" => 3, "Apple" => 2)
        @test update_store_inventory!(inventory, cart) == Dict()
        @test inventory == Dict("Banana" => 12, "Apple" => 10, "Orange" => 1, "Milk" => 2)
    end

    @testset "5. Reorder out-of-stock items" begin
        outofstock = Dict("Orange" => 0)
        stock = Dict("Banana" => 150, "Apple" => 120, "Orange" => 120, "Milk" => 45)
        @test reorder!(outofstock, stock) == Dict("Orange" => 120)
        
        outofstock = Dict("Orange" => 0, "Chocolate" => 0)
        stock = Dict("Banana" => 150, "Apple" => 120, "Orange" => 120, "Milk" => 45)
        @test reorder!(outofstock, stock) == Dict("Orange" => 120, "Chocolate" => 100)

        outofstock =  Dict("Kiwi" => 0, "Apple" => 0, "Melon" => 0)
        stock = Dict("Apple" => 120, "Raspberry" => 20, "Blueberries" => 50, "Broccoli" => 20, "Kiwi" => 25, "Melon" => 10)
        @test reorder!(outofstock, stock) == Dict("Kiwi" => 25, "Apple" => 120, "Melon" => 10)
    end
end
