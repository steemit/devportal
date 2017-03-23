---
title: API References
position: 2
---

### WebSocket

#### Set WebSocket
```javascript
steem.api.setWebSocket(url);
```

### Subscriptions

#### Set Subscribe Callback
```javascript
steem.api.setSubscribeCallback(callback, clearFilter, function(err, result) {
  console.log(err, result);
});
```
#### Set Pending Transaction Callback
```javascript
steem.api.setPendingTransactionCallback(cb, function(err, result) {
  console.log(err, result);
});
```
#### Set Block Applied Callback
```javascript
steem.api.setBlockAppliedCallback(cb, function(err, result) {
  console.log(err, result);
});
```
#### Cancel All Subscriptions
```javascript
steem.api.cancelAllSubscriptions(function(err, result) {
  console.log(err, result);
});
```

### Tags

#### Get Trending Tags
```javascript
steem.api.getTrendingTags(afterTag, limit, function(err, result) {
  console.log(err, result);
});
```
#### Get Discussions By Trending
```javascript
steem.api.getDiscussionsByTrending(query, function(err, result) {
  console.log(err, result);
});
```
#### Get Discussions By Created
```javascript
steem.api.getDiscussionsByCreated(query, function(err, result) {
  console.log(err, result);
});
```
#### Get Discussions By Active
```javascript
steem.api.getDiscussionsByActive(query, function(err, result) {
  console.log(err, result);
});
```
#### Get Discussions By Cashout
```javascript
steem.api.getDiscussionsByCashout(query, function(err, result) {
  console.log(err, result);
});
```
#### Get Discussions By Payout
```javascript
steem.api.getDiscussionsByPayout(query, function(err, result) {
  console.log(err, result);
});
```
#### Get Discussions By Votes
```javascript
steem.api.getDiscussionsByVotes(query, function(err, result) {
  console.log(err, result);
});
```
#### Get Discussions By Children
```javascript
steem.api.getDiscussionsByChildren(query, function(err, result) {
  console.log(err, result);
});
```
#### Get Discussions By Hot
```javascript
steem.api.getDiscussionsByHot(query, function(err, result) {
  console.log(err, result);
});
```
#### Get Discussions By Feed
```javascript
steem.api.getDiscussionsByFeed(query, function(err, result) {
  console.log(err, result);
});
```
#### Get Discussions By Blog
```javascript
steem.api.getDiscussionsByBlog(query, function(err, result) {
  console.log(err, result);
});
```
#### Get Discussions By Comments
```javascript
steem.api.getDiscussionsByComments(query, function(err, result) {
  console.log(err, result);
});
```

### Blocks and transactions

#### Get Block Header
```javascript
steem.api.getBlockHeader(blockNum, function(err, result) {
  console.log(err, result);
});
```
#### Get Block
```javascript
steem.api.getBlock(blockNum, function(err, result) {
  console.log(err, result);
});
```
#### Get State
```javascript
steem.api.getState(path, function(err, result) {
  console.log(err, result);
});
```
#### Get Trending Categories
```javascript
steem.api.getTrendingCategories(after, limit, function(err, result) {
  console.log(err, result);
});
```
#### Get Best Categories
```javascript
steem.api.getBestCategories(after, limit, function(err, result) {
  console.log(err, result);
});
```
#### Get Active Categories
```javascript
steem.api.getActiveCategories(after, limit, function(err, result) {
  console.log(err, result);
});
```
#### Get Recent Categories
```javascript
steem.api.getRecentCategories(after, limit, function(err, result) {
  console.log(err, result);
});
```

### Globals

#### Get Config
```javascript
steem.api.getConfig(function(err, result) {
  console.log(err, result);
});
```
#### Get Dynamic Global Properties
```javascript
steem.api.getDynamicGlobalProperties(function(err, result) {
  console.log(err, result);
});
```
#### Get Chain Properties
```javascript
steem.api.getChainProperties(function(err, result) {
  console.log(err, result);
});
```
#### Get Feed History
```javascript
steem.api.getFeedHistory(function(err, result) {
  console.log(err, result);
});
```
#### Get Current Median History Price
```javascript
steem.api.getCurrentMedianHistoryPrice(function(err, result) {
  console.log(err, result);
});
```
#### Get Hardfork Version
```javascript
steem.api.getHardforkVersion(function(err, result) {
  console.log(err, result);
});
```
#### Get Next Scheduled Hardfork
```javascript
steem.api.getNextScheduledHardfork(function(err, result) {
  console.log(err, result);
});
```

### Keys

#### Get Key References
```javascript
steem.api.getKeyReferences(key, function(err, result) {
  console.log(err, result);
});
```

### Accounts

#### Get Accounts
```javascript
steem.api.getAccounts(names, function(err, result) {
  console.log(err, result);
});
```
#### Get Account References
```javascript
steem.api.getAccountReferences(accountId, function(err, result) {
  console.log(err, result);
});
```
#### Lookup Account Names
```javascript
steem.api.lookupAccountNames(accountNames, function(err, result) {
  console.log(err, result);
});
```
#### Lookup Accounts
```javascript
steem.api.lookupAccounts(lowerBoundName, limit, function(err, result) {
  console.log(err, result);
});
```
#### Get Account Count
```javascript
steem.api.getAccountCount(function(err, result) {
  console.log(err, result);
});
```
#### Get Conversion Requests
```javascript
steem.api.getConversionRequests(accountName, function(err, result) {
  console.log(err, result);
});
```
#### Get Account History
```javascript
steem.api.getAccountHistory(account, from, limit, function(err, result) {
  console.log(err, result);
});
```
#### Get Owner History
```javascript
steem.api.getOwnerHistory(account, function(err, result) {
  console.log(err, result);
});
```
#### Get Recovery Request
```javascript
steem.api.getRecoveryRequest(account, function(err, result) {
  console.log(err, result);
});
```

### Market

#### Get Order Book
```javascript
steem.api.getOrderBook(limit, function(err, result) {
  console.log(err, result);
});
```
#### Get Open Orders
```javascript
steem.api.getOpenOrders(owner, function(err, result) {
  console.log(err, result);
});
```
#### Get Liquidity Queue
```javascript
steem.api.getLiquidityQueue(startAccount, limit, function(err, result) {
  console.log(err, result);
});
```

### Authority / validation

#### Get Transaction Hex
```
steem.api.getTransactionHex(trx, function(err, result) {
  console.log(err, result);
});
```
#### Get Transaction
```
steem.api.getTransaction(trxId, function(err, result) {
  console.log(err, result);
});
```
#### Get Required Signatures
```
steem.api.getRequiredSignatures(trx, availableKeys, function(err, result) {
  console.log(err, result);
});
```
#### Get Potential Signatures
```
steem.api.getPotentialSignatures(trx, function(err, result) {
  console.log(err, result);
});
```
#### Verify Authority
```
steem.api.verifyAuthority(trx, function(err, result) {
  console.log(err, result);
});
```
#### Verify Account Authority
```
steem.api.verifyAccountAuthority(nameOrId, signers, function(err, result) {
  console.log(err, result);
});
```

### Votes

#### Get Active Votes
```
steem.api.getActiveVotes(author, permlink, function(err, result) {
  console.log(err, result);
});
```
#### Get Account Votes
```
steem.api.getAccountVotes(voter, function(err, result) {
  console.log(err, result);
});
```

### Content


#### Get Content Replies
```
steem.api.getContentReplies(parent, parentPermlink, function(err, result) {
  console.log(err, result);
});
```
#### Get Discussions By Author Before Date
```
steem.api.getDiscussionsByAuthorBeforeDate(author, startPermlink, beforeDate, limit, function(err, result) {
  console.log(err, result);
});
```
#### Get Replies By Last Update
```
steem.api.getRepliesByLastUpdate(startAuthor, startPermlink, limit, function(err, result) {
  console.log(err, result);
});
```

### Witnesses


#### Get Witnesses
```
steem.api.getWitnesses(witnessIds, function(err, result) {
  console.log(err, result);
});
```
#### Get Witness By Account
```
steem.api.getWitnessByAccount(accountName, function(err, result) {
  console.log(err, result);
});
```
#### Get Witnesses By Vote
```
steem.api.getWitnessesByVote(from, limit, function(err, result) {
  console.log(err, result);
});
```
#### Lookup Witness Accounts
```
steem.api.lookupWitnessAccounts(lowerBoundName, limit, function(err, result) {
  console.log(err, result);
});
```
#### Get Witness Count
```
steem.api.getWitnessCount(function(err, result) {
  console.log(err, result);
});
```
#### Get Active Witnesses
```
steem.api.getActiveWitnesses(function(err, result) {
  console.log(err, result);
});
```
#### Get Miner Queue
```
steem.api.getMinerQueue(function(err, result) {
  console.log(err, result);
});
```

### Login API

#### Login
```
steem.api.login(username, password, function(err, result) {
  console.log(err, result);
});
```
#### Get Api By Name
```
steem.api.getApiByName(apiName, function(err, result) {
  console.log(err, result);
});
```

### Follow API

#### Get Followers
```
steem.api.getFollowers(following, startFollower, followType, limit, function(err, result) {
  console.log(err, result);
});
```
#### Get Following
```
steem.api.getFollowing(follower, startFollowing, followType, limit, function(err, result) {
  console.log(err, result);
});
```
#### Get Follow Count
```
steem.api.getFollowCount(account, function(err, result) {
  console.log(err, result);
});
```

### Broadcast API

#### Broadcast Transaction
```javascript
steem.api.broadcastTransaction(trx, function(err, result) {
  console.log(err, result);
});
```
#### Broadcast Transaction Synchronous
```javascript
steem.api.broadcastTransactionSynchronous(trx, function(err, result) {
  console.log(err, result);
});
```
#### Broadcast Block
```javascript
steem.api.broadcastBlock(b, function(err, result) {
  console.log(err, result);
});
```
#### Broadcast Transaction With Callback
```javascript
steem.api.broadcastTransactionWithCallback(confirmationCallback, trx, function(err, result) {
  console.log(err, result);
});
```
### Broadcast

#### Account Create
```javascript
steem.broadcast.accountCreate(wif, fee, creator, newAccountName, owner, active, posting, memoKey, jsonMetadata, function(err, result) {
  console.log(err, result);
});
```
#### Account Update
```javascript
steem.broadcast.accountUpdate(wif, account, owner, active, posting, memoKey, jsonMetadata, function(err, result) {
  console.log(err, result);
});
```
### Account Witness Proxy
```javascript
steem.broadcast.accountWitnessProxy(wif, account, proxy, function(err, result) {
  console.log(err, result);
});
```
#### Account Witness Vote
```javascript
steem.broadcast.accountWitnessVote(wif, account, witness, approve, function(err, result) {
  console.log(err, result);
});
```
#### Challenge Authority
```javascript
steem.broadcast.challengeAuthority(wif, challenger, challenged, requireOwner, function(err, result) {
  console.log(err, result);
});
```
#### Change Recovery Account
```javascript
steem.broadcast.changeRecoveryAccount(wif, accountToRecover, newRecoveryAccount, extensions, function(err, result) {
  console.log(err, result);
});
```
#### Comment
```javascript
steem.broadcast.comment(wif, parentAuthor, parentPermlink, author, permlink, title, body, jsonMetadata, function(err, result) {
  console.log(err, result);
});
```
#### Comment Options
```javascript
steem.broadcast.commentOptions(wif, author, permlink, maxAcceptedPayout, percentSteemDollars, allowVotes, allowCurationRewards, extensions, function(err, result) {
  console.log(err, result);
});
```
#### Comment Payout
```javascript
steem.broadcast.commentPayout(wif, author, permlink, payout, function(err, result) {
  console.log(err, result);
});
```
#### Comment Reward
```javascript
steem.broadcast.commentReward(wif, author, permlink, sbdPayout, vestingPayout, function(err, result) {
  console.log(err, result);
});
```
#### Convert
```javascript
steem.broadcast.convert(wif, owner, requestid, amount, function(err, result) {
  console.log(err, result);
});
```
#### Curate Reward
```javascript
steem.broadcast.curateReward(wif, curator, reward, commentAuthor, commentPermlink, function(err, result) {
  console.log(err, result);
});
```
#### Custom
```javascript
steem.broadcast.custom(wif, requiredAuths, id, data, function(err, result) {
  console.log(err, result);
});
```
#### Custom Binary
```
steem.broadcast.customBinary(wif, id, data, function(err, result) {
  console.log(err, result);
});
```
#### Custom Json
```javascript
steem.broadcast.customJson(wif, requiredAuths, requiredPostingAuths, id, json, function(err, result) {
  console.log(err, result);
});
```
#### Delete Comment
```javascript
steem.broadcast.deleteComment(wif, author, permlink, function(err, result) {
  console.log(err, result);
});
```
#### Escrow Dispute
```javascript
steem.broadcast.escrowDispute(wif, from, to, agent, who, escrowId, function(err, result) {
  console.log(err, result);
});
```
#### Escrow Release
```javascript
steem.broadcast.escrowRelease(wif, from, to, agent, who, receiver, escrowId, sbdAmount, steemAmount, function(err, result) {
  console.log(err, result);
});
```
#### Escrow Transfer
```javascript
steem.broadcast.escrowTransfer(wif, from, to, agent, escrowId, sbdAmount, steemAmount, fee, ratificationDeadline, escrowExpiration, jsonMeta, function(err, result) {
  console.log(err, result);
});
```
#### Feed Publish
```javascript
steem.broadcast.feedPublish(wif, publisher, exchangeRate, function(err, result) {
  console.log(err, result);
});
```
#### Pow2
```javascript
steem.broadcast.pow2(wif, work, newOwnerKey, props, function(err, result) {
  console.log(err, result);
});
```
#### Fill Convert Request
```javascript
steem.broadcast.fillConvertRequest(wif, owner, requestid, amountIn, amountOut, function(err, result) {
  console.log(err, result);
});
```
#### Fill Order
```javascript
steem.broadcast.fillOrder(wif, currentOwner, currentOrderid, currentPays, openOwner, openOrderid, openPays, function(err, result) {
  console.log(err, result);
});
```
#### Fill Vesting Withdraw
```javascript
steem.broadcast.fillVestingWithdraw(wif, fromAccount, toAccount, withdrawn, deposited, function(err, result) {
  console.log(err, result);
});
```
#### Interest
```javascript
steem.broadcast.interest(wif, owner, interest, function(err, result) {
  console.log(err, result);
});
```
#### Limit Order Cancel
```javascript
steem.broadcast.limitOrderCancel(wif, owner, orderid, function(err, result) {
  console.log(err, result);
});
```
#### Limit Order Create
```javascript
steem.broadcast.limitOrderCreate(wif, owner, orderid, amountToSell, minToReceive, fillOrKill, expiration, function(err, result) {
  console.log(err, result);
});
```
#### Limit Order Create2
```javascript
steem.broadcast.limitOrderCreate2(wif, owner, orderid, amountToSell, exchangeRate, fillOrKill, expiration, function(err, result) {
  console.log(err, result);
});
```
#### Liquidity Reward
```javascript
steem.broadcast.liquidityReward(wif, owner, payout, function(err, result) {
  console.log(err, result);
});
```
#### Pow
```javascript
steem.broadcast.pow(wif, worker, input, signature, work, function(err, result) {
  console.log(err, result);
});
```
#### Prove Authority
```
steem.broadcast.proveAuthority(wif, challenged, requireOwner, function(err, result) {
  console.log(err, result);
});
```
#### Recover Account
```javascript
steem.broadcast.recoverAccount(wif, accountToRecover, newOwnerAuthority, recentOwnerAuthority, extensions, function(err, result) {
  console.log(err, result);
});
```
#### Report Over Production
```javascript
steem.broadcast.reportOverProduction(wif, reporter, firstBlock, secondBlock, function(err, result) {
  console.log(err, result);
});
```
#### Request Account Recovery
```javascript
steem.broadcast.requestAccountRecovery(wif, recoveryAccount, accountToRecover, newOwnerAuthority, extensions, function(err, result) {
  console.log(err, result);
});
```
#### Escrow Approve
```javascript
steem.broadcast.escrowApprove(wif, from, to, agent, who, escrowId, approve, function(err, result) {
  console.log(err, result);
});
```
#### Set Withdraw Vesting Route
```javascript
steem.broadcast.setWithdrawVestingRoute(wif, fromAccount, toAccount, percent, autoVest, function(err, result) {
  console.log(err, result);
});
```
#### Transfer
```javascript
steem.broadcast.transfer(wif, from, to, amount, memo, function(err, result) {
  console.log(err, result);
});
```
#### Transfer To Vesting
```javascript
steem.broadcast.transferToVesting(wif, from, to, amount, function(err, result) {
  console.log(err, result);
});
```
#### Vote
```javascript
steem.broadcast.vote(wif, voter, author, permlink, weight, function(err, result) {
  console.log(err, result);
});
```
#### Withdraw Vesting
```javascript
steem.broadcast.withdrawVesting(wif, account, vestingShares, function(err, result) {
  console.log(err, result);
});
```
#### Witness Update
```javascript
steem.broadcast.witnessUpdate(wif, owner, url, blockSigningKey, props, fee, function(err, result) {
  console.log(err, result);
});
```
#### Fill Vesting Withdraw
```javascript
steem.broadcast.fillVestingWithdraw(wif, fromAccount, toAccount, withdrawn, deposited, function(err, result) {
  console.log(err, result);
});
```
#### Fill Order
```javascript
steem.broadcast.fillOrder(wif, currentOwner, currentOrderid, currentPays, openOwner, openOrderid, openPays, function(err, result) {
  console.log(err, result);
});
```
#### Fill Transfer From Savings
```javascript
steem.broadcast.fillTransferFromSavings(wif, from, to, amount, requestId, memo, function(err, result) {
  console.log(err, result);
});
```
#### Comment Payout
```javascript
steem.broadcast.commentPayout(wif, author, permlink, payout, function(err, result) {
  console.log(err, result);
});
```
#### Transfer To Savings
```javascript
steem.broadcast.transferToSavings(wif, from, to, amount, memo, function(err, result) {
  console.log(err, result);
});
```
#### Transfer From Savings
```javascript
steem.broadcast.transferFromSavings(wif, from, requestId, to, amount, memo, function(err, result) {
  console.log(err, result);
});
```
#### Cancel Transfer From Savings
```javascript
steem.broadcast.cancelTransferFromSavings(wif, from, requestId, function(err, result) {
  console.log(err, result);
});
```

### Auth

#### Verify
```javascript
steem.auth.verify(name, password, auths);
```

#### Generate Keys
```javascript
steem.auth.generateKeys(name, password, roles);
```

#### Get Private Keys
```javascript
steem.auth.getPrivateKeys(name, password, roles);
```

#### Is Wif
```javascript
steem.auth.isWif(privWif);
```

#### To Wif
```javascript
steem.auth.toWif(name, password, role);
```

#### Wif Is Valid
```javascript
steem.auth.wifIsValid(privWif, pubWif);
```

#### Wif To Public
```javascript
steem.auth.wifToPublic(privWif);
```

#### Sign Transaction
```javascript
steem.auth.signTransaction(trx, keys);
``` 