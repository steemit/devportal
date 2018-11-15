---
title: 'PY: Account Recovery'
position: 35
description: "How to recover an account using Python."
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Account Recovery](https://github.com/steemit/devportal-tutorials-py/tree/master/tutorials/35_account_recovery) can be downloaded as part of the [PY tutorials repository](https://github.com/steemit/devportal-tutorials-py).</span>
<br>



In this tutorial we show you how to request account recovery for a user and also recover that account on the **Steem** blockchain using the [beem-python](https://github.com/holgern/beem) library.

The recovery system is used to recover hacked accounts. In the event that you lose your password, your account is lost forever. You must know at least one old password that was used on your account within 30 days. This recovery process can only be executed once an hour. Stolen Account Recovery gives the rightful account owner 30 days to recover their account from the moment the thief changed their owner key.

## Intro

There are two parties involved in recovering an account. The user that requires their account to be recovered, and the recovery account (or trustee) which is the account that created the username on the blockchain. For anyone creating their account through the main Steemit webiste, their recovery account would be Steemit. If however your account was created for you by another user, that user is the one that would have to initialize your account recovery. The recovery account can be changed however to whichever user you require.

For this tutorial we are using the `beem-python` library which contains the required functions to execute this recovery process. There are two main sections to this process. Firstly, there is the `request_account_recovery` function where the owner is verified and the intent for account recovery is transmitted to the blockchain. The second part is the actual `recover_account` process. Along with this we also create a complete set of new account keys (posting, active, owner and memo) in order for the account to function properly. If these keys are not generated you will receive an error when trying to log in with your new password: `This password is bound to your account's owner key and can not be used to login to this site. However, you can use it to update your password to obtain a more secure set of keys`

**This tutorial runs on the live network so special care needs to be taken when running it.**

The `request_account_recovery` function has the following parameters:

1.  _account to recover_ - The account name that wishes to be recovered
1.  _recovery account_ - The trustee account / account owner that will recover the account
1.  _new owner authority_ - The new owner PUBLIC key of the account to be recovered
1.  _extensions_ - empty array

The `recover_account` function has the following parameters:

1.  _account_to_recover_ - The account name that wishes to be recovered
1.  _new_owner_authority_ - The new owner PUBLIC key of the account to be recovered
1.  _recent_owner_authority_ - The OLD owner PUBLIC key of the account to be recovered
1.  _extensions_ - empty array

## Steps

1.  [**App setup**](#setup) - Library install and import. Input user info and connection to production
1.  [**Owner key creation**](#owner_key) - Creation of new and old owner keys
1.  [**Recovery request operation and transmission**](#recovery_request) - creation of data object, operation and transmission of recovery request function
1.  [**Account recovery and new account keys data objects**](#new_keys) - creation of new account keys and objects for account update and recovery
1.  [**Account recovery commit**](#recovery_commit) - transmit account recovery to blockchain
1.  [**Account update commit**](#account_commit) - transmit account key update to blockchain



#### 1. App setup and connection <a name="setup"></a>

In this tutorial we use 1 packages:

- `beem` - beem-python library and interaction with Blockchain

We import the libraries for the application.

```python
import beembase
from beem.account import Account
from beem import Steem
from beem.transactionbuilder import TransactionBuilder
from beemgraphenebase.account import PasswordKey
from beembase.objects import Permission
```

There are 5 inputs required. The account name to be recovered along with the old and new passwords. We also require the account name and private active key of the recovery account (account owner / trustee). For the first step in the process we initialize the steem class with the private key from the recovery account. The values are supplied via the terminal/console.

```python
#capture user information
username = input('account to be recovered: ')
old_password = input('recent password for account: ')
new_password = input('new password for account: ')

recovery_account = input('account owner (recovery account): ')
recovery_account_private_key = input('account owner private ACTIVE key: ')

#connect to production server with active key
s = Steem(node=['https://api.steemit.com'], keys=[recovery_account_private_key])
```

The new password for the account to be recovered must be at least 32 characters long.

#### 2. Owner key creation <a name="owner_key"></a>

Both new and old owner keys are generated from the passwords supplied in the first step. For a more in depth look at creating keys please refer to [this](https://developers.steem.io/tutorials-python/password_key_change) tutorial on changing your password and keys.

```python
#create new account owner keys
new_account_owner_private_key = PasswordKey(username, new_password, role='owner').get_private_key()
new_account_owner_private_key_string = str(new_account_owner_private_key)
new_account_owner_public_key = str(new_account_owner_private_key.pubkey)

#create old account owner keys
old_account_owner_private_key = PasswordKey(username, old_password, role='owner').get_private_key()
old_account_owner_private_key_string = str(old_account_owner_private_key)
old_account_owner_public_key = str(old_account_owner_private_key.pubkey)
```

The Steem blockchain knows the history of your account, and every owner key that has ever been used for it. When you enter your recent password, it uses that to generate an owner key that can match up to a previous owner public key on the account. Without that password and owner key, the recovery account can't do anything to recover your account.

#### 3. Recovery request operation and transmission <a name="recovery_request"></a>

The `new_owner_authority` containing the new public key is formatted in order to be used in the `request_account_recovery` operation. Once the data object has been created, the operation is transmitted to the blockchain to confirm that the account in question is going to be recovered.

```python
new_owner_authority = {
    "key_auths": [
        [new_account_owner_public_key, 1]
    ],
    "account_auths": [],
    "weight_threshold": 1
}

#recovery request data object creation
request_op_data = {
    'account_to_recover': username,
    'recovery_account': recovery_account,
    'new_owner_authority': new_owner_authority,
    'extensions': []
}

#recovery request operation creation
request_op = beembase.operations.Request_account_recovery(**request_op_data)

print('request_op_data')
print(request_op_data)

#recovery request broadcast
request_result = s.finalizeOp(request_op, recovery_account, "active")

print('request_result')
print(request_result)
```

#### 4. Account recovery and new account keys data objects <a name="new_keys"></a>

The old owner key is formatted and the object for the account recovery function is created with the required parameters.

```python
recent_owner_authority = {
    "key_auths": [
        [old_account_owner_public_key, 1]
    ],
    "account_auths": [],
    "weight_threshold": 1
}

op_recover_account_data = {
    'account_to_recover': username,
    'new_owner_authority': new_owner_authority,
    'recent_owner_authority': recent_owner_authority,
    'extensions': []
}
```

The object for the account key update operation is created with the relevant keys created in the correct format within the object.

```python
op_account_update_data = {
    "account": username,
    "active": {
        "key_auths": [
            [str(PasswordKey(username, new_password, role='active').get_private_key().pubkey), 1]
        ],
        "account_auths": [],
        "weight_threshold": 1
    },
    "posting": {
        "key_auths": [
            [str(PasswordKey(username, new_password, role='posting').get_private_key().pubkey), 1]
        ],
        "account_auths": [],
        "weight_threshold": 1
    },
    "memo_key": str(PasswordKey(username, new_password, role='memo').get_private_key().pubkey),
    "json_metadata": ""
}
```

#### 5. Account recovery commit <a name="recovery_commit"></a>

The steem class is initialised once more but with the required WIF for this specific section. This is necessary when different keys are required at various steps. The `recover_account` function is transmitted to the blockchain via the `TransactionBuilder` operation in order to append the new private keys. The operation is then broadcast.

```python
s = Steem(node=['https://api.steemit.com'], keys=[recovery_account_private_key])

op_recover_account = beembase.operations.Recover_account(**op_recover_account_data)

print('op_recover_account')
print(op_recover_account)

tb = TransactionBuilder()
tb.appendOps([op_recover_account])
tb.appendWif(str(old_account_owner_private_key))
tb.appendWif(str(new_account_owner_private_key))
tb.sign()

result = tb.broadcast()
print('result')
print(result)
```

#### 6. Account update commit <a name="account_commit"></a>

The same basic process is followed as in the previous step. For this step however we require the new owner private key which is initialised in the steem class. The `TransactionBuilder` operation is used once more for the transmission to the blockchain.

```python
s = Steem(node=['https://api.steemit.com'], keys=[new_account_owner_private_key])

op_account_update = beembase.operations.Account_update(**op_account_update_data)

print('op_account_update')
print(op_account_update)

tb = TransactionBuilder()
tb.appendOps([op_account_update])
tb.appendWif(str(new_account_owner_private_key))
tb.sign()

result = tb.broadcast()

print('result')
print(result)
```

And that's it!

### To Run the tutorial

1.  [review dev requirements](getting_started)
1.  clone this repo
1.  `cd tutorials/35_account_recovery`
1.  `pip install -r requirements.txt`
1.  `python index.py`
1.  After a few moments, you should see a prompt for input in terminal screen.


---
