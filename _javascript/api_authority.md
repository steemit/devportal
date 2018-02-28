---
title: Authority/Validation
position: 10
right_code: |
    <p class="right-section-title">Get Transaction Hex</p>
    ```javascript
    steem.api.getTransactionHex(trx, function(err, result) {
      console.log(err, result);
    });
    ```

    <p class="right-section-title">Get Transaction</p>
     ```javascript
    steem.api.getTransaction(trxId, function(err, result) {
      console.log(err, result);
    });
    ```

    <p class="right-section-title">Get Required Signatures</p>
     ```javascript
    steem.api.getRequiredSignatures(trx, availableKeys, function(err, result) {
      console.log(err, result);
    });
    ```

    <p class="right-section-title">Get Potential Signatures</p>
     ```javascript
    steem.api.getPotentialSignatures(trx, function(err, result) {
      console.log(err, result);
    });
    ```

    <p class="right-section-title">Verify Authority</p>
     ```javascript
    steem.api.verifyAuthority(trx, function(err, result) {
      console.log(err, result);
    });
    ```

    <p class="right-section-title">Verify Account Authority</p>
     ```javascript
    steem.api.verifyAccountAuthority(nameOrId, signers, function(err, result) {
      console.log(err, result);
    });
    ```
---
