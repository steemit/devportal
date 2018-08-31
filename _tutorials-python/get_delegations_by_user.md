---
title: 'PY: Get Delegations By User'
position: 29
description: 'How to get a list of active or expiring vesting delegations using Python.'
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Get Delegations By User](https://github.com/steemit/devportal-tutorials-py/tree/master/tutorials/29_get_delegations_by_user) can be downloaded as part of the [PY tutorials repository](https://github.com/steemit/devportal-tutorials-py).</span>
<br>



In this tutorial we will explain and show you how to pull a list of both active and expiring vesting delegations from the **Steem** blockchain using the `steem` class found within the [steem-python](https://github.com/steemit/steem-python) library.

## Intro

The Steem python library has a built-in function to pull information from the blockchain. We are using the `get_vesting_delegations` and `get_expiring_vesting_delegations` methods found within the `steem` class in the library. Each of these functions are executed separately. It should be noted that when a delegation is cancelled the VESTS will only be available again after 7 days. The value of the delegation can also be changed at any time, either decreased or increased. To get active delegations we need the following parameters:

1.  _account_ - The user account that the delegation list is being queried for
1.  _from-account_ - The account name from where to start the search. This parameter can be left empty to pull a list from the first delegatee
1.  _limit_ - The maximum amount of delegations that will be returned by the query

The function to query the expiring delegations use the the same parameters except that the `start_account` is replaced by a `start_date`. If this value is greater than 7 days from present, it will always include all delegations that are pending expiration.

## Steps

1.  [**App setup**](#setup) - Library install and import. Connection to production
1.  [**User input**](#input) - Input user and limit parameters
1.  [**Delegation lists**](#query) - Selection of the type of list and blockchain query

#### 1. App setup <a name="setup"></a>

In this tutorial we use 2 package:

- `steem` - steem-python library and interaction with Blockchain
- `pick` - helps select the query type interactively

We import the libraries and connect to the `production` server.

```python
from pick import pick
from steem import Steem

import pprint

client = Steem()
```

`pprint` is used to print the query results in an easier to read format

#### 2. User input <a name="input"></a>

The `account` and `limit` parameters are assigned via input from the console/terminal. We also check if the username provided does in fact exist on the blockchain using the `get_account` method also found within the `steem` class. This will return an null value if the name does not exist.

```python
#capture username
username = input('Username: ')

#check username
result = client.get_account(username)
if not result:
	print('Invalid username')
	exit()

#capture list limit
limit = input('Max number of vesting delegations to display: ')
```

#### 3. Delegation lists <a name="query"></a>

We use two different functions to query active and expiring delegations, so the user is given a choice on which of these lists he wants to view.

```python
#list type
title = 'Please choose the type of list: '
options = ['Active Vesting Delegations', 'Expiring Vesting Delegations']

#get index and selected list name
option, index = pick(options, title)
print('\n' + 'List of ' + option + ': ' + '\n')
```

Based on the result of the choice, the relevant blockchain query is executed and the result of the query displayed on the console/terminal.

```python
if option=='Active Vesting Delegations' :
    #active delegations
	delegations = client.get_vesting_delegations(username, '', limit)
	if len(delegations) == 0:
		print('No ' + option)
	else:
		pprint.pprint(delegations)
else:
    #expiring delegations
	delegations = client.get_expiring_vesting_delegations(username, "2018-01-01T00:00:00", limit)
	if len(delegations) == 0:
		print('No ' + option)
	else:
		pprint.pprint(delegations)
```

For both the queries the starting points were defined in such a way as to include all available data but this can be changed depending on the user requirements.

That's it!

### To Run the tutorial

1.  [review dev requirements](https://github.com/steemit/devportal-tutorials-py/tree/master/tutorials/00_getting_started#dev-requirements)
1.  clone this repo
1.  `cd tutorials/29_get_delegations_by_user`
1.  `pip install -r requirements.txt`
1.  `python index.py`
1.  After a few moments, you should see a prompt for input in terminal screen.

---
