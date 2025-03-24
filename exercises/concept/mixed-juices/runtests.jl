using Test 

include("mixed-juices.jl")

@testset verbose = true "tests" begin
    @testset "1. time_to_mix_juice" begin
        @testset "Returns the correct time for 'Pure Strawberry Joy'" begin
            @test time_to_mix_juice("Pure Strawberry Joy") == 0.5
        end

        @testset "Returns the correct time for 'Energizer'" begin
            @test time_to_mix_juice("Energizer") == 1.5
        end

        @testset "Returns the correct time for 'Green Garden'" begin
            @test time_to_mix_juice("Green Garden") == 1.5
        end

        @testset "Returns the correct time for 'Tropical Island'" begin
            @test time_to_mix_juice("Tropical Island") == 3
        end

        @testset "Returns the correct time for 'All or Nothing'" begin
            @test time_to_mix_juice("All or Nothing") == 5
        end

        @testset "Returns the correct time for all other juices" begin
            default_time = 2.5
            @test time_to_mix_juice("Limetime") == default_time
            @test time_to_mix_juice("Manic Organic") == default_time
            @test time_to_mix_juice("Papaya & Peach") == default_time
        end
    end

    @testset "2. limes_to_cut" begin
        @testset "Medium order" begin
            limes = [
                "small",
                "large",
                "large",
                "medium",
                "small",
                "large",
                "large",
                "medium"
              ]
            @test limes_to_cut(42, limes) == 6
        end

        @testset "Small order" begin
            limes = [
                "medium",
                "small"
            ]
            @test limes_to_cut(4, limes) == 1
        end

        @testset "Large order" begin
            limes = [
                "small",
                "large",
                "large",
                "medium",
                "small",
                "large",
                "large"
            ]
            @test limes_to_cut(80, limes) == 7
        end

        @testset "If no new wedges are needed, no limes are cut" begin
            limes = [
                "small",
                "large",
                "medium"
            ]
            @test limes_to_cut(0, limes) == 0
        end

        @testset "works if no limes are available" begin
            limes = []
            @test limes_to_cut(10, limes) == 0
        end
    end

    @testset "3. order_times" begin
        @testset "correctly determines the times for current orders" begin
            orders = [
                "Tropical Island",
                "Energizer",
                "Limetime",
                "All or Nothing",
                "Pure Strawberry Joy"
            ]
            expected = [3.0, 1.5, 2.5, 5.0, 0.5]
            @test order_times(orders) == expected
        end

        @testset "correctly determines the times for current orders" begin
            orders = [
                "Pure Strawberry Joy",
                "Pure Strawberry Joy",
                "Vitality",
                "Tropical Island",
                "All or Nothing",
                "All or Nothing",
                "All or Nothing",
                "Green Garden",
                "Limetime"
            ]
            expected = [0.5, 0.5, 2.5, 3.0, 5.0, 5.0, 5.0, 1.5, 2.5]
            @test order_times(orders) == expected
        end

        @testset "correctly returns an empty list if there are no orders" begin
            orders = []
            @test order_times(orders) == []
        end
    end

    @testset "4. remaining_orders" begin
        @testset "correctly determines the remaining orders" begin
            orders = [
                "Tropical Island",
                "Energizer",
                "Limetime",
                "All or Nothing",
                "Pure Strawberry Joy"
            ]
            expected = ["All or Nothing", "Pure Strawberry Joy"]
            @test remaining_orders(7, orders) == expected
        end

        @testset "correctly determines the remaining orders" begin
            orders = [
                "Pure Strawberry Joy",
                "Pure Strawberry Joy",
                "Vitality",
                "Tropical Island",
                "All or Nothing",
                "All or Nothing",
                "All or Nothing",
                "Green Garden",
                "Limetime"
            ]
            expected = ["All or Nothing", "Green Garden", "Limetime"]
            @test remaining_orders(13, orders) == expected
        end

        @testset "counts all orders as fulfilled if there is enough time" begin
            orders = [
                "Energizer",
                "Green Garden",
                "Ruby Glow",
                "Pure Strawberry Joy",
                "Tropical Island",
                "Limetime"
            ]
            @test remaining_orders(12, orders) == []
        end

        @testset "works if there is only very little time left" begin
            orders = [
                "Bananas Gone Wild", 
                "Pure Strawberry Joy"
            ]
            expected = ["Pure Strawberry Joy"]
            @test remaining_orders(0.2, orders) == expected
        end
    end
end
