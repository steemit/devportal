---
title: Blocks and Transactions
position: 5
right_code: |
    <p class="right-section-title">Get Block Header</p>
    ~~~javascript
    steem.api.getBlockHeader(blockNum, function(err, result) {
      console.log(err, result);
    });
    ~~~

    <p class="right-section-title">Get Block</p>
    ~~~javascript
    steem.api.getBlock(blockNum, function(err, result) {
      console.log(err, result);
    });
    ~~~

    <p class="right-section-title">Get State</p>
    ~~~javascript
    steem.api.getState(path, function(err, result) {
      console.log(err, result);
    });
    ~~~
---

Access blocks by number.
