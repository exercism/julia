const possessive_pronouns = Dict(
    "they/them" => "their",
    "she/her" => "her",
    "he/him" => "his"
)

function generate_card(line)
    re = r"^»(?P<title>.+)« – (?P<speaker>[\p{L} ]+)(?:\s+\(?(?P<pronouns>[a-z\/]+)?\))?(?:, from (?P<org>[^.]+))?\. Start: (?P<start>[\d:]+)(?:, Q&A: (?P<qanda>[\d:]+))?, End: (?P<end>[\d:]*)$"
    m = match(re, line)

    """
    - Our next speaker is $(m[:speaker])$(isnothing(m[:org]) ? "" : ", from $(m[:org])")
    - $(isnothing(m[:pronouns]) ? first(split(m[:speaker])) * "'s" : titlecase(possessive_pronouns[m[:pronouns]])) talk is called »$(m[:title])«
    - $(isnothing(m[:qanda]) ? "There will not be a Q&A session." : "$((isnothing(m[:pronouns]) ? first(split(m[:speaker])) : titlecase(first(split(m[:pronouns], "/"))))) will answer your questions in the Q&A session at the end of the talk, starting at $(m[:qanda])")

    $(m[:start]) - $(isnothing(m[:qanda]) ? "NO Q&A" : m[:qanda]) - $(m[:end])
    """
end
