---
title: Blockchain
position: 5
---

Read blockchain related data-

``` sourceCode
from steem.blockchain import Blockchain
chain = Blockchain()
```

Read current block and blockchain info

``` sourceCode
print(chain.get_current_block())
print(chain.info())
```

Monitor for new blocks ..

``` sourceCode
for block in chain.blocks():
    print(block)
```

… or each operation individually:

``` sourceCode
for operations in chain.ops():
    print(operations)
```
