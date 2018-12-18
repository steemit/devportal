---
title: Plugin & API List
position: 1
description: Run a `steemd` node with your preferred APIs.
exclude: true
layout: full
---

*This is a list of the plugins, and their associated dependencies, required to enable specific apis.*

**When setting up the config file `steemd` will enable the `chain`, `p2p`, and `webserver` plugins regardless of other dependencies.**

## API's with their respective plugin dependencies

* [`account_by_key_api`](#account_by_key_api)
* [`account_history_api`](#account_history_api)
* [`block_api`](#block_api)
* [`condenser_api`](#condenser_api)
* [`database_api`](#database_api)
* [`debug_node_api`](#debug_node_api)
* [`follow_api`](#follow_api)
* [`market_history_api`](#market_history_api)
* [`network_broadcast_api`](#network_broadcast_api)
* [`rc_api`](#rc_api)
* [`reputation_api`](#reputation_api)
* [`tags_api`](#tags_api)
* [`transaction_status_api`](#transaction_status_api)
* [`witness_api`](#witness_api)

### `account_by_key_api`

* **Purpose:** Used to lookup account information based on a public key.
* **Requires:** `account_by_key`
* **Exposed Methods:** [`account_by_key_api.*`]({{ '/apidefinitions/#apidefinitions-account-by-key-api' | relative_url }})

Example in `chain.ini`:

```ini
plugin = account_by_key
plugin = account_by_key_api
```

---

### `account_history_api`

* **Purpose:** Used to lookup account history information.
* **Requires:** `account_history` or `account_history_rocksdb`
* **Exposed Methods:** [`account_history_api.*`]({{ '/apidefinitions/#apidefinitions-account-history-api' | relative_url}})

Note, while the `account_history_rocksdb` plugin is a more efficient, the current implementation does not provide support for [`condenser_api.get_transaction`]({{ '/apidefinitions/#condenser_api.get_transaction' | relative_url}}).

Example in `chain.ini`:

```ini
plugin = account_history
plugin = account_history_api
```

... or ...

```ini
plugin = account_history_rocksdb
plugin = account_history_api
```

---

### `block_api`

* **Purpose:** Used to query values related to the block plugin.
* **Requires:** *No additional*
* **Exposed Methods:** [`block_api.*`]({{ '/apidefinitions/#apidefinitions-block-api' | relative_url}})

Example in `chain.ini`:

```ini
plugin = block_api
```

---

### `condenser_api`

* **Purpose:** Intended to help ease the transition to AppBase.  It is recommended that apps transition away from this API.
* **Requires:** `database_api` (automatic)
* **Optional:**
  * `account_by_key`
  * `tags`
  * `follow`
  * `market_history`
  * `account_history`
* **Exposed Methods:** [`condenser_api.*`]({{ '/apidefinitions/#apidefinitions-condenser-api' | relative_url}})

Example in `chain.ini`:

```ini
plugin = account_by_key tags follow market_history account_history
plugin = condenser_api
```

---

### `database_api`

* **Purpose:** Used to query information about accounts, transactions, and blockchain data.
* **Requires:** *No additional*
* **Exposed Methods:** [`database_api.*`]({{ '/apidefinitions/#apidefinitions-database-api' | relative_url}})

Example in `chain.ini`:

```ini
plugin = database_api
```

---

### `debug_node_api`

* **Purpose:** Allows all sorts of creative "what-if" experiments with the chain.
* **Requires:** `debug_node`
* **Exposed Methods:** [`debug_node_api.*`]({{ '/apidefinitions/#apidefinitions-debug-node-api' | relative_url}})

Example in `chain.ini`:

```ini
plugin = debug_node
plugin = debug_node_api
```

---

### `follow_api`

* **Purpose:** Used to lookup information related to reputation and account follow operations.
* **Requires:** `follow` (automatic)
* **Exposed Methods:** [`follow_api.*`]({{ '/apidefinitions/#apidefinitions-follow-api' | relative_url}})

Example in `chain.ini`:

```ini
plugin = follow_api
```

---

### `market_history_api`

* **Purpose:** Used to lookup market history information. Can return the market and trade history of the internal STEEM:SBD market. The order book, recent trades and the market volume is made available through this plugin.
* **Requires:** `market_history` (automatic)
* **Exposed Methods:** [`market_history_api.*`]({{ '/apidefinitions/#apidefinitions-market-history-api' | relative_url}})

Example in `chain.ini`:

```ini
plugin = market_history_api
```

---

### `network_broadcast_api`

* **Purpose:** Used to broadcast transactions and blocks.
* **Requires:** `rc` (automatic)
* **Exposed Methods:** [`network_broadcast_api.*`]({{ '/apidefinitions/#apidefinitions-network-broadcast-api' | relative_url}})

Example in `chain.ini`:

```ini
plugin = network_broadcast_api
```

---

### `rc_api`

* **Purpose:** Managing of resources - curation rewards, vesting shares, etc.
* **Requires:**
  * `rc` (automatic)
  * `database_api` (automatic)
* **Exposed Methods:** [`rc_api.*`]({{ '/apidefinitions/#apidefinitions-rc-api' | relative_url}})

Example in `chain.ini`:

```ini
plugin = rc_api
```

---

### `reputation_api`

* **Purpose:** Manage account reputation (relevant to voting on content).
* **Requires:** `reputation` (automatic)
* **Exposed Methods:** [`reputation_api.*`]({{ '/apidefinitions/#apidefinitions-reputation-api' | relative_url}})

Example in `chain.ini`:

```ini
plugin = reputation_api
```

---

### `tags_api`

* **Purpose:** Used to lookup information about tags, posts, and discussions as well as votes.
* **Requires:** `tags` (automatic)
* **Exposed Methods:** [`tags_api.*`]({{ '/apidefinitions/#apidefinitions-tags-api' | relative_url}})

Example in `chain.ini`:

```ini
plugin = tags_api
```

---

### `transaction_status_api`

* **Purpose:** Evaluates a transaction status after calling [`condenser_api.broadcast_transaction`]({{ '/apidefinitions/#condenser_api.broadcast_transaction' | relative_url}}).
* **Requires:**
  * `transaction_status` (automatic)
  * `database_api` (automatic)
* **Exposed Methods:** [`transaction_status_api.*`]({{ '/apidefinitions/#apidefinitions-transaction-status-api' | relative_url}})

Example in `chain.ini`:

```ini
plugin = transaction_status_api
```

---

### `witness_api` *(deprecated)*

* **Purpose:** The witness plugin contains all of the bandwidth logic (replaced by `rc`).  Can access the available bandwidth of an account and current reserve ratio.
* **Requires:** `rc` (automatic)
* **Exposed Methods:** [`witness_api.*`]({{ '/apidefinitions/#apidefinitions-witness-api' | relative_url}})

Example in `chain.ini`:

```ini
plugin = witness_api
```
