---
title: 'PY: Witness Listing And Voting'
position: 22
description: "How to vote for or remove a vote for a witness user using Python."
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Witness Listing And Voting](https://github.com/steemit/devportal-tutorials-py/tree/master/tutorials/22_witness_listing_and_voting) can be downloaded as part of the [PY tutorials repository](https://github.com/steemit/devportal-tutorials-py).</span>
<br>



In this tutorial we show you how to create a list of active witnesses from the **Steem** blockchain and then vote or unvote for a witness using the `commit` class found within the [steem-python](https://github.com/steemit/steem-python) library.

## Intro

The Steem python library has a built-in function to transmit transactions to the blockchain. We are using the `approve_witness` and `disapprove_witness` method found within the `commit` class in the library. We also use the `get_active_witnesses` function to query the blockchain for a list of available witnesses. Before we vote, we use the `get_account` function to check for all the witnesses that the user has currently voted for. This is not strictly necessary but adds to the useability of the process. The `approve_witness` method has 3 parameters:

1.  _witness_ - The witness to approve
1.  _account_ - The source user account for the voting
1.  _approve_ - This value is set to `True` when approving a witness

The `disapprove_witness` has the same parameters except for `_approve_` which is not required.

## Steps

1.  [**App setup**](#setup) - Library install and import. Connection to testnet
1.  [**User information and steem node**](#userinfo) - Input user information and connection to Steem node
1.  [**Active witness list**](#list) - Create a list of active as well as already voted for witnesses
1.  [**Vote / Unvote**](#commit) - Input witness name and commite vote/unvote to blockchain

#### 1. App setup <a name="setup"></a>

In this tutorial we use 3 packages:

- `steem` - steem-python library and interaction with Blockchain
- `pick` - helps select the query type interactively
- `pprint` - print results in better format

We import the libraries and connect to the `testnet`.

```python
import steembase
import steem
from pick import pick
import pprint

steembase.chains.known_chains['STEEM'] = {
    'chain_id': '79276aea5d4877d9a25892eaa01b0adf019d3e5cb12a97478df3298ccdd01673',
    'prefix': 'STX', 'steem_symbol': 'STEEM', 'sbd_symbol': 'SBD', 'vests_symbol': 'VESTS'
}
```

Because this tutorial alters the blockchain we connect to a testnet so we don't create spam on the production server.

#### 2. User information and steem node <a name="userinfo"></a>

We require the `private active key` of the user in order for the transaction to be committed to the blockchain. This is why we are using a testnet. The values are supplied via the terminal/console before we initialise the steem class. We also check if the user name provided is active on the chain. There are some demo accounts available but we encourage you to create your own accounts on this testnet.

```python
#capture user information
username = input('Enter username: ') #demo account: cdemo
wif = input('Enter private ACTIVE key: ') #demo account: 5KaNM84WWSqzwKzY82fXPaUW43idbLnPqf5SfjGxLfw6eV2kAP3

#connect node and private active key
client = steem.Steem(nodes=['https://testnet.steem.vc'], keys=[wif])

#check valid user
userinfo = client.get_account(username)
if(userinfo is None) :
    print('Oops. Looks like user ' + username + ' doesn\'t exist on this chain!')
    exit()
```

#### 3. Active witness list <a name="list"></a>

We create a list of active witnesses so the user knows which witnesses are available to vote for. We do this by sending a query to the blockchain using the `get_active_witnesses` function. The result of this query is displayed on the UI.

```python
#print list of active witnesses
print('ACTIVE WITNESSES')
witness_list = client.get_active_witnesses()
pprint.pprint(witness_list)
```

We also provide the user with a list of witnesses that has already been voted for by their account. From this the user will know which witnesses can be removed, and which can be added to their set of approved witnesses. We generate this list using the `get_account` function and display it on the UI.

```python
#print list of currently voted for witnesses
print('\n' + 'WITNESSES CURRENTLY VOTED FOR')
vote_list = userinfo['witness_votes']
pprint.pprint(vote_list)

input('Press enter to continue')
```

#### 4. Vote / Unvote <a name="commit"></a>

The user is given the option to `VOTE`, `UNVOTE` or `CANCEL` the process. Depending on the choice the relevant function is executed. Both the `VOTE` and `UNVOTE` methods use the same input - the witness being added or removed. The different method executions are shown below.

```python
#choice of action
title = ('Please choose action')
options = ['VOTE', 'UNVOTE', 'CANCEL']
option, index = pick(options, title)

if (option == 'CANCEL') :
    print('\n' + 'operation cancelled')
    exit()
```

VOTE :

```python
if (option == 'VOTE') :
    # vote process
    witness_vote = input('Please enter the witness name you wish to vote for: ')
    if witness_vote not in witness_list :
        print('\n' + witness_vote + ' does not appear on the available witness list')
        exit()
    if witness_vote in vote_list :
        print('\n' + witness_vote + ' cannot be voted for more than once')
        exit()
    client.approve_witness(witness=witness_vote, account=username, approve=True)
    print('\n' + witness_vote + ' has been successfully voted for')
```

UNVOTE :

```python
else :
    # unvote process
    witness_unvote = input('Please enter the witness name you wish to remove the vote from: ')
    if witness_unvote not in vote_list :
        print('\n' + witness_unvote + ' is not in your voted for list')
        exit()
    client.disapprove_witness(witness=witness_unvote, account=username)
    print('\n' + witness_unvote + ' has been removed from your voted for list')
```

A confirmation of the transaction to the blockchain is displayed on the UI.

We encourage users to play around with different values and data types to fully understand how this process works. You can also check the balances and transaction history on the [testnet portal](http://condenser.steem.vc/).

### To Run the tutorial

1.  [review dev requirements](getting_started)
1.  clone this repo
1.  `cd tutorials/22_witness_listing_and_voting`
1.  `pip install -r requirements.txt`
1.  `python index.py`
1.  After a few moments, you should see a prompt for input in terminal screen.

---
