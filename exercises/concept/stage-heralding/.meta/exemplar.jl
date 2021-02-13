# Julia 1.0 compat
if VERSION < v"1.1"
    @eval isnothing(::Any) = false
    @eval isnothing(::Nothing) = true
end

const possessive_pronouns = Dict(
    "they/them" => "their",
    "she/her" => "her",
    "he/him" => "his"
)

function generate_card(line)
    # You can also write this as a multi-line regex string:
    # re = r"""»(.*)«                     # title
    #          \ –\ (.*?)                 # name
    #          (?:\ \((.*?)\)|)           # optional pronouns
    #          (?:,\ from\ (.*?)|).       # optional organisation
    #          \ Start:\ (.*?),\          # start time
    #          (?:Q&A:\ (.*?),\ |)        # optional Q&A time
    #          End:\ (.*)                 # end time
    #       """x
    re = r"»(.*?)« – (.*?)(?: \((.*?)\)|)(?:, from (.*?)|). Start: (.*?), (?:Q&A: (.*?), |)End: (.*)"

    title, name, pronouns, org, start_time, qa_time, end_time = match(re, line).captures

    they = isnothing(pronouns) ? first(split(name)) : titlecase(first(split(pronouns, '/')))
    their = isnothing(pronouns) ? first(split(name)) * "'s" : titlecase(possessive_pronouns[pronouns])
    qa_line = (isnothing(qa_time) ?
               "There will not be a Q&A session" :
               "$they will answer your questions in the Q&A session at the end of the talk, starting at $qa_time")

    """
    - Our next speaker is $(name * (isnothing(org) ? "" : ", from $org"))
    - $their talk is called »$title«
    - $qa_line

    $start_time - $(isnothing(qa_time) ? "NO Q&A -" : "$qa_time -") $end_time
    """
end
