---
title: Steemit.com
position: 1
right_code: |
    User object
    ~~~json
    {
      "user": {
        "id": 81544,
        "name": "curie",
        "owner": {
          "weight_threshold": 1,
          "account_auths": [],
          "key_auths": [
            ["STM69WGR1yhUdKrnzwQLDPnXrW9kaAERwHze8Uvtw2ecgRqCEjWxT", 1]
          ]
        },
        "active": {
          "weight_threshold": 1,
          "account_auths": [],
          "key_auths": [
            ["STM5GAbbS84ViMEouJL3LKcM8VZzPejn68AfPaYaLZZDdmy98kwU5", 1]
          ],
          "proxy": "",
          "last_owner_update": "1970-01-01T00:00:00",
          "last_account_update": "2016-12-04T12:47:39",
          "created": "2016-09-02T10:44:24",
          "mined": false,
          "owner_challenged": false,
          "active_challenged": false,
          "last_owner_proved": "1970-01-01T00:00:00",
          "last_active_proved": "1970-01-01T00:00:00",
          "recovery_account": "anonsteem",
          "last_account_recovery": "1970-01-01T00:00:00",
          "reset_account": "null",
          "comment_count": 0,
          "lifetime_vote_count": 0,
          "post_count": 229,
          "can_vote": true,
          "voting_power": 5960,
          "last_vote_time": "2017-02-13T19:21:12",
          "balance": "1577.838 STEEM",
          "savings_balance": "0.000 STEEM",
          "sbd_balance": "0.000 SBD",
          "sbd_seconds": "2918395506",
          "sbd_seconds_last_update": "2017-02-12T15:58:36",
          "sbd_last_interest_payment": "2017-02-05T13:45:09",
          "savings_sbd_balance": "0.000 SBD",
          "savings_sbd_seconds": "0",
          "savings_sbd_seconds_last_update": "1970-01-01T00:00:00",
          "savings_sbd_last_interest_payment": "1970-01-01T00:00:00",
          "savings_withdraw_requests": 0,
          "vesting_shares": "141562477.072664 VESTS",
          "vesting_withdraw_rate": "12897472.658235 VESTS",
          "next_vesting_withdrawal": "2017-02-15T04:53:06",
          "withdrawn": "116077253924115",
          "to_withdraw": "167667144557061",
          "withdraw_routes": 0,
          "curation_rewards": 448416,
          "posting_rewards": 154104841,
          "proxied_vsf_votes": [0, 0, 0, 0, 0, 0, 0, 0],
          "witnesses_voted_for": 1,
          "average_bandwidth": 855531960,
          "lifetime_bandwidth": "10797835000000",
          "last_bandwidth_update": "2017-02-13T19:21:12",
          "average_market_bandwidth": 127424482,
          "last_market_bandwidth_update": "2017-02-12T15:39:57",
          "last_post": "2017-02-13T18:00:51",
          "last_root_post": "2017-02-13T18:00:51",
          "post_bandwidth": 19271,
          "new_average_bandwidth": "370418659068",
          "new_average_market_bandwidth": "93913506382",
          "vesting_balance": "0.000 STEEM",
          "reputation": "330673789878881",
          "transfer_history": [],
          "market_history": [],
          "post_history": [],
          "vote_history": [],
          "other_history": [],
          "witness_votes": ["curie"],
          "tags_usage": [],
          "guest_bloggers": [],
          "blog_category": {}
        },
        "status": "200"
      }
    }
    ~~~

    Post object
    ~~~json
    {
      "post": {
        "id": 1720643,
        "author": "curie",
        "permlink": "the-daily-curie-08-09-jan-2017",
        "category": "curation",
        "parent_author": "",
        "parent_permlink": "curation",
        "title": "The Daily Curie (08-09 Jan 2017)",
        "body": "https://www.steemimg.com/images/2016/09/26/transporency5631977a38.png)</center>
        \n IntroductionCurie](https://steemit.com/steemit/@donkeypong/announcing-project-curie-bringing-rewards-and-recognition-to-steemit-s-undiscovered-and-emerg
        ing-authors) is a community project",
        "last_update": "2017-01-09T12:20:15",
        "created": "2017-01-09T12:20:15",
        "active": "2017-01-11T22:44:57",
        "last_payout": "2017-02-09T14:40:54",
        "depth": 0,
        "children": 36,
        "children_rshares2": "0",
        "net_rshares": 0,
        "abs_rshares": 0,
        "vote_rshares": 0,
        "children_abs_rshares": 0,
        "cashout_time": "1969-12-31T23:59:59",
        "max_cashout_time": "1969-12-31T23:59:59",
        "total_vote_weight": 0,
        "reward_weight": 10000,
        "total_payout_value": "0.000 SBD",
        "curator_payout_value": "0.000 SBD",
        "author_rewards": 0,
        "net_votes": 519,
        "root_comment": 1720643,
        "mode": "archived",
        "max_accepted_payout": "0.000 SBD",
        "percent_steem_dollars": 10000,
        "allow_replies": true,
        "allow_votes": true,
        "allow_curation_rewards": true,
        "url": "/curation/@curie/the-daily-curie-08-09-jan-2017",
        "root_title": "The Daily Curie (08-09 Jan 2017)",
        "pending_payout_value": "0.000 SBD",
        "total_pending_payout_value": "0.000 SBD"
      }
    }
    ~~~
---

#### steemit.com endpoints

Steemit.com offers a few endpoints for getting common data. User profile and post JSON data is very convenient and simple by appending .json
to your request.

Getting a particular user profile JSON:

```
https://steemit.com/@curie.json
```


Getting a particular post JSON:

```
https://steemit.com/curation/@curie/the-daily-curie-12-13-feb-2017.json
```

Example outputs.
