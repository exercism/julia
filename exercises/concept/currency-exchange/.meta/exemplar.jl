exchange_money(budget, exchange_rate) = budget / exchange_rate

get_change(budget, exchanging_value) = budget - exchanging_value

get_value_of_bills(denomination, number_of_bills) = denomination * number_of_bills

get_number_of_bills(amount, denomination) = Int(floor(amount)) ÷ denomination

get_leftover_of_bills(amount, denomination) = amount % denomination

function exchangeable_value(budget, exchange_rate, spread, denomination)
    exchange_fee = (exchange_rate / 100) * spread
    exchange_value = exchange_money(budget, exchange_rate + exchange_fee)
    number_of_bills = get_number_of_bills(exchange_value, denomination)
    get_value_of_bills(denomination, number_of_bills)
end
