---
title: Examples
position: 3
right_code: |
    Get Accounts
    ``` javascript
    steem.api.getAccounts(['ned', 'sneak'], function(err, result) {
        console.log(err, result);
    });
    ```
    Get State
    ``` javascript
    steem.api.getState('/trends/funny', function(err, result) {
        console.log(err, result);
    });
    ```
    Broadcast Vote
    ``` javascript
    var steem = require('steem');
    
    var wif = steem.auth.toWif(username, password, 'posting');
    steem.broadcast.vote(wif, voter, author, permlink, weight, function(err, result) {
        console.log(err, result);
    });
    ```
    Reputation Formatter
    ``` javascript
    var reputation = steem.formatter.reputation(user.reputation);
    console.log(reputation);
    ```
   
        
            
---

**Get Accounts** Easily fetch account data on the following users. 

**Get State** Easily fetch state. 

**Broadcast Vote** Easily cast a vote for a user. 

**Reputation Formatter** Easily handle reputation parsing. 
