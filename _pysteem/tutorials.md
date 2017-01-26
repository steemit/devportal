---
title: Tutorials
position: 8
---

#### Auto Reply Bot
------


The most easy auto-reply bot can be coded with just a few lines of code:

``` sourceCode
from steem import Steem
import os
import json
steem = Steem(wif="<posting-key-for-default-author>")
for c in steem.stream_comments():
    if "Boobie" in c["body"]:
        print(c.reply(".. doobidoo"))
```

#### Block Stream
------

This module allows to stream blocks and individual operations from the blockchain and run bots with a minimum of code. This example code shows all comments starting at block 1893850.

``` sourceCode
from steem.blockchain import Blockchain
from pprint import pprint

for a in blockchain.blocks()
    pprint(a)
```

#### Operation Stream
------

``` sourceCode
from steem.blockchain import Blockchain
from pprint import pprint

for a in blockchain.ops()
    pprint(a)
```

#### Decentralized Exchange
------

``` sourceCode
from pprint import pprint
from steem import Steem
from steem.dex import Dex

steem = Steem()
dex = Dex(steem)
pprint(dex.buy(10, "SBD", 100))
pprint(dex.sell(10, "SBD", 100))
pprint(dex.cancel("24432422"))
pprint(dex.returnTicker())
pprint(dex.return24Volume())
pprint(dex.returnOrderBook(2))
pprint(dex.ws.get_order_book(10, api="market_history"))
pprint(dex.returnTradeHistory())
pprint(dex.returnMarketHistoryBuckets())
pprint(dex.returnMarketHistory(300))
pprint(dex.get_lowest_ask())
pprint(dex.get_higest_bid())
pprint(dex.transfer(10, "SBD", "fabian", "foobar"))
```