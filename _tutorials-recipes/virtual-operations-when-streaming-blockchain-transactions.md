---
title: Streaming blockchain transactions
position: 1
description: Including virtual operations when streaming blockchain transactions
exclude: true
layout: full

---

*Include virtual operations when streaming blockchain transactions.*

This recipe will take you through the process of streaming blockchain transactions, both from `head_block_num` and `last_irreversible_block_num`, and explain the presence/absence of virtual operations in the streamed transactions.

## Intro

There are two points from which Steem blockchain transactions can be streamed to give a "live" view of what's happening on the blockchain. The first is from the `head block` which is the most recent block created on the chain (every 3 seconds when a new block is created). The second, is from the `last irreversible block` which is the newest block that has been confirmed by a sufficient number of block producers so that it can no longer be modified. This is not a live view but it is normally not far behind the head block number.

There is already a [javascript tutorial](https://developers.steem.io/tutorials-javascript/stream_blockchain_transactions) on the [devportal](https://developers.steem.io/) on how to stream blockchain transactions. This recipe will go into further detail on operations on each block and more specifically the virtual operations that are executed with every new block. We will also assume that you have already run through the basic tutorials on the Steem blockchain and will focus more on the specific functions and outputs pertinent to this topic.

## Steps

1.  [**Blocks, transactions and operations**](#BTO)
1.  [**Virtual operation streaming**](#V-ops)

#### 1. Blocks, transactions and operations <a name="BTO"></a>

In order to stream a block and get the information as will be shown below we use the `blockchain api` in the `dsteem` library. The below method has an option parameter `mode` that defaults to `irreversible` but can be set to `latest` which would then return the `head blocks`. This means that both types of blocks can be streamed.

```javascript
stream = client.blockchain.getBlockStream();
    stream
        .on('data', function(block) {
            console.log(block);
            ...
            ...
```

Below is an example of what a block looks like:

```json
block_id:"017fa2a9b142cd8d3607b7e7421412402bf97957"
extensions:[]
previous:"017fa2a867978140e7553bbfd65396a5a8136d53"
signing_key:"STM5gBt5xvdb5vhmXjBqfzQ7vwr4hFF5rjmYmZnSbzdb9eWmk9or5"
timestamp:"2018-08-17T08:31:48"
transaction_ids: []
transaction_merkle_root:"4f0d61928ce9595aec6558fb53f1af1b8de06d78"
transactions: []
witness:"smooth.witness"
witness_signature:"204e00e747ce75b24fc26b5d18f12992197c61de0bf27c830416761bd25648238239c5eb26a5e392d474e27c601842e2ccf105ffb47f5a5712727412a18f106dbb"
```

Each block contains transactions:

```json
block_num:25141929
expiration:"2018-08-17T08:41:42"
extensions:[]
operations:[Array(2)]
ref_block_num:41616
ref_block_prefix:3838737669
signatures:["1f261ccf59131dcd10334a40b8b76bd2e80b05eee1c8deaedb…ebb7e4a4d6e22f7823940248f1488978d4ec8ecbd8abbd88e"]
transaction_id:"a972aef3388908f8a4b4a8d889fb89c83d2b8eb3"
transaction_num:0
```

And each transaction contains operations:

```json
0:
  "vote"
1:
  author:"skmedia"
  permlink:"buynearn-new-mlm-plan-launched-4th-june-2018-new-mlm-plan-2018-10inr-4-buynearn-online"
  voter:"nazann"
  weight:4700
```

#### 2. Virtual operation streaming <a name="V-ops"></a>

Virtual operations (curation rewards, etc) are derived from blockchain activity, but aren't actually stored as operations themselves. They happen based on consensus from the blockchain based on other user initiated operations. This information is not available on the head block so a 100% live feed of these virtual operaions would not be possible. In order to follow these operaions you would have to stream the `last_irreversible_block`. To get a feed of virtual operations, each of the block transactions needs to be investigated for the `type` of the operations.

`steem-python` provides a very simple method to stream virtual or any other operations directly:

```python
from steem import Steem
from steem.blockchain import Blockchain
import pprint
s = Steem()
b = Blockchain(s)

for op in b.stream('author_reward'):
    pprint.pprint(op)
    # break
```

With result:

```json
{'_id': '11cb40b9283c8a89ed5d8c348cbc68d76a9d8bd3',
 'author': 'hopehash',
 'block_num': 25145619,
 'permlink': 'hopehash-btc-1-057',
 'sbd_payout': '0.000 SBD',
 'steem_payout': '2.341 STEEM',
 'timestamp': datetime.datetime(2018, 8, 17, 11, 36, 18),
 'trx_id': '0000000000000000000000000000000000000000',
 'type': 'author_reward',
 'vesting_payout': '4740.455508 VESTS'}
```

From the above example all operations of type "author_reward" will be printed on the console/terminal. You can change the type to which ever operation you want to stream or remove the parameter and stream all operations. The same logic can be followed when using `steem-js` by isolating the operations of each transaction and looking for the required operation type. Below example is again a modification of the tutorial initially referenced.

```javascript
stream = client.blockchain.getBlockStream();
    stream
        .on('data', function(block) {
            let x = 0
            while (x < block.transactions.length) {
                if (block.transactions[x].operations[0][0] = 'author_reward') {
                    console.log(block.transactions[x].operations[0]);
                }
                x += 1
            }
        });
```

That's all there is to it.