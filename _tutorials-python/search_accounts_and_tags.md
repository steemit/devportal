---
title: 'PY: Search Accounts And Tags'
position: 17
description: 'How to pull a list of the active user accounts or trending tags from the blockchain using Python.'
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Search Accounts And Tags](https://github.com/steemit/devportal-tutorials-py/tree/master/tutorials/17_search_accounts_and_tags) can be downloaded as part of the [PY tutorials repository](https://github.com/steemit/devportal-tutorials-py).</span>
<br>



This tutorial will explain and show you how to access the **Steem** blockchain using the [steem-python](https://github.com/steemit/steem-python) library to fetch a list of active authors or trending tags, starting the search from a specified value, and displaying the results on the console.

## Intro

We are using the `lookup_accounts` and `get_trending_tags` functions that are built-in in the official library `steem-python`. These functions allow us to query the Steem blockchain in order to retrieve either a list of active authors or a list of trending tags. The option is available to either get a complete list starting from the first value on the blockchain or starting the list from any other closest match string value as provided by the user. Both of these functions have only two parameters:

1.  _account/aftertag_ - The string value from where to start the search. If this value is left empty the search will start from the first value available
1.  _limit_ - The maximum number of names/tags that the query retrieves

## Steps

1.  [**App setup**](#setup) - Library import and Steem class initialisation
1.  [**List selection**](#list) - Selection of the type of list
1.  [**Get and display account names**](#accounts) - Get a list of account names from the blockchain
1.  [**Get and display trending tags**](#tags) - Get a list of trending tags from the blockchain

#### 1. App setup<a name="setup"></a>

In this tutorial we use 2 packages, `pick` - helps us to select the query type interactively. `steem` - steem-python library for interaction with the Blockchain.

First we import both libraries and initialize Steem class

```python
from steem import Steem
from pick import pick


s = Steem()
```

#### 2. List selection<a name="list"></a>

The user is given the option of which list to create, `active accounts` or `trending tags`. We create this option list and setup `pick`.

```python
#choose list type
title = 'Please select type of list:'
options = ['Active Account names', 'Trending tags']

#get index and selected list name
option, index = pick(options, title)
```

This will show the two options as a list to select in terminal/command prompt. From there we can determine which function to execute.

#### 3. Get and display account names<a name="accounts"></a>

Once the user selects the required list, a simple `if` statement is used to execute the relevant function. Based on the selection we then run the query. The parameters for the `lookup_accounts` function is captured in the `if` statement via the terminal/console.

```python
if option=='Active Account names' :
	#capture starting account
	account = input("Enter account name to start search from: ")
	#input list limit
	limit = input("Enter max number of accounts to display: ")
	lists = s.lookup_accounts(account, limit)
	print('\n' + "List of " + option + '\n')
	print(*lists, sep='\n')
```

Once the list is generated it is displayed on the UI with line separators along with a heading of what list it is.

#### 4. Get and display trending tags<a name="tags"></a>

The query for a list of trending tags is executed in the second part of the `if` statement. Again, the parameters for the query is captured via the terminal/console.

```python
else :
	#capture starting tag
	aftertag = input("Enter tag name to start search from: ")
	#capture list limit
	limit = input("Enter max number of tags to display: ")
	lists = s.get_trending_tags(aftertag, limit)
	print('\n' + "List of " + option + '\n')
	for names in lists :
		print(names["name"])
```

The query returns an array of objects. We use the `for` loop to build a list of only the tag `names` from that array and then display the list on the UI with line separators. This creates an easy to read list of tags.

That's it!.

### To Run the tutorial

1.  [review dev requirements](https://github.com/steemit/devportal-tutorials-py/tree/master/tutorials/00_getting_started#dev-requirements)
1.  clone this repo
1.  `cd tutorials/17_get_follower_and_following_list`
1.  `pip install -r requirements.txt`
1.  `python index.py`
1.  After a few moments, you should see output in terminal/command prompt screen.

---
