---
title: 'JS: Get Delegations By User'
position: 29
description: '_View the vesting delegations made by a user as well as the delegations that are expiring._'
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Get Delegations By User](https://github.com/steemit/devportal-tutorials-js/tree/master/tutorials/29_get_delegations_by_user) can be downloaded as part of the [JS tutorials repository](https://github.com/steemit/devportal-tutorials-js).</span>
<br>



This tutorial will take you through the process of calling delegation information from the steem blockchain using the `database API`. The account information provided has been chosen by random and the process is applicable to any user account on both the `production server` and the `testnet`.

## Intro

This tutorial has two separate functions, one for viewing active delegations and one for viewing expiring delegations. Both of these use the `database API` to pull information from the steem blockchain. It should be noted that when a delegation is cancelled it will only be available after 7 days. The value of the delegation can also be changed at any time, either decreased or increased. The first function we use is `getVestingDelegations` for which we require the following parameters:

1.  _account_ - The username for which the query is done
2.  _from_ - The value from where to start the search. This can be used for paging. This parameter is optional
3.  _limit_ - The quantity of results that is queried from the blockchain. This parameter is optional

The second function is `getExpiringVestingDelegations` with parameters:

1.  _user_ - The account that the query is referencing
2.  _from time_ - The date from where the query will be run. Pending expirations clear after 7 days so it will never be older than that. This value can however be set to anytime before the 7 days of expiration and it will return the relevant transactions
3.  _limit_ - The quantity of results that is queried from the blockchain

## Steps

1.  [**Configure connection**](#connection) Configuration of `dsteem` to communicate with a Steem blockchain
2.  [**Input variables**](#input) Collecting the required inputs via an HTML UI
3.  [**Database query**](#query) Sending a query to the blockchain for the user delegations
4.  [**Display results**](#display) Display the results of the blockchain query

#### 1. Configure connection<a name="connection"></a>

As usual, we have a `public/app.js` file which holds the Javascript segment of the tutorial. In the first few lines we define the configured library and packages:

```javascript
const dsteem = require('dsteem');
let opts = {};
//define network parameters
opts.addressPrefix = 'STM';
opts.chainId =
    '0000000000000000000000000000000000000000000000000000000000000000';
//connect to a steem node, production in this case
const client = new dsteem.Client('https://api.steemit.com');
```

Above, we have `dsteem` pointing to the production network with the proper chainId, addressPrefix, and endpoint.

#### 2. Input variables<a name="input"></a>

The required parameters for the delegation query operation is recorded via an HTML UI that can be found in the `public/index.html` file. The values are pre-populated in this case but any account name can be used.

Both of the query functions use the same input variables. The previous results are cleared each time at the start of the function. The parameter values are allocated as seen below, once the user clicks on either the "Display active delegations" or "Display expiring delegations" button.

```javascript
//active delegations function
window.createList = async () => {
    //clear list
    document.getElementById('delegationList').innerHTML = '';

    //get username
    const delegator = document.getElementById('username').value;
```

#### 3. Database query<a name="query"></a>

The queries are sent through to the steem blockchain using the `database API` and parameters as per the `intro`. The result of the query is displayed on the console as a control check.

```javascript
//active delegations function
delegationdata = await client.database.getVestingDelegations(delegator, "", 100);
    console.log(JSON.stringify(delegationdata));
```

```javascript
//expiring delegations function
const delegationdata = await client.database.call('get_expiring_vesting_delegations',[delegator, "2018-01-01T00:00:00", 100]);
    console.log(delegationdata);
```

#### 4. Display results<a name="display"></a>

Before the results are displayed a check is done whether there are in fact any transactions for the specific user.

```javascript
//active delegations function
if (delegationdata[0] == null) {
    console.log('No delegation information');
    document.getElementById('searchResultContainer').style.display = 'flex';
    document.getElementById('searchResult').className =
        'form-control-plaintext alert alert-danger';
    document.getElementById('searchResult').innerHTML =
        'No delegation information';
} else {
    document.getElementById('searchResultContainer').style.display = 'flex';
    document.getElementById('searchResult').className =
        'form-control-plaintext alert alert-success';
    document.getElementById('searchResult').innerHTML = 'Active Delegations';
}
```

```javascript
//expiring delegations function
if (delegationdata[0] == null) {
    console.log('No delegation information');
    document.getElementById('searchResultContainer').style.display = 'flex';
    document.getElementById('searchResult').className =
        'form-control-plaintext alert alert-danger';
    document.getElementById('searchResult').innerHTML =
        'No delegation information';
} else {
    document.getElementById('searchResultContainer').style.display = 'flex';
    document.getElementById('searchResult').className =
        'form-control-plaintext alert alert-success';
    document.getElementById('searchResult').innerHTML = 'Expiring Delegations';
}
```

The result from the query is an array of objects. The results are displayed in a simple list.

The active delegations functions returns the following values and are displayed on the UI as per below.

1.  delegator - The user that made the delegation
2.  delegatee - The user that the delegations has been made to
3.  vesting_shares - The amount of VESTS that has been delegated
4.  min_delegation_time - The time from which the delegation will be active

```javascript
//active delegations function
delegationdata.forEach(newObj => {
    name = newObj.delegatee;
    shares = newObj.vesting_shares;
    document.getElementById('delegationList').innerHTML +=
        delegator + ' delegated ' + shares + ' to ' + name + '<br>';
});
```

The expiring delegations function returns the following values and are displayed on the UI as per below.

1.  vesting_shares - The amount of VESTS that is pending expiration
2.  expiration - The date at which the delegation will expire and the VESTS will be available again

```javascript
//expiring delegations function
delegationdata.forEach(newObj => {
    shares = newObj.vesting_shares;
    date = expiration;
    document.getElementById('delegationList').innerHTML +=
        shares + ' will be released at ' + date + '<br>';
});
```

### To run this tutorial

1.  clone this repo
2.  `cd tutorials/27_get_delegations_by_user`
3.  `npm i`
4.  `npm run dev-server` or `npm run start`
5.  After a few moments, the server should be running at http://localhost:3000/

---
