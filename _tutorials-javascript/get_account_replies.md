---
title: 'JS: Get Account Replies'
position: 8
description: "_By the end of this tutorial you would know how to get replies made on particular account's content._"
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Get Account Replies](https://github.com/steemit/devportal-tutorials-js/tree/master/tutorials/08_get_account_replies) can be downloaded as part of the [JS tutorials repository](https://github.com/steemit/devportal-tutorials-js).</span>
<br>



The purpose of this tutorial is **How to get account replies** and **a)** demonstrate how to use `get_state` api function call, and **b)** fetch recent replies for the content of specific account, in this case `@steemitblog`.

We focus on listing part of the content with simply UI as well as explain the most commonly used fields from the response object as well as parse body of each comment.

## Intro

We are using `get_state` function with `dsteem`, which is straight-forward and this function returns current state of the network as well as additional content given proper query. Each content body, as we described in previous tutorials, is written markdown and submitted to the blockchain by many applications built on top of Steem. For that reason we are using `remarkable` npm package to parse markdown in a readable format.

## Steps

1.  [**App setup**](#app-setup) Setup app packages
1.  [**Query result**](#query-result) Form a proper query and retrieve result
1.  [**Display replies**](#display-replies) Parse and display result in user interface

#### 1. App setup<a name="app-setup"></a>

As usual, we have `public/app.js` file which holds the javascript part of the tutorial. In first few lines we define, configure library and packages.

```javascript
const dsteem = require('dsteem');
let opts = {};
//connect to production server
opts.addressPrefix = 'STM';
opts.chainId =
    '0000000000000000000000000000000000000000000000000000000000000000';
//connect to server which is connected to the network/production
const client = new dsteem.Client('https://api.steemit.com');

const Remarkable = require('remarkable');
const md = new Remarkable({ html: true, linkify: true });
```

`dsteem` is pointing to the main network and proper chain_id, addressPrefix and connection server.
`remarkable` is assigned to `md` variable with linkify and html options, allowing markdown parsing links and html properly.

#### 2. Query result<a name="query-result"></a>

Next, we have `main` function which fires when page is loaded.

```javascript
// query string, fetching recent replies for @steemitblog account
const query = '/@steemitblog/recent-replies';

client.database.call('get_state', [query]).then(result => {
    // work with state object
});
```

Query is the path which we want to extract from Steem blockchain state. In our example we are using `@steemitblog` account and `recent-replies` to its content. Result will be current state object with various information as well as `content` object property holding content of the query.

Following is example of returned object:

```json
{
    "current_route":"/@steemitblog/recent-replies",
    "props":{
        "head_block_number":22307429,
        "head_block_id":"01546265c9dc3e761add4c4b652743e3c640fa19",
        "time":"2018-05-10T12:15:30",
        "current_witness":"smooth.witness",
        "total_pow":514415,
        "num_pow_witnesses":172,
        "virtual_supply":"271970374.699 STEEM",
        "current_supply":"268140818.508 STEEM",
        "confidential_supply":"0.000 STEEM",
        "current_sbd_supply":"13342173.771 SBD",
        "confidential_sbd_supply":"0.000 SBD",
        "total_vesting_fund_steem":"191002132.498 STEEM",
        "total_vesting_shares":"388786707656.308148 VESTS",
        "total_reward_fund_steem":"0.000 STEEM",
        "total_reward_shares2":"0",
        "pending_rewarded_vesting_shares":"366359809.533218 VESTS",
        "pending_rewarded_vesting_steem":"178575.754 STEEM",
        "sbd_interest_rate":0,
        "sbd_print_rate":10000,
        "maximum_block_size":65536,
        "current_aslot":22373110,
        "recent_slots_filled":"340282366920938463463374607431768211455",
        "participation_count":128,
        "last_irreversible_block_num":22307411,
        "vote_power_reserve_rate":10,
        "average_block_size":14881,
        "current_reserve_ratio":200000000,
        "max_virtual_bandwidth":"264241152000000000000"
    },
    "tag_idx":{
        "trending":["","life","photography","steemit","kr","introduceyourself","bitcoin","art","travel","cryptocurrency","spanish","food","steem","blog","funny","news","nature","colorchallenge","dtube","indonesia","story","cn","money","music","writing","crypto","contest","busy","health","poetry","meme","video","utopian-io","photo","new","love","blockchain","deutsch","dmania","science","technology","aceh","entertainment","gaming","politics","myanmar","esteem","sports","fun","tr"]
    },
    "tags":{},
    "content":{
        "afm007/afm007-re-steemitblog-devportal-update-3-ux-improvements-more-javascript-tutorials-and-more-20180509t050215510z":{
            "id":47669989,
            "author":"afm007",
            "permlink":"afm007-re-steemitblog-devportal-update-3-ux-improvements-more-javascript-tutorials-and-more-20180509t050215510z",
            "category":"steem",
            "parent_author":"steemitblog",
            "parent_permlink":"devportal-update-3-ux-improvements-more-javascript-tutorials-and-more","title":"","body":"I want to learn the Python language.",
            "json_metadata":"{''}",
            "last_update":"2018-05-09T05:02:15",
            "created":"2018-05-09T05:02:15",
            "active":"2018-05-09T05:02:15",
            "last_payout":"1970-01-01T00:00:00",
            "depth":1,
            "children":0,
            "net_rshares":1057692008,
            "abs_rshares":1057692008,
            "vote_rshares":1057692008,
            "children_abs_rshares":0,
            "cashout_time":"2018-05-16T05:02:15",
            "max_cashout_time":"1969-12-31T23:59:59",
            "total_vote_weight":32523,
            "reward_weight":10000,
            "total_payout_value":"0.000 SBD",
            "curator_payout_value":"0.000 SBD",
            "author_rewards":0,
            "net_votes":1,
            "root_author":"steemitblog",
            "root_permlink":"devportal-update-3-ux-improvements-more-javascript-tutorials-and-more",
            "max_accepted_payout":"1000000.000 SBD",
            "percent_steem_dollars":10000,
            "allow_replies":true,
            "allow_votes":true,
            "allow_curation_rewards":true,
            "beneficiaries":[],
            "url":"/steem/@steemitblog/devportal-update-3-ux-improvements-more-javascript-tutorials-and-more#@afm007/afm007-re-steemitblog-devportal-update-3-ux-improvements-more-javascript-tutorials-and-more-20180509t050215510z",
            "root_title":"DevPortal Update #3: UX Improvements, More Javascript Tutorials and More!",
            "pending_payout_value":"0.005 SBD",
            "total_pending_payout_value":"0.000 STEEM",
            "active_votes":[{"voter":"afm007","weight":17182,"rshares":1057692008,"percent":10000,"reputation":"855556264424","time":"2018-05-09T05:18:06"}],
            "replies":[],
            "author_reputation":"855556264424",
            "promoted":"0.000 SBD",
            "body_length":0,
            "reblogged_by":[]
        },
        "andreina89/re-steemitblog-devportal-update-3-ux-improvements-more-javascript-tutorials-and-more-20180509t045305223z":{
            "id":47669080,
            "author":"andreina89",
            "permlink":"re-steemitblog-devportal-update-3-ux-improvements-more-javascript-tutorials-and-more-20180509t045305223z",
            "category":"steem",
            "parent_author":"steemitblog",
            "parent_permlink":"devportal-update-3-ux-improvements-more-javascript-tutorials-and-more",
            "title":"",
            "body":"Excellent post very interesting friend, thanks",
            "json_metadata":"{\"tags\":[\"steem\"],\"app\":\"steemit/0.1\"}",
            "last_update":"2018-05-09T04:53:21",
            "created":"2018-05-09T04:53:21",
            "active":"2018-05-09T04:53:27",
            "last_payout":"1970-01-01T00:00:00",
            "depth":1,
            "children":1,
            "net_rshares":0,
            "abs_rshares":0,
            "vote_rshares":0,
            "children_abs_rshares":0,
            "cashout_time":"2018-05-16T04:53:21",
            "max_cashout_time":"1969-12-31T23:59:59",
            "total_vote_weight":0,
            "reward_weight":10000,
            "total_payout_value":"0.000 SBD",
            "curator_payout_value":"0.000 SBD",
            "author_rewards":0,
            "net_votes":0,
            "root_author":"steemitblog",
            "root_permlink":"devportal-update-3-ux-improvements-more-javascript-tutorials-and-more",
            "max_accepted_payout":"1000000.000 SBD",
            "percent_steem_dollars":10000,
            "allow_replies":true,
            "allow_votes":true,
            "allow_curation_rewards":true,
            "beneficiaries":[],
            "url":"/steem/@steemitblog/devportal-update-3-ux-improvements-more-javascript-tutorials-and-more#@andreina89/re-steemitblog-devportal-update-3-ux-improvements-more-javascript-tutorials-and-more-20180509t045305223z",
            "root_title":"DevPortal Update #3: UX Improvements, More Javascript Tutorials and More!",
            "pending_payout_value":"0.000 SBD",
            "total_pending_payout_value":"0.000 STEEM",
            "active_votes":[],
            "replies":[],
            "author_reputation":"174938588721",
            "promoted":"0.000 SBD",
            "body_length":0,"reblogged_by":[]
        },
        {"etc.":"etc."}
    },
    "accounts":{
        "afm007/afm007-re-steemitblog-devportal-update-3-ux-improvements-more-javascript-tutorials-and-more-20180509t050215510z":{
            {"etc.":"etc."}
        },
    },
    "witnesses":{},
    "discussion_idx":{},
    "witness_schedule":{
        "id":0,
        "current_virtual_time":"326078326927286190874576091",
        "next_shuffle_block_num":22307439,
        "current_shuffled_witnesses":["furion","someguy123","good-karma","blocktrades","smooth.witness"],
        "num_scheduled_witnesses":21,
        "top19_weight":1,
        "timeshare_weight":5,
        "miner_weight":1,
        "witness_pay_normalization_factor":25,
        "median_props":{
            "account_creation_fee":"0.100 STEEM",
            "maximum_block_size":65536,
            "sbd_interest_rate":0
        },
        "majority_version":"0.19.3",
        "max_voted_witnesses":20,
        "max_miner_witnesses":0,
        "max_runner_witnesses":1,
        "hardfork_required_witnesses":17
    },
    "feed_price":{
        "base":"3.484 SBD",
        "quote":"1.000 STEEM"
    },
    "error":""
}
```

#### 3. Display replies<a name="display-replies"></a>

Next we will format above object properly in simple user interface. From above object, we are only interested in `content` object which holds the data we queried.

```javascript
if (
    !(
        Object.keys(result.content).length === 0 &&
        result.content.constructor === Object
    )
) {
    var replies = [];
    Object.keys(result.content).forEach(key => {
        const reply = result.content[key];
        const author = reply.author;
        const created = new Date(reply.created).toDateString();
        const body = md.render(reply.body);
        const netvotes = reply.net_votes;
        replies.push(
            `<div class="list-group-item list-group-item-action flex-column align-items-start">\
                <div class="d-flex w-100 justify-content-between">\
                  <h5 class="mb-1">@${author}</h5>\
                  <small class="text-muted">${created}</small>\
                </div>\
                <p class="mb-1">${body}</p>\
                <small class="text-muted">&#9650; ${netvotes}</small>\
              </div>`
        );
    });
    document.getElementById('replies').style.display = 'block';
    document.getElementById('replies').innerHTML = replies.join('');
}
```

We check if `content` is not an empty object and we iterate through each object via its key and extract, `author`, format `created` date and time, parse `body` markdown, get `net_votes` on that reply. Pushing each list item separately and displaying it. That's it!

### To Run the tutorial

1.  clone this repo
1.  `cd tutorials/08_get_account_replies`
1.  `npm i`
1.  `npm run dev-server` or `npm run start`
1.  After a few moments, the server should be running at [http://localhost:3000/](http://localhost:3000/)


---
