---
title: Market
position: 9
right_code: |
    <p class="right-section-title">Get Order Book</p>
    ```javascript
    steem.api.getOrderBook(limit, function(err, result) {
      console.log(err, result);
    });
    ```

    <p class="right-section-title">Get Open Orders</p>
    ```javascript
    steem.api.getOpenOrders(owner, function(err, result) {
      console.log(err, result);
    });
    ```
---
