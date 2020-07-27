---
title: 'JS: Witness Listing And Voting'
position: 22
description: "_Create a list of available witnesses as well as vote for and remove your vote for a witness._"
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Witness Listing And Voting](https://github.com/steemit/devportal-tutorials-js/tree/master/tutorials/22_witness_listing_and_voting) can be downloaded as part of the [JS tutorials repository](https://github.com/steemit/devportal-tutorials-js).</span>
<br>



This tutorial will take you through the process of preparing and submitting a `vote` using the `broadcast` operation. A demo account is provided to use on the `testnet` but all variables can be easily changed and applied to the `production server`.

There is also an alternative method to vote for a witness using a `hot signing` link that can be generated via [Steemlogin](https://steemlogin.com/sign/). You create a link using the `witness` name and the `approve` fields which denotes whether you want to vote for or remove the vote. This [link](https://steemlogin.com/sign/account-witness-vote?witness=grg&approve=approve) then allows you to vote simply by signing in with your account details. This is a very simple way to send a vote request to any other user with the correct details already provided by the link.

## Intro

We are using the `account witness vote` function to create the vote which we then commit to the steem blockchain with a `broadcast` operation from `dsteem`. We also look at the vote status for a specific user using the `getAccounts` function. The parameters required for the witness voting operation are:

1.  _limit_ - Used in creating the witness list. Denotes the maximum number of witnesses to display
1.  _voter_ - This is the account making the vote
1.  _privatekey_ - The private active key of the voter account
1.  _witness_ - The name of the witness being voted for
1.  _approve_ - This is a boolean value determining whether the voting opration is to vote for, or to remove a vote

## Steps

1.  [**Configure connection**](#connection) Configuration of `dsteem` to communicate with a Steem blockchain
1.  [**Create witness list**](#createlist) Displaying a list of active witnesses
1.  [**Input variables**](#input) Collecting the required inputs via an HTML UI
1.  [**Voting status**](#status) Confirming the current vote status for the selected witness
1.  [**Broadcast**](#broadcast) Creating an object and broadcasting the vote to the blockchain

#### 1. Configure connection<a name="connection"></a>

As usual, we have a `public/app.js` file which holds the Javascript segment of the tutorial. In the first few lines we define the configured library and packages:

```javascript
import { Client, PrivateKey } from 'dsteem';
import { Testnet as NetConfig } from '../../configuration'; //A Steem Testnet. Replace 'Testnet' with 'Mainnet' to connect to the main Steem blockchain.

let opts = { ...NetConfig.net };
//connect to a steem node, testnet in this case
const client = new Client(NetConfig.url, opts);
```

Above, we have `dsteem` pointing to the test network with the proper chainId, addressPrefix, and endpoint by importing from the `configuration.js` file. Because this tutorial is interactive, we will not publish test content to the main network. Instead, we're using the testnet and a predefined account which is imported once the application loads, to demonstrate witness voting.

```javascript
window.onload = async () => {
    const account = NetConfig.accounts[0];
    document.getElementById('username').value = account.address;
    document.getElementById('activeKey').value = account.privActive;
};
```

#### 2. Create witness list<a name="createlist"></a>

We create a list of the current active witnesses available. This gives a list from which to select a witness to vote for. The list retrieved from the blockchain has a maximum length of 100 witnesses. We query the blockchain with the `getState` function and then use a `for loop` to display the list. This function is initiated once the user inputs a value for the `limit` variable and clicks on the "Fetch current Witnesses" button.

```javascript
window.createList = async () => {
    //get list limit
    const limit = document.getElementById('limit').value;

    const witnessdata = await client.database.getState('witnesses');
    var witnesses = [];

    for (const witness in witnessdata.witnesses) {
        console.log('witness', witness);
        witnesses.push(
            `<li><a href="#" onclick="document.getElementById('witness').value = '${witness}';">${witness}</a></li>`
        );
    }
    console.log('witnesses', witnesses);
    document.getElementById('witnessList').innerHTML = witnesses.join('');
    document.getElementById('witnessListContainer').style.display = 'flex';
};
```

#### 3. Input variables<a name="input"></a>

The required parameters for the vote operation is recorded via an HTML UI that can be found in the `public/index.html` file. The values are pre-populated in this case with a testnet `demo` account.

The parameter values are allocated as seen below, once the user clicks on the "Submit Vote" button.

```javascript
window.submitVote = async () => {
    //get all values from the UI
    //get account name of voter
    const voter = document.getElementById('username').value;
    //get private active key
    const privateKey = dsteem.PrivateKey.fromString(
        document.getElementById('activeKey').value
    );
    //get witness name
    const witness = document.getElementById('witness').value;
```

#### 4. Voting status<a name="status"></a>

The `approve` parameter within the vote function determines whether the user is voting for the witness or removing its vote. In order to get the correct value for this parameter we first need to identify whether the user has already voted for the specified witness or not. One of the fields from the account information (blockchain query) holds an array of all the witnesses currently voted for by the user. The check returns `true` if the user has already voted for the selected witness. The result of this query is displayed and the user is given a choice whether to proceed with the vote/unvote process or stop the process activating a new function for each of those choices.

```javascript
    //check if witness is already voted for
    _data = new Array
    _data = await client.database.getAccounts([voter]);
    const witnessvotes = _data[0]["witness_votes"];
    const approve = witnessvotes.includes(witness);
    if (approve) {
        checkresult = "Witness has already been voted for, would you like to remove vote?"
        votecheck = "Vote removed"
    } else {
        checkresult = "Witness has not yet been voted for, would you like to vote?"
        votecheck = "Vote added"
    }

    document.getElementById('voteCheckContainer').style.display = 'flex';
    document.getElementById('voteCheck').className = 'form-control-plaintext alert alert-success';
    document.getElementById('voteCheck').innerHTML = checkresult;

    document.getElementById("submitYesBtn").style.visibility = "visible";
    document.getElementById("submitNoBtn").style.visibility = "visible";
```

#### 5. Broadcast<a name="broadcast"></a>

When the user decides to continue with the voting process the actual vote function is triggered and we create a `vote object` with the input variables before we can broadcast to the blockchain.

```javascript
window.submitYes = async () => {
        //create vote object
        const vote = [
        'account_witness_vote',
        { account: voter, witness: witness, approve: !approve },
        ];
```

The array cotains the function for the witness vote along with an object containing the needed parameters. We have to use the opposite of the `approve` variable that we created in the previous step. That variable is `true` if the user has already voted, and a value of `true` for the `approve` parameter means that the user is voting _for_ the specified witness which will then return an error.

After the object has been created we can `broadcast` the operation to the steem blockchain along with the private active key of the user. The result of the vote is displayed on the UI to confirm whether you voted for or removed a vote for the witness as well as error details should there be one.

```javascript
//broadcast the vote
client.broadcast.sendOperations([vote], privateKey).then(
    function(result) {
        console.log(
            'included in block: ' + result.block_num,
            'expired: ' + result.expired
        );
        document.getElementById('voteCheckContainer').style.display = 'flex';
        document.getElementById('voteCheck').className =
            'form-control-plaintext alert alert-success';
        document.getElementById('voteCheck').innerHTML = votecheck;
    },
    function(error) {
        console.error(error);
        document.getElementById('voteCheckContainer').style.display = 'flex';
        document.getElementById('voteCheck').className =
            'form-control-plaintext alert alert-danger';
        document.getElementById('voteCheck').innerHTML = error.jse_shortmsg;
    }
);
document.getElementById('submitYesBtn').style.visibility = 'hidden';
document.getElementById('submitNoBtn').style.visibility = 'hidden';
```

Should the user choose to stop the process the following function is executed.

```javascript
window.submitNo = async () => {
    document.getElementById('voteCheckContainer').style.display = 'flex';
    document.getElementById('voteCheck').className =
        'form-control-plaintext alert alert-success';
    document.getElementById('voteCheck').innerHTML =
        'Vote process has ben cancelled';
    document.getElementById('submitYesBtn').style.visibility = 'hidden';
    document.getElementById('submitNoBtn').style.visibility = 'hidden';
};
```

The option buttons (continue with voting process or stop) are disabled at the end of the process in order to remove confusion on what to do next or what the option buttons will do.

### To run this tutorial

1.  clone this repo
1.  `cd tutorials/22_witness_listing_and_voting`
1.  `npm i`
1.  `npm run dev-server` or `npm run start`
1.  After a few moments, the server should be running at [http://localhost:3000/](http://localhost:3000/)


---
