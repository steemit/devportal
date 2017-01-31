---
title: Account
position: 2
---

Obtaining data of an account.

``` sourceCode
from steem.account import Account
account = Account("xeroc")
print(account)
print(account.reputation())
print(account.balances)
```
