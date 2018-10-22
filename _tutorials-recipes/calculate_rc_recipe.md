---
title: Calculating RC costs
position: 1
description: How to calculate resource credit cost for transactions.
exclude: true
layout: full
---

Since HF20 a resource credit (RC) system has been implemented to manage the amount of transactions (comments, votes, transfers, etc) you can process on the blockchain at any given time. This recipe will look at how to calculate your remaining RC and also what the various RC costs are.

## Intro

The most important thing to understand about RCs is that they are non-transferable credits given to each account based on how much Steem Power it has, which get “spent” whenever a user transacts with the Steem blockchain. Of course, if RCs did not replenish over time, then eventually everyone would become unable to transact at some point. For that reason, RCs regenerate over a 5 day period. If an account doesn’t have sufficient credits, the transaction will not be allowed to occur.

The price of each resource is based on the current level of the stockpile. As the stockpile decreases, the price of that resource (in terms of RCs) increases. In other words, as the stockpile goes down, accounts will have to pay more RCs to use the remaining resources. This system disincentivize the over-consumption of resources by users as well as spam.

The RC system uses three measurements to determine how much an operation should cost in terms of RCs: blockchain size, compute time, and state size. If an operation is especially expensive in any one of these measurements, then performing that operation will be costly in terms of RCs. It is important to bear in mind that these are objective measurements of resource consumption at the blockchain level, so when something is expensive in RCs, all that means is that performing the action places a high burden on the network relative to other operations.

There are applications available to check an accounts status, like [steemd.com](https://steemd.com/@username), but here we will look at how calculate the values manually.

## Calculating available RC

Since RC is calculated relative to Steem Power, we first need to know the available SP before we can calculate how much RC we have left. The value of the current available mana(RC) is also accessible as a field from the `getAccounts` function.

```javascript
//capture account
var _account = await client.database.getAccounts(['username'])
var account = _account[0]
var props = await client.database.getDynamicGlobalProperties()
var CURRENT_UNIX_TIMESTAMP = parseInt((new Date(props.time).getTime() / 1000).toFixed(0))
//calculate available SP
var totalShares = parseFloat(account.vesting_shares) + parseFloat(account.received_vesting_shares) - parseFloat(account.delegated_vesting_shares);
//determine elapsed time since last RC update
var elapsed = CURRENT_UNIX_TIMESTAMP - account.voting_manabar.last_update_time;
var maxMana = totalShares * 1000000;
//calculate current mana for the 5 day period (432000 sec = 5 days)
var currentMana = parseFloat(account.voting_manabar.current_mana) + elapsed * maxMana / 432000;

if (currentMana > maxMana) {
    currentMana = maxMana;
}
//determine percentage of available mana(RC)
var currentManaPerc = currentMana * 100 / maxMana;
    
console.log(currentManaPerc);
```

The beem-python library offers a solution to calculate the RC costs for a specific operation. The three main operations being posts/comments, transfers and voting on posts. The functions can be executed with the default parameter values (as seen below) to provide an estimate of an average operation.

```python
import beem
from beem.rc import RC

client = beem.Steem()

rc = RC(steem_instance=client)
print(rc.comment()) #(self, tx_size=1000, permlink_length=10, parent_permlink_length=10)
print(rc.vote()) #(self, tx_size=210)
print(rc.transfer()) #(self, tx_size=290, market_op_count=1)
```

The functions can also be executed for a specific operation by replacing the default parameter values with the specific vote/transfer/etc in question. The first step is to calculate the transfer size of the operation which is then used to execute the function to calculate the RC costs.

```python
opdata = {
    'voter': 'steemit',
    'author': 'r1s2g3',
    'permlink': 'rc-calculations-according-to-your-need-part-1',
    'weight': 100
}
#create operation to check
op = beembase.operations.Vote(opdata)
#check vote transaction size
vote_tx = rc.get_tx_size(op)
print(vote_tx)
#check vote RC cost
print(rc.vote(vote_tx))
```

The full RC class in beem can be viewed at [beem-python](https://github.com/holgern/beem/blob/master/beem/rc.py)
Additional info can also be found in [this article](https://steemit.com/utopian-io/@holger80/update-for-beem-adding-rc-costs-calculation-and-witnesssetproperties-broadcasting?sort=new)