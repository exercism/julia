using Test 

include("tisbury-treasure-hunt.jl")

@testset verbose = true "tests" begin
    @testset "1. get_coordinate" begin
        @testset "For Scrimshaw Whale's Tooth" begin
            @test get_coordinate(("Scrimshaw Whale's Tooth", "2A")) == "2A"
        end

        @testset "For Brass Spyglass" begin
            @test get_coordinate(("Brass Spyglass", "4B")) == "4B"
        end

        @testset "For Robot Parrot" begin
            @test get_coordinate(("Robot Parrot", "1C")) == "1C"
        end

        @testset "For Glass Starfish" begin
            @test get_coordinate(("Glass Starfish", "6D")) == "6D"
        end

        @testset "For Crystal Crab" begin
            @test get_coordinate(("Crystal Crab", "6A")) == "6A"
        end

        @testset "For Angry Monkey Figurine" begin
            @test get_coordinate(("Angry Monkey Figurine", "5B")) == "5B"
        end
    end

    @testset "2. convert_coordinate" begin
        @testset "For 2A" begin
            @test convert_coordinate("2A") == ('2', 'A')
        end

        @testset "For 4B" begin
            @test convert_coordinate("4B") == ('4', 'B')
        end

        @testset "For 6A" begin
            @test convert_coordinate("6A") == ('6', 'A')
        end

    end

    @testset "3. compare_records" begin
        @testset "first matched records returns true" begin
            azara_record = ("Scrimshaw Whale's Tooth", "2A")
            rui_record = ("Deserted Docks", ('2', 'A'), "Blue")
            @test compare_records(azara_record, rui_record) == true
        end

        @testset "second matched records returns true" begin
            azara_record = ("Glass Starfish", "6D")
            rui_record = ("Tangled Seaweed Patch", ('6', 'D'), "Orange")
            @test compare_records(azara_record, rui_record) == true
        end

        @testset "third matched records returns true" begin
            azara_record = ("Vintage Pirate Hat", "7E")
            rui_record = ("Quiet Inlet (Island of Mystery)", ('7', 'E'), "Orange")
            @test compare_records(azara_record, rui_record) == true
        end

        @testset "fourth matched records returns true" begin
            azara_record = ("Glass Starfish", "6D")
            rui_record = ("Tangled Seaweed Patch", ('6', 'D'), "Orange")
            @test compare_records(azara_record, rui_record) == true
        end

        @testset "first unmatched records returns false" begin
            azara_record = ("Angry Monkey Figurine", "5B")
            rui_record = ("Aqua Lagoon (Island of Mystery)", ('1', 'F'), "Yellow")
            @test compare_records(azara_record, rui_record) == false
        end

        @testset "second unmatched records returns false" begin
            azara_record = ("Brass Spyglass", "4B")
            rui_record = ("Spiky Rocks", ('3', 'D'), "Yellow")
            @test compare_records(azara_record, rui_record) == false
        end

        @testset "third unmatched records returns false" begin
            azara_record = ("Angry Monkey Figurine", "5B")
            rui_record = ("Quiet Inlet (Island of Mystery)", ('7', 'E'), "Orange")
            @test compare_records(azara_record, rui_record) == false
        end
    end

    @testset "4. create_record" begin
        @testset "first matched records returns correct tuple" begin
            azara_record = ("Scrimshaw Whale's Tooth", "2A")
            rui_record = ("Deserted Docks", ('2', 'A'), "Blue")
            expected = ("2A", "Deserted Docks", "Blue", "Scrimshaw Whale's Tooth")
           @test create_record(azara_record, rui_record) == expected
        end

        @testset "second matched records returns correct tuple" begin
            azara_record = ("Glass Starfish", "6D")
            rui_record = ("Tangled Seaweed Patch", ('6', 'D'), "Orange")
            expected =  ("6D", "Tangled Seaweed Patch", "Orange", "Glass Starfish")
            @test create_record(azara_record, rui_record) == expected
        end

        @testset "third matched records returns correct tuple" begin
            azara_record = ("Vintage Pirate Hat", "7E")
            rui_record = ("Quiet Inlet (Island of Mystery)", ('7', 'E'), "Orange")
            expected = ("7E", "Quiet Inlet (Island of Mystery)", "Orange", "Vintage Pirate Hat")
            @test create_record(azara_record, rui_record) == expected
        end

        @testset "fourth matched records returns correct tuple" begin
            azara_record = ("Glass Starfish", "6D")
            rui_record = ("Tangled Seaweed Patch", ('6', 'D'), "Orange")
            expected = ("6D", "Tangled Seaweed Patch", "Orange", "Glass Starfish")
            @test create_record(azara_record, rui_record) == expected
        end

        @testset "first unmatched records returns empty tuple" begin
            azara_record = ("Angry Monkey Figurine", "5B")
            rui_record = ("Aqua Lagoon (Island of Mystery)", ('1', 'F'), "Yellow")
            @test create_record(azara_record, rui_record) == ()
        end

        @testset "second unmatched records returns empty tuple" begin
            azara_record = ("Brass Spyglass", "4B")
            rui_record = ("Spiky Rocks", ('3', 'D'), "Yellow")
            @test create_record(azara_record, rui_record) == ()
        end

        @testset "third unmatched records returns empty tuple" begin
            azara_record = ("Angry Monkey Figurine", "5B")
            rui_record = ("Quiet Inlet (Island of Mystery)", ('7', 'E'), "Orange")
            @test create_record(azara_record, rui_record) == ()
        end

    end

end
