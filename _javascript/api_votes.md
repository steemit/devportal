---
title: Votes
position: 11
right_code: |
    <p class="right-section-title">Get Active Votes</p>
     ~~~javascript
    steem.api.getActiveVotes(author, permlink, function(err, result) {
      console.log(err, result);
    });
    ~~~

    <p class="right-section-title">Get Account Votes</p>
     ~~~javascript
    steem.api.getAccountVotes(voter, function(err, result) {
      console.log(err, result);
    });
    ~~~
---
