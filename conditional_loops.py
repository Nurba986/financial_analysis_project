# def check_password(password):
#     if len(password) < 6:
#         return 'weak'
#     elif password.isalpha():
#         return 'moderate'
#     elif password.isalnum():
#         return 'strong'
#     return 'invalid password'
#
# password = input('Enter password: ')
# print(check_password(password))


# def calculation(purchases):
#     if purchases > 1000:
#         return purchases - (purchases * 0.1)
#     elif 500 <= purchases < 1000:
#         return purchases - (purchases * 0.05)
#     else:
#         return 'No discount'
#
# purchases = int(input('Purchase number: '))
# print(calculation(purchases))


def converter(celsius):
    fahrenheit = celsius * 9/5 + 32
    return fahrenheit


celsius = int(input('Enter temperature: '))
fahrenheit = converter(celsius)


if fahrenheit > 100:
    print(f'{fahrenheit} Fahrenheit - Warning: High Temperature')
elif fahrenheit < 32:
    print(f'{fahrenheit} Fahrenheit - Warning: Freezing Temperature')
else:
    print(f'{fahrenheit} Fahrenheit - Normal Temperature')
