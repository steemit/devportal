---
title: Account creation process
position: 1
description: The methods on how to create a new account.
exclude: true
layout: full
---

The purpose of this is to explain the different methods of creating new accounts with selected examples of the relevant code. There will also be a full tutorial on account creation in the [tutorial section](https://developers.steem.io/tutorials/#tutorials-javascript) of the devportal.

Please note that this document only has code snippets and not a complete and executable app for account creation.

## Intro

With the introduction of the Resource Credit system there are now three ways in which to create an account. The methods are listed below with a detailed explanation of each in the following section.

1.  [**Steemconnect**`](#steemconnect)
1.  [**Non-discounted**](#nondisc)
1.  [**Discounted**](#disc)

#### 1. Steemconnect<a name="steemconnect"></a>

Steemconnect offers a "simple link" solution to creating new accounts. Instead of running through a list of operations on your app, you can simply use the link below and follow the steps. You will be required to enter the new username (a random generated password will be supplied) as well as the account name and private active key of the "sponsor" account that needs to supply the 3 STEEM to create the account.

[https://steemconnect.com/accounts/create](https://steemconnect.com/accounts/create)

#### 2. Non-discounted account creations<a name="nondisc"></a>

Non-discounted account creation is where the creation fee is paid with STEEM. We use the `account_create` function to commit this transaction to the blockchain. Currently this `account_creation_fee` is set to 3 STEEM. This is not the preferred way to create new accounts but it's a very simple solution. When creating a new account, the new username and password needs to be supplied. This is used to create the public and private keys for this account. An example of the code to create keys can be seen below:

```javascript
const username = //new username
const password = //new password

//create private keys
const ownerKey = dsteem.PrivateKey.fromLogin(username, password, 'owner');
const activeKey = dsteem.PrivateKey.fromLogin(username, password, 'active');
const postingKey = dsteem.PrivateKey.fromLogin(username, password, 'posting');
const memoKey = dsteem.PrivateKey.fromLogin(username, password, 'memo').createPublic();

//create public keys
const ownerAuth = {
    weight_threshold: 1,
    account_auths: [],
    key_auths: [[ownerKey.createPublic(), 1]],
};
const activeAuth = {
    weight_threshold: 1,
    account_auths: [],
    key_auths: [[activeKey.createPublic(), 1]],
};
const postingAuth = {
    weight_threshold: 1,
    account_auths: [],
    key_auths: [[postingKey.createPublic(), 1]],
};
```

The actual `account_create` function can be seen below. The created keys are required to complete this transaction as well as the "sponsor" account and the creation fee (3 STEEM). In order for this function to execute correctly the Steem instance needs to be initiated with the creator account's private Active key as no transfer transaction for any account can happen without Active authority being provided.

```javascript
const op = [
    'account_create',
    {
        fee: , //3.00 STEEM
        creator: , //account supplying the fee
        new_account_name: username, //new account
        owner: ownerAuth, //new owner key
        active: activeAuth, //new active key
        posting: postingAuth, //new posting key
        memo_key: memoKey, //new memo key
        json_metadata: ''
    },
];
```

#### 3. Discounted account creations<a name="disc"></a>

The discounted account creation process uses an `Account creation token` that is purchased with Resource Credits (RC) to create the account instead of paying the creation fee in STEEM. These tokens are fairly expensive in RC terms so a new account for example won't be able to create more accounts. This ensures that the account creator is incentivized to only create accounts for people that will add value to the network.

Purchasing an Account Creation token only enables you to do one thing: create one account at zero cost. It should be noted that these tokens do not expire, are not transferable and there is also no upper limit to the amount of tokens one can have, so they can be stockpiled. There is however a limit on the total amount of tokens available on the blockchain for claiming at any one time. The available tokens replenishes over time and the limit is decided upon by the witnesses.

Purchasing/Claiming the token is only the first step in this process. Once you have an `Account creation token` you are able to initiate the second step, which is the actual account creation. This step is very similar to the previous method of creating accounts, except that no fee is included. These requirements include the "sponsor" account, login requirements and public and private key creations. Before the creation of the account however, you first have to claim a token:

```javascript
//claim discounted account operation
const claim_op = [
    'claim_account',
    {
        creator: //creator account,
        fee: '0.000 STEEM', //0 STEEM indicating RC to be used
        extensions: [],
    }
];
```

After which you proceed to create an account:

```javascript
//create operation to transmit
const create_op = [
    'create_claimed_account',
    {
        creator: //creator account
        new_account_name: username, //new account
        owner: ownerAuth, //new owner key
        active: activeAuth, //new active key
        posting: postingAuth, //new posting key
        memo_key: memoKey, //new memo key
        json_metadata: '',
        extensions: []
    },
];
```