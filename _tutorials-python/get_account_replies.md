---
title: 'PY: Get Account Replies'
position: 8
description: 'List of replies received by account to its content, post, comment.'
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Get Account Replies](https://github.com/steemit/devportal-tutorials-py/tree/master/tutorials/08_get_account_replies) can be downloaded as part of the [PY tutorials repository](https://github.com/steemit/devportal-tutorials-py).</span>
<br>



Tutorial will explain and show you how to access the **Steem** blockchain using the [steem-python](https://github.com/steemit/steem-python) library to fetch a list of comments made on a specific accounts content.

## Intro

In Steem there are built-in functions in the official library `steem-python` that we are going to use throughout all Python tutorials. For this one we are using the `get_replies` function.

## Steps

1.  [**App setup**](#app-setup) - Library install and import
1.  [**Post list**](#post-list) - List of filters to select from
1.  [**Comment details**](#comment-details) - Form a query
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

Next we will fetch and make a list of posts and setup `pick` properly.

```python
    query = {
        "limit":5, #number of posts
        "tag":"" #tag of posts
    }
    #post list for selected query
    #we are merely using this to display the most recent posters
    #the 'author' can easily be changed to any value within the 'get_replies' function

    posts = s.get_discussions_by_created(query)

    title = 'Please choose author: '
    options = []
    #posts list
    for post in posts:
        options.append(post["author"]+'/'+post["permlink"])
    # get index and selected filter name
    option, index = pick(options, title)
    # option is printed as reference
    pprint.pprint("Selected: "+option)
```

This will show us list of posts to select in terminal/command prompt. And after selection we will get index and post name to `index` and `option` variables. We will also print the selection on screen for easy reference.

#### 3. Comment details <a name="comment-details"></a>

Next we will allocate variables to make the function easier to use as well as provide a limit for the number of replies that we want to print. To retreive the replies we only need the `author` variable. This is then used in the `get_replies` function present in the steem library.

```python
    # allocate variables
    _author = posts[index]["author"]
    _limit = 1

    # get replies for specific author
    details = s.get_replies(_author)
```

#### 4. Print output <a name="print-output"></a>

Next, we will print the details obtained from the function. Because we only want to print a limited number, we input the values in the form of an array.

```python
    # print specified number of comments

    pprint.pprint(details[:_limit])
```

### To Run the tutorial

1.  [review dev requirements](https://github.com/steemit/devportal-tutorials-py/tree/master/tutorials/00_getting_started#dev-requirements)
1.  clone this repo
1.  `cd tutorials/08_get_account_replies`
1.  `pip install -r requirements.txt`
1.  `python index.py`
1.  After a few moments, you should see output in terminal/command prompt screen.
---
