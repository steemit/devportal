---
title: Examples
position: 3
right_code: |
    ~~~ javascript
    steem.api.getAccounts(['ned', 'sneak'], function(err, result) {
        console.log(err, result);
    });
    ~~~
    {: title="Get Accounts"} 
    
    ~~~ javascript
    steem.api.getState('/trends/funny', function(err, result) {
        console.log(err, result);
    });
    ~~~
    {: title="Get State"} 
    
    ~~~ javascript
    var steem = require('steem');
    
    var wif = steem.auth.toWif(username, password, 'posting');
    steem.broadcast.vote(wif, voter, author, permlink, weight, function(err, result) {
        console.log(err, result);
    });
    ~~~
    {: title="Broadcast Vote"} 
    
    ~~~ javascript
    var reputation = steem.formatter.reputation(user.reputation);
    console.log(reputation);
    ~~~
    {: title="Reputation Formatter"} 
   
        
            
---

**Get Accounts** Easily fetch account data on the following users. 

**Get State** Easily fetch state. 

**Broadcast Vote** Easily cast a vote for a user. 

**Reputation Formatter** Easily handle reputation parsing. 
