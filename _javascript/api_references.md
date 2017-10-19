---
title: API References
position: 2
right_code: | 
    <p class="right-section-title">WebSocket</p>
    
    `Set WebSocket`
    ``` javascript
    steem.api.setWebSocket(url);
    ```
    
    ```
    `Set Pending Transaction Callback`
    ```javascript
    steem.api.setPendingTransactionCallback(cb, function(err, result) {
      console.log(err, result);
    });
    ```
    `Cancel All Subscriptions`
    ```javascript
    steem.api.cancelAllSubscriptions(function(err, result) {
      console.log(err, result);
    });
    ```

    <p class="right-section-title">Tags</p>
    `Get Trending Tags`
    ```javascript
    steem.api.getTrendingTags(afterTag, limit, function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Discussions By Trending`
    ```javascript
    steem.api.getDiscussionsByTrending(query, function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Discussions By Created`
    ```javascript
    steem.api.getDiscussionsByCreated(query, function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Discussions By Active`
    ```javascript
    steem.api.getDiscussionsByActive(query, function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Discussions By Cashout`
    ```javascript
    steem.api.getDiscussionsByCashout(query, function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Discussions By Payout`
    ```javascript
    steem.api.getDiscussionsByPayout(query, function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Discussions By Votes`
    ```javascript
    steem.api.getDiscussionsByVotes(query, function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Discussions By Children`
    ```javascript
    steem.api.getDiscussionsByChildren(query, function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Discussions By Hot`
    ```javascript
    steem.api.getDiscussionsByHot(query, function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Discussions By Feed`
    ```javascript
    steem.api.getDiscussionsByFeed(query, function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Discussions By Blog`
    ```javascript
    steem.api.getDiscussionsByBlog(query, function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Discussions By Comments`
    ```javascript
    steem.api.getDiscussionsByComments(query, function(err, result) {
      console.log(err, result);
    });
    ```
    <p class="right-section-title">Blocks</p>
    `Get Block Header`
    ```javascript
    steem.api.getBlockHeader(blockNum, function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Block`
    ```javascript
    steem.api.getBlock(blockNum, function(err, result) {
      console.log(err, result);
    });
    ```
    `Get State`
    ```javascript
    steem.api.getState(path, function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Trending Categories`
    ```javascript
    steem.api.getTrendingCategories(after, limit, function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Best Categories`
    ```javascript
    steem.api.getBestCategories(after, limit, function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Active Categories`
    ```javascript
    steem.api.getActiveCategories(after, limit, function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Recent Categories`
    ```javascript
    steem.api.getRecentCategories(after, limit, function(err, result) {
      console.log(err, result);
    });
    ```
    <p class="right-section-title">Globals</p>
    `Get Config`
    ```javascript
    steem.api.getConfig(function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Dynamic Global Properties`
    ```javascript
    steem.api.getDynamicGlobalProperties(function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Chain Properties`
    ```javascript
    steem.api.getChainProperties(function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Feed History`
    ```javascript
    steem.api.getFeedHistory(function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Current Median History Price`
    ```javascript
    steem.api.getCurrentMedianHistoryPrice(function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Hardfork Version`
    ```javascript
    steem.api.getHardforkVersion(function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Next Scheduled Hardfork`
    ```javascript
    steem.api.getNextScheduledHardfork(function(err, result) {
      console.log(err, result);
    });
    ```
    <p class="right-section-title">Keys</p>
    `Get Key References`
    ```javascript
    steem.api.getKeyReferences(key, function(err, result) {
      console.log(err, result);
    });
    ```
    <p class="right-section-title">Accounts</p>
    `Get Accounts`
    ```javascript
    steem.api.getAccounts(names, function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Account References`
    ```javascript
    steem.api.getAccountReferences(accountId, function(err, result) {
      console.log(err, result);
    });
    ```
    `Lookup Account Names`
    ```javascript
    steem.api.lookupAccountNames(accountNames, function(err, result) {
      console.log(err, result);
    });
    ```
    `Lookup Accounts`
    ```javascript
    steem.api.lookupAccounts(lowerBoundName, limit, function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Account Count`
    ```javascript
    steem.api.getAccountCount(function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Conversion Requests`
    ```javascript
    steem.api.getConversionRequests(accountName, function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Account History`
    ```javascript
    steem.api.getAccountHistory(account, from, limit, function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Owner History`
    ```javascript
    steem.api.getOwnerHistory(account, function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Recovery Request`
    ```javascript
    steem.api.getRecoveryRequest(account, function(err, result) {
      console.log(err, result);
    });
    ```
    <p class="right-section-title">Market</p>
    `Get Order Book`
    ```javascript
    steem.api.getOrderBook(limit, function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Open Orders`
    ```javascript
    steem.api.getOpenOrders(owner, function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Liquidity Queue`
    ```javascript
    steem.api.getLiquidityQueue(startAccount, limit, function(err, result) {
      console.log(err, result);
    });
    ```
    
    <p class="right-section-title">Authority</p>
    `Get Transaction Hex`
    ```javascript
    steem.api.getTransactionHex(trx, function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Transaction`
     ```javascript
    steem.api.getTransaction(trxId, function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Required Signatures`
     ```javascript
    steem.api.getRequiredSignatures(trx, availableKeys, function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Potential Signatures`
     ```javascript
    steem.api.getPotentialSignatures(trx, function(err, result) {
      console.log(err, result);
    });
    ```
    `Verify Authority`
     ```javascript
    steem.api.verifyAuthority(trx, function(err, result) {
      console.log(err, result);
    });
    ```
    `Verify Account Authority`
     ```javascript
    steem.api.verifyAccountAuthority(nameOrId, signers, function(err, result) {
      console.log(err, result);
    });
    ```
    <p class="right-section-title">Votes</p>
    `Get Active Votes`
     ```javascript
    steem.api.getActiveVotes(author, permlink, function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Account Votes`
     ```javascript
    steem.api.getAccountVotes(voter, function(err, result) {
      console.log(err, result);
    });
    ```
    <p class="right-section-title">Content</p>
    `Get Content Replies`
     ```javascript
    steem.api.getContentReplies(parent, parentPermlink, function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Discussions By Author Before Date`
     ```javascript
    steem.api.getDiscussionsByAuthorBeforeDate(author, startPermlink, beforeDate, limit, function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Replies By Last Update`
    ```javascript
    steem.api.getRepliesByLastUpdate(startAuthor, startPermlink, limit, function(err, result) {
      console.log(err, result);
    });
    ```
    <p class="right-section-title">Witness</p>
    `Get Witnesses`
    ```javascript
    steem.api.getWitnesses(witnessIds, function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Witness By Account`
    ```javascript
    steem.api.getWitnessByAccount(accountName, function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Witnesses By Vote`
    ```javascript
    steem.api.getWitnessesByVote(from, limit, function(err, result) {
      console.log(err, result);
    });
    ```
    `Lookup Witness Accounts`
    ```javascript
    steem.api.lookupWitnessAccounts(lowerBoundName, limit, function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Witness Count`
    ```javascript
    steem.api.getWitnessCount(function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Active Witnesses`
    ```javascript
    steem.api.getActiveWitnesses(function(err, result) {
      console.log(err, result);
    });
    ```
    `Get Miner Queue`
    ```javascript
    steem.api.getMinerQueue(function(err, result) {
      console.log(err, result);
    });
    ```
---

### WebSocket

Access the Steem websocket API enabling RPC communication with steemd.

### Tags

### Blocks

### Globals

### Keys

### Accounts

### Market

### Authority 

### Votes

### Content

### Witness

