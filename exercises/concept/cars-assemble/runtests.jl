using Test

include("cars-assemble.jl")

@testset verbose = true "tests" begin

    @testset "1. success_rate" begin
        @testset "Success rate for speed zero" begin
            speed = 0
            @test isapprox(success_rate(speed), 0.0, atol=1e-3)
        end

        @testset "Success rate for speed one" begin
            speed = 1
            @test isapprox(success_rate(speed), 1.0, atol=1e-3)
        end

        @testset "Success rate for speed four" begin
            speed = 4
            @test isapprox(success_rate(speed), 1.0, atol=1e-3)
        end

        @testset "Success rate for speed five" begin
            speed = 5
            @test isapprox(success_rate(speed), 0.9, atol=1e-3)
        end

        @testset "Success rate for speed nine" begin
            speed = 9
            @test isapprox(success_rate(speed), 0.8, atol=1e-3)
        end

        @testset "Success rate for speed ten" begin
            speed = 10
            @test isapprox(success_rate(speed), 0.77, atol=1e-3)
        end
    end
    
    @testset "2. production_rate_per_hour" begin
        @testset "Production rate per hour for speed zero" begin
            speed = 0
            @test isapprox(production_rate_per_hour(speed), 0.0, atol=1e-3)
        end

        @testset "Production rate per hour for speed one" begin
            speed = 1
            @test isapprox(production_rate_per_hour(speed), 221.0, atol=1e-3)
        end

        @testset "Production rate per hour for speed four" begin
            speed = 4
            @test isapprox(production_rate_per_hour(speed), 884.0, atol=1e-3)
        end

        @testset "Production rate per hour for speed seven" begin
            speed = 7
            @test isapprox(production_rate_per_hour(speed), 1392.3, atol=1e-3)
        end

        @testset "Production rate per hour for speed nine" begin
            speed = 9
            @test isapprox(production_rate_per_hour(speed), 1591.2, atol=1e-3)
        end

        @testset "Production rate per hour for speed ten" begin
            speed = 10
            @test isapprox(production_rate_per_hour(speed), 1701.7, atol=1e-3)
        end
    end

    @testset "3. working_items_per_minute" begin
        @testset "Working items per minute for speed zero" begin
            speed = 0
            @test typeof(working_items_per_minute(speed)) == Int
            @test working_items_per_minute(speed) == 0
        end

        @testset "Working items per minute for speed one" begin
            speed = 1
            @test typeof(working_items_per_minute(speed)) == Int
            @test working_items_per_minute(speed) == 3
        end

        @testset "Working items per minute for speed five" begin
            speed = 5
            @test typeof(working_items_per_minute(speed)) == Int
            @test working_items_per_minute(speed) == 16
        end

        @testset "Working items per minute for speed eight" begin
            speed = 8
            @test typeof(working_items_per_minute(speed)) == Int
            @test working_items_per_minute(speed) == 26
        end

        @testset "Working items per minute for speed nine" begin
            speed = 9
            @test typeof(working_items_per_minute(speed)) == Int
            @test working_items_per_minute(speed) == 26
        end

        @testset "Working items per minute for speed ten" begin
            speed = 10
            @test typeof(working_items_per_minute(speed)) == Int
            @test working_items_per_minute(speed) == 28
        end
    end
end
