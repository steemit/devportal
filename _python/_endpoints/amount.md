---
title: Amount
position: 3
---

For the sake of easier handling of Assets on the blockchain

``` sourceCode
from steem.amount import Amount
a = Amount("1 SBD")
b = Amount("20 SBD")
a + b
a * 2
a += b
a /= 2.0
```