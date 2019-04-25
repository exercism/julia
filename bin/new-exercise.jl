using Pkg
import REPL
using REPL.TerminalMenus

using DataStructures
using HTTP
using JSON

# TOPICS.txt parser
function parsetopics(topicstxt)
    # category -> topic
    # e.g. Basic Concepts -> abstract_classes
    topics = OrderedDict{String, Vector{String}}()

    category = ""
    for (i, l) in enumerate(topicstxt)
        if isempty(category)
            category = l
            topics[category] = String[]
            continue
        elseif isempty(l)
            # new line means that the next line will be a new heading
            category = ""
            continue
        elseif all(c -> c == '-', l)
            # underline, ignore it
            continue
        end
        
        push!(topics[category], l)
    end

    topics
end

# [Yes/No] selector
# The following function has been derived from BinaryBuilder.jl's `yn_prompt`:
# https://github.com/JuliaPackaging/BinaryBuilder.jl/blob/60124d0532ae689227d6c707ab899841e6306c10/src/wizard/utils.jl#L118-L141
# BinaryBuilder.jl license info: Copyright (c) 2017: Elliot Saba [MIT License]
# Full license text: https://github.com/JuliaPackaging/BinaryBuilder.jl/blob/60124d0532ae689227d6c707ab899841e6306c10/LICENSE.md
function yn_select(question, default = :y)
    @assert default in (:y, :n)
    ynstr = default == :y ? "[Y/n]" : "[y/N]"
    while true
        print(question, " ", ynstr, ": ")
        answer = lowercase(strip(readline()))
        if isempty(answer)
            return default == :y
        elseif answer == "y" || answer == "yes"
            return true
        elseif answer == "n" || answer == "no"
            return false
        else
            println("Unrecognized answer. Answer `y` or `n`.")
        end
    end
end

# slug
function choose_slug()
    print("exercise slug: ")
    readline()
end

# core
iscore(slug) = yn_select("Is $slug a core exercise?", :n)

# unlocked_by
function choose_unlocked_by(slug, core, core_exercises)
    if !core
        menu = RadioMenu(core_exercises)
        choice = request("choose the core exercise that $slug is unlocked by:", menu)
        core_exercises[choice]
    else
        nothing
    end
end

# difficulty
function choose_difficulty(slug)
    while true
        print("choose the difficulty of $slug [1-10]: ")
        d = parse(Int, readline())
        if d ∈ 1:10
            return d
        else
            @error "difficulty must be a number from 1-10"
        end
    end
end

function shared_topics()
    url = "https://raw.githubusercontent.com/exercism/problem-specifications/master/TOPICS.txt"
    r = HTTP.request("GET", url)
    split(String(r.body), '\n')
end

# topics
function choose_topics(slug)
    println("Please select all of the following topics that are covered by this exercise.")
    alltopics = merge(parsetopics(shared_topics()), parsetopics(readlines(open("TOPICS.txt"))))
    topics = String[]
    for category in keys(alltopics)
        # MultiSelectMenu requires at least two options
        # if a category only has one entry, add an empty entry
        if length(alltopics[category]) < 2
            push!(alltopics[category], "")
        end

        menu = MultiSelectMenu(alltopics[category])
        choices = request("$category:", menu)
        for i in choices
            push!(topics, alltopics[category][i])
        end
        println()
    end
    topics
end

const configlet = joinpath("bin", "configlet")

# check if configlet has been installed and the script is running from the root dir of the repo
try
    read(`$configlet version`)
catch e
    isa(e, Base.IOError) && error("could not run configlet\n\nMake sure to run the script from the root directory of the track repo\nand that the configlet has been fetched using `bin/fetch-configlet`.\n\n")
end

# load config.json
const cfg = JSON.parsefile("config.json")

# load exercises from config
const core_exercises = [ex["slug"] for ex in cfg["exercises"] if ex["core"]]

# show prompts
const uuid = strip(String(read(`$configlet uuid`)))
const slug = choose_slug()
const core = iscore(slug)
const unlocked_by = choose_unlocked_by(slug, core, core_exercises)
const difficulty = choose_difficulty(slug)
const topics = choose_topics(slug)

const cfg_entry = OrderedDict(
    "uuid" => uuid,
    "slug" => slug,
    "core" => core,
    "unlocked_by" => unlocked_by,
    "difficulty" => difficulty,
    "topics" => topics,
)

println(json(cfg_entry))
