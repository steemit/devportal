---
title: 'PY: Follow A User'
position: 18
description: "How to follow or unfollow an author using Python."
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Follow A User](https://github.com/steemit/devportal-tutorials-py/tree/master/tutorials/18_follow_a_user) can be downloaded as part of the [PY tutorials repository](https://github.com/steemit/devportal-tutorials-py).</span>
<br>



In this tutorial we will explain and show you how to follow or unfollow any author on the **Steem** blockchain using the `commit` class found within the [steem-python](https://github.com/steemit/steem-python) library.

## Intro

The Steem python library has a built-in function to transmit transactions to the blockchain. We are using the `follow` and `unfollow` methods found within the `commit` class in the the library. Before we can follow/unfollow we first have to check what the current 'follow status' is of the author. We use another function for this which is explained in the tutorial entitled `get_following_and_follower_list`. There are 3 parameters within the `follow/unfollow` methods:

1.  _follow/unfollow_ - The name of the author that will be followed/unfollowed
1.  _what_ - The list of states to be followed. Currently this defaults to `blog` as it's the only option available on the block chain at this stage
1.  _account_ - The name of the account that is executing the follow/unfollow

## Steps

1.  [**App setup**](#setup) - Library install and import. Connection to testnet
1.  [**User information and steem node**](#userinfo) - Input user information and connection to Steem node
1.  [**Check author status**](#authorstat) - Validity check on requested autor to follow
1.  [**Follow status**](#followstat) - Check whether specified author is already followed
1.  [**Follow/Unfollow commit**](#commit) - Follow/unfollow commit to the blockchain

#### 1. App setup <a name="setup"></a>

In this tutorial we use 3 packages:

- `steem` - steem-python library and interaction with Blockchain
- `pick` - helps select the query type interactively

We import the libraries and connect to the `testnet`.

```python
import steembase
import steem
from pick import pick

steembase.chains.known_chains['STEEM'] = {
    'chain_id': '79276aea5d4877d9a25892eaa01b0adf019d3e5cb12a97478df3298ccdd01673',
    'prefix': 'STX', 'steem_symbol': 'STEEM', 'sbd_symbol': 'SBD', 'vests_symbol': 'VESTS'
}
```

Because this tutorial alters the blockchain we connect to the testnet so we don't create spam on the production server.

#### 2. User information and steem node<a name="userinfo"></a>

We also require the `private posting key` of the user that wishes to follow a selected author in order to commit the action to the blockchain. This is why we have to specify this along with the `testnet` node. The values are supplied via the terminal/console before we initialise the steem class. We have supplied a test account, `cdemo` to use with this tutorial but any demo account set up on the testnet can be used.

```python
#capture user information
username = input('Please enter your username: ')
postingkey = input('Please enter your private posting key: ')

#connect node and private posting key, demo account being used: cdemo, posting key: 5JEZ1EiUjFKfsKP32b15Y7jybjvHQPhnvCYZ9BW62H1LDUnMvHz
s = steem.Steem(nodes=['https://testnet.steem.vc'], keys=[postingkey])
```

#### 3. Check author status<a name="authorstat"></a>

To insure the validity of the `follow` process, we first check to see if the `author` provided by the user is in fact an active username. This is done with a simple call to the blockchain which returns an array of all the user information. If the author does not exist, the return value is `null`.

```python
#capture variables
author = input('Author to follow: ')

#check author status
result = s.get_account(author)
```

Once the author name is confirmed to be valid we can move on to check the follow status of that author.

#### 4. Follow status<a name="followstat"></a>

If the author check comes back with a value we use a simple `if` statement to initialise the database query for the follow status. A comprehensive tutorial is available to retrieve a list of followers and users that are being followed in the tutorial specified in the `intro`. As we are only interested in a very specific author we can narrow the query results down to a single result. That result then determines what the available actions are.

```python
#result from previous step
if result :
	#check for author name in the current following list
	follow = s.get_following(username, author, 'blog', 1)
	if len(follow) > 0 and follow[0]['following'] == author :
		title = "Author is already being followed, please choose action"
	else:
		title = "Author has not yet been followed, please choose action"
else:
	print('Author does not exist')
	exit()
```

The result from the `follow` query is printed on the UI and the user is asked to select the next action to take based on that information. If the author does not exit the program exits automatically.

```python
#get index and selected action
options = ['Follow', 'Unfollow', 'Exit']
option, index = pick(options, title)
```

Once we know what the user wants to do, we can move on to the actual `commit` to the blockchain.

#### 5. Follow/Unfollow commit<a name="commit"></a>

Once the user has selected which action to take we user another `if` statement to execute that selection.

```python
if option == 'Follow' :
	s.commit.follow(author, ['blog'], username)
	print(author + ' is now being followed')
else:
	if option == 'Unfollow' :
		s.commit.unfollow(author, ['blog'], username)
		print(author + ' has now been unfollowed')
	else:
		print('Action Cancelled')
```

A simple confirmation of the chosen action is printed on the screen.

You can also check on the [testportal](http://condenser.steem.vc/blog/@cdemo) for a list of the authors being followed by the demo account.

### To Run the tutorial

1.  [review dev requirements](getting_started)
1.  clone this repo
1.  `cd tutorials/18_follow_a_user`
1.  `pip install -r requirements.txt`
1.  `python index.py`
1.  After a few moments, you should see a prompt for input in terminal screen.


---
