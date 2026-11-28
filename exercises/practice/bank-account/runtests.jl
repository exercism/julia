# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/bank-account/canonical-data.json
# File last updated on 2026-11-28

using Test

include("bank-account.jl")

@testset verbose = true "tests" begin
    @testset "Newly opened account has zero balance" begin
        account = create()
        open!(account)
        @test balance(account) == 0
    end

    @testset "Single deposit" begin
        account = create()
        open!(account)
        deposit!(account, 100)
        @test balance(account) == 100
    end

    @testset "Multiple deposits" begin
        account = create()
        open!(account)
        deposit!(account, 100)
        deposit!(account, 50)
        @test balance(account) == 150
    end

    @testset "Withdraw once" begin
        account = create()
        open!(account)
        deposit!(account, 100)
        withdraw!(account, 75)
        @test balance(account) == 25
    end

    @testset "Withdraw twice" begin
        account = create()
        open!(account)
        deposit!(account, 100)
        withdraw!(account, 80)
        withdraw!(account, 20)
        @test balance(account) == 0
    end

    @testset "Can do multiple operations sequentially" begin
        account = create()
        open!(account)
        deposit!(account, 100)
        deposit!(account, 110)
        withdraw!(account, 200)
        deposit!(account, 60)
        withdraw!(account, 50)
        @test balance(account) == 20
    end

    @testset "Cannot check balance of closed account" begin
        account = create()
        open!(account)
        close!(account)
        @test_throws ErrorException balance(account)
    end

    @testset "Cannot deposit into closed account" begin
        account = create()
        open!(account)
        close!(account)
        @test_throws ErrorException deposit!(account, 50)
    end

    @testset "Cannot deposit into unopened account" begin
        account = create()
        @test_throws ErrorException deposit!(account, 50)
    end

    @testset "Cannot withdraw from closed account" begin
        account = create()
        open!(account)
        close!(account)
        @test_throws ErrorException withdraw!(account, 50)
    end

    @testset "Cannot close an account that was not opened" begin
        account = create()
        @test_throws ErrorException close!(account)
    end

    @testset "Cannot open an already opened account" begin
        account = create()
        open!(account)
        @test_throws ErrorException open!(account)
    end

    @testset "Reopened account does not retain balance" begin
        account = create()
        open!(account)
        deposit!(account, 50)
        close!(account)
        open!(account)
        @test balance(account) == 0
    end

    @testset "Cannot withdraw more than deposited" begin
        account = create()
        open!(account)
        deposit!(account, 25)
        @test_throws ArgumentError withdraw!(account, 50)
    end

    @testset "Cannot withdraw negative" begin
        account = create()
        open!(account)
        deposit!(account, 100)
        @test_throws ArgumentError withdraw!(account, -50)
    end

    @testset "Cannot deposit negative" begin
        account = create()
        open!(account)
        @test_throws ArgumentError deposit!(account, -50)
    end

    @testset "Can handle concurrent transactions" begin
        account = create()
        open!(account)
        @sync for _ in 1:1000
            Threads.@spawn begin
                deposit!(account, 1)
                withdraw!(account, 1)
            end
        end
        @test balance(account) == 0
    end
end
