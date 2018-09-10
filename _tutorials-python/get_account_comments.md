---
title: 'PY: Get Account Comments'
position: 9
description: 'Fetch list of comments made by account on posts or comments.'
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Get Account Comments](https://github.com/steemit/devportal-tutorials-py/tree/master/tutorials/09_get_account_comments) can be downloaded as part of the [PY tutorials repository](https://github.com/steemit/devportal-tutorials-py).</span>
<br>



In this tutorial will explain and show you how to access the **Steem** blockchain using the [steem-python](https://github.com/steemit/steem-python) library to fetch list of posts to randomize account list and get replies of selected account.

## Intro

Steem python library has built-in function to get comments list made by specific account. Since we don't have predefined account list, we will fetch newly created posts and show their authors for selection and give option to choose one account to get its comments. `get_discussions_by_comments` function fetches list of comments made by account. Note that `get_discussions_by_created` filter is used for fetching 5 posts and after selection of its author tutorial uses `author` of the post to fetch that account's comments. 

## Steps

1.  [**App setup**](#app-setup) - Library install and import
1.  [**Post list**](#post-list) - List of posts to select from created filter 
1.  [**Comments list**](#comments-list) - Get comments list made by selected account
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


Next we will fetch and make list of accounts and setup `pick` properly.

```python
    query = {
      "limit":5, #number of posts
      "tag":"" #tag of posts
    }
    #author list from created post list to randomize account list
    posts = s.get_discussions_by_created(query)

    title = 'Please choose account: '
    options = []
    #accounts list
    for post in posts:
      options.append(post["author"])

    # get index and selected account name
    option, index = pick(options, title)
```

This will show us list of accounts to select in terminal/command prompt. And after selection we will get account name as a `option` variable.

#### 3. Comments list <a name="comments-list"></a>

Next we will form another query to get comments list of account

```python
  query2 = {
    "limit":5, #number of comments
    "start_author":option #selected user
  }

  # get comments of selected account
  comments = s.get_discussions_by_comments(query2)
```

Note that `start_author` variable in query should be account name so that `get_discussions_by_comments` can provide us corrent information.

#### 4. Print output <a name="print-output"></a>

Next, we will print result, comments of selected account and details of each comment.

```python
  # print comment details for selected account
  pprint.pprint(comments)
  pprint.pprint("Selected: "+option)
```

The example of result returned from the service is a `JSON` object with the following properties:

```json
[{'abs_rshares': 0,
  'active': '2018-06-21T06:48:57',
  'active_votes': [],
  'allow_curation_rewards': True,
  'allow_replies': True,
  'allow_votes': True,
  'author': 'rakibmaruf24',
  'author_reputation': '115387353393',
  'author_rewards': 0,
  'beneficiaries': [],
  'body': "That extra push will take you Back- That's my opinion .",
  'body_length': 55,
  'cashout_time': '2018-06-28T06:48:57',
  'category': 'life',
  'children': 0,
  'children_abs_rshares': 0,
  'created': '2018-06-21T06:48:57',
  'curator_payout_value': '0.000 SBD',
  'depth': 1,
  'id': 53788647,
  'json_metadata': '{"tags":["life"],"app":"steemit/0.1"}',
  'last_payout': '1970-01-01T00:00:00',
  'last_update': '2018-06-21T06:48:57',
  'max_accepted_payout': '1000000.000 SBD',
  'max_cashout_time': '1969-12-31T23:59:59',
  'net_rshares': 0,
  'net_votes': 0,
  'parent_author': 'blazing',
  'parent_permlink': 'that-extra-push-will-take-you-forward',
  'pending_payout_value': '0.000 SBD',
  'percent_steem_dollars': 10000,
  'permlink': 're-blazing-that-extra-push-will-take-you-forward-20180621t064855012z',
  'promoted': '0.000 SBD',
  'reblogged_by': [],
  'replies': [],
  'reward_weight': 10000,
  'root_author': 'blazing',
  'root_permlink': 'that-extra-push-will-take-you-forward',
  'root_title': 'That extra push will take you forward ',
  'title': '',
  'total_payout_value': '0.000 SBD',
  'total_pending_payout_value': '0.000 STEEM',
  'total_vote_weight': 0,
  'url': '/life/@blazing/that-extra-push-will-take-you-forward#@rakibmaruf24/re-blazing-that-extra-push-will-take-you-forward-20180621t064855012z',
  'vote_rshares': 0},
 {'abs_rshares': 0,
  'active': '2018-06-01T18:36:06',
  'active_votes': [{'percent': 200,
                    'reputation': '26818436016691',
                    'rshares': '16086534528',
                    'time': '2018-06-01T21:42:09',
                    'voter': 'gamer00',
                    'weight': 65289},
                   {'percent': 800,
                    'reputation': '7605717819625',
                    'rshares': '7561308944',
                    'time': '2018-06-01T18:44:51',
                    'voter': 'markkujantunen',
                    'weight': 90456}],
  'allow_curation_rewards': True,
  'allow_replies': True,
  'allow_votes': True,
  'author': 'rakibmaruf24',
  'author_reputation': '115387353393',
  'author_rewards': 29,
  'beneficiaries': [],
  'body': "How did it worked ? I don't understand about this brother.",
  'body_length': 58,
  'cashout_time': '1969-12-31T23:59:59',
  'category': 'finland',
  'children': 1,
  'children_abs_rshares': 0,
  'created': '2018-06-01T17:56:15',
  'curator_payout_value': '0.018 SBD',
  'depth': 1,
  'id': 51280699,
  'json_metadata': '{"tags":["finland"],"app":"steemit/0.1"}',
  'last_payout': '2018-06-08T17:56:15',
  'last_update': '2018-06-01T17:56:15',
  'max_accepted_payout': '1000000.000 SBD',
  'max_cashout_time': '1969-12-31T23:59:59',
  'net_rshares': 0,
  'net_votes': 2,
  'parent_author': 'markkujantunen',
  'parent_permlink': 'mein-kampf-gegen-den-loewenzahn-my-struggle-against-dandelions',
  'pending_payout_value': '0.000 SBD',
  'percent_steem_dollars': 10000,
  'permlink': 're-markkujantunen-mein-kampf-gegen-den-loewenzahn-my-struggle-against-dandelions-20180601t175605072z',
  'promoted': '0.000 SBD',
  'reblogged_by': [],
  'replies': [],
  'reward_weight': 10000,
  'root_author': 'markkujantunen',
  'root_permlink': 'mein-kampf-gegen-den-loewenzahn-my-struggle-against-dandelions',
  'root_title': 'Mein Kampf Gegen Den Löwenzahn/My Struggle Against The '
                'Dandelion',
  'title': '',
  'total_payout_value': '0.067 SBD',
  'total_pending_payout_value': '0.000 STEEM',
  'total_vote_weight': 0,
  'url': '/finland/@markkujantunen/mein-kampf-gegen-den-loewenzahn-my-struggle-against-dandelions#@rakibmaruf24/re-markkujantunen-mein-kampf-gegen-den-loewenzahn-my-struggle-against-dandelions-20180601t175605072z',
  'vote_rshares': 0}
]
```

From this result you have access to everything associated to the comments of account including content of comment, timestamp, active_votes, etc., so that you can use in further development of your application with Python.

That's it!

### To Run the tutorial

1.  [review dev requirements](https://github.com/steemit/devportal-tutorials-py/tree/master/tutorials/00_getting_started#dev-requirements)
1.  clone this repo
1.  `cd tutorials/09_get_account_comments`
1.  `pip install -r requirements.txt`
1.  `python index.py`
1.  After a few moments, you should see output in terminal/command prompt screen.


---
