# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/diamond/canonical-data.json
# File last updated on 2026-10-23

using Test

include("diamond.jl")

@testset verbose = true "tests" begin
    @testset "Degenerate case with a single 'A' row" begin
        @test rows("A") == ["A"]
    end

    @testset "Degenerate case with no row containing 3 distinct groups of spaces" begin
        @test rows("B") == [" A ", "B B", " A "]
    end

    @testset "Smallest non-degenerate case with odd diamond side length" begin
        @test rows("C") == ["  A  ", " B B ", "C   C", " B B ", "  A  "]
    end

    @testset "Smallest non-degenerate case with even diamond side length" begin
        @test rows("D") ==
              ["   A   ", "  B B  ", " C   C ", "D     D", " C   C ", "  B B  ", "   A   "]
    end

    @testset "Largest possible diamond" begin
        @test rows("Z") == ["                         A                         ",
                            "                        B B                        ",
                            "                       C   C                       ",
                            "                      D     D                      ",
                            "                     E       E                     ",
                            "                    F         F                    ",
                            "                   G           G                   ",
                            "                  H             H                  ",
                            "                 I               I                 ",
                            "                J                 J                ",
                            "               K                   K               ",
                            "              L                     L              ",
                            "             M                       M             ",
                            "            N                         N            ",
                            "           O                           O           ",
                            "          P                             P          ",
                            "         Q                               Q         ",
                            "        R                                 R        ",
                            "       S                                   S       ",
                            "      T                                     T      ",
                            "     U                                       U     ",
                            "    V                                         V    ",
                            "   W                                           W   ",
                            "  X                                             X  ",
                            " Y                                               Y ",
                            "Z                                                 Z",
                            " Y                                               Y ",
                            "  X                                             X  ",
                            "   W                                           W   ",
                            "    V                                         V    ",
                            "     U                                       U     ",
                            "      T                                     T      ",
                            "       S                                   S       ",
                            "        R                                 R        ",
                            "         Q                               Q         ",
                            "          P                             P          ",
                            "           O                           O           ",
                            "            N                         N            ",
                            "             M                       M             ",
                            "              L                     L              ",
                            "               K                   K               ",
                            "                J                 J                ",
                            "                 I               I                 ",
                            "                  H             H                  ",
                            "                   G           G                   ",
                            "                    F         F                    ",
                            "                     E       E                     ",
                            "                      D     D                      ",
                            "                       C   C                       ",
                            "                        B B                        ",
                            "                         A                         "]
    end
end
