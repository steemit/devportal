---
title: Witnesses
position: 13
right_code: |
    <p class="right-section-title">Get Witnesses</p>
    ~~~javascript
    steem.api.getWitnesses(witnessIds, function(err, result) {
      console.log(err, result);
    });
    ~~~

    <p class="right-section-title">Get Witness By Account</p>
    ~~~javascript
    steem.api.getWitnessByAccount(accountName, function(err, result) {
      console.log(err, result);
    });
    ~~~

    <p class="right-section-title">Get Witnesses By Vote</p>
    ~~~javascript
    steem.api.getWitnessesByVote(from, limit, function(err, result) {
      console.log(err, result);
    });
    ~~~

    <p class="right-section-title">Lookup Witness Accounts</p>
    ~~~javascript
    steem.api.lookupWitnessAccounts(lowerBoundName, limit, function(err, result) {
      console.log(err, result);
    });
    ~~~

    <p class="right-section-title">Get Witness Count</p>
    ~~~javascript
    steem.api.getWitnessCount(function(err, result) {
      console.log(err, result);
    });
    ~~~

    <p class="right-section-title">Get Active Witnesses</p>
    ~~~javascript
    steem.api.getActiveWitnesses(function(err, result) {
      console.log(err, result);
    });
    ~~~
---
