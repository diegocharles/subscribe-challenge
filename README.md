# Sales Taxes Problem (Ruby)

## Problem Statement

This problem requires some kind of input. You are free to implement any mechanism for feeding the input into your solution. You should provide sufficient evidence that your solution is complete by, as a minimum, indicating that it works correctly against the supplied test data.

**Basic sales tax** is applicable at a rate of **10%** on all goods, **except** books, food, and medical products that are exempt. **Import duty** is an additional sales tax applicable on all imported goods at a rate of 5%, with no exemptions.

When I purchase items I receive a receipt which lists the name of all the items and their price (including tax), finishing with the total cost of the items, and the total amounts of sales taxes paid. The rounding rules for sales tax are that for a tax rate of n%, a shelf price of p contains (np/100 rounded up to the nearest 0.05) amount of sales tax.


Write an application that prints out the receipt details for these shopping baskets:

### Input

#### Input 1:
```
2 book at 12.49
1 music CD at 14.99
1 chocolate bar at 0.85
```

#### Output 1:
```
2 book: 24.98
1 music CD: 16.49
1 chocolate bar: 0.85
Sales Taxes: 1.50
Total: 42.32
```

#### Input 2:
```
1 imported box of chocolates at 10.00
1 imported bottle of perfume at 47.50
```

#### Output 2:
```
1 imported box of chocolates: 10.50
1 imported bottle of perfume: 54.65
Sales Taxes: 7.65
Total: 65.15
```

#### Input 3:
```
1 imported bottle of perfume at 27.99
1 bottle of perfume at 18.99
1 packet of headache pills at 9.75
3 imported boxes of chocolates at 11.25
```

#### Output 3:
```
1 imported bottle of perfume: 32.19
1 bottle of perfume: 20.89
1 packet of headache pills: 9.75
3 imported boxes of chocolates: 35.55
Sales Taxes: 7.90
Total: 98.38
```

#### Output 3:
```
1 imported bottle of perfume: 32.19
1 bottle of perfume: 20.89
1 packet of headache pills: 9.75
3 imported boxes of chocolates: 35.55
Sales Taxes: 7.90
Total: 98.38
```


Run:
```
ruby run.rb < input1.txt
ruby run.rb < input2.txt
ruby run.rb < input3.txt
```

### Run tests:
```
ruby -I test test/*_test.rb
```

#### Or run individual test files:
```
ruby -I test test/product_classifier_test.rb
ruby -I test test/tax_calculator_test.rb
ruby -I test test/integration_test.rb
```

# Technical Motivations

## Design Decisions

### Dependency Injection

I decided to implement dependency injection in some parts of the codebase, specifically:

- **Product** accepts a `classifier` parameter (defaults to `ProductClassifier`)
- **TaxCalculator** accepts `basic_rate` and `import_rate` parameters (with defaults)

I was actually in doubt about this decision. On one hand, giving preference to dependency injection could be considered over-engineering for the proposed test, however, it would be my call for large codebases.
 The challenge is relatively simple and could be solved with direct class references and constants, and that would be my call for product or features MVPs specialy at the early validation stages.

However, I was uncertain about which skill I should demonstrate: knowledge of SOLID principles (specifically Dependency Inversion Principle) or keeping everything simple, even if it means violating some principles in favor of simplicity.

I ended up going with the DI approach to show that I understand these concepts, but I'm aware that a simpler solution would also be valid and maybe more aligned with the "don't over-engineer" guidance. It's a trade-off between showing OOP knowledge vs keeping things simple.

### Class Separation

I separated the code into 5 main classes:
- **Product**: Value object representing a product
- **ProductClassifier**: Handles product classification logic (exempt detection)
- **TaxCalculator**: Calculates taxes with configurable rates
- **Receipt**: Handles formatting and printing
- **ReceiptLineParser**: Parses input lines

This separation follows Single Responsibility Principle.

### Thread Safety

The `ProductClassifier` uses `.freeze` on the `EXEMPT_WORDS` constant to ensure immutability and thread-safety.
All classes are stateless (except for injected dependencies), making them inherently thread-safe.

### Ruby Paradigms

- Duck typing for dependencies (TaxCalculator works with any object that responds to `price`, `exempt?`, `imported?`)
- Ruby idioms: `%w[]`, `format`, expressive method names
- Private methods for internal implementation details
# subscribe-challenge
