# bank_tech_test

## Introduction
This is a TDD'd implementation at Week 10 of a specification we were introduced to very early on. It allows you to make deposits to and withdrawals from a bank account, and you can print your statement.

See also the [User Stories](UserStoes.md) and [Original Spec](OriginalSpec.md).

## Diagramming
```
+-----------+               +---------+
|TRANSACTION|               |STATEMENT|
+-----------+               +---------+
|                           |
|#Initialize                |#Initialize
|  @account+--------------> |  @account
|     ^                     |    +
|     +------+              |    v
|#Desposit+--|              |#Print
|  -amount   |              |
|            |              |
|            |              |
|#Withdraw+--+              |
+  -amount                  +
```

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

## How to Use
The app runs in a REPL such as IRB or Pry. In your REPL, you can run the following commands:
* Transaction
  * #new - creates a new instance of the Transaction class with an `@account` array which starts off empty
  * #deposit(amount) - add an `amount` of money to your account
  * #withdraw(amount) - take an `amount` of money from your account

* Statement
  * #new(transaction) - creates a new instance of the Statement class, taking an instance of Transaction as an argument for dependency injection. This is used to allow access to Transaction's `@account` attribute.
  * #print - displays your account's transactions, line by line.
