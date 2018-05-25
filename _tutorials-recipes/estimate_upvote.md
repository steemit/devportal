---
title: Estimate the value of an upvote
position: 1
description: Calculate the approximate value of an upvote on Steem
exclude: true
layout: full

---

*By the end of this recipe you should know how to estimate value of each vote on Steem.*

This recipe will take you through the process of fetching necessary data and formulating estimation.

## Intro 

Calculating value of each vote depends on multiple factors. Reward fund, recent claims, account's total vests, rate of the sbd, voting power and weight of the vote. It is quite useful information for users to see and estimate. All of the data is possible to get via available APIs.

## Steps

1. **Get Reward Fund** Current reward fund information is crucial part of estimation
1. **Get Account** Steem power and voting power is another important info
1. **Feed history** To get price rate reported by witnesses
1. **Final calculation** Formulate all information we have


#### 1. Get Reward Fund

Getting Reward Fund information is simply calling `get_reward_fund('post')` api call, it will give us `reward_balance` and `recent_claims`.

The response we're working with will look like:

```json
{
	"id":0,
	"name":"post",
	"reward_balance":"741222.051 STEEM",
	"recent_claims":"457419472820935017",
	"last_update":"2018-05-23T12:08:36",
	"content_constant":"2000000000000",
	"percent_curation_rewards":2500,
	"percent_content_rewards":10000,
	"author_reward_curve":"linear",
	"curation_reward_curve":"square_root"
}
```

#### 2. Get Account

Next we will need total vests held by account, `get_accounts` api call returns account data, which will hold `vesting_shares`, `received_vesting_shares`, `delegated_vesting_shares`. It also returns current `voting_power` information.

The response example will look like:

```json
[
  {
    "id": 9660,
    "name": "steemitblog",
    "owner": {
      "weight_threshold": 1,
      "account_auths": [
        [
          "ned",
          1
        ]
      ],
      "key_auths": [
        [
          "STM65wH1LZ7BfSHcK69SShnqCAH5xdoSZpGkUjmzHJ5GCuxEK9V5G",
          1
        ]
      ]
    },
    "active": {
      "weight_threshold": 1,
      "account_auths": [],
      "key_auths": [
        [
          "STM65wH1LZ7BfSHcK69SShnqCAH5xdoSZpGkUjmzHJ5GCuxEK9V5G",
          1
        ]
      ]
    },
    "posting": {
      "weight_threshold": 1,
      "account_auths": [
        [
          "ned",
          1
        ]
      ],
      "key_auths": [
        [
          "STM4yfYEjUoey4PLrKhnKFo1XKQZtZ77fWLnbGTr2mAUaSt2Sx9W4",
          1
        ],
        [
          "STM5FeHFtL8J453DUi98LKwkqXBH5iwxf9xCqYs6QwPibPru3RNq3",
          1
        ],
        [
          "STM5VwLXkNQf17sQ2XuxScdxruwBy1jak2mDxCjmyfYMNhm1WzPzN",
          1
        ],
        [
          "STM5ke2kzgwBmysSqCNM6zRABi8SNpaJEtnFXuTtRcU3Uvf47481z",
          1
        ]
      ]
    },
    "memo_key": "STM5FeHFtL8J453DUi98LKwkqXBH5iwxf9xCqYs6QwPibPru3RNq3",
    "json_metadata": "",
    "proxy": "",
    "last_owner_update": "2017-03-17T18:19:18",
    "last_account_update": "2017-03-17T18:19:18",
    "created": "2016-05-24T18:54:24",
    "mined": false,
    "recovery_account": "steem",
    "last_account_recovery": "2016-07-19T19:48:54",
    "reset_account": "null",
    "comment_count": 0,
    "lifetime_vote_count": 0,
    "post_count": 154,
    "can_vote": true,
    "voting_power": 9800,
    "last_vote_time": "2018-05-22T20:10:45",
    "balance": "810.371 STEEM",
    "savings_balance": "0.000 STEEM",
    "sbd_balance": "4613.426 SBD",
    "sbd_seconds": "10828300402329",
    "sbd_seconds_last_update": "2018-05-22T22:34:24",
    "sbd_last_interest_payment": "2018-04-25T18:26:15",
    "savings_sbd_balance": "0.000 SBD",
    "savings_sbd_seconds": "0",
    "savings_sbd_seconds_last_update": "1970-01-01T00:00:00",
    "savings_sbd_last_interest_payment": "1970-01-01T00:00:00",
    "savings_withdraw_requests": 0,
    "reward_sbd_balance": "79.490 SBD",
    "reward_steem_balance": "0.000 STEEM",
    "reward_vesting_balance": "608341.169185 VESTS",
    "reward_vesting_steem": "293.101 STEEM",
    "vesting_shares": "93540695.469156 VESTS",
    "delegated_vesting_shares": "0.000000 VESTS",
    "received_vesting_shares": "0.000000 VESTS",
    "vesting_withdraw_rate": "0.000000 VESTS",
    "next_vesting_withdrawal": "1969-12-31T23:59:59",
    "withdrawn": 0,
    "to_withdraw": 0,
    "withdraw_routes": 0,
    "curation_rewards": 10288,
    "posting_rewards": 38917298,
    "proxied_vsf_votes": [
      0,
      0,
      0,
      0
    ],
    "witnesses_voted_for": 0,
    "last_post": "2018-05-22T18:59:33",
    "last_root_post": "2018-05-22T18:59:33",
    "average_bandwidth": "34722906781",
    "lifetime_bandwidth": "656153000000",
    "last_bandwidth_update": "2018-05-22T20:10:45",
    "average_market_bandwidth": 1170000000,
    "lifetime_market_bandwidth": 1170000000,
    "last_market_bandwidth_update": "2016-07-27T15:10:09",
    "vesting_balance": "0.000 STEEM",
    "reputation": "146151592482665",
    "transfer_history": [],
    "market_history": [],
    "post_history": [],
    "vote_history": [],
    "other_history": [],
    "witness_votes": [],
    "tags_usage": [],
    "guest_bloggers": []
  }
]
```



#### 3. Feed history

Last thing we will need is rate of the `get_current_median_history_price`, returns median price rate bucket with `base` element.

The response example will look like:

```json
{
  "base": "3.029 SBD",
  "quote": "1.000 STEEM"
}
```

#### 4. Final calculation

After getting all these variables, all we have to do is to calculate estimation

```
total_vests = vesting_shares + received_vesting_shares - delegated_vesting_shares
final_vest = total_vests * 1e6
power = (voting_power * weight / 10000) / 50
rshares = power * final_vest / 10000
estimate = rshares / recent_claims * reward_balance * sbd_median_price
```

That's all there is to it.