---
title: Create a password recoverable account
position: 1
description: How to create a new account that will be recoverable, and how to recover your account
exclude: true
layout: full
---

_This recipe shows how to create an account that is recoverable in the event of a hacked account or lost password as well as how to recover that account_

This recipe is effectively an RFC. It only outlines part of the account creation and recovery process. It should not be considered complete, nor legal advice on best process for account creation.

## Requirements for recovery

There is already an [Account Creation Process Recipe](https://developers.steem.io/tutorials-recipes/account-creation-process) on how to create a new account as well as tutorials on the subject. The recovery account for your new account depends on where you created the account from. If you did so through Steemit.com, they will be the account responsible to assist with your account recovery. The same goes for creating an account through a third party or via an invitation from another Steemit user.

Recovery of an account must go through your account's registrar/recovery agent. Only the "recovery agent" can initialise the recovery process on the blockchain. The recovery process is there to assist users who had their account key stolen.

The account specific recovery agent can be obtained from `steemd.com/@username`

The term multisig refers to the requirement of having more than one signature to create a valid transaction. Most transactions don't have this requirement because they are tied to regular accounts. However, you can extend your account to a multi-authority account by adding more keys and requiring more than one of them to sign a transaction. With multisig you can give owner authority to another trusted account. This account can then be used to recover the first account in the case of a lost password. This permission can be granted to multiple users and can be set up to require more than one signature to action anything on the owner authority. You could share authority with 2 other accounts and set the threshold to require 2 signatures meaning that 2 of the 3 accounts need to approve the action. When adding multisig for your owner authority remember that the owner level provides COMPLETE access to all functions of your account.

## Account recovery

There are two steps in recovering a steemit account:

1.  [**Request account recovery**](#request) - indication of intent to recover account
1.  [**Recover account**](#recover) - recovery of indicated account

#### Request account recovery <a name="request"></a>

The first step to recovering an account is to broadcast the `request_account_recovery` function to the blockchain. This step is done to verify the user and account information for the account being recovered. This effectively broadcasts intent to recover an account. The `recovery_account` parameter is the registrar/recovery agent of the account to recover.

```json
[
    "request_account_recovery",
    {
        "account_to_recover": "account_to_recover",
        "recovery_account": "recovery_account",
        "new_owner_authority": {
            "weight_threshold": 1,
            "account_auths": [],
            "key_auths": [
                ["000000000000000000000000000000000000000000000000000", 1]
            ]
        },
        "extensions": []
    }
]
```

#### Recover account <a name="recover"></a>

The second step is the actual recovery of the account. The `recover_account` function is used for this step to transmit the recovery. In the case of an account with multisig the recent/old owner key can be provided by the account(s) that you have given owner authority to.

```json
[
    "recover_account",
    {
        "account_to_recover": "account_to_recover",
        "new_owner_authority": {
            "weight_threshold": 1,
            "account_auths": [],
            "key_auths": [
                ["000000000000000000000000000000000000000000000000000", 1]
            ]
        },
        "recent_owner_authority": {
            "weight_threshold": 1,
            "account_auths": [],
            "key_auths": [
                ["000000000000000000000000000000000000000000000000000", 1]
            ]
        },
        "extensions": []
    }
]
```

Once the account recovery has been broadcast with the new owner key, the rest of the account keys will be created and updated as well. This is done with an account update operation. A working tutorial explaining the change of account keys is available [here](https://developers.steem.io/tutorials-python/password_key_change)

```json
{
    "account": "account",
    "active": {
        "weight_threshold": 1,
        "account_auths": [],
        "key_auths": [
            ["000000000000000000000000000000000000000000000000000", 1]
        ]
    },
    "posting": {
        "weight_threshold": 1,
        "account_auths": [],
        "key_auths": [
            ["000000000000000000000000000000000000000000000000000", 1]
        ]
    },
    "memo_key": {
        "weight_threshold": 1,
        "account_auths": [],
        "key_auths": [
            ["000000000000000000000000000000000000000000000000000", 1]
        ],
    },
    "json_metadata": ""
}
```

To see a working example of how to recover an account you can follow the tutorial [here](https://developers.steem.io/tutorials/#tutorials-python)
