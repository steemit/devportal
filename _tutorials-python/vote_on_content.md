---
title: 'PY: Vote On Content'
position: 18
description: 'How to  vote on a post/comment using Python.'
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Vote On Content](https://github.com/steemit/devportal-tutorials-py/tree/master/tutorials/18_vote_on_content) can be downloaded as part of the [PY tutorials repository](https://github.com/steemit/devportal-tutorials-py).</span>
<br>



In this tutorial we will explain and show you how to to check if a user has voted on specified content and also how to submit a vote on the **Steem** blockchain using the `commit` class found within the [steem-python](https://github.com/steemit/steem-python) library.

## Intro

Voting is a way of promoting good content via an `upvote` or reporting misuse, spam or other unfit content by `downvoting`. The Steem python library has a built-in function to transmit transactions to the blockchain. We are using the `vote` method found within the `commit` class in the the library. Before we vote on content we first check whether the user has already voted. This is not strictly necessary as a voting operation overrides the previous vote value. We use the `get_active_votes` function to check for this. This function only requires two parameters, the `author` and the `permlink` for the comment/post that the query is for. This returns a list of the current voters for that comment. The `vote` function has 3 parameters:

1.  _identifier_ - This is a combination of the author and permink of the post/comment that the vote will be on
1.  _weight_ - This value determines whether the vote is an upvote (+100.0) or a downvote (-100.0) but this value cannot be 0
1.  _username_ - The name of the account that is executing the vote

## Steps

1.  [**App setup**](#setup) - Library install and import. Connection to testnet
1.  [**User information and steem node**](#userinfo) - Input user information and connection to Steem node
1.  [**Check vote status**](#votestat) - Vote status of post/comment
1.  [**Commit vote**](#commit) - Commit vote to the blockchain

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

We also require the `private posting key` of the user that wishes to vote on the selected content so the action can be committed to the blockchain. This is why we have to specify this along with the `testnet` node. The values are supplied via the terminal/console before we initialise the steem class. We have supplied a test account, `cdemo` to use with this tutorial but any account set up on the testnet can be used.

```python
#capture user information
username = input('Please enter your username: ')
postingkey = input('Please enter your private posting key: ')

#connect node and private posting key, demo account name: cdemo, posting key: 5JEZ1EiUjFKfsKP32b15Y7jybjvHQPhnvCYZ9BW62H1LDUnMvHz
s = steem.Steem(nodes=['https://testnet.steem.vc'], keys=[postingkey])
```

#### 3. Check vote status<a name="votestat"></a>

In order to give the user an educated choice we first check whether they have already voted on the given post/comment. The author and permlink for the post is supplied via the console/terminal.
If you need to find something to vote on, you can try (https://condenser.steem.vc/) YMMV.

```python
#capture variables
author = input('Author of post/comment that you wish to vote for: ')
permlink = input('Permlink of the post/comment you wish to vote for: ')
```

The vote status check is done with a simple query to the blockchain.

```python
#check vote status
result = s.get_active_votes(author, permlink)
```

This query returns a list of the current voters on the specified post/comment. The result is checked against the username to determine what the current status is.

```python
if result:
	for vote in result :
		if vote['voter'] == username:
			title = "This post/comment has already been voted for"
			break
		else:
			title = "No vote for this post/comment has been submitted"
else:
	title = "No vote for this post/comment has been submitted"
```

#### 4. Commit vote<a name="commit"></a>

The result from the previous step is used to give the user a choice in what the next step in the operation should be.

```python
#option to continue
options = ['Add/Change vote', 'Cancel voting process']
option, index = pick(options, title)
```

The user is given a choice to either continue with the vote or cancel the operation. If the user elects to continue, the `vote` function is executed. The weight of the vote is input from the UI and the identifier parameter is created by combining the author and permlink values.

*It's important to note that the http client in steem-python will retry **IF** it sends an appbase query and detects a older, non-appbase error*
```python
#voting commit
if option == 'Add/Change vote':
	weight = input('\n'+'Please advise weight of vote between -100.0 and 100 (not zero): ')
	identifier = ('@'+author+'/'+permlink)
	try:
		print('Sending vote. ...')
		s.commit.vote(identifier, float(weight), username)
		print('\n'+'Vote sent.')
	except (RPCErrorRecoverable, RPCError) as err: 
		print('\n'+'Exception encountered. Unable to vote')

else:
	print('Voting has been cancelled')
```

When the function is executed the selected vote weight overrides any value previously recorded on the blockchain.

A simple confirmation of the chosen action is printed on the screen.

### To Run the tutorial

1.  [review dev requirements](https://github.com/steemit/devportal-tutorials-py/tree/master/tutorials/00_getting_started#dev-requirements)
1.  clone this repo
1.  `cd tutorials/18_vote_on_content`
1.  `pip install -r requirements.txt`
1.  `python index.py`
1.  After a few moments, you should see a prompt for input in terminal screen.
---
