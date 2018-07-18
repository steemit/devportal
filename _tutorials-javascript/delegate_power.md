---
title: 'JS: Delegate Power'
position: 25
description: In this tutorial we will learn how to delegate power to other users using Steemconnect as well as with Clientside signing method
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Delegate Power](https://github.com/steemit/devportal-tutorials-js/tree/master/tutorials/25_delegate_power) can be downloaded as part of the [JS tutorials repository](https://github.com/steemit/devportal-tutorials-js).</span>
<br>



This tutorial runs on the main Steem blockchain. And accounts queried/searched are real accounts with their available VESTS balances and estimated STEEM POWER holdings.

## Intro

This tutorial will show few functions such as querying account by name and getting account vesting balance. We then convert VESTS to STEEM POWER for convenience of user. And allow user to choose portion or all holdings of VESTS to delegate other users. A simple HTML interface is provided to capture the account with search and its VESTS balance as well as allowing interactively delegate.

## Steps

1.  [**App setup**](#app-setup) Setup `dsteem` to use the proper connection and network.
2.  [**Search account**](#search-account) Get account details after input has account name
3.  [**Calculate and Fill form**](#fill-form) Calculate available vesting shares and Fill form with details
4.  [**Delegate power**](#delegate-power) Delegate VESTS with Steemconnect or Client-side signing.

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

After account name field is filled with some name, we do automatic search for account by name when input is focused out. HTML input forms can be found in the `index.html` file. The values are pulled from that screen with the below:

```javascript
    const accSearch = document.getElementById('username').value;
    const _account = await client.database.call('get_accounts', [[accSearch]]);
    console.log(`_account:`, _account);
```

#### 3. Calculate and Fill form <a name="fill-form"></a>

After we fetched account data, we will fill form with VESTS balance and show current balance details. Note, that in order to get available VESTS balance we will have to check if account is already powering down and how much is powering down, how much of VESTS were delegated out which locks them from being powered down. Available balance will be in `avail` variable, next for convenience of user, we convert available VESTS to STEEM with `getDynamicGlobalProperties` function and fill form fields accordingly.

```javascript
    const name = _account[0].name;
    const avail = parseFloat(_account[0].vesting_shares) - (parseFloat(_account[0].to_withdraw) - parseFloat(_account[0].withdrawn)) / 1e6 - parseFloat(_account[0].delegated_vesting_shares);

    const props = await client.database.getDynamicGlobalProperties();
    const vestSteem = parseFloat(parseFloat(props.total_vesting_fund_steem) *
        (parseFloat(avail) / parseFloat(props.total_vesting_shares)),6);

    const balance = `Available Vests for ${name}: ${avail} VESTS ~ ${vestSteem} STEEM POWER<br/><br/>`;
    document.getElementById('accBalance').innerHTML = balance;
    document.getElementById('steem').value = avail+' VESTS';
```

Once form is filled with maximum available VESTS balance, you can choose portion or lesser amount of VESTS to delegate other user.

#### 4. Delegate power <a name="delegate-power"></a>

We have 2 options on how to delegate others. Steemconnect and Client-side signing options. By default we generate Steemconnect link to delegate power (delegate vesting shares), but you can choose client signing option to delegate right inside tutorial, note client-side signing will require Active Private key to perform the operation.

In order to enable client signing, we will generate operation and also show Active Private key (wif) field to sign transaction client side.
Below you can see example of operation and signing transaction, after successful operation broadcast result will be shown in user interface. It will be block number that transaction was included.

```javascript
window.submitTx = async () => {
    const privateKey = dsteem.PrivateKey.fromString(
        document.getElementById('wif').value
    );
    const op = [
        'delegate_vesting_shares',
        {
            delegator: document.getElementById('username').value,
            delegatee: document.getElementById('account').value,
            vesting_shares: document.getElementById('steem').value,
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
1.  `cd tutorials/25_delegate_power`
1.  `npm i`
1.  `npm run dev-server` or `npm run start`
1.  After a few moments, the server should be running at [http://localhost:3000/](http://localhost:3000/)

---
