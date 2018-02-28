---
title: Globals
position: 6
right_code: |
    <p class="right-section-title">Get Config</p>
    ```javascript
    steem.api.getConfig(function(err, result) {
      console.log(err, result);
    });
    ```

    <p class="right-section-title">Get Dynamic Global Properties</p>
    ```javascript
    steem.api.getDynamicGlobalProperties(function(err, result) {
      console.log(err, result);
    });
    ```

    <p class="right-section-title">Get Chain Properties</p>
    ```javascript
    steem.api.getChainProperties(function(err, result) {
      console.log(err, result);
    });
    ```

    <p class="right-section-title">Get Feed History</p>
    ```javascript
    steem.api.getFeedHistory(function(err, result) {
      console.log(err, result);
    });
    ```

    <p class="right-section-title">Get Current Median History Price</p>
    ```javascript
    steem.api.getCurrentMedianHistoryPrice(function(err, result) {
      console.log(err, result);
    });
    ```

    <p class="right-section-title">Get Hardfork Version</p>
    ```javascript
    steem.api.getHardforkVersion(function(err, result) {
      console.log(err, result);
    });
    ```

    <p class="right-section-title">Get Next Scheduled Hardfork</p>
    ```javascript
    steem.api.getNextScheduledHardfork(function(err, result) {
      console.log(err, result);
    });
    ```
---
