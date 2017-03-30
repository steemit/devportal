---
title: API References
position: 2
right_code: | 
    WebSocket
    ``` javascript
    steem.api.setWebSocket(url);
    ```
    Subscriptions
    ``` javascript
    steem.api.setSubscribeCallback(callback, clearFilter, function(err, result) {
      console.log(err, result);
    });
    ```
    
    ```javascript
    steem.api.setPendingTransactionCallback(cb, function(err, result) {
      console.log(err, result);
    });
    ```

    ```javascript
    steem.api.cancelAllSubscriptions(function(err, result) {
      console.log(err, result);
    });
    ```

    Tags
    ```javascript
    steem.api.getTrendingTags(afterTag, limit, function(err, result) {
      console.log(err, result);
    });
    ```

    ```javascript
    steem.api.getDiscussionsByTrending(query, function(err, result) {
      console.log(err, result);
    });
    ```

    ```javascript
    steem.api.getDiscussionsByCreated(query, function(err, result) {
      console.log(err, result);
    });
    ```

    ```javascript
    steem.api.getDiscussionsByActive(query, function(err, result) {
      console.log(err, result);
    });
    ```

    ```javascript
    steem.api.getDiscussionsByCashout(query, function(err, result) {
      console.log(err, result);
    });
    ```
    
    ```javascript
    steem.api.getDiscussionsByPayout(query, function(err, result) {
      console.log(err, result);
    });
    ```

    ```javascript
    steem.api.getDiscussionsByVotes(query, function(err, result) {
      console.log(err, result);
    });
    ```
    
    ```javascript
    steem.api.getDiscussionsByChildren(query, function(err, result) {
      console.log(err, result);
    });
    ```

    ```javascript
    steem.api.getDiscussionsByHot(query, function(err, result) {
      console.log(err, result);
    });
    ```
    ```javascript
    steem.api.getDiscussionsByFeed(query, function(err, result) {
      console.log(err, result);
    });
    ```
    ```javascript
    steem.api.getDiscussionsByBlog(query, function(err, result) {
      console.log(err, result);
    });
    ```
    ```javascript
    steem.api.getDiscussionsByComments(query, function(err, result) {
      console.log(err, result);
    });
    ```
    Blocks and transactions
    ```javascript
    steem.api.getBlockHeader(blockNum, function(err, result) {
      console.log(err, result);
    });
    ```
    ```javascript
    steem.api.getBlock(blockNum, function(err, result) {
      console.log(err, result);
    });
    ```
    ```javascript
    steem.api.getState(path, function(err, result) {
      console.log(err, result);
    });
    ```
    ```javascript
    steem.api.getTrendingCategories(after, limit, function(err, result) {
      console.log(err, result);
    });
    ```
    ```javascript
    steem.api.getBestCategories(after, limit, function(err, result) {
      console.log(err, result);
    });
    ```
    ```javascript
    steem.api.getActiveCategories(after, limit, function(err, result) {
      console.log(err, result);
    });
    ```
    ```javascript
    steem.api.getRecentCategories(after, limit, function(err, result) {
      console.log(err, result);
    });
    ```
    Globals
    ```javascript
    steem.api.getConfig(function(err, result) {
      console.log(err, result);
    });
    ```
    ```javascript
    steem.api.getDynamicGlobalProperties(function(err, result) {
      console.log(err, result);
    });
    ```
    ```javascript
    steem.api.getChainProperties(function(err, result) {
      console.log(err, result);
    });
    ```
    ```javascript
    steem.api.getFeedHistory(function(err, result) {
      console.log(err, result);
    });
    ```
    ```javascript
    steem.api.getCurrentMedianHistoryPrice(function(err, result) {
      console.log(err, result);
    });
    ```
    ```javascript
    steem.api.getHardforkVersion(function(err, result) {
      console.log(err, result);
    });
    ```
    ```javascript
    steem.api.getNextScheduledHardfork(function(err, result) {
      console.log(err, result);
    });
    ```
    Keys
    ```javascript
    steem.api.getKeyReferences(key, function(err, result) {
      console.log(err, result);
    });
    ```
    Accounts
    ```javascript
    steem.api.getAccounts(names, function(err, result) {
      console.log(err, result);
    });
    ```
    ```javascript
    steem.api.getAccountReferences(accountId, function(err, result) {
      console.log(err, result);
    });
    ```
    ```javascript
    steem.api.lookupAccountNames(accountNames, function(err, result) {
      console.log(err, result);
    });
    ```
    ```javascript
    steem.api.lookupAccounts(lowerBoundName, limit, function(err, result) {
      console.log(err, result);
    });
    ```
    ```javascript
    steem.api.getAccountCount(function(err, result) {
      console.log(err, result);
    });
    ```
    ```javascript
    steem.api.getConversionRequests(accountName, function(err, result) {
      console.log(err, result);
    });
    ```
    ```javascript
    steem.api.getAccountHistory(account, from, limit, function(err, result) {
      console.log(err, result);
    });
    ```
    ```javascript
    steem.api.getOwnerHistory(account, function(err, result) {
      console.log(err, result);
    });
    ```
    ```javascript
    steem.api.getRecoveryRequest(account, function(err, result) {
      console.log(err, result);
    });
    ```
    Market
    ```javascript
    steem.api.getOrderBook(limit, function(err, result) {
      console.log(err, result);
    });
    ```
    ```javascript
    steem.api.getOpenOrders(owner, function(err, result) {
      console.log(err, result);
    });
    ```
    ```javascript
    steem.api.getLiquidityQueue(startAccount, limit, function(err, result) {
      console.log(err, result);
    });
    ```
    
    Authority/Validation
    
    ```javascript
    steem.api.getTransactionHex(trx, function(err, result) {
      console.log(err, result);
    });
    ```
     ```javascript
    steem.api.getTransaction(trxId, function(err, result) {
      console.log(err, result);
    });
    ```
     ```javascript
    steem.api.getRequiredSignatures(trx, availableKeys, function(err, result) {
      console.log(err, result);
    });
    ```
     ```javascript
    steem.api.getPotentialSignatures(trx, function(err, result) {
      console.log(err, result);
    });
    ```
     ```javascript
    steem.api.verifyAuthority(trx, function(err, result) {
      console.log(err, result);
    });
    ```
     ```javascript
    steem.api.verifyAccountAuthority(nameOrId, signers, function(err, result) {
      console.log(err, result);
    });
    ```
    Votes
     ```javascript
    steem.api.getActiveVotes(author, permlink, function(err, result) {
      console.log(err, result);
    });
    ```
     ```javascript
    steem.api.getAccountVotes(voter, function(err, result) {
      console.log(err, result);
    });
    ```
    Content
     ```javascript
    steem.api.getContentReplies(parent, parentPermlink, function(err, result) {
      console.log(err, result);
    });
    ```
     ```javascript
    steem.api.getDiscussionsByAuthorBeforeDate(author, startPermlink, beforeDate, limit, function(err, result) {
      console.log(err, result);
    });
    ```
    ```javascript
    steem.api.getRepliesByLastUpdate(startAuthor, startPermlink, limit, function(err, result) {
      console.log(err, result);
    });
    ```
    Witness
    ```javascript
    steem.api.getWitnesses(witnessIds, function(err, result) {
      console.log(err, result);
    });
    ```
    ```javascript
    steem.api.getWitnessByAccount(accountName, function(err, result) {
      console.log(err, result);
    });
    ```
    ```javascript
    steem.api.getWitnessesByVote(from, limit, function(err, result) {
      console.log(err, result);
    });
    ```
    ```javascript
    steem.api.lookupWitnessAccounts(lowerBoundName, limit, function(err, result) {
      console.log(err, result);
    });
    ```
    ```javascript
    steem.api.getWitnessCount(function(err, result) {
      console.log(err, result);
    });
    ```
    ```javascript
    steem.api.getActiveWitnesses(function(err, result) {
      console.log(err, result);
    });
    ```
    ```javascript
    steem.api.getMinerQueue(function(err, result) {
      console.log(err, result);
    });
    ```
---

### WebSocket

Set WebSocket
<br>

### Subscriptions

Set Subscribe Callback

Set Pending Transaction Callback

Cancel All Subscriptions
<br>

### Tags

Get Trending Tags

Get Discussions By Trending

Get Discussions By Created

Get Discussions By Active

Get Discussions By Cashout

Get Discussions By Payout

Get Discussions By Votes

Get Discussions By Children

Get Discussions By Hot

Get Discussions By Feed

Get Discussions By Blog

Get Discussions By Comments


### Blocks and transactions

Get Block Header

Get Block

Get State

Get Trending Categories

Get Best Categories

Get Active Categories

Get Recent Categories


### Globals

Get Config

Get Dynamic Global Properties

Get Chain Properties

Get Feed History

Get Current Median History Price

Get Hardfork Version

Get Next Scheduled Hardfork

### Keys

Get Key References

### Accounts

Get Accounts

Get Account References

Lookup Account Names

Lookup Accounts

Get Account Count

Get Conversion Requests

Get Account History

Get Owner History

Get Recovery Request

### Market

Get Order Book

Get Open Orders

Get Liquidity Queue


### Authority / Validation

Get Transaction Hex

Get Transaction

Get Required Signatures

Get Potential Signatures

Verify Authority

Verify Account Authority

### Votes

Get Active Votes

Get Account Votes

### Content

Get Content Replies

Get Discussions By Author Before Date

Get Replies By Last Update


### Witnesses


Get Witnesses

Get Witness By Account

Get Witnesses By Vote

Lookup Witness Accounts

Get Witness Count

Get Active Witnesses

Get Miner Queue

