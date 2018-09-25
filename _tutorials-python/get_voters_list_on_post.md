---
title: 'PY: Get Voters List On Post'
position: 6
description: "Voters list and detail of each vote on selected content."
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Get Voters List On Post](https://github.com/steemit/devportal-tutorials-py/tree/master/tutorials/06_get_voters_list_on_post) can be downloaded as part of the [PY tutorials repository](https://github.com/steemit/devportal-tutorials-py).</span>
<br>



Tutorial will explain and show you how to access the **Steem** blockchain using the [steem-python](https://github.com/steemit/steem-python) library to fetch list of posts and get voters info on selected post.

## Intro

Steem python library has built-in function to get active voters information if post with author and permlink as an argument. Since we don't have predefined post or author/permlink. We will fetch post list from previous tutorial and give option to choose one post to get its active voters. `get_active_votes` function fetches list of active voters on content. Note that `get_discussions_by_active` filter is used for fetching 5 posts which by default contains `active_votes` of each post, but for purpose of this tutorial we will use `get_active_votes` function to fetch voters info.

## Steps

1.  [**App setup**](#app-setup) - Library install and import
1.  [**Post list**](#post-list) - List of posts to select from created filter 
1.  [**Voters list**](#voters-list) - Get voters list for selected post
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
    posts = s.get_discussions_by_active(query)

    title = 'Please choose post: '
    options = []
    #posts list options
    for post in posts:
        options.append(post["author"]+'/'+post["permlink"])
    # get index and selected filter name
    option, index = pick(options, title)
```

This will show us list of posts to select in terminal/command prompt. And after selection we will get index and post name to `index` and `option` variables.

#### 3. Voters list <a name="voters-list"></a>

Next we will fetch active votes on selected post with `get_active_votes`. By default `get_discussions_by_active` function already contains `active_votes` list, but for this tutorial purpose we will ignore all other fields but only use `author` and `permlink` fields to fetch voters list.

```python

voters = s.get_active_votes(posts[index]["author"],posts[index]["permlink"])
```


#### 4. Print output <a name="print-output"></a>

Next, we will print result, details of selected post.

```python
    # print voters list for selected post
    pprint.pprint(voters)
    pprint.pprint("Selected: "+option)
```

The example of result returned from the service is a `JSON` object with the following properties:

```json
[{'percent': 100,
  'reputation': '4675452335798',
  'rshares': 174045922,
  'time': '2018-06-13T05:27:06',
  'voter': 'ubg',
  'weight': 663},
 {'percent': 3000,
  'reputation': 0,
  'rshares': '52213408920',
  'time': '2018-06-13T12:53:30',
  'voter': 'warofcraft',
  'weight': 99589},
 {'percent': 10000,
  'reputation': '16976056264304',
  'rshares': '41495494555',
  'time': '2018-06-13T08:56:00',
  'voter': 'jiahn',
  'weight': 80257}
]
'Selected: steemitblog/join-team-steemit-at-tokenfest'
```

From this result you have access to everything associated to the voter including reputation of voter, timestamp, voter's account name, percent and weight of vote, rshares reward shares values that you can be use in further development of application with Python.

That's it!

### To Run the tutorial

1.  [review dev requirements](getting_started)
1.  clone this repo
1.  `cd tutorials/06_get_voters_list`
1.  `pip install -r requirements.txt`
1.  `python index.py`
1.  After a few moments, you should see output in terminal/command prompt screen.



---
