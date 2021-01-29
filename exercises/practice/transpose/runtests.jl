using Test

include("transpose.jl")

@testset "empty string" begin
    @test transpose_strings([]) == []
end

@testset "two characters in a row" begin
    @test transpose_strings(["A1"]) == ["A", "1"]
end

@testset "two characters in a column" begin
    @test transpose_strings(["A", "1"]) == ["A1"]
end

@testset "simple" begin
    @test transpose_strings(["ABC", "123"]) == [
          "A1",
          "B2",
          "C3"
        ]
end

@testset "single line" begin
    @test transpose_strings(["Single line."]) == [
          "S",
          "i",
          "n",
          "g",
          "l",
          "e",
          " ",
          "l",
          "i",
          "n",
          "e",
          "."
        ]
end

@testset "first line longer than second line" begin
    @test transpose_strings([
          "The fourth line.",
          "The fifth line."
        ]) == [
          "TT",
          "hh",
          "ee",
          "  ",
          "ff",
          "oi",
          "uf",
          "rt",
          "th",
          "h ",
          " l",
          "li",
          "in",
          "ne",
          "e.",
          "."
        ]
end

@testset "second line longer than first line" begin
    @test transpose_strings([
          "The first line.",
          "The second line."
        ]) == [
          "TT",
          "hh",
          "ee",
          "  ",
          "fs",
          "ie",
          "rc",
          "so",
          "tn",
          " d",
          "l ",
          "il",
          "ni",
          "en",
          ".e",
          " ."
        ]
end

@testset "mixed line length" begin
    @test transpose_strings([
        "The longest line.",
        "A long line.",
        "A longer line.",
        "A line."
    ]) == [
        "TAAA",
        "h   ",
        "elll",
        " ooi",
        "lnnn",
        "ogge",
        "n e.",
        "glr",
        "ei ",
        "snl",
        "tei",
        " .n",
        "l e",
        "i .",
        "n",
        "e",
        "."
    ]
end

@testset "square" begin
    @test transpose_strings([
          "HEART",
          "EMBER",
          "ABUSE",
          "RESIN",
          "TREND"
        ]) == [
          "HEART",
          "EMBER",
          "ABUSE",
          "RESIN",
          "TREND"
        ]
end

@testset "rectangle" begin
    @test transpose_strings([
          "FRACTURE",
          "OUTLINED",
          "BLOOMING",
          "SEPTETTE"
        ]) == [
          "FOBS",
          "RULE",
          "ATOP",
          "CLOT",
          "TIME",
          "UNIT",
          "RENT",
          "EDGE"
        ]
end

@testset "triangle" begin
    @test transpose_strings([
          "T",
          "EE",
          "AAA",
          "SSSS",
          "EEEEE",
          "RRRRRR"
        ]) == [
          "TEASER",
          " EASER",
          "  ASER",
          "   SER",
          "    ER",
          "     R"
        ]
end

@testset "many lines" begin
    @test transpose_strings([
          "Chor. Two households, both alike in dignity,",
          "In fair Verona, where we lay our scene,",
          "From ancient grudge break to new mutiny,",
          "Where civil blood makes civil hands unclean.",
          "From forth the fatal loins of these two foes",
          "A pair of star-cross'd lovers take their life;",
          "Whose misadventur'd piteous overthrows",
          "Doth with their death bury their parents' strife.",
          "The fearful passage of their death-mark'd love,",
          "And the continuance of their parents' rage,",
          "Which, but their children's end, naught could remove,",
          "Is now the two hours' traffic of our stage;",
          "The which if you with patient ears attend,",
          "What here shall miss, our toil shall strive to mend."
        ]) == [
          "CIFWFAWDTAWITW",
          "hnrhr hohnhshh",
          "o oeopotedi ea",
          "rfmrmash  cn t",
          ".a e ie fthow ",
          " ia fr weh,whh",
          "Trnco miae  ie",
          "w ciroitr btcr",
          "oVivtfshfcuhhe",
          " eeih a uote  ",
          "hrnl sdtln  is",
          "oot ttvh tttfh",
          "un bhaeepihw a",
          "saglernianeoyl",
          "e,ro -trsui ol",
          "h uofcu sarhu ",
          "owddarrdan o m",
          "lhg to'egccuwi",
          "deemasdaeehris",
          "sr als t  ists",
          ",ebk 'phool'h,",
          "  reldi ffd   ",
          "bweso tb  rtpo",
          "oea ileutterau",
          "t kcnoorhhnatr",
          "hl isvuyee'fi ",
          " atv es iisfet",
          "ayoior trr ino",
          "l  lfsoh  ecti",
          "ion   vedpn  l",
          "kuehtteieadoe ",
          "erwaharrar,fas",
          "   nekt te  rh",
          "ismdsehphnnosa",
          "ncuse ra-tau l",
          " et  tormsural",
          "dniuthwea'g t ",
          "iennwesnr hsts",
          "g,ycoi tkrttet",
          "n ,l r s'a anr",
          "i  ef  'dgcgdi",
          "t  aol   eoe,v",
          "y  nei sl,u; e",
          ",  .sf to l   ",
          "     e rv d  t",
          "     ; ie    o",
          "       f, r   ",
          "       e  e  m",
          "       .  m  e",
          "          o  n",
          "          v  d",
          "          e  .",
          "          ,"]
end
