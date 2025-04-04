using Test

include("currency-exchange.jl")

@testset verbose = true "tests" begin
    @testset "1. exchange_money" begin
        @test isapprox(exchange_money(100000, 0.8), 125000; atol=0.1)
        @test isapprox(exchange_money(700000, 10.0), 70000; atol=0.1)
     end

    @testset "2. get_change" begin
        @test isapprox(get_change(463000, 5000), 458000; atol=0.1)
        @test isapprox(get_change(1250, 120), 1130; atol=0.1)
        @test isapprox(get_change(15000, 1380), 13620; atol=0.1)
    end

    @testset "3. get_value_of_bills" begin
        @test get_value_of_bills(10000, 128) == 1280000
        @test get_value_of_bills(50, 360) == 18000
        @test get_value_of_bills(200, 200) == 40000
    end

    @testset "4. get_number_of_bills" begin
        @test get_number_of_bills(163270, 50000) == 3
        @test get_number_of_bills(54361, 1000) == 54
    end

    @testset "5. get_leftover_of_bills" begin
        @test isapprox(get_leftover_of_bills(10.1, 10), 0.1; atol=1e-8)
        @test isapprox(get_leftover_of_bills(654321.0, 5), 1.0; atol=1e-8)
        @test isapprox(get_leftover_of_bills(3.14, 2) , 1.14; atol=1e-8)
    end

    @testset "6. exchangeable_value" begin
        @test exchangeable_value(100000, 10.61, 10, 1) == 8568
        @test exchangeable_value(1500, 0.84, 25, 40) == 1400
        @test exchangeable_value(470000, 1050, 30, 10000000000) == 0
        @test exchangeable_value(470000, 0.00000009, 30, 700) == 4017094016600
        @test exchangeable_value(425.33, 0.0009, 30, 700) == 363300
    end
end
