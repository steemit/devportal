---
title: Accounts
position: 8
right_code: |
    <p class="right-section-title">Get Accounts</p>
    ```javascript
    steem.api.getAccounts(names, function(err, result) {
      console.log(err, result);
    });
    ```

    <p class="right-section-title">Lookup Account Names</p>
    ```javascript
    steem.api.lookupAccountNames(accountNames, function(err, result) {
      console.log(err, result);
    });
    ```

    <p class="right-section-title">Lookup Accounts</p>
    ```javascript
    steem.api.lookupAccounts(lowerBoundName, limit, function(err, result) {
      console.log(err, result);
    });
    ```

    <p class="right-section-title">Get Account Count</p>
    ```javascript
    steem.api.getAccountCount(function(err, result) {
      console.log(err, result);
    });
    ```

    <p class="right-section-title">Get Conversion Requests</p>
    ```javascript
    steem.api.getConversionRequests(accountName, function(err, result) {
      console.log(err, result);
    });
    ```

    <p class="right-section-title">Get Account History</p>
    ```javascript
    steem.api.getAccountHistory(account, from, limit, function(err, result) {
      console.log(err, result);
    });
    ```

    <p class="right-section-title">Get Owner History</p>
    ```javascript
    steem.api.getOwnerHistory(account, function(err, result) {
      console.log(err, result);
    });
    ```

    <p class="right-section-title">Get Recovery Request</p>
    ```javascript
    steem.api.getRecoveryRequest(account, function(err, result) {
      console.log(err, result);
    });
    ```
---
