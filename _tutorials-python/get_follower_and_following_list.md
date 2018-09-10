---
title: 'PY: Get Follower And Following List'
position: 15
description: 'Tutorial pulls a list of the followers or authors being followed from the blockchain then displays the result.'
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Get Follower And Following List](https://github.com/steemit/devportal-tutorials-py/tree/master/tutorials/15_get_follower_and_following_list) can be downloaded as part of the [PY tutorials repository](https://github.com/steemit/devportal-tutorials-py).</span>
<br>



This tutorial will explain and show you how to access the **Steem** blockchain using the [steem-python](https://github.com/steemit/steem-python) library to fetch list of authors being followed or authors that a specified user is following.

## Intro

We are using the `get_followers` and `get_following` functions that are built into the official library `steem-python`. These functions allow us to query the Steem blockchain in order to retrieve either a list of authors that are being followed or a list of authors that are currently following a specified user. There are 4 parameters required to execute these functions:

1.  _account_ - The specific user for which the follower(ing) list will be retrieved
1.  _start follower(ing)_ - The starting letter(s) or name for the search query. This value can be set as an empty string in order to include all authors starting from "a"
1.  _follow type_ - This value is set to `blog` and includes all users following or being followed by the `user`. This is currently the only valid parameter value for this function to execute correctly.
1.  _limit_ - The maximum number of lines that can be returned by the query

## Steps

1.  [**App setup**](#setup) - Library install and import
1.  [**Input variables**](#input) - Collecting the required inputs via the UI
1.  [**Get followers/following**](#query) Get the followers or users being followed
1.  [**Print output**](#output) - Print results in output

#### 1. App setup <a name="setup"></a>

In this tutorial we use 2 packages, `pick` - helps us to select the query type interactively. `steem` - steem-python library, interaction with Blockchain.

First we import both libraries and initialize Steem class

```python
from pick import pick
from steem import Steem

s = Steem()
```

#### 2. Input variables <a name="input"></a>

We assign two of the variables via a simple input from the UI.

```python
#capture username
username = input("Username: ")

#capture list limit
limit = input("Max number of followers(ing) to display: ")
```

Next we make a list of the two list options available to the user, `following` or `followers` and setup `pick`.

```python
#list type
title = 'Please choose the type of list: '
options = ['Follower', 'Following']

#get index and selected list name
option, index = pick(options, title)
print("List of " + option)
```

This will show the two options as a list to select in terminal/command prompt. From there we can determine which function to execute. We also display the choice on the UI for clarity.

#### 3. Get followers/following <a name="query"></a>

Now that we know which function we will be using, we can form the query to send to the blockchain. The selection is done with a simple `if` statement.

```python
if option=="Follower" :
    follow = s.get_followers(username, '', 'blog', limit)
    # for follower in follow:
    #     lists.append(follower["follower"])
    # print(*lists, sep='\n')
else:
    follow = s.get_following(username, '', 'blog', limit)
    # for following in follow:
    #     lists.append(following["following"])
    # print(*lists, sep='\n')
```

The output is displayed using the same `if` statement and will be discussed in the next step.

#### 4. Print output <a name="output"></a>

Next, we will print the result.

```python
if option=="Follower" :
    # follow = s.get_followers(username, '', 'blog', limit)
    for follower in follow:
        lists.append(follower["follower"])
    print(*lists, sep='\n')
else:
    # follow = s.get_following(username, '', 'blog', limit)
    for following in follow:
        lists.append(following["following"])
    print(*lists, sep='\n')
```

The query returns an array of objects. We use the `for` loop to build a list of only the followers(ing) from that array and then display the list on the UI with line separators. This creates an easy to read list of authors.

We also do a check for when the list is empty to display the proper message.

```python
#check if follower(ing) list is empty
if len(lists) == 0:
    print("No "+option+" information available")
```

This is a fairly simple example of how to use these functions but we encourage you to play around with the parameters to gain further understanding of possible results.

### To Run the tutorial

1.  [review dev requirements](https://github.com/steemit/devportal-tutorials-py/tree/master/tutorials/00_getting_started#dev-requirements)
1.  clone this repo
1.  `cd tutorials/15_get_follower_and_following_list`
1.  `pip install -r requirements.txt`
1.  `python index.py`
1.  After a few moments, you should see output in terminal/command prompt screen.

---
