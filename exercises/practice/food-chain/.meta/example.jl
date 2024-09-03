const ANIMALS = ["fly", "spider", "bird", "cat", "dog", "goat", "cow", "horse"]
const LINE2 = ["",
         "It wriggled and jiggled and tickled inside her.",
         "How absurd to swallow a bird!",
         "Imagine that, to swallow a cat!",
         "What a hog, to swallow a dog!",
         "Just opened her throat and swallowed a goat!",
         "I don't know how she swallowed a cow!",
         "She's dead, of course!"]

const WRIGGLE = " that wriggled and jiggled and tickled inside her."
const LAST = "I don't know why she swallowed the fly. Perhaps she'll die."

function recite(start_verse, end_verse)
    verses = [make_verse(i) for i in start_verse:end_verse]
    all_verses = [line for v in verses for line in v]
    all_verses[2:end]
end

function make_verse(n)
    verse = ["", "I know an old lady who swallowed a $(ANIMALS[n])."]
    isempty(LINE2[n]) || push!(verse, LINE2[n])

    ANIMALS[n] == "horse" && return verse

    for v in n:-1:2
        line = "She swallowed the $(ANIMALS[v]) to catch the $(ANIMALS[v-1])"
        line *= ANIMALS[v - 1] == "spider" ? WRIGGLE : "."
        push!(verse, line)
    end

    push!(verse, LAST)
    verse
end
