---
title: Websocket
position: 3
right_code: |
    <p class="right-section-title">Set WebSocket</p>
    ~~~javascript
    steem.api.setWebSocket(url);
    ~~~

    <p class="right-section-title">Set Pending Transaction Callback</p>
    ~~~javascript
    steem.api.setPendingTransactionCallback(cb, function(err, result) {
      console.log(err, result);
    });
    ~~~

    <p class="right-section-title">Cancel All Subscriptions</p>
    ~~~javascript
    steem.api.cancelAllSubscriptions(function(err, result) {
      console.log(err, result);
    });
    ~~~
---

Access the Steem websocket API enabling RPC communication with steemd.
