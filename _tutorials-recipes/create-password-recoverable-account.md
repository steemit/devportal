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

There is already an [Account Creation Process Recipe](/tutorials-recipes/account-creation-process) on how to create a new account as well as tutorials on the subject. In order for that newly created account to be recoverable a password is necessary. Without a previously used password the account cannot be recovered. Lost passwords can't be recovered either. Once an account has been compramised you only have 30 days to recover the account.

If you created your account via Steemit.com and have your last known master password you can attempt to recover your account directly through the website. If however it was created via SteemInvite.com or Anonsteem or any other third party services then they will be your recovery agent. Recovery of an account must go through your accounts registrar/recovery agent. Only the "recovery agent" can initialise the recovery process on the blockchain.

The account specific recovery agent can be obtained from `steemd.com/@username`

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

The second step is the actual recovery of the account. The `recover_account` function is used for this step to transmit the recovery.

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

Once the account recovery has been broadcast with the new owner key, the rest of the account keys needs to be created and updated as well. This is done with an account update operation. A working tutorial explaining the change of account keys is available as a [Password Key Change Tutorial](/tutorials-python/password_key_change)

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
    "memo_key": "000000000000000000000000000000000000000000000000000",
    "json_metadata": ""
}
```

To see a working example of how to recover an account you can follow the [Account Recovery Tutorial](/tutorials-python/35_account_recovery).
