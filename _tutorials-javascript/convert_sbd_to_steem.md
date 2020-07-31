---
title: 'JS: Convert Sbd To Steem'
position: 32
description: "_How to convert SBD to STEEM for a specified account._"
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Convert Sbd To Steem](https://github.com/steemit/devportal-tutorials-js/tree/master/tutorials/32_convert_sbd_to_steem) can be downloaded as part of the [JS tutorials repository](https://github.com/steemit/devportal-tutorials-js).</span>
<br>



This tutorial will take you through the process of checking a specific users' balances and then broadcasting the intended SBD conversion to the blockchain. Demo account information has been provided to assist with the tutorial. This tutorial has been set up for the `testnet` but can be easily be changed for `production`.

It should be noted that the converted STEEM will not be available instantly as it takes 3.5 days for the transaction to be processed. It is also not possible to stop a conversion once initialised. During the 3.5 days for it to be converted and as the conversion price fluctuates you could actually be receiving less STEEM than what you should. Because of this, the method in this tutorial is NOT the preferred or most efficient way of converting SBD to STEEM. This tutorial just illustrates that it can be done in this manner.

There is a marketplace on Steemit that allows you to "sell" your SBD instantly. With this process you can get your STEEM immediately and at the exact price that you expect. The market place is the better way to convert your SBD. [This article](https://steemit.com/steem/@epico/convert-sbd-to-steem-and-steem-power-guide-2017625t103821622z) provides more information on using the market to exchange your SBD to STEEM

Steemlogin offers an alternative to converting SBD with a "simple link" solution. Instead of running through a list of operations on your account, you can simply use a link similar to the one below substituting the three parameters for your own details. You will be prompted to enter your username and password before the transaction will be executed.
https://steemlogin.com/sign/convert?owner=username&requestid=1234567&amount=0.000%20SBD
This is similar to the steemlogin links that have been covered in previous tutorials. For a list of signing operations that work in this manner you can go to https://steemlogin.com/sign
[This article](https://steemit.com/sbd/@timcliff/how-to-convert-sbd-into-steem-using-steemlogin) has more information on using steemlogin

## Intro

This tutorial uses the `database API` to gather account information for the current SBD and STEEM balances of the specified user. This information is then used to assist the user in completing the conversion request. The values are then captured and the operation is transmitted via the `broadcast` API. The parameters for this `convert` function are:

1.  _owner_ - The account for which the conversion is being done
1.  _requestid_ - Integer identifier for tracking the conversion. This needs to be a unique number for a specified user
1.  _amount_ - The amount of SBD to withdraw

The only other information required is the private active key of the user.

## Steps

1.  [**Configure connection**](#connection) Configuration of `dsteem` to communicate with a Steem blockchain
1.  [**User account**](#user) User account is captured and balances displayed
1.  [**Input variables**](#input) Collecting the required inputs via an HTML UI
1.  [**Broadcast operation**](#broadcast) Broadcasting the operation to the blockchain

#### 1. Configure connection<a name="connection"></a>

As usual, we have a `public/app.js` file which holds the Javascript segment of the tutorial. In the first few lines we define the configured library and packages:

```javascript
import { Client, PrivateKey } from 'dsteem';
import { Testnet as NetConfig } from '../../configuration'; //A Steem Testnet. Replace 'Testnet' with 'Mainnet' to connect to the main Steem blockchain.

let opts = { ...NetConfig.net };

// //connect to a steem node, tesetnet in this case
const client = new Client(NetConfig.url, opts);
```

Above, we have `dsteem` pointing to the testnet with the proper chainId, addressPrefix, and endpoint by importing it from the `configuration.js` file. Due to this tutorial altering the blockchain it is preferable to not work on production.

#### 2. User account<a name="user"></a>

The user account is input through the UI. Once entered, the user can select the `search` button to display the SBD and STEEM balances for that account. During this step, a random number is also generated for the `requestid`. This value can be changed to any integer value as long as it is unique for the specific account. If the requestid is duplicated an error to do with "uniqueness constraint" will be displayed in the console. For ease of use values for a demo account has already been entered in the relevant fields once the page loads.

```javascript
window.onload = async () => {
    const account = NetConfig.accounts[0];
    document.getElementById('username').value = account.address;
    document.getElementById('privateKey').value = account.privActive;
};
```

With the account search function as seen below.

```javascript
window.submitAcc = async () => {
    const accSearch = document.getElementById('username').value;

    const _account = await client.database.call('get_accounts', [[accSearch]]);
    console.log(`_account:`, _account);

    const availSBD = _account[0].sbd_balance 
    const availSTEEM = _account[0].balance

    const balance = `Available balance: ${availSBD} and ${availSTEEM} <br/>`;
    document.getElementById('accBalance').innerHTML = balance;

    //create random number for requestid paramter
    var x = Math.floor(Math.random() * 10000000);
    document.getElementById("requestID").value = x
}
```

#### 3. Input variables<a name="input"></a>

The parameters for the `convert` function are input in the UI and assigned as seen below once the user presses the convert button.

```javascript
//get all values from the UI
//get account name
const username = document.getElementById('username').value;
//get private active key
const privateKey = PrivateKey.fromString(
    document.getElementById('privateKey').value
);
//get convert amount
const quantity = document.getElementById('quantity').value;
//create correct format
const convert = quantity.concat(' SBD');
//assign integer value of ID
const requestid = parseInt(document.getElementById('requestID').value);
```

#### 4. Broadcast operation<a name="broadcast"></a>

With all the parameters assigned we create an array for the `convert` function and transmit it to the blockchain via the `sendOperation` function in the `broadcast` API.

```javascript
//create convert operation
const op = [
    'convert',
    { owner: username, amount: convert, requestid: requestid },
];
    
//broadcast the conversion
client.broadcast.sendOperations([op], privateKey).then(
    function(result) {
        console.log(
            'included in block: ' + result.block_num,
            'expired: ' + result.expired
        );
        document.getElementById('convertResultContainer').style.display = 'flex';
        document.getElementById('convertResult').className =
            'form-control-plaintext alert alert-success';
        document.getElementById('convertResult').innerHTML = 'Success';
    },
    function(error) {
        console.error(error);
        document.getElementById('convertResultContainer').style.display = 'flex';
        document.getElementById('convertResult').className =
            'form-control-plaintext alert alert-danger';
        document.getElementById('convertResult').innerHTML = error.jse_shortmsg;
    }
);
```

The results of the operation is displayed on the UI along with a block number in the console to confirm a successful operation.

### To run this tutorial

1.  clone this repo
1.  `cd tutorials/32_convert_sbd_to_steem`
1.  `npm i`
1.  `npm run dev-server` or `npm run start`
1.  After a few moments, the server should be running at http://localhost:3000/

---
