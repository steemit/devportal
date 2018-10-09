---
title: 'PY: Stream Blockchain Transactions'
position: 13
description: "How to stream transactions on the live **Steem** blockchain"
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Stream Blockchain Transactions](https://github.com/steemit/devportal-tutorials-py/tree/master/tutorials/13_stream_blockchain_transactions) can be downloaded as part of the [PY tutorials repository](https://github.com/steemit/devportal-tutorials-py).</span>
<br>



In this tutorial we show you how to stream transactions on the **Steem** blockchain using the `blockchain` class found within the [steem-python](https://github.com/steemit/steem-python) library.

## Intro

Tutorial is demonstrating the typical process of streaming blocks on Steem. We will show some information from each block that is being streamed to give you an idea. Each block contains transactions objects as well but we will not show each of this data in user interface.

We are using the `blockchain.stream()` function provided by `steem-python` which returns each block after it has been accepted by witnesses. By default it follows irreversible blocks which was accepted by all witnesses.

## Steps

1.  [**App setup**](#app-setup) Configure imports and initialization of libraries
1.  [**Stream blocks**](#stream-blocks) Stream blocks
1.  [**Sample result**](#sample-result) Stream blocks

#### 1. App setup<a name="app-setup"></a>

In this tutorial we use 1 package:

steem - steem-python library and interaction with Blockchain

```python
from steem.blockain import Blockchain

blockchain = Blockchain()
```

Above we create an instance of Blockchain which will give us the ability to stream the live transactions from the blockchain.

#### 2. Stream blocks<a name="stream-blocks"></a>

Next we create an instance of `stream` and then loop through the steam as transactions are available and print them to the screen.

```python
stream = blockchain.stream()

for post in stream:
	print(post)
```

#### 3. Sample result<a name="sample-result"></a>

```json
{
  "curator": "idx",
  "reward": "4.042446 VESTS",
  "comment_author": "blackbunny",
  "comment_permlink": "6tfv5e",
  "_id": "5801d1c99ca7ecd1d4387ebd89d4edab08612b35",
  "type": "curation_reward",
  "timestamp": "2018-09-21T21:11:02.005Z",
  "block_num": 26136919,
  "trx_id": "0000000000000000000000000000000000000000"
}
```


That's it!

### To Run the tutorial

1.  [review dev requirements](getting_started)
1.  clone this repo
1.  `cd tutorials/13_stream_blockchain_transactions`
1.  `pip install -r requirements.txt`
1.  `python index.py`
1.  After a few moments, you should see a prompt for input in terminal screen.

---
