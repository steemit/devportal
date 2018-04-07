---
title: Client Signing
position: 4
description: How client side transaction signing works under the hood.
layout: full
right_code: |
    <p class="static-right-section-title">Connect</p>
    
    ```javascript
    opts.addressPrefix = 'TST'
    opts.chainId = '46d82ab7d8db682eb1959aed0ada039a6d49afa1602491f93dde9cac3e8e6c32'
    //connect to server which is connected to the network/testnet
    const client = new dsteem.Client('https://testnet.steemitdev.com', opts)

    ```
    <p class="static-right-section-title">Account-selection</p>
    
    ```javascript
    privateKey = dsteem.PrivateKey.fromString(document.getElementById("account").value)
    ```
    <p class="static-right-section-title">Generate-transaction</p>
    
    Vote operation example

    ```javascript
    op = {
        ref_block_num: head_block_number,
        ref_block_prefix: Buffer.from(head_block_id, 'hex').readUInt32LE(4),
        expiration: new Date(Date.now() + expireTime).toISOString().slice(0, -5),
        operations: [['vote', {
            voter: account,
            author: 'test',
            permlink: 'test',
            weight: 10000
        }]],
        extensions: [],
    }
    ```

    
    <p class="static-right-section-title">Sign-transaction</p>
    
    ```javascript
    stx = client.broadcast.sign(op, privateKey)
    ```

    <p class="static-right-section-title">Verify-signature</p>
    
    ```javascript
    const rv = await client.database.verifyAuthority(stx)
    ```

    <p class="static-right-section-title">Broadcast-transaction</p>

    ```javascript
    const res = await client.broadcast.send(stx)
    ```
---
The application in this tutorial gives you overview of how client side transaction signing works under the hood.

Purpose is to guide you through the steps required so that you could adapt this in your own applications.

We have predefined accounts to select for you to quickly use and few transaction types to test the process.

### Overview

Client side signing of transaction is yet another way of interacting with Steem blockchain. Compare to [Steemconnect](https://github.com/steemit/devportal-tutorials-js/tree/master/tutorials/02_steemconnect) method, client signing doesn't rely on other servers to generate and verify transaction, except when transaction is broadcasted to the network, it should be routed through one of the servers connected to that network or blockchain. It can be your own local machine running Steem blockchain or it could be any other publicly accessible servers.

### Connect

Testnet and Production networks only differ with few settings which helps developers to switch their application from testnet to production. One of these settings is `addressPrefix` - string that is defined and will be in front of every public address on that chain/network. Another one is `chainId` - id of that network. By defining those parameters we are selecting Testnet and connecting to publicly available server with help of `dsteem` library. First few lines of code in `public/app.js` gives you example of connection to different networks, testnet and production.

* *Disclaimer: In this tutorial we are using testnet powered by community member (`@almost-digital`) and predefined accounts reside on this network only.*

### Network globals

To test connection as well as to get parameters of the connected network, we can use `getDynamicGlobalProperties` function from **dsteem** library. Only 2 fields are in our interesting for this tutorial, `head_block_number` - returns head or latest block number of the network, `head_block_id` - returns id of head block.

![Overview](https://steemitimages.com/DQmXzwhPB7TVKYWsxGoUg6u9mtWTizty5ij8CyKxjuTUHS6/2018-03-29_16-40-02.png)

### Account-selection

We have predefined list of accounts to help you with generate, sign, verify and broadcast transaction on testnet. Select list has posting private key for each account and `onchange` selection event we keep account name and credentials in memory. `accountChange` function shows example of turning plain posting private key into private key buffer format that is understandable by **dsteem**. 

Account and its credentials should belong to specified testnet/mainnet network to sign/verify/broadcast transactions properly.

### Operation selection

Number of operations are also predefined to show you example of operation format. `opChange` also keeps selected operation name in memory.

### Generate-transaction

Next we have button which helps us to generate operation object. Depending on selected operation type we have different structure for operation object. Typically, each transaction object has following fields: 
* `ref_block_num` - references block number in past, in this example we have chosen head block number, but it is possible to use a block number from up to 65,536 blocks ago.  This is required in TaPoS (Transaction as Proof of Stake) to avoid network forks.
* `ref_block_prefix` - reference buffer of block id of `ref_block_num` as prefix
* `expiration` - transaction expiration date in future, in our example we have set it +1 minute into future
* `operations` - array of operations, this field holds main information about transaction type and its structure which is recognized by the network
* `extensions` - any extensions to the transaction to change its parameters or options

First item, operation type, `vote` and second item object with `voter` - account that is casting vote, `author` - author of post vote is being casted to, `permlink` - permanent link of the post, `weight` - vote weight 10000 being 100%, 1 being 0.01% smallest voting unit.

And output of operation object/json is set to `OpInput` element.

### Sign-transaction

Each operation needs to be signed before they can be sent to the network, transactions without signature will not be accepted by network. Because someone has to identify operation and sign it with their private keys. Sign transaction button calls for `signTx` function which is job is to sign selected operation and its obkect with selected account. And output result into `TxOutput` element.

### Verify-signature

This process is mostly done automatically but to show every step, we have included this process to check validity of the transaction signature. Verify transaction button calls `verifyTx` function. Function then verify authority of the signature in signed transaction, if it was signed with correct private key and authority. If verification is successful user interfaces adds checkmark next to button otherwise adds crossmark to indicate state of the signature.

### Broadcast-transaction

Final step is to broadcast our signed transction to the selected server. Server chosen in Connect section will handle propagating transction to the network. After network accepts transaction it will return result with transaction `id`, `block_num` that this transaction is included to, `trx_num` transaction number, and if it is `expired` or not. 

That's it!

### To run

* clone this repo
* `cd tutorials/03_client_signing`
* `npm i`
* `npm run start`
