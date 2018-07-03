---
title: Steemit.com
position: 1
---

#### steemit.com endpoints

Steemit.com offers a few endpoints for getting common data. User profile and post JSON data is very convenient and simple by appending .json
to your request. 

Getting a particular user profile JSON:

```
https://steemit.com/@curie.json
```

User object
```json
{
   "user":{
      "id":81544,
      "name":"curie",
      "owner":{
         "weight_threshold":1,
         "account_auths":[],
         "key_auths":[["STM69WGR1yhUdKrnzwQLDPnXrW9kaAERwHze8Uvtw2ecgRqCEjWxT", 1]]
      },
      "active":{
         "weight_threshold":1,
         "account_auths":[],
         "key_auths":[["STM5GAbbS84ViMEouJL3LKcM8VZzPejn68AfPaYaLZZDdmy98kwU5", 1]]
      },
      "posting":{
         "weight_threshold":1,
         "account_auths":[["steemauto", 1]],
         "key_auths":[["STM5cmuKw6EPkZWeVNXcZorKtattZTX5wSopcRb4xNe6VhRKjETgv", 1]]
      },
      "memo_key":"STM7ZBi61xYz1b9STE1PHcAraPXJbvafzge3AcPjcfeq4XkKtM2At",
      "json_metadata":{
         "profile":{
            "profile_image":"https://i.imgur.com/Mjewc66.jpg",
            "name":"Curie",
            "about":"Discovering exceptional content. ",
            "location":"Worldwide",
            "website":"http://curiesteem.com"
         }
      },
      "proxy":"",
      "last_owner_update":"1970-01-01T00:00:00",
      "last_account_update":"2018-02-28T14:21:24",
      "created":"2016-09-02T10:44:24",
      "mined":false,
      "recovery_account":"anonsteem",
      "last_account_recovery":"1970-01-01T00:00:00",
      "reset_account":"null",
      "comment_count":0,
      "lifetime_vote_count":0,
      "post_count":1042,
      "can_vote":true,
      "voting_power":8927,
      "last_vote_time":"2018-06-21T19:42:33",
      "balance":"24.519 STEEM",
      "savings_balance":"0.000 STEEM",
      "sbd_balance":"36.736 SBD",
      "sbd_seconds":"11732264931",
      "sbd_seconds_last_update":"2018-06-21T19:35:00",
      "sbd_last_interest_payment":"2018-06-15T14:05:03",
      "savings_sbd_balance":"0.000 SBD",
      "savings_sbd_seconds":"0",
      "savings_sbd_seconds_last_update":"1970-01-01T00:00:00",
      "savings_sbd_last_interest_payment":"1970-01-01T00:00:00",
      "savings_withdraw_requests":0,
      "reward_sbd_balance":"0.000 SBD",
      "reward_steem_balance":"0.000 STEEM",
      "reward_vesting_balance":"481.354811 VESTS",
      "reward_vesting_steem":"0.237 STEEM",
      "vesting_shares":"128367480.795804 VESTS",
      "delegated_vesting_shares":"0.000000 VESTS",
      "received_vesting_shares":"17069919.621493 VESTS",
      "vesting_withdraw_rate":"9672265.370398 VESTS",
      "next_vesting_withdrawal":"2018-06-24T14:01:51",
      "withdrawn":0,
      "to_withdraw":"125739449815180",
      "withdraw_routes":0,
      "curation_rewards":79730650,
      "posting_rewards":168964559,
      "proxied_vsf_votes":["1753316906111", 0, 0, 0],
      "witnesses_voted_for":1,
      "last_post":"2018-06-21T18:06:57",
      "last_root_post":"2018-06-19T13:16:15",
      "average_bandwidth":"540385456623",
      "lifetime_bandwidth":"33717478000000",
      "last_bandwidth_update":"2018-06-21T19:42:33",
      "average_market_bandwidth":"83841450748",
      "lifetime_market_bandwidth":"8042800000000",
      "last_market_bandwidth_update":"2018-06-19T04:21:42",
      "vesting_balance":"0.000 STEEM",
      "reputation":"418378051905700",
      "transfer_history":[],
      "market_history":[],
      "post_history":[],
      "vote_history":[],
      "other_history":[],
      "witness_votes":["curie"],
      "tags_usage":[],
      "guest_bloggers":[]
   },
   "status":"200"
}
```

Getting a particular post JSON:

```
https://steemit.com/curation/@curie/the-daily-curie-12-13-feb-2017.json
```

Post object
```json
{
   "post":{
      "id":1720643,
      "author":"curie",
      "permlink":"the-daily-curie-08-09-jan-2017",
      "category":"curation",
      "parent_author":"",
      "parent_permlink":"curation",
      "title":"The Daily Curie (08-09 Jan 2017)",
      "body":"<center>https://s29.postimg.org/dgtsfe7if/curie2.png</center>\n## Introduction\n[Curie](https://steemit.com/steemit/@donkeypong/announcing-project-curie-bringing-rewards-and-recognition-to-steemit-s-undiscovered-and-emerging-authors)  is a commu ...",
      "last_update":"2017-01-09T12:20:15",
      "created":"2017-01-09T12:20:15",
      "active":"2017-01-11T22:44:57",
      "last_payout":"2017-02-09T14:40:54",
      "depth":0,
      "children":36,
      "children_rshares2":"0",
      "net_rshares":0,
      "abs_rshares":0,
      "vote_rshares":0,
      "children_abs_rshares":0,
      "cashout_time":"1969-12-31T23:59:59",
      "max_cashout_time":"1969-12-31T23:59:59",
      "total_vote_weight":0,
      "reward_weight":10000,
      "total_payout_value":"0.000 SBD",
      "curator_payout_value":"0.000 SBD",
      "author_rewards":0,
      "net_votes":519,
      "root_comment":1720643,
      "mode":"archived",
      "max_accepted_payout":"0.000 SBD",
      "percent_steem_dollars":10000,
      "allow_replies":true,
      "allow_votes":true,
      "allow_curation_rewards":true,
      "url":"/curation/@curie/the-daily-curie-08-09-jan-2017",
      "root_title":"The Daily Curie (08-09 Jan 2017)",
      "pending_payout_value":"0.000 SBD",
      "total_pending_payout_value":"0.000 SBD"
   }
}
```
