---
title: 'JS: Set Withdraw Route'
position: 28
description: "_Set routes to an account's power downs or withdraws._"
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Set Withdraw Route](https://github.com/steemit/devportal-tutorials-js/tree/master/tutorials/28_set_withdraw_route) can be downloaded as part of the [JS tutorials repository](https://github.com/steemit/devportal-tutorials-js).</span>
<br>



We will learn how to allocate a percentage for withdrawal to other accounts using Steemconnect as well as with the client-side signing method. This tutorial runs on the main Steem blockchain. Therefore, any accounts used here will affect real funds on the live network. **Use with caution.**

## Intro

This tutorial will demonstrate a few functions such as querying account by name and determining the vesting balance of the related account. This will allow us to set "withdraw routes" to other accounts with a percent selection and auto power up function. This feature is quite useful if you want to withdraw a portion of your STEEM to a separate account or POWER UP other accounts as you withdraw from one account.

## Steps

1.  [**App setup**](#app-setup) Setup `dsteem` to use the proper connection and network.
2.  [**Get account routes**](#search-account) Get account's current routes
3.  [**Fill form**](#fill-form) Fill form with appropriate data
4.  [**Set withdraw route**](#withdraw-route) Set route with Steemconnect or client-side signing

#### 1. App setup <a name="app-setup"></a>

Below, we have `dsteem` pointing to the production network with the proper chainId, addressPrefix, and endpoint. There is a `public/app.js` file which holds the Javascript segment of this tutorial. In the first few lines we define the configured library and packages:

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

#### 2. Get account routes <a name="search-account"></a>

After the account name field is provided, using the `Get withdraw routes` button, we can fetch the current withdraw routes, if they exist. The related HTML input forms can be found in the `index.html` file. The values are pulled from that screen with the following:

```javascript
    const accSearch = document.getElementById('username').value;

    const _account = await client.database.call('get_withdraw_routes', [accSearch]);
    console.log(`_account:`, _account);
```

#### 3. Fill form <a name="fill-form"></a>

After we have fetched the account data, we will show a list of current routes, if they exist, and display information to the user about how many much they can apply to other accounts.

```javascript
let info = '';
let sum = 0;
if (_account.length > 0) {
    for (var i = 0; i < _account.length; i++) {
        info += `${_account[i].to_account} - ${_account[i].percent / 100}%<br>`;
        sum += _account[i].percent / 100;
    }
} else {
    info += `No route is available!<br>`;
}
info += `You can set ${100 - sum}% remaining part to other accounts!`;
document.getElementById('accInfo').innerHTML = info;
```

Previous routes can be overwritten by changing and submitting a new transaction to the same account.

We also generate a Steemconnect signing link.

```javascript
window.openSC = async () => {
    const link = `https://steemconnect.com/sign/set-withdraw-vesting-route?from_account=${
        document.getElementById('username').value
    }&percent=${document.getElementById('steem').value * 100}&to_account=${
        document.getElementById('account').value
    }&auto_vest=${document.getElementById('percent').checked}`;
    window.open(link);
};
```

#### 4. Set withdraw route <a name="withdraw-route"></a>

We have two options on how to Power down: Steemconnect and client-side signing. Since this action requires Active authority, both client-side and Stemconnect signing will require the Active Private key to sign the transaction. The transaction submission function appears as follows:

```javascript
window.submitTx = async () => {
    const privateKey = dsteem.PrivateKey.fromString(
        document.getElementById('wif').value
    );
    const op = [
        'set_withdraw_vesting_route',
        {
            from_account: document.getElementById('username').value,
            to_account: document.getElementById('account').value,
            percent: document.getElementById('steem').value * 100,
            auto_vest: document.getElementById('percent').checked,
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
};
```

That's it!

### To run this tutorial

1.  clone this repo
1.  `cd tutorials/26_set_withdraw_route`
1.  `npm i`
1.  `npm run dev-server` or `npm run start`
1.  After a few moments, the server should be running at [http://localhost:3000/](http://localhost:3000/)


---
