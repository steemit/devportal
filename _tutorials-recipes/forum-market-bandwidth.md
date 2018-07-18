---
title: Forum/Market Bandwidth
position: 1
description: How to interpret raw bandwidth data.
exclude: true
layout: full
---

### Intro

We're going over the various API calls needed to determine the remaining bandwidth available to a particular account.  As mentioned in the [STEEM Whitepaper](https://steem.io/steem-whitepaper.pdf):

> Bandwidth used by an individual user should be measured over a suitably long period of time to allow that
user to time-shift their usage. Users tend to login, do many things at once, then logout. This means that
their bandwidth over a short period of time may appear much higher than if viewed over a longer period of
time. If the time window is stretched too far, then the reserve ratio will not adjust fast enough to respond
to short-term surges; conversely, if the window is too short then clustering usage will have too big of an
impact on normal users.

Bandwidth is specific to each account and depends on account activity.

### Sections

1. [Getting Account Bandwidth](#getting-account-bandwidth)
1. [Dynamic Global Properties](#dynamic-global-properties)
1. [Account STEEM Power](#account-steem-power)
1. [Calculate](#calculate)

### Getting Account Bandwidth

```bash
curl -s --data '{
   "jsonrpc":"2.0",
   "method":"condenser_api.get_account_bandwidth",
   "params":[
      "cheetah",
      "forum"
   ],
   "id":1
}' https://api.steemit.com
```

```json
{
   "jsonrpc":"2.0",
   "result":{
      "id":20846,
      "account":"cheetah",
      "type":"forum",
      "average_bandwidth":"7525646416619",
      "lifetime_bandwidth":"386010589000000",
      "last_bandwidth_update":"2018-07-18T16:37:54"
   },
   "id":1
}
```

In this example, we got forum (blogging) average bandwidth of 7,525,646,416,619 with a lifetime bandwidth of 386,010,589,000,000.

Note, `average_bandwidth` is expressed as an integer with six decimal places represented.  Divide by 1,000,000 in order to get the actual bytes of bandwidth, in this case: 7,525,646 bytes.

### Dynamic Global Properties

To do the calculation, we need `max_virtual_bandwidth` and `total_vesting_shares` from the global properties, e.g.:

```bash
curl -s --data '{"jsonrpc":"2.0", "method":"condenser_api.get_dynamic_global_properties", "params":[], "id":1}' https://api.steemit.com
```

```json
{
   "id":1,
   "jsonrpc":"2.0",
   "result":{
      "head_block_number":24264289,
      "head_block_id":"01723e6156ad44ac7bf3028a53a7ac642084cb39",
      "time":"2018-07-17T20:25:27",
      "current_witness":"followbtcnews",
      "total_pow":514415,
      "num_pow_witnesses":172,
      "virtual_supply":"283443693.176 STEEM",
      "current_supply":"271786073.683 STEEM",
      "confidential_supply":"0.000 STEEM",
      "current_sbd_supply":"15504633.926 SBD",
      "confidential_sbd_supply":"0.000 SBD",
      "total_vesting_fund_steem":"193007548.472 STEEM",
      "total_vesting_shares":"391468555319.000697 VESTS",
      "total_reward_fund_steem":"0.000 STEEM",
      "total_reward_shares2":"0",
      "pending_rewarded_vesting_shares":"382967391.274340 VESTS",
      "pending_rewarded_vesting_steem":"187173.234 STEEM",
      "sbd_interest_rate":0,
      "sbd_print_rate":2966,
      "maximum_block_size":65536,
      "current_aslot":24341309,
      "recent_slots_filled":"340282366920938463463374607431768211455",
      "participation_count":128,
      "last_irreversible_block_num":24264271,
      "vote_power_reserve_rate":10,
      "average_block_size":13436,
      "current_reserve_ratio":200000000,
      "max_virtual_bandwidth":"264241152000000000000"
   }
}
```

### Account STEEM Power

We also need to know how much the account has in STEEM Power from `vesting_shares` and `received_vesting_shares`:

```bash
curl -s --data '{"jsonrpc":"2.0", "method":"condenser_api.get_accounts", "params":[["cheetah"]], "id":1}' https://api.steemit.com
```

```json
{
   "jsonrpc":"2.0",
   "result":[
      {
         "id":25796,
         "name":"cheetah",
         "owner":{
            "weight_threshold":1,
            "account_auths":[],
            "key_auths":[["STM7yFmwPSKUP7FCV7Ut9Aev5cwfDzJZixcreS1U3ha36XG47ZpqT", 1]]
         },
         "active":{
            "weight_threshold":1,
            "account_auths":[],
            "key_auths":[["STM7yFmwPSKUP7FCV7Ut9Aev5cwfDzJZixcreS1U3ha36XG47ZpqT", 1]]
         },
         "posting":{
            "weight_threshold":1,
            "account_auths":[["anyx", 100]],
            "key_auths":[["STM5bicRFWhpxnwBymo2HHJv6mFLiaP6AwVVsFEnnVjVcqbvqzvFt", 100], ["STM7yFmwPSKUP7FCV7Ut9Aev5cwfDzJZixcreS1U3ha36XG47ZpqT", 100], ["STM8Jn23vNmBzVuDAgQeZzzR17LmruENmmZmv1ra53tbsBgYbJFwk", 100]]
         },
         "memo_key":"STM7yFmwPSKUP7FCV7Ut9Aev5cwfDzJZixcreS1U3ha36XG47ZpqT",
         "json_metadata":"{\"profile\":{\"profile_image\":\"https:\/\/c1.staticflickr.com\/6\/5739\/22389343016_25d10c52a3_b.jpg\",\"about\":\"I am a robot that automatically finds similar content. Check the website linked to on my blog to learn more about me!\",\"website\":\"http:\/\/steemit.com\/steemit\/@cheetah\/faq-about-cheetah\"}}",
         "proxy":"",
         "last_owner_update":"1970-01-01T00:00:00",
         "last_account_update":"2017-06-13T00:14:00",
         "created":"2016-07-17T08:47:18",
         "mined":true,
         "recovery_account":"steem",
         "last_account_recovery":"1970-01-01T00:00:00",
         "reset_account":"null",
         "comment_count":0,
         "lifetime_vote_count":0,
         "post_count":517808,
         "can_vote":true,
         "voting_power":1249,
         "last_vote_time":"2018-07-18T16:39:21",
         "balance":"118.463 STEEM",
         "savings_balance":"0.000 STEEM",
         "sbd_balance":"67.717 SBD",
         "sbd_seconds":"127094582318",
         "sbd_seconds_last_update":"2018-07-18T14:13:15",
         "sbd_last_interest_payment":"2018-06-20T12:01:15",
         "savings_sbd_balance":"0.000 SBD",
         "savings_sbd_seconds":"0",
         "savings_sbd_seconds_last_update":"1970-01-01T00:00:00",
         "savings_sbd_last_interest_payment":"1970-01-01T00:00:00",
         "savings_withdraw_requests":0,
         "reward_sbd_balance":"0.005 SBD",
         "reward_steem_balance":"0.009 STEEM",
         "reward_vesting_balance":"26.366463 VESTS",
         "reward_vesting_steem":"0.013 STEEM",
         "vesting_shares":"4770940.577823 VESTS",
         "delegated_vesting_shares":"0.000000 VESTS",
         "received_vesting_shares":"16020356.484882 VESTS",
         "vesting_withdraw_rate":"347124.891306 VESTS",
         "next_vesting_withdrawal":"2018-07-21T02:27:09",
         "withdrawn":"1388499565224",
         "to_withdraw":"4512623586985",
         "withdraw_routes":1,
         "curation_rewards":170083,
         "posting_rewards":37433355,
         "proxied_vsf_votes":["50341599736964", "20169963876698", 0, 0],
         "witnesses_voted_for":23,
         "last_post":"2018-07-18T16:39:24",
         "last_root_post":"2018-07-18T07:00:45",
         "average_bandwidth":"7525467544963",
         "lifetime_bandwidth":"386011530000000",
         "last_bandwidth_update":"2018-07-18T16:39:24",
         "average_market_bandwidth":2406616155,
         "lifetime_market_bandwidth":"224370000000",
         "last_market_bandwidth_update":"2018-07-12T04:57:36",
         "vesting_balance":"0.000 STEEM",
         "reputation":"305786119478594",
         "transfer_history":[],
         "market_history":[],
         "post_history":[],
         "vote_history":[],
         "other_history":[],
         "witness_votes":[
            "anyx",
            "arcange",
            "ats-witness",
            "ausbitbank",
            "bitcoiner",
            "blockchained",
            "chitty",
            "drakos",
            "followbtcnews",
            "fubar-bdhr",
            "guiltyparties",
            "liondani",
            "lukestokes.mhth",
            "neoxian",
            "netuoso",
            "noisy.witness",
            "patrice",
            "pfunk",
            "pjau",
            "teamsteem",
            "thecryptodrive",
            "themarkymark",
            "timcliff"
         ],
         "tags_usage":[],
         "guest_bloggers":[]
      }
   ],
   "id":1
}
```

### Calculate

Now, we can derive `bandwidth_allocated`:

`bandwidth_allocated = max_virtual_bandwidth * (vesting_shares + received_vesting_shares) / total_vesting_shares`

`bandwidth_allocated = bandwidth_allocated / 1000000`

In our example, `bandwidth_allocated = 14034118993`.

Now that we have both `bandwidth_allocated` and `average_bandwidth`, we can determine the percentages.

First, we need `average_bandwidth` on the same scale as `bandwidth_allocated`:

`average_bandwidth = average_bandwidth / 1000000`

Then we can get the percentages:

`bandwidth_used = 100 * average_bandwidth / bandwidth_allocated`

`bandwidth_remaining = 100 - (100 * average_bandwidth / bandwidth_allocated)`

We can see that `cheetah` has used `0.053 %` bandwidth and has `99.946 %` remaining as of `last_bandwidth_update`.
