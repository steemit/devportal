---
title: Understanding Transaction Status
position: 1
description: How to use the Steem API to check the status of a transaction for a given `trx_id` value.
exclude: true
layout: full
---

The overarching goal is to stop using [`condenser_api.broadcast_transaction_synchronous`](/apidefinitions/#condenser_api.broadcast_transaction_synchronous) but we still want the benefits.

* [Why Client-side Computation?](#why-client-side-computation)
* [Why After Broadcast?](#why-after-broadcast)
* [Why In General?](#why-in-general)
* [Client-side Computation](#client-side-computation)
* [After Broadcast](#after-broadcast)
* [Polling](#polling)

## Why Client-side Computation?

The primary reason to compute the `trx_id` before broadcast is to track the transaction when quality of service is impacted. If the `trx_id` is known before [`condenser_api.broadcast_transaction`](/apidefinitions/#condenser_api.broadcast_transaction), but the response times out, we can still track the transaction.

## Why After Broadcast?

Assuming quality of service has not been impacted, solely relying on the [`condenser_api.broadcast_transaction`](/apidefinitions/#condenser_api.broadcast_transaction) response should not be a problem.

## Why In General?

Whichever method we use above to get `trx_id`, we can track it if anything goes wrong while we wait for it to be included in a block. Then, even after it's included, we can still track a transaction while we wait for 2/3rds of the witnesses to verify (thus irreversable). We can poll [`transaction_status_api`](/apidefinitions/#apidefinitions-transaction-status-api) until we're satisfied that the `trx_id` has been included.
## Client-side Computation

First, create a transaction, for example:

```json
{
   "ref_block_num":20,
   "ref_block_prefix":2890012981,
   "expiration":"2018-10-15T19:52:09",
   "operations":[
      {
         "type":"transfer_to_vesting_operation",
         "value":{
            "from":"alice",
            "to":"bob",
            "amount":{"amount":"8204", "precision":3, "nai":"@@000000021"}
         }
      }
   ],
   "extensions":[]
}
```

From this, we create a serialization, call it `hex`:

```
1400351942ace9efc45b010305616c69636503626f620c2000000000000003535445454d00000
```

Next, we convert `hex` to binary, call it `bytes` and digest `bytes`, with sha256, call it `digest`:

```
eba610257ad6c60d89f84ce54d3e10b52c18d4cce5547867e2450aeac80d9530
```

Last, we truncate `digest` to 20 bytes / 40 hex digits:

```
eba610257ad6c60d89f84ce54d3e10b52c18d4cc
```

This is the computed `trx_id`.

## After Broadcast

If your client does not support client-side id computation, you can still get the `trx_id` from the result of [`condenser_api.broadcast_transaction`](/apidefinitions/#condenser_api.broadcast_transaction).

The combination of [`condenser_api.broadcast_transaction`](/apidefinitions/#condenser_api.broadcast_transaction) and [`transaction_status_api.find_transaction`](/apidefinitions/#transaction_status_api.find_transaction), described below, allows us to avoid using [`condenser_api.broadcast_transaction_synchronous`](/apidefinitions/#condenser_api.broadcast_transaction_synchronous), which is being deprecated.

## Polling

Now that we have `trx_id`, we can poll `transaction_status_api.find_transaction`, for example:

```bash
curl -s --data '{"jsonrpc":"2.0", "method":"transaction_status_api.find_transaction", "params":{"transaction_id":"eba610257ad6c60d89f84ce54d3e10b52c18d4cc"}, "id":1}' https://api.steemit.com
```

Which returns:

```bash
{"jsonrpc":"2.0","result":{"status":"unknown"},"id":1}
```

We can provide the expiration:

```bash
curl -s --data '{"jsonrpc":"2.0", "method":"transaction_status_api.find_transaction", "params":{"transaction_id":"eba610257ad6c60d89f84ce54d3e10b52c18d4cc","expiration":"2018-10-15T19:52:09"}, "id":1}' https://api.steemit.com
```

Which returns:

```json
{"jsonrpc":"2.0","result":{"status":"too_old"},"id":1}
```

Possible `status` results are:

| Status | Meaning |
|--------|---------|
| `unknown` | Expiration time in future, transaction not included in block or mempool |
| `within_mempool` | Transaction in mempool |
| `within_reversible_block` | Transaction has been included in block, block not irreversible (result will also contain `block_num`) |
| `within_irreversible_block` | Transaction has been included in block, block is irreversible (result will also contain `block_num`) |
| `expired_reversible` | Transaction has expired, transaction is not irreversible (transaction could be in a fork) |
| `expired_irreversible` | Transaction has expired, transaction is irreversible (transaction cannot be in a fork) |
| `too_old` | Transaction is too old, I don't know about it |

See: [`transaction_status_api`](/apidefinitions/#apidefinitions-transaction-status-api)
