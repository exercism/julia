# Instructions

Your friend Chandler plans to visit exotic countries all around the world. Sadly, Chandler's math skills aren't good. He's pretty worried about being scammed by currency exchanges during his trip - and he wants you to make a currency calculator for him. Here are his specifications for the app:

## 1. Estimate value after exchange

Create the `exchange_money()` function, taking 2 parameters:

1. `budget` : The amount of money you are planning to exchange.
2. `exchange_rate` : The amount of domestic currency equal to one unit of foreign currency.

This function should return the value of the exchanged currency.

**Note:** If your currency is USD and you want to exchange USD for EUR with an exchange rate of `1.20`, then `1.20 USD == 1 EUR`.

```julia
exchange_money(127.5, 1.2)  # => 106.25
```

## 2. Calculate currency left after an exchange

Create the `get_change()` function, taking 2 parameters:

1. `budget` : Amount of money before exchange.
2. `exchanging_value` : Amount of money that is *taken* from the budget to be exchanged.

This function should return the amount of money that *is left* from the budget.

```julia
get_change(127.5, 120)  # => 7.5
```

## 3. Calculate value of bills

Create the `get_value_of_bills()` function, taking 2 parameters:

1. `denomination` : The value of a single bill.
2. `number_of_bills` : The total number of bills.

This exchanging booth only deals in cash of certain increments.
The total you receive must be divisible by the value of one "bill" or unit, which can leave behind a fraction or remainder.
Your function should return only the total value of the bills (_excluding fractional amounts_) the booth would give back.
Unfortunately, the booth gets to keep the remainder/change as an added bonus.

```julia
get_value_of_bills(5, 128)  # => 640
```

## 4. Calculate number of bills

Create the `get_number_of_bills()` function, taking `amount` and `denomination`.

This function should return the _number of currency bills_ that you can receive within the given _amount_.
In other words:  How many _whole bills_ of currency fit into the starting amount?
Remember -- you can only receive _whole bills_, not fractions of bills, so remember to divide accordingly.
Effectively, you are rounding _down_ to the nearest whole bill/denomination.

```julia
get_number_of_bills(127.5, 5)  # => 25
```

## 5. Calculate leftover after exchanging into bills

Create the `get_leftover_of_bills()` function, taking `amount` and `denomination`.

This function should return the _leftover amount_ that cannot be returned from your starting _amount_ given the denomination of bills.
It is very important to know exactly how much the booth gets to keep.

```julia
get_leftover_of_bills(127.5, 20)  # => 7.5
```

## 6. Calculate value after exchange

Create the `exchangeable_value()` function, taking `budget`, `exchange_rate`, `spread`, and `denomination`.

Parameter `spread` is the *percentage taken* as an exchange fee, written as an integer.
It needs to be converted to decimal by dividing it by 100.
If `1.00 EUR == 1.20 USD` and the *spread* is `10`, the actual exchange rate will be: `1.00 EUR == 1.32 USD` because 10% of 1.20 is 0.12, and this additional fee is added to the exchange.

This function should return the maximum value of the new currency after calculating the *exchange rate* plus the *spread*.
Remember that the currency *denomination* is a whole number, and cannot be sub-divided.

**Note:** Returned value should be an integer type.

```julia
exchangeable_value(127.25, 1.20, 10, 20)  # => 80
exchangeable_value(127.25, 1.20, 10, 5)  # => 95
```
