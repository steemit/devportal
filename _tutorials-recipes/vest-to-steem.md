---
title: Converting VESTS to STEEM
position: 1
description: How to convert VESTS to STEEM or STEEM POWER
exclude: true
layout: full
---

### Intro

Steem's has base unit is VESTS and usually user doesn't know about this unit because everything is dynamically calucated and presented in STEEM form for convenience of the user. In this recipe we will talk about how converting is working behind the scenes on all Steem apps. Dynamic Global Properties are used in this recipe to fetch the current values of global blockchain properties.

## Steps

1. [**Get Dynamic Global Properties**](#get-global) Fetch current values of global blockchain properties
1. [**Formulate VESTS_TO_STEEM**](#formula) Formulate function that will convert given VESTS to STEEM.    


#### 1. Get Dynamic Global Properties <a name="get-global"></a>

Following method can be used to fetch global values

```bash
curl -s --data '{"jsonrpc":"2.0", "method":"condenser_api.get_dynamic_global_properties", "params":[], "id":1}' https://api.steemit.com
```

##### Example Output<a style="float: right" href="#steps"><i class="fas fa-chevron-up fa-sm" /></a>

```json
{
   "id":1,
   "jsonrpc":"2.0",
   "result":{
      "head_block_number":24238248,
      "head_block_id":"0171d8a833dc369abd034b0c67d8725f96df9e5b",
      "time":"2018-07-16T22:41:24",
      "current_witness":"xeldal",
      "total_pow":514415,
      "num_pow_witnesses":172,
      "virtual_supply":"283434761.199 STEEM",
      "current_supply":"271729171.190 STEEM",
      "confidential_supply":"0.000 STEEM",
      "current_sbd_supply":"15498201.173 SBD",
      "confidential_sbd_supply":"0.000 SBD",
      "total_vesting_fund_steem":"192913644.627 STEEM",
      "total_vesting_shares":"391296886352.617261 VESTS",
      "total_reward_fund_steem":"0.000 STEEM",
      "total_reward_shares2":"0",
      "pending_rewarded_vesting_shares":"379159224.860656 VESTS",
      "pending_rewarded_vesting_steem":"185294.019 STEEM",
      "sbd_interest_rate":0,
      "sbd_print_rate":2933,
      "maximum_block_size":65536,
      "current_aslot":24315228,
      "recent_slots_filled":"340282366920938463463374607431768211400",
      "participation_count":128,
      "last_irreversible_block_num":24238230,
      "vote_power_reserve_rate":10,
      "average_block_size":10950,
      "current_reserve_ratio":200000000,
      "max_virtual_bandwidth":"264241152000000000000"
   }
}
```

#### 2. Formulate VESTS_TO_STEEM <a name="formula"></a><a style="float: right" href="#steps"><i class="fas fa-chevron-up fa-sm" /></a>

From above results we have everything we need to calculate STEEM from given VESTS value.

Let's say we have been given `availableVESTS` variable, value in VESTS and we want to convert that to STEEM. By using values from above returned object our formula would be as follows:

```
vestSteem = ( result.total_vesting_fund_steem x availableVESTS ) / result.total_vesting_shares
```

That's it!
