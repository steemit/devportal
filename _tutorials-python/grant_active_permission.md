---
title: 'PY: Grant Active Permission'
position: 31
description: "How to give another user active permission on your account using Python."
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Grant Active Permission](https://github.com/steemit/devportal-tutorials-py/tree/master/tutorials/31_grant_active_permission) can be downloaded as part of the [PY tutorials repository](https://github.com/steemit/devportal-tutorials-py).</span>
<br>



In this tutorial we show you how to check if someone has got active permission for an account on the **Steem** blockchain and how to grant or revoke that permission using the `commit` class found within the [steem-python](https://github.com/steemit/steem-python) library.

Providing another user active permission for your account enables them to do fund transfers from your account. This can be useful in setting up a secondary account(s) to manage funds for a main account or having a backup should you lose passwords for the main account.

One of the common practice nowadays is to lend/delegate SP to another account, above same technique can be used to create market around it with minimum 3rd party trust. All your funds stay in your account. You can use/create automated system where you can lease for certain period of time and system can take care of payments and release of delegations (notify clients). Even better, you can use multi-signature feature to establish 100% trust where clients will have to confirm, approve transactions.

Active permissions and authority should be used with utmost care, you don't want to lose your funds. It is really not easy to hack Steem accounts, let alone take control over it. But without careful use (revealing private keys) losing liquid funds are not that difficult and it takes only couple seconds to do that, keeping most value powered up always helps.

[this article](https://steemit.com/steem/@good-karma/steem-multi-authority-permissions-and-how-active-authority-works-part-2-f158813ec0ec1) has more detail around active authorities

## Intro

The Steem python library has a built-in function to transmit transactions to the blockchain. We are using the `allow` and `disallow` methods found within the `commit` class in the library. Before we grant or revoke permission, we use the `get_account` function to check whether the requested user already has that permission or not. This is not strictly necessary but adds to the useability of the process. The `allow` method has 5 parameters:

1.  _foreign_ - The foreign account that will obtain access
1.  _weight_ - This is an optional parameter defining the weight to use. If not defined, the threshold value will be used. If the weight is smaller than the threshold, additional signatures will be required.
1.  _permission_ - The actual permission to modify. This value must be either "posting", "active" or "owner"
1.  _account_ - The account to allow access to
1.  _threshold_ - The threshold that needs to be reached by signatures to be able to interact

The `disallow` method uses the same parameters except for `weight` which is not required.

There is currently a bug with the `disallow` method when using it on the testnet that we normally connect to. Due to that bug, we are using the production server for this tutorial. Special care should be taken when creating transactions as everything we do will affect `real` accounts.

## Steps

1.  [**App setup**](#setup) - Library install and import. Input user info and connection to production
1.  [**Username validation**](#username) - Check validity of user and foreign account
1.  [**Check permission status**](#status) - Check current permission status of foreign account
1.  [**Commit to blockchain**](#commit) - Commit transaction to blockchain

#### 1. App setup and connection <a name="setup"></a>

In this tutorial we use 2 packages:

- `steem` - steem-python library and interaction with Blockchain
- `pick` - helps select the query type interactively

We import the libraries for the application.

```python
import steembase
import steem
from pick import pick
```

We require the `private active key` of the user in order for the `allow` or `disallow` to be committed to the blockchain. The values are supplied via the terminal/console before we initialise the steem class with the supplied private key included.

```python
#capture user information
username = input('Enter username: ')
wif = input('Enter private ACTIVE key: ')

#connect to production server with active key
client = steem.Steem(keys=[wif])
```

#### 2. Username validation <a name="username"></a>

Both the main account granting the permission and the account that permission is being granted to are first checked to make certain that they do in fact exist. We do this with the `get_account` function.

```python
#check valid user
userinfo = client.get_account(username)
if(userinfo is None) :
    print('Oops. Looks like user ' + username + ' doesn\'t exist on this chain!')
    exit()

#get account to authorise and check if valid
foreign_acc = input('Please enter the account name for ACTIVE authorisation: ')
if (foreign_acc == username) :
    print('Cannot allow or disallow active permission to your own account')
    exit()
foreign_userinfo = client.get_account(foreign_acc)
if(foreign_userinfo is None) :
    print('Oops. Looks like user ' + foreign_acc + ' doesn\'t exist on this chain!')
    exit()
```

#### 3. Check permission status <a name="status"></a>

In order to determine which function to execute (`allow` or `disallow`) we first need to check whether the requested user already has permission or not. We do this with the same variable created in the previous step. The `get_account` function has a value - `active` - that contains an array of the all the usernames that has been granted active permission for the account being queried. We use this check to limit the options of the user as you cannot grant permission to a user that already has permission or revoke permission of a user that does not yet have permission. The information is displayed on the options list.

```python
#check if foreign_account already has active auth
_data = []
title = ''
for i in range(len(userinfo['active']['account_auths'])) :
    _data.append(userinfo['active']['account_auths'][i])
    if (_data[i][0] == foreign_acc) :
        title = (foreign_acc + ' already has active permission. Please choose option from below list')
        options = ['DISALLOW', 'CANCEL']

if (title == '') :
    title = (foreign_acc + ' does not yet active permission. Please choose option from below list')
    options = ['ALLOW', 'CANCEL']
```

#### 4. Commit to blockchain <a name="commit"></a>

Based on the check in the previous step, the user is given the option to `allow`, `disallow` or `cancel` the operation completely. All the required parameters have already been assigned via console/terminal input and based on the choice of the user the relevant function can be executed. A confirmation of the succesfully executed action is displayed on the UI.

```python
option, index = pick(options, title)

if (option == 'CANCEL') :
    print('operation cancelled')
    exit()

if (option == 'ALLOW') :
    #allow(foreign, weight=None, permission='posting', account=None, threshold=None)
    client.allow(foreign=foreign_acc, weight=1, permission='active', account=username, threshold=1)
    print(foreign_acc + ' has been granted active permission')
else :
    #disallow(foreign, permission='posting', account=None, threshold=None)
    client.disallow(foreign=foreign_acc, permission='active', account=username, threshold=1)
    print('active permission for ' + foreign_acc + ' has been removed')
```

And that's it!

### To Run the tutorial

1.  [review dev requirements](getting_started)
1.  clone this repo
1.  `cd tutorials/31_grant_active_permission`
1.  `pip install -r requirements.txt`
1.  `python index.py`
1.  After a few moments, you should see a prompt for input in terminal screen.

---
