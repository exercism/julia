"""
    welcome(customer)

Return the welcome message for the customer.
"""
welcome(customer) = "Welcome to the Tech Palace, " * uppercase(customer)

"""
    add_border(message, n)

Return the welcome message with a border of stars.
"""
add_border(message, n) = "*"^n * "\n" * message * "\n" * "*"^n

"""
    clean(message)

Return the cleaned up marketing message.
"""
clean(message) = strip(message)
