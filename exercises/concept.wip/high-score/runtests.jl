using Test

include("high-score.jl")

@testset "Adding players" begin
    @testset "Add player with score to empty score dict" begin
        scores = Dict{String, Int}()
        add_player!(scores, "Kalei", 233_436)
        @test scores == Dict(
            "Kalei" => 233_436,
        )
    end

    @testset "Add two players with scores to empty score dict" begin
        scores = Dict{String, Int}()
        add_player!(scores, "Léna", 901_806)
        add_player!(scores, "Ljuba", 302_799)
        @test scores == Dict(
            "Léna" => 901_806,
            "Ljuba" => 302_799,
        )
    end

    @testset "Add player without score to empty score dict" begin
        scores = Dict{String, Int}()
        add_player!(scores, "Nicolet")
        @test scores == Dict(
            "Nicolet" => 0,
        )
    end

    @testset "Add two players without score to empty dict" begin
        scores = Dict{String, Int}()
        add_player!(scores, "Dina")
        add_player!(scores, "Yasu")
        @test scores == Dict(
            "Dina" => 0,
            "Yasu" => 0,
        )
    end
end

@testset "Removing players" begin
    @testset "Removing a player from empty score dict results in empty score dict" begin
        scores = Dict{String, Int}()
        remove_player!(scores, "Waldemar")
        @test isempty(scores)
    end

    @testset "Removing a player after adding results in empty score dict" begin
        scores = Dict{String, Int}()
        add_player!(scores, "Arisha")
        remove_player!(scores, "Arisha")
        @test isempty(scores)
    end

    @testset "Removing the first player after adding two results in dict with remaining player" begin
        scores = Dict{String, Int}()
        add_player!(scores, "Fritjof")
        add_player!(scores, "Valèria")
        remove_player!(scores, "Fritjof")
        @test scores == Dict(
            "Valèria" => 0,
        )
    end

    @testset "Removing the second player after adding two results in dict with remaining player" begin
        scores = Dict{String, Int}()
        add_player!(scores, "Fritjof")
        add_player!(scores, "Valèria")
        remove_player!(scores, "Valèria")
        @test scores == Dict(
            "Fritjof" => 0,
        )
    end
end

@testset "Updating scores" begin
    @testset "Updating score for non-existent player initializes value" begin
        scores = Dict{String, Int}()
        update_score!(scores, "Dov", 721_957)
        @test scores == Dict(
            "Dov" => 721_957,
        )
    end

    @testset "Updating score for existing player without score replaces previous score" begin
        scores = Dict(
            "Sabriyya" => 0,
        )
        update_score!(scores, "Sabriyya", 560_806)
        @test scores == Dict(
            "Sabriyya" => 560_806,
        )
    end

    @testset "Updating score for existing player with score replaces previous score" begin
        scores = Dict(
            "Edvard" => 151_216,
        )
        update_score!(scores, "Edvard", 600_259)
        @test scores == Dict(
            "Edvard" => 600_259,
        )
    end

    @testset "Updating score for existing player in a dict with several players with score replaces player's previous score" begin
        scores = Dict(
            "Əli" => 977_076,
            "Lisbet" => 288_100,
        )
        update_score!(scores, "Lisbet", 989_376)
        @test scores == Dict(
            "Əli" => 977_076,
            "Lisbet" => 989_376,
        )
    end
end

@testset "Resetting scores" begin
    @testset "Resetting score for existing player sets score to 0" begin
        scores = Dict(
            "Thea" => 307_261,
        )
        reset_score!(scores, "Thea")
        @test scores == Dict(
            "Thea" => 0,
        )
    end

    @testset "Resetting score for existing player in a dict with several players sets player's score to 0" begin
        scores = Dict(
            "Anelia" => 307_261,
            "Robert" => 785_497,
        )
        reset_score!(scores, "Anelia")
        @test scores == Dict(
            "Anelia" => 0,
            "Robert" => 785_497,
        )
    end

    @testset "Resetting score for non-existent player sets player score to 0" begin
        scores = Dict{String, Int}()
        reset_score!(scores, "Erwin")
        @test scores == Dict(
            "Erwin" => 0,
        )
    end
end

@testset "List of players" begin
    @testset "Score board with one entry gives one result" begin
        scores = Dict(
            "Rodolfito" => 820_876
        )
        @test players(scores) == ["Rodolfito"]
    end

    @testset "Score board with multiple entries gives results in unknown order" begin
        scores = Dict(
            "Naheed" => 97_506,
            "Ivona" => 837_854,
            "Iztok" => 160_855,
            "Sara" => 936_371,
            "Udo" => 25,
        )
        @test sort(players(scores)) == ["Ivona", "Iztok", "Naheed", "Sara", "Udo"]
    end

    @testset "Empty score board results in empty player list" begin
        scores = Dict()
        @test isempty(players(scores))
    end
end
