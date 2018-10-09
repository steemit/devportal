---
title: 'PY: Password Key Change'
position: 33
description: "How to change your accounts password and keys"
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Password Key Change](https://github.com/steemit/devportal-tutorials-py/tree/master/tutorials/33_password_key_change) can be downloaded as part of the [PY tutorials repository](https://github.com/steemit/devportal-tutorials-py).</span>
<br>



In this tutorial we will explain and show you how to change your account password and keys on the **Steem** blockchain using the `steem` class found within the [steem-python](https://github.com/steemit/steem-python) library.

## Intro

The Steem python library has a built-in function to update your account details on the blockchain. We are using the `AccountUpdate` and `commit.finalizeOp` to make these changes. The `AccountUpdate` function creates the operation that we will be committing to the blockchain using the `commit.finalizeOp` function. We first get the existing keys from your account then recreate these from your new password. Once these have been created using your new password we commit them to the blockchain. The initial parameters we need to complete this operation are:

1.  _account_ - The user account that we will be changing
1.  _old_password_ - Your existing password for the account we are changing
1.  _new_password_ - The new password we will be updating your account with

**Caution:**
This functionality does not work on the TestNet so we will be modifying the **live** blockchain.

## Steps

1.  [**App setup**](#setup) - Library install and import. Connection to production
1.  [**User input**](#input) - Input user and limit parameters
1.  [**Connect to the blockchain**](#connection) - Connect to the blockchain using the parameters collected from the user
1.  [**Configure new keys**](#configure) - Setup the new json object that will have the new keys derived from your new password
1.  [**Commit changes to blockchain**](#commit) - Commit the account update to the blockchain

#### 1. App setup <a name="setup"></a>

In this tutorial we use 2 package:

- `steem` - steem-python library and interaction with Blockchain
- `steembase` - library containing functions to manipulate private keys and passwords as well as commit the operation to the blockchain

We import the libraries and get parameters from the user.

```python
import steem
import steembase
from steembase.account import PasswordKey
from steembase.account import PrivateKey
from steembase import operations
```

### 2. User input<a name="input"></a>

You will first be asked for the account that we will be modifying the password for. You will then be prompted to enter your existing password as well as your new password that we will update your account with.

```python
account = input('Account: ')
old_password = input('Current password: ')
new_password = input('New password: ')
```

### 3. Connect to the blockchain<a name="connection"></a>

From the parameters that have been collected we will generate the private key for the account and connect to the **Steem** blockchain. 

```python
old_owner_key = str(
    PasswordKey(account, old_password, "owner").get_private_key()
)

client = steem.Steem(keys=[old_owner_key])
```

### 4. Configure new keys<a name="configure"></a>

We will now generate new keys for each role using the new password as well as create the json that will be committed to the **Steem** blockchain. We generate new keys using the new password for each of these roles.

```python
new_public_keys = {}

for role in ["owner", "active", "posting", "memo"]:
    private_key = PasswordKey(account, new_password, role).get_private_key()
    new_public_keys[role] = str(private_key.pubkey)

new_data = {
    "account": account,
    "json_metadata": {},
    "owner": {
        "key_auths": [
            [new_public_keys["owner"], 1]
        ],
        "account_auths": [],
        "weight_threshold": 1
    },
    "active": {
        "key_auths": [
            [new_public_keys["active"], 1]
        ],
        "account_auths": [],
        "weight_threshold": 1
    },
    "posting": {
        "key_auths": [
            [new_public_keys["posting"], 1]
        ],
        "account_auths": [],
        "weight_threshold": 1
    },
    "memo_key": new_public_keys["memo"]
}

print("New data:")
print(new_data)
```

#### 5. Commit changes to blockchain <a name="commit"></a>

The `operations.AccountUpdate(**new_data)` creates the operation that will be committed to the blockchain using the new json object we have created.

Once we commit the changes to the blockchain using `client.commit.finalizeOp` the changes are committed and the password is updated.

```python
op = operations.AccountUpdate(**new_data)

result = client.commit.finalizeOp(op, account, "owner")
print("Result:")
print(result)
```

If you update your password and attempt to update it again to quickly you will receive the following error.

```
Assert Exception:_db.head_block_time() - account_auth.last_owner_update > STEEM_OWNER_UPDATE_LIMIT: Owner authority can only be updated once an hour.
```

You will need to wait at least an hour before attempting this again.

That's it!

### To Run the tutorial

1.  [review dev requirements](getting_started)
1.  clone this repo
1.  `cd tutorials/33_password_key_change`
1.  `pip install -r requirements.txt`
1.  `python index.py`
1.  After a few moments, you should see a prompt for input in terminal screen.

---
