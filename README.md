# Tech Test
```
/$$$$$$$   /$$$$$$  /$$   /$$ /$$   /$$
| $$__  $$ /$$__  $$| $$$ | $$| $$  /$$/
| $$  \ $$| $$  \ $$| $$$$| $$| $$ /$$/
| $$$$$$$ | $$$$$$$$| $$ $$ $$| $$$$$/
| $$__  $$| $$__  $$| $$  $$$$| $$  $$
| $$  \ $$| $$  | $$| $$\  $$$| $$\  $$
| $$$$$$$/| $$  | $$| $$ \  $$| $$ \  $$
|_______/ |__/  |__/|__/  \__/|__/  \__/
```

## Introduction
This is a TDD'd implementation at Week 10 of a specification we were introduced to very early on. It allows you to make deposits to and withdrawals from a bank account, check your balance, and you can print your statement. This runs from a REPL, such as IRB or Pry.

See the [User Stories](UserStories.md) and [Original Spec](OriginalSpec.md).

## Domain Model
![Screenshot](/assets/Tech Test - Bank - Domain Model.png)

## Project Approach
I started off by reading the specification, followed by diagramming the envisaged classes and their core methods and attributes. Following this, I set up the project (Git, gems, etc.) and then took a TDD approach to writing the app. I took the approach of creating one feature at a time by writing and passing one test at a time (Red -> Green -> Refactor).

At the end of the first day, I got to a stage where I had a functioning program and all tests were passing, but the structure was not quite right still. There were only two classes and there was too much reliance on directly modifying instance variables. This presented a number of issues:
1. The classes and methods were doing too much, meaning a breach in the Single Responsibility Principle.
2. Directly modifying instance variables in methods provides too much power for the user to wrongly manipulate the data (such as changing the balance without making a deposit).
3. The code structure was not future proof - it worked at the time but specification modification requests would be difficult to implement as the methods were not sufficiently encapsulated.

On day two, I began to rethink my model in light of these issues. The extent of the overhaul to the core code and the associated tests meant it would be easier to restart from scratch. I remodelled and continued with the Red -> Green -> Refactor TDD approach outlined above, whilst bearing in mind these issues. The model changed several times over the course of the next two days, until the final model displayed above.

## Logic
Account
  - Responsible for controlling all account activity
  - Opens the account with `@balance` of 0 (which users can read)
  - Provides the user with their interface methods:
    - `#deposit` adds money to the account
    - `#withdraw` deducts money from the account
    - `#print_statement` displays all transactions stored in the Statement
  - The `#request_transaction` private method means the user cannot wrongly manipulate their account
  - Includes edge case management and error handling in the `#error_handler` private method

Transaction
  - Executes the transactions which users make on their Account
  - Handles deposit and withdrawal requests via the `#modify_balance` method, which returns a balance value to Account
  - `record_transaction` calls a method to make a record of the transaction for Statement purposes

Statement
 - Executes statement operations which users call for their Account
 - `#record` populates an array with a hash of data for each transaction that takes place
 - `#generate_report` returns a multi-line string of all the transactions that have taken place

Date
 - Generates and formats the date on which the transaction takes place

## How to Use
The app runs in a REPL such as IRB or Pry. A user need only interact with the Account class:
1. Set up a new account `acc = Account.new`
2. Make deposits `acc.deposit(99.99)`
3. Make withdrawals `acc.withdraw(30)`
4. View balance `acc.balance`
5. View statement `acc.print_statement`

## Example Screenshot
![Screenshot](/assets/Tech Test - Bank - Screenshot.png)

## Installation and Testing
To install and run this app locally:

1. Clone this repo:

   `$ git clone git@github.com:julesnuggy/bank_tech_test.git`

2. Install the gems using Bundler:

   `$ bundle install`

   or manually:

   `$ gem install rspec rubocop simplecov simplecov-console`

3. Run the tests:

   `$ rspec && rubocop`

   N.B. SimpleCov is integrated with RSpec to display coverage stats.

## Personal Thoughts & Future Additional Features
Creating this application took a lot more effort than I thought. Initially I had planned to create one version in Ruby and another in JavaScript, but it took 3 days to create a product in Ruby alone that I was happy with. I submitted my self-assessment form on Day 1 and, despite recognising the significant flaws in my program, required a coach to motivate me to reflect on the product and how it could be improved. These flaws are outlined above.

I'm really glad that I revisited the app in earnest, as it now barely resembles what it was before and reflects something _nearer_ best practice (SRP, encapsulation, DRY, etc). The model and flow of data makes more sense to me and there are over 3x as many tests. This significant amount of testing has improved my understanding of and confidence with doubles/mocks/stubs, an area that I have perceived as being one of my weakest areas.

If I had more time (as I wish to move on to another test), I would add the following features:
* The statement is displayed in a neat layout
* The values are displayed as currency
* The error_handler messages are customised so they don't show the traceback
