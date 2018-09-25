---
title: 'PY: Delegate Power'
position: 27
description: "How to delegate or remove delegation of STEEM POWER to another user using Python."
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Delegate Power](https://github.com/steemit/devportal-tutorials-py/tree/master/tutorials/27_delegate_power) can be downloaded as part of the [PY tutorials repository](https://github.com/steemit/devportal-tutorials-py).</span>
<br>



In this tutorial we show you how to delegate a portion of an accounts available VESTS (STEEM POWER) to another user on the **Steem** blockchain using the `commit` class found within the [steem-python](https://github.com/steemit/steem-python) library.

## Intro

The Steem python library has a built-in function to transmit transactions to the blockchain. We are using the `delegate_vesting_shares` method found within the `commit` class in the library. When you delegate power you make a portion of your VESTS available to another user. This can empower an application, author, or curator to make higher votes. Before we do the delegation, we use the `get_account` function to check the current VESTS balance of the account to see what is available. This is not strictly necessary but adds to the useability of the process. It should be noted that when a delegation is cancelled the VESTS will only be available again after 7 days. The `delegate_vesting_shares` method has 3 parameters:

1.  _to_account_ - The account we are delegating shares to (delegatee)
1.  _vesting_shares_ - The amount of VESTS to delegate. This is required to be a string value
1.  _account_ - The source user account for the delegation (delegator)

## Steps

1.  [**App setup**](#setup) - Library install and import. Connection to testnet
1.  [**User information and steem node**](#userinfo) - Input user information and connection to Steem node
1.  [**Check balance**](#balance) - Check current VESTS balance of user account
1.  [**Delegation amount and commit**](#delegate) - Input delegation amount and commit to blockchain

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
from steem.amount import Amount

steembase.chains.known_chains['STEEM'] = {
    'chain_id': '79276aea5d4877d9a25892eaa01b0adf019d3e5cb12a97478df3298ccdd01673',
    'prefix': 'STX', 'steem_symbol': 'STEEM', 'sbd_symbol': 'SBD', 'vests_symbol': 'VESTS'
}
```

Because this tutorial alters the blockchain we connect to a testnet so we don't create spam on the production server.

#### 2. User information and steem node <a name="userinfo"></a>

We require the `private active key` of the user in order for the transaction to be committed to the blockchain. This is why we are using a testnet. The values are supplied via the terminal/console before we initialise the steem class. We also check if the user name provided is active on the chain. There are some demo accounts available but we encourage you to create your own accounts on this testnet and create balances you can delegate.

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

#### 3. Check balance <a name="balance"></a>

In order to give the user enough information to make the delegation we check the current VESTS balance of the account using the `get_account` function. We also display a list of currently active delegations should the user choose to remove a delegation. You can refer to tutorial `29_get_delegations_by_user` to see how this is done.

```python
#display active delegations (refer to tutorial #29_get_delegations_by_user)
delegations = client.get_vesting_delegations(username, '', 100)
if len(delegations) == 0:
	print('No active delegations')
else:
	pprint.pprint(delegations)

#available VESTS
avail_vests = (Amount(userinfo['vesting_shares']).amount - 
    ((userinfo['to_withdraw']-userinfo['withdrawn'])/1000000)-
    Amount(userinfo['delegated_vesting_shares']).amount)
print('\n' + 'Available VESTS : ' + str(avail_vests))

input('Press enter to continue' + '\n')
```

The result of the query is displayed in the console/terminal.

#### 4. Delegation amount and commit <a name="delegate"></a>

Both the `vesting_shares` and the `to_account` parameters are assigned via input from the terminal/console. The user is given the option to delegate power to or remove a currently active delegation from another user. We also check the `to_account` to make sure it's a valid account name.

```python
#choice of action
title = ('Please choose action')
options = ['DELEGATE POWER', 'UN-DELEGATE POWER', 'CANCEL']
option, index = pick(options, title)

if (option == 'CANCEL') :
    print('operation cancelled')
    exit()

#get account to authorise and check if valid
delegatee = input('Please enter the account name to ADD / REMOVE delegation: ')
delegatee_userinfo = client.get_account(delegatee)
if(delegatee_userinfo is None) :
    print('Oops. Looks like user ' + delegatee + ' doesn\'t exist on this chain!')
    exit()
```

Any amount of VESTS delegated to a user will overwrite the amount of VESTS currently delegated to that user. This means that to cancel a delegation we transmit to the blockchain a `vesting_shares` value of zero. The inputs and function execution is based on the users choice. If you are using one of Steemit's demo accounts, please leave some VESTS for others to delegate!

```python
if (option == 'DELEGATE POWER') :
    vesting_value = input('Please enter the amount of VESTS to delegate: ')
    vesting_shares = (str(vesting_value) + ' VESTS')
    client.delegate_vesting_shares(to_account=delegatee, vesting_shares=vesting_shares, account=username)
    print('\n' + str(vesting_shares) + ' have been successfully been delegated to ' + delegatee)
else :
    vesting_shares = '0 VESTS'
    client.delegate_vesting_shares(to_account=delegatee, vesting_shares=vesting_shares, account=username)
    print('Delegated VESTS have been successfully removed from ' + delegatee)
```

A confirmation of the transaction is displayed on the UI.

We encourage users to play around with different values and data types to fully understand how this process works. You can also check the balances and transaction history on the [testnet portal](http://condenser.steem.vc/).

### To Run the tutorial

1.  [review dev requirements](getting_started)
1.  clone this repo
1.  `cd tutorials/27_delegate_power`
1.  `pip install -r requirements.txt`
1.  `python index.py`
1.  After a few moments, you should see a prompt for input in terminal screen.

---
