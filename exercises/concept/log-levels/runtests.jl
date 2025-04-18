using Test 

include("log-levels.jl")

@testset verbose = true "tests" begin
    @testset "1. Get message" begin
        @testset "Error message" begin
            msg = "[ERROR]: Stack overflow"
            @test message(msg) == "Stack overflow"
        end
        
        @testset "Warning message" begin
            msg = "[WARNING]: Disk almost full"
            @test message(msg) == "Disk almost full"
        end
        
        @testset "Info message" begin
            msg = "[INFO]: File moved"
            @test message(msg) == "File moved"
        end
        
        @testset "Message with leading and trailing white space" begin
            msg = "[WARNING]:   \tTimezone not set  \r\n"
            @test message(msg) == "Timezone not set"
        end
    end

    @testset "2. Get log level" begin
        @testset "Error log level" begin
            msg = "[ERROR]: Disk full"
            @test log_level(msg) == "error"
        end

        @testset "Warning log level" begin
            msg = "[WARNING]: Unsafe password"
            @test log_level(msg) == "warning"
        end

        @testset "Info log level" begin
            msg = "[INFO]: Timezone changed"
            @test log_level(msg) == "info"
        end
    end

    @testset "3. Reformat a log line" begin
        @testset "Warning reformat" begin
            msg = "[WARNING]: Decreased performance"
            @test reformat(msg) == "Decreased performance (warning)"
        end

        @testset "Info reformat" begin
            msg = "[INFO]: Disk defragmented"
            @test reformat(msg) == "Disk defragmented (info)"
        end

        @testset "Reformat with leading and trailing white space" begin
            msg = "[ERROR]: \t Corrupt disk\t \t \r\n"
            @test reformat(msg) == "Corrupt disk (error)"
        end
    end
end
