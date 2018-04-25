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
This is a TDD'd implementation at Week 10 of a specification we were introduced to very early on. It allows you to make deposits to and withdrawals from a bank account, and you can print your statement.

See also the [User Stories](UserStories.md) and [Original Spec](OriginalSpec.md).

## Domain Model
[Full Version](DomainModel.md)

Simplified Version:
```
+-----------------------------------------------------------------------------------------------------------------------+
|                                          |                                 |                                          |
|         +------------------+             |    +-----------------------+    |           +-------------------+          |
|         |                  |             |    |                       |    |           |                   |          |
|         |      ACCOUNT     |             |    |      TRANSACTION      |    |           |     STATEMENT     |          |
|         | Controls account |             |    | Executes transactions |    |           | Generates account |          |
|         | activity         |             |    | that modify balance   |    |           | statement         |          |
|         |                  |             |    |                       |    |           |                   |          |
|         +------------------+             |    +-----------------------+    |           +-------------------+          |
|                                          |                                 |                                          |
|  * Open an account                       | * Executes transactions         | * Executes print                         |
|                                          |   #modify_balance(type, amount) |   #generate_statement                    |
|    #initialize                           |     ...                         |     return @report = account.each { |tr| |
|      @account = []                       |     return @balance+/-amount    |                        ...               |
|      @balance = 0                        |                                 |                        TURN INTO         |
|                                          |                                 |                        MULTILINE STRING  |
|                                          |                                 |                        ...               |
|                                          |                                 |                      }                   |
|  *Request transactions                   |                                 |                                          |
|                                          +----------------------------------------------------------------------------+
|    #deposit(:credit, amount)             |                                                                            |
|    #withdraw(:debit, amount)             |                                                                            |
|      @transaction.modify_balance         |                                                                            |
|      record(...)                         |                                                                            |
|                                          |                                                                            |
|                                          |                            +-----------+                                   |
|                                          |                            |           |                                   |
|  * Record activity                       |                            |    DATE   |                                   |
|                                          |                            | Generates |                                   |
|    #record(date, credit, debit, balance) |                            | date      |                                   |
|      record = {date:_,                   |                            |           |                                   |
|                credit:_,                 |                            +-----------+                                   |
|                debit:_,                  |                                                                            |
|                balance:_}                |                     * Generates date                                       |
|                                          |                       @date = Time.now.strftime()                          |
|                                          |                                                                            |
|      @account.unshift(record)            |                                                                            |
|                                          |                                                                            |
|  * Print statement                       |                                                                            |
|                                          |                                                                            |
|    #print_statement(account)             |                                                                            |
|      p @statement.generate_statement     +                                                                            |
|                                                                                                                       |
+-----------------------------------------------------------------------------------------------------------------------+

```

## Project Approach
I started off by reading the specification, followed by diagramming the envisaged classes and their core methods and attributes. Following this, I set up the project (Git, gems, etc.) and then took a TDD approach to writing the app. I took the approach of writing and passing one test at a time.

At the end of the first day, I got to a stage where I had a functioning program and all tests were passing, but the structure was not quite right still. There were only two classes (Transaction and Statement) and Transaction had too many responsibilities:
1. Create the account (managing the balance and storing the history)
2. Execute transactions (deposit and withdraw) <-- the only responsibility it should have
3. Formatting the date
4. Formatting the statement

So on day two, I created a new class, Account, to handle account creation (by managing the balance) and history storage. This required ...

Another realisation is that because of the way the objects have been encapsulated, where one class needs to influence the attributes of other classes, the code will need to return values instead of directly altering the attribute values.

Shouldn't be allowed to modify the attributes directly across classes because otherwise people could make fake transactions to wrongly influence their account.

If I had better planned and domain modelled more thoroughly, I could have saved a lot of time.

## Logic
Account
  - Opens the account with `@balance` of 0
  - Stores the transaction `@history` array
  - Instantiates the Transaction and Statement classes

Transaction
  - Handles `#deposit`s, which have an associated `@credit` attribute
  - Handles `#withdraw`als, which have an associated `@debit` attribute
  - Knows the `@date` on which these methods take place

Statement
 - `#print`s the transaction `@history` in the required format

 Formatter
 - Formats the `@statement` with `#format_statement`
 - Formats the `@date` with `#format_date`

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
