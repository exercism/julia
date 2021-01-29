using Unicode: graphemes

const TEST_GRAPHEMES = true

function myreverse(phrase::String)
    join(reverse(collect(graphemes(phrase))))
end
