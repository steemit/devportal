---
title: 'PY: Power Down Steem'
position: 25
description: 'How to power down (withdraw) your vesting shares using Python.'
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Power Down Steem](https://github.com/steemit/devportal-tutorials-py/tree/master/tutorials/25_power_down_steem) can be downloaded as part of the [PY tutorials repository](https://github.com/steemit/devportal-tutorials-py).</span>
<br>



In this tutorial we will explain and show you how to power down some or all of your available vesting shares (STEEM POWER) on the **Steem** blockchain using the `commit` class found within the [steem-python](https://github.com/steemit/steem-python) library.

## Intro

The Steem python library has a built-in function to transmit transactions to the blockchain. We are using the `withdraw_vesting` method found within the `commit` class in the library. When you power down, the converted VESTS (STEEM POWER) will not be available as STEEM immediately. It is converted in 13 equal parts and transferred into your STEEM wallet weekly, the first portion only being available a week after the power down was initiated. Before we do the conversion, we check the current balance of the account to check how much STEEM POWER is available. This is not strictly necessary as the process will automatically abort with the corresponding error, but it does give some insight into the process as a whole. We use the `get_account` function to check for this. The `withdraw_vesting` method has 2 parameters:

1.  _amount_ - The amount of VESTS that will be withdrawn. This must be of the `float` data type
1.  _account_ - The specified user account for the transfer

## Steps

1.  [**App setup**](#setup) - Library install and import. Connection to testnet
1.  [**User information and steem node**](#userinfo) - Input user information and connection to Steem node
1.  [**Check balance**](#balance) - Check current vesting balance of user account
1.  [**Conversion amount and commit**](#convert) - Input of VESTS amount to convert and commit to blockchain

#### 1. App setup <a name="setup"></a>

In this tutorial we use 2 packages:

- `steem` - steem-python library and interaction with Blockchain
- `pick` - helps select the query type interactively

We import the libraries and connect to the `testnet`.

```python
import steembase
import steem
from pick import pick
from steem.amount import Amount

steembase.chains.known_chains['STEEM'] = {
    'chain_id': '79276aea5d4877d9a25892eaa01b0adf019d3e5cb12a97478df3298ccdd01673',
    'prefix': 'STX', 'steem_symbol': 'STEEM', 'sbd_symbol': 'SBD', 'vests_symbol': 'VESTS'
}
```

Because this tutorial alters the blockchain we connect to the testnet so we don't create spam on the production server.

#### 2. User information and steem node <a name="userinfo"></a>

We require the `private active key` of the user in order for the conversion to be committed to the blockchain. This is why we have to specify this alongside the `testnet` node. The values are supplied via the terminal/console before we initialise the steem class. There is a demo account available to use with this tutorial but any account that is set up on the testnet can be used.

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
#get account balance for vesting shares
userinfo = client.get_account(username)
delegated_vests = userinfo['delegated_vesting_shares']
vesting_shares = userinfo['vesting_shares']
to_withdraw = float(userinfo['to_withdraw'])
withdrawn = float(userinfo['withdrawn'])

available_vests = (Amount(vesting_shares).amount - Amount(delegated_vests).amount - 
     ((to_withdraw - withdrawn)/1000000))

print('VESTS currently powering down: ' + str(to_withdraw/1000000) + ' VESTS' +
    '\n' + 'Available VESTS: ' + str(available_vests) + ' VESTS')

input('\n' + 'Press enter to continue' + '\n')
```

The available vesting shares to withdraw is not directly available from the user information and needs to be calculated. In order to find the total VESTS available to power down we need to know how much is currently in power down, how much has been delegated and then the total amount of vesting shares. The values are assigned from the query directly as `float` type to make the calculations a little simpler. The results of the query and calculation are converted to `string` type and displayed in the console/terminal.

#### 4. Conversion amount and commit <a name="convert"></a>

The user is given the option to withdraw all available vesting shares, a portion of the shares or to cancel the transaction completely.

```python
#choice of transfer
title = 'Please choose an option: '
options = ['Power down ALL', 'Power down PORTION', 'Cancel Transaction']
option, index = pick(options, title)
```

Based on the input from the user the `amount` variable can be assigned and the transaction committed to the blockchain. The amount must be between zero and the total amount of vesting shares (both pending conversion and available VESTS combined). **The amount you set to be withdrawn will override the current amount of vesting shares pending withdrawal.** If for example the user enters a new amount of '0' shares to be withdrawn, it will cancel the current withdrawal completely.

```python
#parameters: amount, account
if (option == 'Cancel Transaction') :
    print('transaction cancelled')
    exit()
else :
    if (option == 'Power down ALL') :
        if (available_vests == 0) :
            print('No change to withdraw amount')
        else :
            amount = to_withdraw/1000000 + available_vests
            client.withdraw_vesting(amount, username)
            print(str(amount) + ' VESTS now powering down')
    else :
        amount = float(input('Please enter the amount of VESTS you would like to power down: '))
        if (amount < (to_withdraw/1000000 + available_vests)) :
            client.withdraw_vesting(amount, username)
            print(str(amount) + ' VESTS now powering down')
        else :
            if (amount == to_withdraw/1000000) :
                print('No change to withdraw amount')
            else :
                print('insufficient funds available')
```

The result is displayed on the console/terminal.

We encourage users to play around with different values and data types to fully understand how this process works. You can also check the balances and transaction history on the [testnet portal](http://condenser.steem.vc/).

### To Run the tutorial

1.  [review dev requirements](https://github.com/steemit/devportal-tutorials-py/tree/master/tutorials/00_getting_started#dev-requirements)
1.  clone this repo
1.  `cd tutorials/25_power_down_steem`
1.  `pip install -r requirements.txt`
1.  `python index.py`
1.  After a few moments, you should see a prompt for input in terminal screen.

---
