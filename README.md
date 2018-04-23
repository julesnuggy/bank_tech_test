# bank_tech_test

## Diagramming

 +-----------+               +---------+
 |Transaction|               |Statement|
 +-----------+               +---------+
 |                           |
 |#initialize                |#initialize
 |  -Array+-------------+    |  -Line
 |     ^                |    |    +
 |     +------+         |    |    v
 |#desposit+-->         +--> |#print
 |  -Amount   |              |
 |            |              |
 |            |              |
 |#withdraw+--+              |
 |  -Amount                  |

## User Stories
As a user,
So that I can add money to my bank account,
I want to be able to `#deposit` money.

As a user,
So that I can take money fro my bank account
I want to be able to `#withdraw` money.

As a user,
So that I can check bank account,
I want to be able to `#print` a `Statement` of my `Transaction`s.

As a user,
So that I can see when `Transaction`s happened,
I want to be able to see the `@date` on my `Statement`.

As a user,
So that I can see what my TRANSACTIONS were,
I want to be able to see the amount `@credit`ed / `@debit`ed.

As a user,
So that I know how much money I have available,
I want to be able to see my `@balance`.

----------------------

## Original Specification

### Requirements

* You should be able to interact with your code via a REPL like IRB or the JavaScript console.  (You don't need to implement a command line interface that takes input from STDIN.)
* Deposits, withdrawal.
* Account statement (date, amount, balance) printing.
* Data can be kept in memory (it doesn't need to be stored to a database or anything).

### Acceptance criteria

**Given** a client makes a deposit of 1000 on 10-01-2012  
**And** a deposit of 2000 on 13-01-2012  
**And** a withdrawal of 500 on 14-01-2012  
**When** she prints her bank statement  
**Then** she would see

```
date || credit || debit || balance
14/01/2012 || || 500.00 || 2500.00
13/01/2012 || 2000.00 || || 3000.00
10/01/2012 || 1000.00 || || 1000.00
