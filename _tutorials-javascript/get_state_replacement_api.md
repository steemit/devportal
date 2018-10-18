---
title: 'JS: Get State Replacement Api'
position: 34
description: "This is a list of replacement API calls for each of the different _routes_ available from the `getState` function."
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Get State Replacement Api](https://github.com/steemit/devportal-tutorials-js/tree/master/tutorials/34_get_state_replacement_api) can be downloaded as part of the [JS tutorials repository](https://github.com/steemit/devportal-tutorials-js).</span>
<br>



## Intro

With the `getState` API call retrieving ALL block information and now being deprecated, a more efficient process is required to call only the dataset that you require for a your specific application. There are a couple different `routes` (data groupings) that can be found within the `getState` function. Each of these will be described and a replacement API call will be discussed.

Included in this single `getState` call is the list of content being requested, the latest Dynamic Global Properties, the latest Account Data for the authors included in the results, and the current feed price. The `getState` function is great in order to get the first 20 posts (and account information based on the post authors) based on the selected tag. If the query field is left empty `getState` automatically calls info based on the `trending` tag. `getState` can also be used to call information for a specific account.

The call `routes` that will be covered are for:

1.  [**accounts**](#accounts)
1.  [**content**](#content)
1.  [**feed_price**](#price)
1.  [**props**](#props)
1.  [**tags**](#tags)
1.  [**tag_idx**](#tagidx)
1.  [**witness_schedule**](#schedule)
1.  [**witnesses**](#witness)

#### Current getState() result:

```json
{
  "current_route": "",
  "props": {
    "head_block_number": 0,
    "head_block_id": "0000000000000000000000000000000000000000",
    "time": "1970-01-01T00:00:00",
    "current_witness": "",
    "total_pow": "18446744073709551615",
    "num_pow_witnesses": 0,
    "virtual_supply": "0.000 STEEM",
    "current_supply": "0.000 STEEM",
    "confidential_supply": "0.000 STEEM",
    "current_sbd_supply": "0.000 STEEM",
    "confidential_sbd_supply": "0.000 STEEM",
    "total_vesting_fund_steem": "0.000 STEEM",
    "total_vesting_shares": "0.000 STEEM",
    "total_reward_fund_steem": "0.000 STEEM",
    "total_reward_shares2": "0",
    "pending_rewarded_vesting_shares": "0.000 STEEM",
    "pending_rewarded_vesting_steem": "0.000 STEEM",
    "sbd_interest_rate": 0,
    "sbd_print_rate": 10000,
    "maximum_block_size": 0,
    "current_aslot": 0,
    "recent_slots_filled": "0",
    "participation_count": 0,
    "last_irreversible_block_num": 0,
    "vote_power_reserve_rate": 40,
    "average_block_size": 0,
    "current_reserve_ratio": 1,
    "max_virtual_bandwidth": "0"
  },
  "tag_idx": {"trending": []},
  "tags": {},
  "content": {},
  "accounts": {},
  "witnesses": {},
  "discussion_idx": {},
  "witness_schedule": {
    "id": 0,
    "current_virtual_time": "0",
    "next_shuffle_block_num": 1,
    "current_shuffled_witnesses": [],
    "num_scheduled_witnesses": 1,
    "top19_weight": 1,
    "timeshare_weight": 5,
    "miner_weight": 1,
    "witness_pay_normalization_factor": 25,
    "median_props": {
      "account_creation_fee": "0.000 STEEM",
      "maximum_block_size": 131072,
      "sbd_interest_rate": 1000
    },
    "majority_version": "0.0.0",
    "max_voted_witnesses": 19,
    "max_miner_witnesses": 1,
    "max_runner_witnesses": 1,
    "hardfork_required_witnesses": 17
  },
  "feed_price": {"base": "0.000 STEEM", "quote": "0.000 STEEM"},
  "error": ""
}
```

## Use cases and data sets

#### Route: getState('accounts')<a name="accounts"></a>

- Purpose: Returns a list of account objects for the top 20 trending post authors or a single account if specified.

- Replacement API call:

```javascript
databaseAPI.getAccounts(['username'])
```

In order to get the full compliment of account information for a specified account, `getAccounts` can be used as in the example above. If you require this information for the top 20 trending authors, you can use the function as per `getState('content')` to retrieve the author names and then get the information per individual. The account information can be used to track balances, vesting, followers, witness votes and pending rewards among others.

- Expected result:

```json
{
  "active": {
    "weight_threshold": 1,
    "account_auths": [],
    "key_auths": []
  },
  "average_bandwidth": 0,
  "average_market_bandwidth": 0,
  "balance": "0.000 STEEM",
  "can_vote": true,
  "comment_count": 0,
  "created": "2016-03-26T08:26:21",
  "curation_rewards": 396530808,
  "delegated_vesting_shares": "505881.492379 VESTS",
  "guest_bloggers": [],
  "id": 340,
  "json_metadata": {"profile":{"name":,"profile_image":}},
  "last_account_recovery": "1970-01-01T00:00:00",
  "last_account_update": "2018-08-30T01:48:15",
  "last_bandwidth_update": "1970-01-01T00:00:00",
  "last_market_bandwidth_update": "1970-01-01T00:00:00",
  "last_owner_update": "2017-11-22T03:58:09",
  "last_post": "2018-09-26T18:32:30",
  "last_root_post": "2018-09-26T16:07:51",
  "last_vote_time": "2018-09-26T16:23:09",
  "lifetime_bandwidth": 0,
  "lifetime_market_bandwidth": 0,
  "lifetime_vote_count": 0,
  "market_history": [],
  "memo_key": "",
  "mined": true,
  "name": "",
  "next_vesting_withdrawal": "1969-12-31T23:59:59",
  "other_history": [],
  "owner": {
    "weight_threshold": 1,
    "account_auths": [],
    "key_auths": []
  },
  "pending_claimed_accounts": 0,
  "post_bandwidth": 10000,
  "post_count": 6289,
  "post_history": [],
  "posting": {
    "weight_threshold": 1,
    "account_auths": [],
    "key_auths": []
  },
  "posting_rewards": 30925563,
  "proxied_vsf_votes": ["1466563679903716", "754759334883", 0, 0],
  "proxy": "",
  "received_vesting_shares": "0.000000 VESTS",
  "recovery_account": "steem",
  "reputation": "",
  "reset_account": "null",
  "reward_sbd_balance": "0.000 SBD",
  "reward_steem_balance": "0.000 STEEM",
  "reward_vesting_balance": "967.889424 VESTS",
  "reward_vesting_steem": "0.479 STEEM",
  "savings_balance": "0.000 STEEM",
  "savings_sbd_balance": "0.000 SBD",
  "savings_sbd_last_interest_payment": "1970-01-01T00:00:00",
  "savings_sbd_seconds": "0",
  "savings_sbd_seconds_last_update": "1970-01-01T00:00:00",
  "savings_withdraw_requests": 0,
  "sbd_balance": "0.000 SBD",
  "sbd_last_interest_payment": "2018-09-08T13:46:15",
  "sbd_seconds": "79984344",
  "sbd_seconds_last_update": "2018-09-26T17:36:15",
  "tags_usage": [],
  "to_withdraw": 0,
  "transfer_history": [],
  "vesting_balance": "0.000 STEEM",
  "vesting_shares": "26772189.757016 VESTS",
  "vesting_withdraw_rate": "0.000000 VESTS",
  "vote_history": [],
  "voting_manabar": {"current_mana": "5514091390534", "last_update_time": 1537978989},
  "voting_power": 2099,
  "withdraw_routes": 0,
  "withdrawn": 0,
  "witness_votes": [],
  "witnesses_voted_for": 24
}
```

#### Route: getState('content')<a name="content"></a>

- Purpose: The `content` in getState calls the top 20 trending posts

- Replacement API call:

```javascript
databaseAPI.call('get_discussions_by_trending',[{limit:20}])
```

While `getState()` truncates the post body at 1024 characters, `getDiscussionsBy` will not truncate the body unless you provide a truncate_body value in the query structure. `getDiscussionsBy` can be executed by trending, created, active, cashout, payout, votes, children, hot, feed, blog or comments. This provides a wide range by which the posts can be called depending on the specific needs. Within the `query` parameter specific tags, filters, authors and permlinks can be provided. The limit can also be increased to a maximum of 100 posts where `getState` is limited to the first 20. You can also refer to the [get post](https://developers.steem.io/tutorials-javascript/get_posts) tutorial for a simplified database call for posts. The detail provided by this statement can be used to track pending payouts, curator rewards and votes for the trending, or specified posts.

- Expected result:

```json
{
  "abs_rshares": "60411661082705",
  "active": "2018-09-26T19:47:15",
  "active_votes": [],
  "allow_curation_rewards": true,
  "allow_replies": true,
  "allow_votes": true,
  "author": "therealwolf",
  "author_reputation": "100096076084764",
  "author_rewards": 0,
  "beneficiaries": [],
  "body": "......",
  "body_length": 4577,
  "cashout_time": "2018-10-02T13:52:24",
  "category": "witness-update",
  "children": 7,
  "children_abs_rshares": "60493226759117",
  "created": "2018-09-25T13:52:24",
  "curator_payout_value": "0.000 SBD",
  "depth": 0,
  "id": 63318715,
  "json_metadata": {"tags":[]},
  "last_payout": "1970-01-01T00:00:00",
  "last_update": "2018-09-26T19:17:33",
  "max_accepted_payout": "100000.000 SBD",
  "max_cashout_time": "1969-12-31T23:59:59",
  "net_rshares": "60411661082705",
  "net_votes": 179,
  "parent_author": "",
  "parent_permlink": "witness-update",
  "pending_payout_value": "80.490 SBD",
  "percent_steem_dollars": 10000,
  "permlink": "witness-essentials-hf20-ready",
  "promoted": "0.000 SBD",
  "reblogged_by": [],
  "replies": [],
  "reward_weight": 10000,
  "root_author": "therealwolf",
  "root_permlink": "witness-essentials-hf20-ready",
  "root_title": "Witness Essentials: HF20 Ready",
  "title": "Witness Essentials: HF20 Ready",
  "total_payout_value": "0.000 SBD",
  "total_pending_payout_value": "0.000 STEEM",
  "total_vote_weight": 7795119,
  "url": "/witness-update/@therealwolf/witness-essentials-hf20-ready",
  "vote_rshares": "60411661082705"
}
  ```

#### Route: getState('feed_price')<a name="price"></a>

- Purpose: The price feed is used by the Steem blockchain when it calculates how many SBD it owes for its author rewards. It is also used to calculate the worth in $US displayed in the wallet. The price feed is the median price feed of the last 3.5 days of all the top 20 witnesses' price feed.

- Replacement API call:

```javascript
databaseAPI.getCurrentMedianHistoryPrice()
```

This provides the same data as `getState` but is executed much faster due to the limited amount of information provided by this function.

- Expected result:

```json
{
  "base": {"amount": 0.887, "symbol": "SBD"},
  "quote": {"amount": 1, "symbol": "STEEM"}
}
```

#### Route: getState('props')<a name="props"></a>

- Purpose: Provides detailed information of the block properties. Block number, witness, current STEEM and SBD supply, pending rewards and total vesting fund and shares among others.

- Replacement API call:

```javascript
//all block info
databaseAPI.getDynamicGlobalProperties()
//head block number only
blockchainAPI.getCurrentBlockNum()
//simple head block info
databaseAPI.getBlock(HeadBlockNum)
```

`getDynamicGlobalProperties()` provides the same level of information and tracks the same values for each created block. You can also call a simplified version of block info containing only the block_id, previous block_id, signing_key, timestamp, witness and witness signature by using the current head block number with the `getBlock` database call.

- Expected result:

```json
{
  "average_block_size":122,
  "confidential_sbd_supply":"0.000 SBD",
  "confidential_supply":"0.000 STEEM",
  "current_aslot":26372251,
  "current_reserve_ratio":200000000,
  "current_sbd_supply":"14921682.900 SBD",
  "current_supply":"277501868.004 STEEM",
  "current_witness":"ausbitbank",
  "delegation_return_period":432000,
  "head_block_id":"0190f89c584661d6ffc78e17395df17ea5653197",
  "head_block_number":26278044,
  "last_irreversible_block_num":26278024,
  "max_virtual_bandwidth":"264241152000000000000",
  "maximum_block_size":65536,
  "num_pow_witnesses":172,
  "participation_count":126,
  "pending_rewarded_vesting_shares":"483834672.069834 VESTS",
  "pending_rewarded_vesting_steem":"237227.812 STEEM",
  "recent_slots_filled":"340282366911034938426725082362930003967",
  "reverse_auction_seconds":900,
  "sbd_interest_rate":0,
  "sbd_print_rate":10000,
  "sbd_start_percent":900,
  "sbd_stop_percent":1000,
  "time":"2018-09-26T08:52:33",
  "total_pow":514415,
  "total_reward_fund_steem":"0.000 STEEM",
  "total_reward_shares2":"0",
  "total_vesting_fund_steem":"196777383.890 STEEM",
  "total_vesting_shares":"397621943253.336916 VESTS",
  "virtual_supply":"294324509.379 STEEM",
  "vote_power_reserve_rate":10
}
```

#### Route: getState('tags')<a name="tags"></a>

- Purpose: Calls a list of trending tags with detailed information on each tag. The list is displayed alphabetically.

- Replacement API call:

```javascript
databaseAPI.call('get_trending_tags',[startingValue, limit])
```

The `getTrendingTags` function calls the same information as with `getState` but can be limited in the number of results. The data on each tag includes the number of votes and comments made with that tag as well as the total payouts for that tag. This is useful to determine which tags are most popular to assist in effective post creation.

- Expected result:

```json
{
  "comments": 31203776,
  "name": "life",
  "net_votes": 54671586,
  "top_posts": 4996200,
  "total_payouts": "61584243.124 SBD",
  "trending": "114450355665"
}
```

#### Route: getState('tag_idx')<a name="tagidx"></a>

- Purpose: Provides a list of names (index) of the current tags (according to trending) available on the blockchain with no additional information.

- Replacement API call:

```javascript
databaseAPI.call('get_trending_tags',[startingValue, limit])
```

This information can be gained by the using the same method as for `getState('tags')` and then only displaying the `name` object of the array of tags provided. You can refer to the tutorial [search tags](https://developers.steem.io/tutorials-javascript/search_tags) for a detailed example of this.

- Expected result:

```json
{
  "life"
  "photography"
  "kr"
  "steemit"
  "bitcoin"
}
```

#### Route: getState('witness_schedule')<a name="schedule"></a>

- Purpose: Calls the current round's schedule. Every round consists of 21 3-second blocks. This includes the top 19 witnesses, a miner witness, and a backup witness. The `current_virtual_time` is used to aid in choosing the next witness. `next_shuffle_block_num` indicates when the current list will be shuffled.

- Replacement API call:

```javascript
//full info
databaseAPI.call('get_witness_schedule',[])
//median props only
databaseAPI.getChainProperties()
```

If required you can also call the `median_props` values as standalone via the second function listed above.

- Expected result:

```json
{
  "account_subsidy_rd": {
    "resource_unit": 10000,
    "budget_per_time_unit": 797,
    "pool_eq": 157691079,
    "max_pool_size": 157691079,
    "decay_params": {},
  },
  "account_subsidy_witness_rd": {
    "resource_unit": 10000,
    "budget_per_time_unit": 996,
    "pool_eq": 9384019,
    "max_pool_size": 9384019,
    "decay_params": {},
  },
  "current_shuffled_witnesses": ["followbtcnews", "good-karma", "smooth.witness", "anyx", "thecryptodrive", "jesta", "utopian-io", "cervantes", "roelandp", "aggroed", "blocktrades", "gtg", "xeldal", "lukestokes.mhth", "someguy123", "pfunk", "ausbitbank", "furion", "curie", "timcliff", "clayop"],
  "current_virtual_time": "376982753287696133965407589",
  "elected_weight": 1,
  "hardfork_required_witnesses": 17,
  "id": 0,
  "majority_version": "0.20.3",
  "max_miner_witnesses": 0,
  "max_runner_witnesses": 1,
  "max_voted_witnesses": 20,
  "median_props": {
    "account_creation_fee": "3.000 STEEM",
    "maximum_block_size": 65536,
    "sbd_interest_rate": 0,
    "account_subsidy_budget": 797,
    "account_subsidy_decay": 347321
  },
  "min_witness_account_subsidy_decay": 0,
  "miner_weight": 1,
  "next_shuffle_block_num": 26313756,
  "num_scheduled_witnesses": 21,
  "timeshare_weight": 5,
  "witness_pay_normalization_factor": 25
}
```

#### Route: getState('witnesses')<a name="witness"></a>

- Purpose: Calls a list of active witnesses with extended details, listed alphabetically

- Replacement API call:

```javascript
databaseAPI.call('get_witnesses_by_vote',['',limit])
```

This detailed information can be used to track the performance of a specific witness when deciding for who to vote or for your own witness statistics. The detail includes the amount of votes, blocks missed and also the SBD exchange rate (feed price) that this witness is reporting. This function calls the info listed according to total votes.

- Expected result:

```json
{
  "available_witness_account_subsidies": 9138354,
  "created": "1970-01-01T00:00:00",
  "hardfork_time_vote": "2018-09-25T15:00:00",
  "hardfork_version_vote": "0.20.0",
  "id": 9493,
  "last_aslot": 26387405,
  "last_confirmed_block_num": 26293189,
  "last_sbd_exchange_update": "2018-09-26T19:54:36",
  "last_work": "0000000048bf77f525731f28db7c1aa9ad853a475ccc78e71ea952a7782e5459",
  "owner": "gtg",
  "pow_worker": 0,
  "props": {
    "account_creation_fee": "3.000 STEEM",
    "maximum_block_size": 65536,
    "sbd_interest_rate": 0,
    "account_subsidy_budget": 797,
    "account_subsidy_decay": 347321
  },
  "running_version": "0.20.3",
  "sbd_exchange_rate": {"base": "0.893 SBD", "quote": "1.000 STEEM"},
  "signing_key": "STM5T98tp8jZRbs7zzyCg74o2siqBw2SXxoYaE1MCuwuCPeQwKrju",
  "total_missed": 535,
  "url": "https://steemit.com/witness-category/@gtg/witness-gtg",
  "virtual_last_update": "376717145948220892034052885",
  "virtual_position": "240558419146717570415939163840356145056",
  "virtual_scheduled_time": "376718433464807443533288610",
  "votes": "77454495589313361"
}
```

### To run this tutorial

1.  clone this repo
1.  `cd tutorials/34_get_state_replacement_api`
1.  `npm i`
1.  `npm run dev-server` or `npm run start`
1.  After a few moments, the server should be running at http://localhost:3000/


---
