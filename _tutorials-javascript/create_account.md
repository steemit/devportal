---
title: 'JS: Create Account'
position: 26
description: "_Create Steem account using Steemconnect as well as with client-side signing._"
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Create Account](https://github.com/steemit/devportal-tutorials-js/tree/master/tutorials/26_create_account) can be downloaded as part of the [JS tutorials repository](https://github.com/steemit/devportal-tutorials-js).</span>
<br>



This tutorial will show how to search for a valid account name and then create a new account by means of Resource Credits or STEEM. This tutorial runs on the main Steem blockchain so extra care needs to be taken as any operation will affect real accounts.

## Intro

This tutorial will show few functions such as querying account by name and check if username is taken or available to register. We are using the `call` function provided by the `dsteem` library to pull account from the Steem blockchain. We then create proper private keys for new account. A simple HTML interface is used to enter payment of account creation fee and create account right inside tutorial. We use the `account_create` function to commit the transaction to the blockchain. This function is used to create what is called a "non-discounted account". This means that the creator account needs to supply the exact `account_creation_fee` in STEEM in order for the transaction to process successfully. Currently this value is set to 3 STEEM. There is a second method of creating accounts using tokens. These are called "discounted accounts". In stead of STEEM, the `account_creation_fee` is paid in RC (resource credits). There are however a limited amount of discounted accounts that can be claimed which is decided upon by the witnesses. This account creation process is done in two steps, first claiming an account and then creating the account.

## Steps

1.  [**App setup**](#app-setup) Setup `dsteem` to use the proper connection and network.
2.  [**Search account**](#search-account) Get account details after input has account name
3.  [**Generate private keys**](#generate-keys) Generate proper keys for new account
4.  [**Create account**](#create-account) Create account via Client-side or Steemconnect

#### 1. App setup <a name="app-setup"></a>

Below we have `dsteem` pointing to the production network with the proper chainId, addressPrefix, and endpoint. There is a `public/app.js` file which holds the Javascript segment of this tutorial. In the first few lines we define the configured library and packages:

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

#### 2. Search account <a name="search-account"></a>

After account name field is filled with some name, tutorial has Search button to search for account by name. HTML input forms can be found in the `index.html` file. The values are pulled from that screen with the below:

```javascript
const accSearch = document.getElementById('username').value;
let avail = 'Account is NOT available to register';
if (accSearch.length > 2) {
    const _account = await client.database.call('get_accounts', [
        [accSearch],
    ]);
    console.log(`_account:`, _account, accSearch.length);

    if (_account.length == 0) {
        avail = 'Account is available to register';
    }
}
document.getElementById('accInfo').innerHTML = avail;
```

We will then do simple check if account is taken or not.

#### 3. Generate private keys <a name="generate-keys"></a>

After we know that account is available to register, we will fill form with password we wish for that account and enter creation fee. Note, that creation fees are "burned" once the new account is created. The creator account wishes to provide the new account with VEST (as per previous account creation process) they can do so by following the `delegate_vesting_shares` process (refer tutorial [#27](https://developers.steem.io/tutorials-javascript/delegate_power)). Irrespective of which account creation method is being followed, the process for generating new accounts keys is the same for both.

```javascript
const username = document.getElementById('username').value;
const password = document.getElementById('password').value;

const ownerKey = dsteem.PrivateKey.fromLogin(username, password, 'owner');
const activeKey = dsteem.PrivateKey.fromLogin(username, password, 'active');
const postingKey = dsteem.PrivateKey.fromLogin(username, password, 'posting');
const memoKey = dsteem.PrivateKey.fromLogin(
    username,
    password,
    'memo'
).createPublic(opts.addressPrefix);

const ownerAuth = {
    weight_threshold: 1,
    account_auths: [],
    key_auths: [[ownerKey.createPublic(opts.addressPrefix), 1]],
};
const activeAuth = {
    weight_threshold: 1,
    account_auths: [],
    key_auths: [[activeKey.createPublic(opts.addressPrefix), 1]],
};
const postingAuth = {
    weight_threshold: 1,
    account_auths: [],
    key_auths: [[postingKey.createPublic(opts.addressPrefix), 1]],
};
```

Above script shows, how to properly setup private keys of new account.

#### 4. Create account <a name="create-account"></a>

After following all steps properly, we can now submit transaction to create new account.

```javascript
//non-discounted account creation
const privateKey = dsteem.PrivateKey.fromString(
    document.getElementById('wif').value
);
const op = [
    'account_create',
    {
        fee: document.getElementById('steem').value,
        creator: document.getElementById('account').value,
        new_account_name: username,
        owner: ownerAuth,
        active: activeAuth,
        posting: postingAuth,
        memo_key: memoKey,
        json_metadata: '',
    },
];

client.broadcast.sendOperations([op], privateKey).then(
    function(result) {
        document.getElementById('result').style.display = 'block';
        document.getElementById(
            'result'
        ).innerHTML = `<br/><p>Included in block: ${
            result.block_num
        }</p><br/><br/>`;
    },
    function(error) {
        console.error(error);
    }
);
```

Discounted account creation uses the same eventual `account_create` parameters but does not include the optional `fee` parameter. We also check to see if the creator account has an `account_creation_token` available already and then skips the first section of claiming this token.

```javascript
//discounted account creation
//private active key of creator account
const privateKey = dsteem.PrivateKey.fromString(document.getElementById('wif').value);

let ops = [];

//claim discounted account operation
const creator = document.getElementById('account').value
const _account = await client.database.call('get_accounts', [
    [creator],
]);
console.log('current pending claimed accounts: ' + _account[0].pending_claimed_accounts)
if (_account[0].pending_claimed_accounts == 0) {
    const claim_op = [
        'claim_account',
        {
            creator: creator,
            fee: '0.000 STEEM',
            extensions: [],
        }
    ];
    console.log('You have claimed a token')
    ops.push(claim_op)
}

//create operation to transmit
const create_op = [
    'create_claimed_account',
    {
        creator: document.getElementById('account').value,
        new_account_name: username,
        owner: ownerAuth,
        active: activeAuth,
        posting: postingAuth,
        memo_key: memoKey,
        json_metadata: '',
        extensions: []
    },
];
ops.push(create_op)

//broadcast operation to blockchain
client.broadcast.sendOperations(ops, privateKey).then(
    function(result) {
        document.getElementById('result').style.display = 'block';
        document.getElementById(
            'result'
        ).innerHTML = `<br/><p>Included in block: ${
            result.block_num
        }</p><br/><br/>`;
    },
    function(error) {
        console.error(error);
    }
);
```

That's it!

### To run this tutorial

1.  clone this repo
1.  `cd tutorials/26_create_account`
1.  `npm i`
1.  `npm run dev-server` or `npm run start`
1.  After a few moments, the server should be running at [http://localhost:3000/](http://localhost:3000/)


---
