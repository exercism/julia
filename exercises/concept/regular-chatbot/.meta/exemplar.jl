const valid = r"^chatbot"i
const emoji = r"emoji[0-9]+"
const phone = r"^\(\+?([0-9]{2})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{3})[-. ]?([0-9]{3})$"
const url   = r"(\w+\.)+\w+"
const names = r"(?<surname>\w+), (?<name>\w+)"

is_valid_command(msg) = occursin(valid, msg)

remove_emoji(msg) = replace(msg, emoji => "")

check_phone_number(number) = occursin(phone, number) ? 
    "Thanks! You can now download me to your phone." : 
    "Oops, it seems like I can't reach out to $number"

getURL(msg) = [m.match for m in eachmatch(url, msg)]

nice_to_meet_you(str) = "Nice to meet you, " * replace(str, names => s"\g<name> \g<surname>")
