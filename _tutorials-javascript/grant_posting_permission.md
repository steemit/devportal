---
title: 'JS: Grant Posting Permission'
position: 30
description: "_How to grant and revoke posting permission to another user._"
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Grant Posting Permission](https://github.com/steemit/devportal-tutorials-js/tree/master/tutorials/30_grant_posting_permission) can be downloaded as part of the [JS tutorials repository](https://github.com/steemit/devportal-tutorials-js).</span>
<br>



This tutorial will take you through the process of checking a specific users' data, altering the array pertaining to the posting `account_auths`, and then broadcasting the changes to the blockchain. Demo account information has been provided to assist with the tutorial. This tutorial has been set up for the `testnet` but can be easily be changed for `production`.

Providing another user posting permission for your account can be used to allow multiple users to submit posts on a single steemit community. @Utopian-Io is an example of such a community. There are also applications that allows you to schedule posts by automatically publishing on your behalf.

## Intro

This tutorial uses the `database API` to gather account information for the user that is granting posting permission to another user. This information is used to check current permissions as well as to build the `broadcast` operation. Granting or revoking posting permission works by changing the array of usernames containing this information and then pushing those changes to the blockchain. The parameters for this `updateAccount` function are:

1.  _account_ - The username of the main account
2.  _active_ - Optional parameter to denote changes to the active authority type
3.  _jsonMetadata_ - This is a string value obtained from the current account info
4.  _memoKey_ - This is the public memoKey of the user
5.  _owner_ - Optional parameter to denote changes to the owner authority type
6.  _posting_ - Optional parameter to denote changes to the posting authority type. This is the parameter that we will be changing in this tutorial
7.  _privateKey_ - The private `active` key of the user

The only other information required is the username of the account that the posting permission is being granted to.

The tutorial is set up with three individual functions for each of the required operations - checking permission status, granting permission and revoking permission.

## Steps

1.  [**Configure connection**](#connection) Configuration of `dsteem` to communicate with a Steem blockchain
2.  [**Input variables**](#input) Collecting the required inputs via an HTML UI.
3.  [**Database query**](#query) Sending a query to the blockchain for the posting permissions (status)
4.  [**Object creation**](#object) Create the array and subsequent data object for the broadcast operation
5.  [**Broadcast operation**](#broadcast) Broadcasting the changes to the blockchain

#### 1. Configure connection<a name="connection"></a>

As usual, we have a `public/app.js` file which holds the Javascript segment of the tutorial. In the first few lines we define the configured library and packages:

```javascript
const dsteem = require('dsteem');
//define network parameters
let opts = {};
opts.addressPrefix = 'STX';
opts.chainId =
    '79276aea5d4877d9a25892eaa01b0adf019d3e5cb12a97478df3298ccdd01673';
//connect to a steem node, testnet in this case
const client = new dsteem.Client('https://testnet.steem.vc', opts);
```

Above, we have `dsteem` pointing to the testnet with the proper chainId, addressPrefix, and endpoint. Due to this tutorial altering the blockchain it is preferable to not work on production.

#### 2. Input variables<a name="input"></a>

The required parameters for the account status query is recorded via an HTML UI that can be found in the `public/index.html` file. The values are pre-populated in this case but any account name can be used.

All of the functions use the same input variables. Once the function is activated via the UI the variables are allocated as seen below.

```javascript
//get username
const username = document.getElementById('username').value;
//get private active key
const privateKey = dsteem.PrivateKey.fromString(
    document.getElementById('privateKey').value
);
//get account to provide posting auth
const newAccount = document.getElementById('newAccount').value;
```

#### 3. Database query<a name="query"></a>

The queries are sent through to the steem blockchain with the `database API` using the `getAccounts` function. The results of the query is used to check the status of the current posting authorisations and parameters as per the `intro`.

```javascript
    //query database for posting array
    _data = new Array
    _data = await client.database.getAccounts([username]);
    const postingAuth = _data[0].posting;

     //check for username duplication
    const checkAuth = _data[0].posting.account_auths;
    var arrayindex = -1;
    var checktext = " does not yet have posting permission"
    for (var i = 0,len = checkAuth.length; i<len; i++) {
        if (checkAuth[i][0]==newAccount) {
            arrayindex = i
            var checktext = " already has posting permission"
        }
    }
```

The result of this status query is then displayed on the UI along with the array on the console as a check.

```javascript
document.getElementById('permCheckContainer').style.display = 'flex';
document.getElementById('permCheck').className =
    'form-control-plaintext alert alert-success';
document.getElementById('permCheck').innerHTML = newAccount + checktext;
console.log(checkAuth);
```

#### 4. Object creation<a name="object"></a>

The database query is the same for all the functions and is required to create an updated array to broadcast to the blockchain. This is how we determine whether a user permission will be added or revoked. The actual operation is the same apart from the array variable as can be seen below. The difference is in that when creating a permission, an element is added to the `account_auths` array where revoking removes an element from it.

```javascript
//add account permission
postingAuth.account_auths.push([
    newAccount,
    parseInt(postingAuth.weight_threshold),
]);
postingAuth.account_auths.sort();

//revoke permission
postingAuth.account_auths.splice(arrayindex, 1);
```

When adding to the array (creaing permission) it is required to sort the array before we can broadcast. The steem blockchain does not accept the new fields in the array if it's not alphabetically sorted.
After the posting array has been defined, the broadcast object can be created. This holds all the required information for a successful transaction to be sent to the blockchain. Where there is no change in the authority types, the parameter can be omitted or in the case of required parameters, allocated directly from the database query.

```javascript
//object creation
const accObj = {
    account: username,
    json_metadata: _data[0].json_metadata,
    memo_key: _data[0].memo_key,
    posting: postingAuth,
};
```

#### 5. Broadcast operation<a name="broadcast></a>

With all the parameters assigned, the transaction can be broadcast to the blockchain. As stated before, the actual `broadcast` operation for both new permissions and to revoke permissions use the same parameters.

```javascript
//account update broadcast
client.broadcast.updateAccount(accObj, privateKey).then(
    function(result) {
        console.log(
            'included in block: ' + result.block_num,
            'expired: ' + result.expired
        );
        document.getElementById('permCheckContainer').style.display = 'flex';
        document.getElementById('permCheck').className =
            'form-control-plaintext alert alert-success';
        document.getElementById('permCheck').innerHTML =
            'posting permission has been granted to ' + newAccount;
    },
    function(error) {
        console.error(error);
        document.getElementById('permCheckContainer').style.display = 'flex';
        document.getElementById('permCheck').className =
            'form-control-plaintext alert alert-danger';
        document.getElementById('permCheck').innerHTML = error.jse_shortmsg;
    }
);
```

The results of the operation is displayed on the UI along with a block number in the console to confirm a successful operation. If you add permission to an account that already has permission will display an error of "Missing Active Authority".

Steemconnect offers an alternative to revoking posting permission with a "simple link" solution. Instead of running through a list of opetions on your account, you can simply use a link similar to the one below. You will be prompted to enter your usename and password and the specified user will have their posting permission removed instantly.
https://v2.steemconnect.com/revoke/@username
This is similar to the steemconnect links that have been covered in previous tutorials. For a list of signing operations that work in this manner you can go to https://v2.steemconnect.com/sign

### To run this tutorial

1.  clone this repo
2.  `cd tutorials/28_grant_posting_permission`
3.  `npm i`
4.  `npm run dev-server` or `npm run start`
5.  After a few moments, the server should be running at http://localhost:3000/


---
