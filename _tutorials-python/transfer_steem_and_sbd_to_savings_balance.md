---
title: 'PY: Transfer Steem And Sbd To Savings Balance'
position: 33
description: "How to transfer STEEM and SBD to savings using Python."
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Transfer Steem And Sbd To Savings Balance](https://github.com/steemit/devportal-tutorials-py/tree/master/tutorials/33_transfer_steem_and_sbd_to_savings_balance) can be downloaded as part of the [PY tutorials repository](https://github.com/steemit/devportal-tutorials-py).</span>
<br>



In this tutorial we show you how to check the STEEM and SBD balance of an account on the **Steem** blockchain and also how to transfer a portion or all of that to a "savings" account using the `commit` class found within the [steem-python](https://github.com/steemit/steem-python) library.

It should be noted that when funds are being withdrawn from the savings account it takes 3 days for those funds to reflect in the available STEEM/SBD balance. The withdrawal can be cancelled at any point during this waiting period. This measure was put in place to reduce the risk of funds being stolen when accounts are hacked as it gives sufficient time to recover your account before your funds are transferred out. Storing your funds in your savings account is thus more secure than having them as available balances.

Steemconnect offers an alternative to transferring STEEM and SBD with a "simple link" solution. Instead of running through a list of operations on your account, you can simply use a link similar to the one below substituting the four parameters with your own details. You will be prompted to enter your username and password before the transaction will be executed.
https://steemconnect.com/sign/transfer-to-savings?from=username&to=username&amount=0.000%20STEEM&memo=text
This is similar to the steemconnect links that have been covered in previous tutorials. For a list of signing operations that work in this manner you can go to https://v2.steemconnect.com/sign. There is also a steemconnect link for withdrawing funds.

## Intro

The Steem python library has a built-in function to transmit transactions to the blockchain. We are using the `transfer_to_savings` and `transfer_from_savings` methods found within the `commit` class in the library. Before we do the transfer, we use the `get_account` function to check the current STEEM and SBD balance of the account to see what funds are available to transfer or withdraw. This is not strictly necessary but adds to the useability of the process. The `transfer_to_savings` method has 5 parameters:

1.  _amount_ - The amount of STEEM or SBD that the user wants to transfer. This parameter has to be of the `float` data type and is rounded up to 3 decimal spaces
1.  _asset_ - A string value specifying whether `STEEM` or `SBD` is being transferred
1.  _memo_ - An optional text field containing comments on the transfer
1.  _to_ - The recipient savings account name. Funds can be transferred to any other users' savings balance
1.  _account_ - The source account for the transfer

and `transfer_from_savings` has 6 parameters:

1.  _amount_ - The amount of STEEM or SBD that the user wants to withdraw. This parameter has to be of the `float` data type and is rounded up to 3 decimal spaces
1.  _asset_ - A string value specifying whether `STEEM` or `SBD` is being withdrawn
1.  _memo_ - An optional text field containing comments on the withdrawal
1.  _request id_ - Integer identifier for tracking the withdrawal. This needs to be a unique number for a specified user
1.  _to_ - The recipient account name. Funds can be withdrawn to any other users' available balance
1.  _account_ - The source account for the transfer

## Steps

1.  [**App setup**](#setup) - Library install and import. Connection to testnet
1.  [**User information and steem node**](#userinfo) - Input user information and connection to Steem node
1.  [**Check balance**](#balance) - Check current STEEM and SBD balance of user account
1.  [**Transfer type and amount**](#amount) - Input of transfer type and the amount to transfer
1.  [**Transfer commit**](#commit) - Commit of transfer to blockchain

#### 1. App setup <a name="setup"></a>

In this tutorial we use 3 packages:

- `steem` - steem-python library and interaction with Blockchain
- `pick` - helps select the query type interactively
- `random` - use to create random numbers

We import the libraries and connect to the `testnet`.

```python
import steembase
import steem
from pick import pick
import random

steembase.chains.known_chains['STEEM'] = {
    'chain_id': '79276aea5d4877d9a25892eaa01b0adf019d3e5cb12a97478df3298ccdd01673',
    'prefix': 'STX', 'steem_symbol': 'STEEM', 'sbd_symbol': 'SBD', 'vests_symbol': 'VESTS'
}
```

Because this tutorial alters the blockchain we connect to a testnet so we don't create spam on the production server.

#### 2. User information and steem node <a name="userinfo"></a>

We require the `private active key` of the user in order for the transfer to be committed to the blockchain. This is why we are using a testnet. The values are supplied via the terminal/console before we initialise the steem class. There are some demo accounts available but we encourage you to create your own accounts on a testnet and create balances you can transfer; it's good practice.

```python
#capture user information
username = input('Enter username: ') #demo account: demo01
wif = input('Enter private ACTIVE key: ') #demo account: 5HxTntgeoLm4trnTz94YBsY6MpAap1qRVXEKsU5n1v2du1gAgVH

#connect node and private active key
client = steem.Steem(nodes=['https://testnet.steem.vc'], keys=[wif])
```

#### 3. Check balance <a name="balance"></a>

In order to give the user enough information to make the transfer we check the current balance of both the available and savings funds of the account using the `get_account` function.

```python
#check for valid account and get account balance for STEEM and SBD
userinfo = client.get_account(username)
if(userinfo is None) :
    print('Oops. Looks like user ' + username + ' doesn\'t exist on this chain!')
    exit()

total_steem = userinfo['balance']
total_sbd = userinfo['sbd_balance']
savings_steem = userinfo['savings_balance']
savings_sbd = userinfo['savings_sbd_balance']

print('CURRENT ACCOUNT BALANCE:' + '\n' + total_steem + '\n' + total_sbd + '\n')
print('CURRENT SAVINGS BALANCE:' + '\n' + savings_steem + '\n' + savings_sbd + '\n')

input('Press enter to continue with the transfer' + '\n')
```

The result of the query is displayed in the console/terminal.

#### 4. Transfer type and amount <a name="amount"></a>

The user is given a choice on the type of transfer (transfer/withdraw) as well as the currency. The user can also elect to cancel the process entirely. If you are using one of Steemit's demo accounts, please leave some funds for others to transfer! Once the user makes their choice we proceed to assign the `amount` as well as the `asset` parameter.

```python
#choice of transfer/withdrawal
title1 = 'Please choose transfer type: '
options1 = ['Transfer', 'Withdrawal', 'Cancel']
#get index and selected transfer type
transfer_type, index = pick(options1, title1)

if transfer_type == 'Cancel':
    print('Transaction cancelled')
    exit()

#choice of currency
title2 = 'Please choose currency: '
options2 = ['STEEM', 'SBD']
option, index = pick(options2, title2)

if option == 'STEEM':
    #get STEEM transfer amount
    amount = input('Enter amount of STEEM to transfer: ')
    asset = 'STEEM'
else:
    #get SBD transfer amount
    amount = input('Enter amount of SBD to transfer: ')
    asset = 'SBD'
```

#### 5. Transfer commit <a name="commit"></a>

Once all the parameters have been assigned we can proceed with the actual commit to the blockchain. The relevant function is executed based on the selected choice the user made in the previous step.

```python
if transfer_type == 'Transfer':
    #parameters: amount, asset, memo, to, account
    client.transfer_to_savings(float(amount), asset, '', username, username)
    print('\n' + 'Transfer to savings balance successful')
else:
    #create request ID random integer
    requestID = random.randint(1,1000000)
    #parameters: amount, asset, memo, request_id=None, to=None, account=None
    client.transfer_from_savings(float(amount), asset, '', requestID, username, username)
    print('\n' + 'Withdrawal from savings successful, transaction ID: ' + str(requestID))
```

With a withdrawal, the method requires a unique identifier for the transaction to be completed. For this we create a random integer and also display it on the UI along with the result of the transaction. The `memo` parameter is optional and can be left empty as in the above example. We also use the source account for the `to` parameter. This can be replace by any other valid user account. A simple confirmation of the transfer is printed on the UI.

As an added confirmation we check the balance of the user again and display it on the UI. This is not required at all but it serves as a more definitive confirmation that the transfer has been completed correctly.

```python
#get remaining account balance for STEEM and SBD
userinfo = client.get_account(username)
total_steem = userinfo['balance']
total_sbd = userinfo['sbd_balance']
savings_steem = userinfo['savings_balance']
savings_sbd = userinfo['savings_sbd_balance']

print('\n' + 'REMAINING ACCOUNT BALANCE:' + '\n' + total_steem + '\n' + total_sbd + '\n')
print('CURRENT SAVINGS BALANCE:' + '\n' + savings_steem + '\n' + savings_sbd + '\n')
```

We encourage users to play around with different values and data types to fully understand how this process works. You can also check the balances and transaction history on the [testnet portal](http://condenser.steem.vc/).

### To Run the tutorial

1.  [review dev requirements](https://github.com/steemit/devportal-tutorials-py/tree/master/tutorials/00_getting_started#dev-requirements)
1.  clone this repo
1.  `cd tutorials/33_transfer_steem_and_sbd_to_savings_balance`
1.  `pip install -r requirements.txt`
1.  `python index.py`
1.  After a few moments, you should see a prompt for input in terminal screen.

---
