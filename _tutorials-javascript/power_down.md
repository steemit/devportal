---
title: 'JS: Power Down'
position: 25
description: "_Perform a power down on all or part of an account's VESTS using either Steemlogin or client-side signing._"
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Power Down](https://github.com/steemit/devportal-tutorials-js/tree/master/tutorials/25_power_down) can be downloaded as part of the [JS tutorials repository](https://github.com/steemit/devportal-tutorials-js).</span>
<br>



This tutorial runs on the main Steem blockchain. Therefore, any accounts used here will affect real funds on the live network. **Use with caution.**

## Intro

This tutorial will demonstrate a few functions such as querying account by name and determining the vesting balance of the related account. We are using the `call` function provided by the `dsteem` library to pull account data from the Steem blockchain. We then calculate STEEM Power from the VESTS (vesting shares) for the convenience of the user. We will use a simple HTML interface to capture the account and its VESTS. It also has an interactive UI to perform a power down in full or in part.

## Steps

1.  [**App setup**](#app-setup) Setup `dsteem` to use the proper connection and network.
2.  [**Search account**](#search-account) Get account details after input has account name
3.  [**Calculate and Fill form**](#fill-form) Calculate available vesting shares and fill the form with details
4.  [**Power down**](#power-down) Power down VESTS with Steemlogin or client-side signing.

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

#### 2. Search account <a name="search-account"></a>

After the account name field has been filled with a name, we automatically search for the account by name when the input is focused out. The related HTML input forms can be found in the `index.html` file. The values are pulled from that screen with the following:

```javascript
    const accSearch = document.getElementById('username').value;
    const _account = await client.database.call('get_accounts', [[accSearch]]);
    console.log(`_account:`, _account);
```

#### 3. Calculate and Fill form <a name="fill-form"></a>

Once the account data has been fetched, we will fill the form with VESTS balance and show current balance details. Note, that in order to get the available vesting shares we will have to check a few things:

*   if account is already powering down
*   how much is currently powering down
*   how much has been delegated (because active delegation locks those funds from being powered down)

Available balance will be in the `avail` variable.

For the convenience of the user, we will convert available VESTS to STEEM with `getDynamicGlobalProperties` function and fill the form fields accordingly.

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

Once form is filled with the maximum available VESTS balance, we can choose the amount of VESTS to power down.

#### 4. Power down <a name="power-down"></a>

We have two options on how to Power down: Steemlogin and client-side signing. By default we generate a Steemlogin link to Power down (withdraw vesting), but we can also choose the client signing option to Power down right inside tutorial. **Note:** client-side signing will require Active Private key to perform the operation.

In order to enable client signing, we will generate the operation and also show Active Private key (wif) field to sign transaction right there, client side.

Below, we can see an example of the operation and signing transaction. After a successful broadcast, the result will be shown in user interface. It will show the block number that the transaction was included in.

```javascript
window.submitTx = async () => {
    const privateKey = dsteem.PrivateKey.fromString(
        document.getElementById('wif').value
    );
    const op = [
        'withdraw_vesting',
        {
            account: document.getElementById('username').value,
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

1.  `git clone https://github.com/steemit/devportal-tutorials-js.git`
1.  `cd devportal-tutorials-js/tutorials/23_power_down`
1.  `npm i`
1.  `npm run dev-server` or `npm run start`
1.  After a few moments, the server should be running at [http://localhost:3000/](http://localhost:3000/)


---
