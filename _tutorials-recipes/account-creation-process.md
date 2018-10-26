---
title: Account creation process
position: 1
description: The methods on how to create a new account.
exclude: true
layout: full
---

This recipe will take you through the different options when creating accounts on the Steem blockchain.

## Intro

With the introduction of the Resource Credit system there are now two ways in which to create an account. The methods are listed below with a detailed explanation of each in the following section.

1. [**Account creation method comparison**](#create)
1.  [**Discounted**](#discounted)
1.  [**Non-discounted**](#nondisc)

#### Account creation method comparison<a name="create"></a>

| Discounted account creations  | Non-discounted account creations |
| - | - |
| You can purchase claim tokens and use them at a later stage to create an account. These tokens do not expire.| You need to create an account and wait for it to be approved by the Steemit faucet |
| Account's are created immediately at no additional cost.  | You are required to pay the 3 STEEM to create an account and wait for the account to be approved.  |


#### 1. Discounted account creations<a name="discounted"></a>

The discounted account creation process uses an `Account creation token` that is purchased with Resource Credits (RC) to create the account instead of paying the creation fee in STEEM.

Purchasing an Account Creation token only enables you to do one thing: create one account at zero cost. It should be noted that these tokens do not expire, are not transferable and there is also no upper limit to the amount of tokens one can have, so they can be stockpiled. There is however a limit on the total amount of tokens available on the blockchain for claiming at any one time. The available tokens replenishes over time and the limit is decided upon by the witnesses.

Claiming tokens is the first step required to create an account without paying the STEEM cost. You are required to broadcast the `claim_account` operation on the network to claim an account token.

```json
[
    "claim_account",
    {
        "creator": "creator",
        "fee": "0.000 STEEM",
        "extensions": [],
    }
]
```

Once you have claimed a token you are able to broadcast the `create_claimed_account` operation to create the account. You are required to use the `creator` account, as well as select a new unique account name and then provide account keys for the new account. These can be generated using any of the Steem libraries available.

```json
[
    "create_claimed_account",
    {
        "creator": "creator",
        "new_account_name": "new_account_name",
        "owner": {
            "weight_threshold": 1,
            "account_auths": [],
            "key_auths": [["000000000000000000000000000000000000000000000000000", 1]],
        },
        "active": {
            "weight_threshold": 1,
            "account_auths": [],
            "key_auths": [["000000000000000000000000000000000000000000000000000", 1]],
        },
        "posting": {
            "weight_threshold": 1,
            "account_auths": [],
            "key_auths": [["000000000000000000000000000000000000000000000000000", 1]],
        },
        "memo_key": {
            "weight_threshold": 1,
            "account_auths": [],
            "key_auths": [["000000000000000000000000000000000000000000000000000", 1]],
        },
        "json_metadata": "",
        "extensions": []
    },
]
```

Created accounts with this method, doesn't have any SP on it but have a couple of RCs to interact with the chain.

#### 2. Non-discounted account creation<a name="nondisc"></a>

Non-discounted account creation operation allows you to create accounts and paying the creation cost using STEEM. Currently the `account_creation_fee` is 3 STEEM to create a single account. We use the `account_create` operation to commit this transaction to the blockchain. When creating a new account, the new `account_name` needs to be supplied. The keys must be derived from a `master_key` which must be kept safe. The account keys can be generated using the `new_account_name`, `master_key` and Steem tools.

```json
[
    "account_create",
    {
        "fee": "3.00 STEEM",
        "creator": "creator",
        "new_account_name": "new_account_name",
        "owner": {
            "weight_threshold": 1,
            "account_auths": [],
            "key_auths": [["000000000000000000000000000000000000000000000000000", 1]],
        },
        "active": {
            "weight_threshold": 1,
            "account_auths": [],
            "key_auths": [["000000000000000000000000000000000000000000000000000", 1]],
        },
        "posting": {
            "weight_threshold": 1,
            "account_auths": [],
            "key_auths": [["000000000000000000000000000000000000000000000000000", 1]],
        },
        "memo_key": {
            "weight_threshold": 1,
            "account_auths": [],
            "key_auths": [["000000000000000000000000000000000000000000000000000", 1]],
        },
        "json_metadata": ""
    }
]
```

You can follow this [tutorial](https://github.com/steemit/devportal-tutorials-js/tree/master/tutorials/26_create_account) to see working code of how to create accounts.
