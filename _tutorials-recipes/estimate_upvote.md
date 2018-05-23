---
title: Estimate the value of an upvote
position: 1
description: Calculate the pproximate value of an upvote on Steem
exclude: true
---

# Estimate the value of an upvote

Calculating value of each vote depends on multiple factors. Reward fund, recent claims, account's total vests, rate of the sbd, voting power and weight of the vote.

All of these data is available via available APIs.

1. `get_reward_fund('post')` api call will give us `reward_fund` and `recent_claims`.

2. Next we will need total vests held by account, `get_accounts` api call returns account data, which will hold `vesting_shares`, `received_vesting_shares`, `delegated_vesting_shares`. It also returns current `voting_power` information.

3. Last thing we will need is rate of the get_feed_history, returns `current_median_history` object with `base` element.

After getting all these variables, all we have to do is to add this function

```
total_vests = vesting_shares + received_vesting_shares - delegated_vesting_shares
final_vest = total_vests * 1e6
power = (voting_power * weight / 10000) / 50
rshares = power * final_vest / 10000
estimate = rshares / recent_claims * reward_fund * sbd_median_price
```