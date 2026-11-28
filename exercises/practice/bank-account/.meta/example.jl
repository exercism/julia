mutable struct BankAccount
    @atomic balance::Int128
    @atomic open::Bool
end

function create()
    BankAccount(0, false)
end

function open!(account)
    account.open && error("Account is already open")
    @atomic account.open = true
    @atomic account.balance = 0
end

function close!(account)
    account.open || error("Account is already closed")
    @atomic account.open = false
end

function deposit!(account, amount)
    account.open || error("Account is closed")
    isnegative(amount) && throw(ArgumentError("Amount must be positive"))
    @atomic account.balance += amount
end

function withdraw!(account, amount)
    account.open || error("Account is closed")
    isnegative(amount) && throw(ArgumentError("Amount must be positive"))
    account.balance < amount && throw(ArgumentError("Insufficient funds"))
    @atomic account.balance -= amount
end

function balance(account)
    account.open || error("Account is closed")
    account.balance
end
