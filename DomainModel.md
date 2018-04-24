```
+------------------+                       +-----------------------+                       +-------------------+                             +-----------+
|                  |                       |                       |                       |                   |                             |           |
|      ACCOUNT     |                       |      TRANSACTION      |                       |     STATEMENT     |                             |    DATE   |
| Controls account |                       | Executes transactions |                       | Generates account |                             | Generates |
| activity         |                       | that modify balance   |                       | statement         |                             | date      |
|                  |                       |                       |                       |                   |                             |           |
+------------------+                       +-----------------------+                       +-------------------+                             +-----------+

* Open an account                           +->* Executes transactions               +->* Executes print                                     * Generates date
                                     |    #modify_balance(type, amount)       |    #generate_statement                                  @date = Time.now.strftime()
#initialize                               |      ...                               |      return @report = account.each { |tr|                 +
@account = []                           |      return @balance+/-amount          |             +           ...                               |
@balance = 0                            |             +                          |             |           TURN INTO                         |
                                     |             |                          |             |           MULTILINE STRING                  |
                                     |             |                          |             |           ...                               |
                                     |             |                          |             |         }                                   |
* Request transactions                      |             |                          |             |                                             |
                                     |             |                          |             |                                             |
+-------------+#deposit(:credit, amount)+----------------+             |                          |             |                                             |
|-------------|#withdraw(:debit, amount)+----------------|             |                          |             |                                             |
+---------------+@transaction.modify_balance<--------------------------+                          |             |                                             |
|                                                                                                 |             |                                             |
|                record(...)                                                                      |             |                                             |
|                                                                                                 |             |                                             |
|                                                                                                 |             |                                             |
|            * Record activity                                                                    |             |                                             |
|                                                                                                 |             |                                             |
+------------->#record(date, credit, debit, balance)                                              |             |                                             |
|                record = {date:_,                                                                |             |                                             |
|                          credit:_,                                                              |             |                                             |
|                          debit:_,                                                               |             |                                             |
|                          balance:_}                                                             |             |                                             |
|                                                                                                 |             |                                             |
|                                                                                                 |             |                                             |
|                @account.unshift(record)                                                         |             |                                             |
|                                                                                                 |             |                                             |
|            * Print statement                                                                    |             |                                             |
|                                                                                                 |             |                                             |
|              #print_statement(account+----------------------------------------------------------+             |                                             |
|                p @statement.generate_statement                                                                |                                             |
|                              ^                                                                                |                                             |
|                              |                                                                                |                                             |
|                              |                                                                                |                                             |
|                              +--------------------------------------------------------------------------------+                                             |
|                                                                                                                                                             |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------+

```
