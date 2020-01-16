# NOTE: This code is purely to test the coverage of the JSON to test converter.
# It prints the number of exercises that the script works on.

using JSON, HTTP

# Include the code we want to test the coverage of
include("JSONtoTests.jl")

# Print the slugs of the exercises that the code works on.
println("The converter works on the following exercises: ")

# Initialize an error counter to keep track of the number of exercises our script does not work on.
error_count = 0

# Initialize a counter for keeping track of how many exercises don't have canonical data in problem-specifications.
not_existing = 0

# Get all exercises and iterate over them

slugs = collect(readdir("../exercises"))

# Comment out if you want to run on all exercises in problem-specifications
# slugs = ["accumulate","acronym","affine-cipher","all-your-base","allergies","alphametics","anagram","armstrong-numbers","atbash-cipher","bank-account","beer-song","binary","binary-search","binary-search-tree","bob","book-store","bowling","change","circular-buffer","clock","collatz-conjecture","complex-numbers","connect","counter","crypto-square","custom-set","darts","diamond","difference-of-squares","diffie-hellman","dnd-character","dominoes","dot-dsl","error-handling","etl","flatten-array","food-chain","forth","gigasecond","go-counting","grade-school","grains","grep","hamming","hangman","hello-world","hexadecimal","high-scores","house","isbn-verifier","isogram","kindergarten-garden","knapsack","largest-series-product","leap","ledger","lens-person","linked-list","list-ops","luhn","markdown","matching-brackets","matrix","meetup","micro-blog","minesweeper","nth-prime","nucleotide-codons","nucleotide-count","ocr-numbers","octal","paasio","palindrome-products","pangram","parallel-letter-frequency","pascals-triangle","perfect-numbers","phone-number","pig-latin","point-mutations","poker","pov","prime-factors","protein-translation","proverb","pythagorean-triplet","queen-attack","rail-fence-cipher","raindrops","rational-numbers","react","rectangles","resistor-color","resistor-color-duo","resistor-color-trio","rest-api","reverse-string","rna-transcription","robot-name","robot-simulator","roman-numerals","rotational-cipher","run-length-encoding","saddle-points","satellite","say","scale-generator","scrabble-score","secret-handshake","series","sgf-parsing","sieve","simple-cipher","simple-linked-list","space-age","spiral-matrix","strain","sublist","sum-of-multiples","tournament","transpose","tree-building","triangle","trinary","twelve-days","two-bucket","two-fer","variable-length-quantity","word-count","word-search","wordy","yacht","zebra-puzzle","zipper"]

for i in slugs
    # Make error_count global to change its value in the try-catch block.
    global error_count
    global not_existing

    # Try to run the code on the exercise.
    try
        main(i)
        # If code works, then we can print the slug of the exercise. (slug is indented, and bulleted)
        println("-   $i")
    catch error
        # If exercise does not exist in problem-specifications repo, increment number of exercies
        # that are not on problem-specifications and move on.
        if isa(error,NotFoundException)
            not_existing += 1
            continue
        end
        # If code doesn't work, increment the error count, and continue to next exercise
        error_count += 1
        continue
    end
end

# Print final number of passes and fails.
println("Pass: $(length(slugs) - error_count - not_existing), Fail = $error_count, Neutral = $not_existing")