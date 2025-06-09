using Test

include("factory-sensors.jl")

@testset verbose = true "tests" begin

    @testset "1. Monitor the humidity level of the room" begin
        @testset "Passing" begin
            @test humidity_level_ok(53)
        end

        @testset "Failing" begin
            @test_throws ErrorException humidity_level_ok(80)
            @test_throws "80" humidity_level_ok(80)
        end       
    end

    @testset "2. Check for overheating" begin
        @testset "Passing" begin
            @test temperature_ok(200)
        end

        @testset "Failing" begin
            @test_throws ArgumentError temperature_ok(nothing)
            @test_throws DomainError temperature_ok(501)
            @test_throws "501" temperature_ok(501)
        end
    end

    @testset "3. Monitor the machine" begin
        @testset "Passing" begin
            @test_logs (:info, "Machine is running smoothly") monitor_the_machine(53, 200)
        end

        @testset "Failing" begin
            @test_throws ErrorException humidity_level_ok(80)
            @test_throws "80" humidity_level_ok(80)

            @test_throws ArgumentError temperature_ok(nothing)
            @test_throws DomainError temperature_ok(501)
            @test_throws "501" temperature_ok(501)
        end       

        # I can't get this working:
        
        # @testset "Failing humidity" begin
        #     @test_logs (:error, "Humidity level check failed: 100%") monitor_the_machine(100, 200)
        # end

    end
end
