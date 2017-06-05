---
title: Examples
position: 3
right_code: |
    Accounts
    ``` javascript
    steem.api.getAccounts(['ned', 'sneak'], function(err, result) {
        console.log(err, result);
    });
    ```
    State
    ``` javascript
    steem.api.getState('/trends/funny', function(err, result) {
        console.log(err, result);
    });
    ```
    Broadcast
    ``` javascript
    var steem = require('steem');
    
    var wif = steem.auth.toWif(username, password, 'posting');
    steem.broadcast.vote(wif, voter, author, permlink, weight, function(err, result) {
        console.log(err, result);
    });
    ```
    Reputation
    ``` javascript
    var reputation = steem.formatter.reputation(user.reputation);
    console.log(reputation);
    ```
   
        
            
---

### Accounts

Easily fetch account data on the following users. 

### State

Easily fetch state. 

### Broadcast

Easily cast a vote for a user. 

### Reputation

Easily handle reputation parsing. 
