---
title: 'PY: Power Up Steem'
position: 24
description: 'How to power up your STEEM to STEEM POWER using Python.'
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Power Up Steem](https://github.com/steemit/devportal-tutorials-py/tree/master/tutorials/24_power_up_steem) can be downloaded as part of the [PY tutorials repository](https://github.com/steemit/devportal-tutorials-py).</span>
<br>



In this tutorial we show you how to check the STEEM balance of an account on the **Steem** blockchain and how to power up your STEEM into STEEM POWER using the `commit` class found within the [steem-python](https://github.com/steemit/steem-python) library.

## Intro

The Steem python library has a built-in function to transmit transactions to the blockchain. We are using the `transfer_to_vesting` method found within the `commit` class in the library. When you power up you convert your STEEM into STEEM POWER to increase your influence on Steemit. Before we do the conversion, we use the `get_account` function to check the current STEEM balance of the account to see what is available to power up. This is not strictly necessary but adds to the useability of the process. The `transfer_to_vesting` method has 3 parameters:

1.  _amount_ - The amount of STEEM to power up. This must be of the `float` data type
1.  _to_ - The account to where the STEEM will be powered up
1.  _account_ - The source user account for the transfer

## Steps

1.  [**App setup**](#setup) - Library install and import. Connection to testnet
1.  [**User information and steem node**](#userinfo) - Input user information and connection to Steem node
1.  [**Check balance**](#balance) - Check current vesting balance of user account
1.  [**Conversion amount**](#convert) - Input power up amount and check valid transfer
1.  [**Commit to blockchain**](#commit) - Commit transaction to blockchain

#### 1. App setup <a name="setup"></a>

In this tutorial we use 2 packages:

- `steem` - steem-python library and interaction with Blockchain
- `pick` - helps select the query type interactively

We import the libraries and connect to the `testnet`.

```python
import steembase
import steem
from steem.amount import Amount
from pick import pick

steembase.chains.known_chains['STEEM'] = {
    'chain_id': '79276aea5d4877d9a25892eaa01b0adf019d3e5cb12a97478df3298ccdd01673',
    'prefix': 'STX', 'steem_symbol': 'STEEM', 'sbd_symbol': 'SBD', 'vests_symbol': 'VESTS'
}
```

Because this tutorial alters the blockchain we connect to a testnet so we don't create spam on the production server.

#### 2. User information and steem node <a name="userinfo"></a>

We require the `private active key` of the user in order for the conversion to be committed to the blockchain. This is why we are using a testnet. The values are supplied via the terminal/console before we initialise the steem class. There are some demo accounts available but we encourage you to create your own accounts on this testnet and create balances you can claim; it's good practice.

```python
#capture user information
username = input('Enter username: ') #demo account: cdemo
wif = input('Enter private ACTIVE key: ') #demo account: 5KaNM84WWSqzwKzY82fXPaUW43idbLnPqf5SfjGxLfw6eV2kAP3

#connect node and private active key
client = steem.Steem(nodes=['https://testnet.steem.vc'], keys=[wif])
```

#### 3. Check balance <a name="balance"></a>

In order to give the user enough information to make the conversion we check the current balance of the account using the `get_account` function.

```python
#check valid user and get account balance
userinfo = client.get_account(username)
if(userinfo is None) :
    print('Oops. Looks like user ' + username + ' doesn\'t exist on this chain!')
    exit()
balance = userinfo['balance']

print('Available STEEM balance: ' + balance + '\n')

input('Press any key to continue')
```

The results of the query are displayed in the console/terminal.

#### 4. Conversion amount <a name="convert"></a>

Both the `amount` and the `to` parameters are assigned via input from the terminal/console. The user is given the option to power up the STEEM to their own account or to another user's account. The amount has to be greater than zero and no more than the total available STEEM of the user. If you are using one of Steemit's demo accounts, please leave some STEEM for others to power up! We also check the `to account` to make sure it's a valid account name.

```python
#choice of account
title = 'Please choose an option for an account to transfer to: '
options = ['SELF', 'OTHER']
option, index = pick(options, title)

if (option == 'OTHER') :
    #account to power up to
    to_account = input('Please enter the ACCOUNT to where the STEEM will be transferred: ')
    #check valid username
    result = client.get_account(to_account)
    if (not result) :
        print(to_account + ' doesn\'t exist on this chain!')
        exit()
else :
    print('\n' + 'Power up STEEM to own account' + '\n')
    to_account = username

#amount to power up
amount = float(input('Please enter the amount of STEEM to power up: '))
```

#### 5. Commit to blockchain <a name="commit"></a>

Now that all the parameters have been assigned we can continue with the actual transmission to the blockchain. The output and commit is based on the validity of the amount that has been input.

```python
#parameters: amount, to, account
if (amount == 0) :
    print('\n' + 'No STEEM entered for powering up')
    exit()
else :
    if (amount > Amount(balance).amount) :
        print('\n' + 'Insufficient funds available')
        exit()
    else :
        client.transfer_to_vesting(amount, to_account, username)
        print('\n' + str(amount) + ' STEEM has been powered up successfully')
```

The result of the power up transfer is displayed on the console/terminal.

As an added check we also display the new STEEM balance of the user on the terminal/console

```python
#get new account balance
userinfo = client.get_account(username)
balance = userinfo['balance']
print('New STEEM balance: ' + balance)
```

We encourage users to play around with different values and data types to fully understand how this process works. You can also check the balances and transaction history on the [testnet portal](http://condenser.steem.vc/).

### To Run the tutorial

1.  [review dev requirements](https://github.com/steemit/devportal-tutorials-py/tree/master/tutorials/00_getting_started#dev-requirements)
1.  clone this repo
1.  `cd tutorials/24_power_up_steem`
1.  `pip install -r requirements.txt`
1.  `python index.py`
1.  After a few moments, you should see a prompt for input in terminal screen.

---
