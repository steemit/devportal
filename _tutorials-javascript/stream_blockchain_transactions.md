---
title: Stream Blockchain Transactions
position: 13
description: By the end of this tutorial you should know how to stream transactions and blocks from Steem blockchain
layout: full
---


This tutorial will take you through the process of preparing and streaming blocks using the `blockchain.getBlockStream()` operation. Being able to stream blocks is crucial if you are building automated or follow up scripts or detect certain type of transactions on network or simply use it for your backend application to sync and/or work with data in real-time.

## Intro

Tutorial is demonstrating the typical process of streaming blocks on Steem. We will show some information from each block that is being streamed to give you an idea. Each block contains transactions objects as well but we will not show each of this data in user interface.

We are using the `blockchain.getBlockStream` function provided by `dsteem` which returns each block after it has been accepted by witnesses. By default it follows irreversible blocks which was accepted by all witnesses. Function follows or gets blocks every 3 seconds so it would not miss any new blocks. We will then extract part of this data and show it in list.

## Steps

1.  [**App setup**](#app-setup) Configure proper settings for dsteem
1.  [**Stream blocks**](#stream-blocks) Stream blocks
1.  [**Display result**](#display-result) Show results in proper UI

#### 1. App setup<a name="app-setup"></a>

As usual, we have a file called `public/app.js`, which holds the Javascript segment of the tutorial. In the first few lines, we have defined the configured library and packages:

```javascript
const dsteem = require('dsteem');

let opts = {};

//connect to production server
opts.addressPrefix = 'STM';
opts.chainId =
    '0000000000000000000000000000000000000000000000000000000000000000';

//connect to server which is connected to the network/production
const client = new dsteem.Client('https://api.steemit.com');
```

Above, we have `dsteem` pointing to the live network with the proper chainId, addressPrefix, and endpoint. Because this tutorial requires active transactions to see some data.

#### 2. Stream blocks<a name="stream-blocks"></a>

Next, we have a `main` function which fires at on-load and starts streaming blocks from network.

```javascript
stream = client.blockchain.getBlockStream();
stream
    .on('data', function(block) {
        //console.log(block);
        blocks.unshift(
            `<div class="list-group-item"><h5 class="list-group-item-heading">Block id: ${
                block.block_id
            }</h5><p>Transactions in this block: ${
                block.transactions.length
            } <br>Witness: ${
                block.witness
            }</p><p class="list-group-item-text text-right text-nowrap">Timestamp: ${
                block.timestamp
            }</p></div>`
        );
        document.getElementById('blockList').innerHTML = blocks.join('');
    })
    .on('end', function() {
        // done
        console.log('END');
    });
```

We have also defined `Pause` and `Resume` functions for relevant buttons to pause/resume stream at any moment.

```javascript
//pause stream
window.pauseStream = async () => {
    state = stream.pause();
};

//resume stream
window.resumeStream = async () => {
    state = state.resume();
};
```

#### 3. Display result<a name="display-result"></a>

In above scection, following line of code populates object with the data coming from Stream:

```javascript
blocks.unshift(
    `<div class="list-group-item"><h5 class="list-group-item-heading">Block id: ${
        block.block_id
    }</h5><p>Transactions in this block: ${
        block.transactions.length
    } <br>Witness: ${
        block.witness
    }</p><p class="list-group-item-text text-right text-nowrap">Timestamp: ${
        block.timestamp
    }</p></div>`
);
```

Example of output:

```json
{
    block_id: "015d34f12bced299cec068500fdbf3070016160c",
    extensions:[],
    previous:"015d34f021e85b437c9fcb8cf47d9e258a1ad7e4",
    signing_key:"STM5zNNjMyCKbhcPgo5ca7jq9UBGVzpq6yoaHw1R2dKaZdxhcuwuW",
    timestamp:"2018-05-30T14:27:36",
    transaction_ids:
        ["0e7ce7445884c44346da4dafdef99ea7fda60bd0", "194f404d3dab66459421792045625334f7465da1"],
    transaction_merkle_root:"bc39f1fb9edbb02200d1ab0e68d3dbc4afc62aca",
    transactions:[{…}, {…}],
    witness:"good-karma",
    witness_signature:"2005f2d5f9d4000ca2ba76db5e555982e3ca47d6f6516ea1bacb316545b478d6617987afd71b5bf0b3f231fdc140453f9043b8ea981220cecf44118d50eedbe870"
}
```

That's it!

### To Run the tutorial

1.  clone this repo
1.  `cd tutorials/13_stream_blockchain_transactions`
1.  `npm i`
1.  `npm run dev-server` or `npm run start`
1.  After a few moments, the server should be running at [http://localhost:3000/](http://localhost:3000/)
