---
title: Calculating RC costs
position: 1
description: How to calculate resource credit cost for transactions.
exclude: true
layout: full
---

Since HF20 a Resource Credit (RC) system has been implemented to manage the number of transactions (comments, votes, transfers, etc) you can execute on the blockchain at any given time. This recipe will look at how to calculate your current RC and also what the current RC cost is for a given transaction. This recipe is far more 'basics oriented' than most. For a more in-depth description of how RC's work consume [this excellent RC demo](https://github.com/steemit/rcdemo) created by Steemit's Blockchain Team.

## Intro

RCs are non-transferable credits that accrue to each Steem account based on how much Steem Power(SP) it has. An account spends RC when it transacts on the Steem blockchain. RCs regenerate over a 5 day period. If an account doesn’t have sufficient credits, the transaction will not be allowed to occur.

The price of a transaction (which consumes a particular resource, or resources) is based on the current stockpile of those resources. As a stockpile of a resource decreases, the RC cost of that resource increases. In other words, as the stockpile goes down, accounts will have to pay more RCs to use the remaining resources. This system disincentivize the over-consumption of resources by users as well as spam.

The RC system uses three measurements to determine how much a transaction should cost in terms of RCs: blockchain size, compute time, and state size. If an transaction is especially expensive in any one of these measurements, then performing that operation will be costly in terms of RCs. It is important to bear in mind that these are objective measurements of resource consumption at the blockchain level, so when something is expensive in RCs, all that means is that performing the action places a high burden on the network relative to other operations.

There are applications available to check an account's status, like [steemd.com](https://steemd.com/@username), but here we will look at how calculate the values manually.

## Calculating available RC

Since RC is calculated relative to SP, we first need to know the available SP before we can calculate how much RC we have left. The value of the current available mana(RC) is also accessible as a field from the `getAccounts` function.

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

A community created library, [beem-python](https://github.com/holgern/beem) offers a solution to calculate the RC costs for a different transaction types. The three main transaction types are: posts/comments, transfers, and vote(on posts). The beem's functions can be executed with no parameters (as seen below) to provide a rough estimate of an average operation.

```python
import beem
from beem.rc import RC

client = beem.Steem()

rc = RC(steem_instance=client)
#beem sets its own rough, default values if you don't pass them in.
print(rc.comment()) #(self, tx_size=1000, permlink_length=10, parent_permlink_length=10)
print(rc.vote()) #(self, tx_size=210)
print(rc.transfer()) #(self, tx_size=290, market_op_count=1)
```

The functions can also be executed for a specific transaction by passing in data for transaction in question. The first step is to calculate the transfer size of the operation which is then used to execute the function to calculate the RC costs.

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

You can find the source for beem's RC class in the [beem github repo](https://github.com/holgern/beem/blob/master/beem/rc.py)
Additional info can also be found in [this article by steem user @holger80](https://steemit.com/utopian-io/@holger80/update-for-beem-adding-rc-costs-calculation-and-witnesssetproperties-broadcasting?sort=new)
