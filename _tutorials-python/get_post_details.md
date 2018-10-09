---
title: 'PY: Get Post Details'
position: 5
description: "Get post details from list of posts from the blockchain with `created` filter and tag then display selected post details."
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Get Post Details](https://github.com/steemit/devportal-tutorials-py/tree/master/tutorials/05_get_post_details) can be downloaded as part of the [PY tutorials repository](https://github.com/steemit/devportal-tutorials-py).</span>
<br>



We will explain and show you how to access the **Steem** blockchain using the [steem-python](https://github.com/steemit/steem-python) library to fetch list of posts filtered by a _filter_ and _tag_

## Intro

Steem python library has built-in function to get details of post with author and permlink as an argument. Since we don't have predefined post or author/permlink. We will fetch post list from previous tutorial and give option to choose one option/post to get its details. `get_content` function fetches latest state of the post and delivers its details. Note that `get_discussions_by_created` filter is used for fetching 5 posts which by default contains details of each post, but for purpose of this tutorial we will showcase `get_content` function to fetch details.

## Steps

1.  [**App setup**](#app-setup) - Library install and import
1.  [**Post list**](#post-list) - List of posts to select from created filter 
1.  [**Post details**](#post-details) - Get post details for selected post
1.  [**Print output**](#print-output) - Print results in output

#### 1. App setup <a name="app-setup"></a>

In this tutorial we use 3 packages, `pick` - helps us to select filter interactively. `steem` - steem-python library, interaction with Blockchain. `pprint` - print results in better format.

First we import all three library and initialize Steem class

```python
    import pprint
    from pick import pick
    # initialize Steem class
    from steem import Steem

    s = Steem()
```

#### 2. Post list <a name="post-list"></a>


Next we will fetch and make list of posts and setup `pick` properly.

```python
    query = {
        "limit":5, #number of posts
        "tag":"" #tag of posts
        }
    #post list for selected query
    posts = s.get_discussions_by_created(query)

    title = 'Please choose post: '
    options = []
    #posts list options
    for post in posts:
        options.append(post["author"]+'/'+post["permlink"])
    # get index and selected filter name
    option, index = pick(options, title)
```

This will show us list of posts to select in terminal/command prompt. And after selection we will get index and post name to `index` and `option` variables.

#### 3. Post details <a name="post-details"></a>

Next we will fetch post details with `get_content`. By default `get_discussions_by_created` function already contains post details, but for this tutorial purpose we will ignore all other fields but only use `author` and `permlink` fields to fetch fresh post details.

```python

details = s.get_content(posts[index]["author"],posts[index]["permlink"])
```


#### 4. Print output <a name="print-output"></a>

Next, we will print result, details of selected post.

```python
    # print post details for selected post
    pprint.pprint(details)
    pprint.pprint("Selected: "+option)
```

The example of result returned from the service is a `JSON` object with the following properties:

```json
{
    "id": 37338948,
    "author": "steemitblog",
    "permlink": "join-team-steemit-at-tokenfest",
    "category": "steemit",
    "parent_author": "",
    "parent_permlink": "steemit",
    "title": "Join Team Steemit at TokenFest!",
    "body":
        "<a href=\"https://tokenfest.adria.digital\"><img src=\"https://i.imgur.com/fOScDIW.png\"/></a>\n\nHello Steemians! If you’d like to meet Team Steemit live-in-person, or are just interested in attending what promises to be a great blockchain conference, join us at <a href=\"https://tokenfest.adria.digital/\">TokenFest</a> in San Francisco from March 15th to 16th. \n\nSteemit CEO, Ned Scott, will be participating in a fireside chat alongside Steemit’s CTO, Harry Schmidt, as well as the creator of Utopian.io, Diego Pucci. Steemit will also be hosting the opening party on Thursday night and we’d certainly love to meet as many of you as possible IRL, so head on over to https://tokenfest.adria.digital/ and get your tickets while you can. \n\n*Team Steemit*",
    "json_metadata":
        "{\"tags\":[\"steemit\",\"tokenfest\",\"conference\"],\"image\":[\"https://i.imgur.com/fOScDIW.png\"],\"links\":[\"https://tokenfest.adria.digital\",\"https://tokenfest.adria.digital/\"],\"app\":\"steemit/0.1\",\"format\":\"markdown\"}",
    "last_update": "2018-03-07T23:22:54",
    "created": "2018-03-07T20:56:36",
    "active": "2018-03-13T01:40:21",
    "last_payout": "1970-01-01T00:00:00",
    "depth": 0,
    "children": 29,
    "net_rshares": "11453442114933",
    "abs_rshares": "11454054795840",
    "vote_rshares": "11454054795840",
    "children_abs_rshares": "13568695606090",
    "cashout_time": "2018-03-14T20:56:36",
    "max_cashout_time": "1969-12-31T23:59:59",
    "total_vote_weight": 3462435,
    "reward_weight": 10000,
    "total_payout_value": "0.000 SBD",
    "curator_payout_value": "0.000 SBD",
    "author_rewards": 0,
    "net_votes": 77,
    "root_comment": 37338948,
    "max_accepted_payout": "0.000 SBD",
    "percent_steem_dollars": 10000,
    "allow_replies": true,
    "allow_votes": true,
    "allow_curation_rewards": true,
    "beneficiaries": [],
    "url": "/steemit/@steemitblog/join-team-steemit-at-tokenfest",
    "root_title": "Join Team Steemit at TokenFest!",
    "pending_payout_value": "46.436 SBD",
    "total_pending_payout_value": "0.000 STEEM",
    "active_votes": [
        {
            "voter": "steemitblog",
            "weight": 0,
            "rshares": "1870813909383",
            "percent": 10000,
            "reputation": "128210130644387",
            "time": "2018-03-07T20:56:36"
        },
        {
            "voter": "kevinwong",
            "weight": 526653,
            "rshares": "2208942520687",
            "percent": 5000,
            "reputation": "374133832002581",
            "time": "2018-03-08T04:27:00"
        }
    ],
    "replies": [],
    "author_reputation": "128210130644387",
    "promoted": "0.000 SBD",
    "body_length": 754,
    "reblogged_by": []
}
'Selected: steemitblog/join-team-steemit-at-tokenfest'
```

From this result you have access to everything associated to the post including additional metadata which is a `JSON` string (that must be decoded to use), `active_votes` info, post title, body, etc. details that can be used in further development of application with Python.

That's it!

### To Run the tutorial

1.  [review dev requirements](getting_started)
1.  clone this repo
1.  `cd tutorials/05_get_post_details`
1.  `pip install -r requirements.txt`
1.  `python index.py`
1.  After a few moments, you should see output in terminal/command prompt screen.



---
