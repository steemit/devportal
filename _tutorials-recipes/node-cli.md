---
title: Steem Node Command Line Options
position: 1
description: All options available to `steemd` at command line interface
exclude: true
layout: full
---

Command line options are typically expressed with double-dash (e.g., `--replay-blockchain`):

```bash
steemd --data-dir=. --replay-blockchain
```

Note that nearly all options available from `config.ini` can be set as command-line options.  See: [Node Config]({{ '/tutorials-recipes/node-config' | relative_url }})

The following are *only* available as command-line options.

### Sections

* [`disable-get-block`](#disable-get-block)
* [`statsd-record-on-replay`](#statsd-record-on-replay)
* [`transaction-status-rebuild-state`](#transaction-status-rebuild-state)
* [`p2p-force-validate`](#p2p-force-validate)
* ~~[`force-validate`](#force-validate)~~
* [`replay-blockchain`](#replay-blockchain)
* [`force-open`](#force-open)
* [`resync-blockchain`](#resync-blockchain)
* [`stop-replay-at-block`](#stop-replay-at-block)
* [`advanced-benchmark`](#advanced-benchmark)
* [`set-benchmark-interval`](#set-benchmark-interval)
* [`dump-memory-details`](#dump-memory-details)
* [`check-locks`](#check-locks)
* [`validate-database-invariants`](#validate-database-invariants)
* [`database-cfg`](#database-cfg)
* [`memory-replay`](#memory-replay)
* [`chain-id`](#chain-id)
* [`account-history-rocksdb-immediate-import`](#account-history-rocksdb-immediate-import)

### `disable-get-block`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Disable `get_block` API call.

```bash
--disable-get-block
```

### `statsd-record-on-replay`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Records statsd events during replay

Used by plugin: `statsd`

See: [#2276](https://github.com/steemit/steem/issues/2276)

```bash
--statsd-record-on-replay
```

### `transaction-status-rebuild-state`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Indicates that the transaction status plugin must re-build its state upon startup.

Used by plugin: `transaction_status`

See: [Plugin & API List]({{ '/tutorials-recipes/plugin-and-api-list#transaction_status_api' | relative_url }}), [#2458](https://github.com/steemit/steem/issues/2458)

```bash
--transaction-status-rebuild-state
```

### `p2p-force-validate`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Force validation of all transactions.

```bash
--p2p-force-validate
```

### `force-validate`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Force validation of all transactions.

**Deprecated in favor of:** `p2p-force-validate`

```bash
--force-validate
```

### `replay-blockchain`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Clear chain database and replay all blocks.

```bash
--replay-blockchain
```

### `force-open`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Force open the database, skipping the environment check.  If the binary or configuration has changed, replay the blockchain explicitly using `--replay-blockchain`.  If you know what you are doing you can skip this check and force open the database using `--force-open`.

**WARNING: THIS MAY CORRUPT YOUR DATABASE. FORCE OPEN AT YOUR OWN RISK.**

See: [#3446](https://github.com/steemit/steem/issues/3446)

```bash
--force-open
```

### `resync-blockchain`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Clear chain database and block log.

```bash
--resync-blockchain
```

### `stop-replay-at-block`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Stop and exit after reaching given block number

See: [#1590](https://github.com/steemit/steem/issues/1590)

```bash
--stop-replay-at-block=1234
```

### `advanced-benchmark`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Make profiling for every plugin.

See: [#1996](https://github.com/steemit/steem/issues/1996)

```bash
--advanced-benchmark
```

### `set-benchmark-interval`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Print time and memory usage every given number of blocks.

See: [#1590](https://github.com/steemit/steem/issues/1590)

```bash
--set-benchmark-interval
```

### `dump-memory-details`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Dump database objects memory usage info. Use `set-benchmark-interval` to set dump interval.

See: [#1985](https://github.com/steemit/steem/issues/1985)

```bash
--dump-memory-details
```

### `check-locks`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Check correctness of *chainbase* locking.

```bash
--check-locks
```

### `validate-database-invariants`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Validate all supply invariants check out.

See: [#1477](https://github.com/steemit/steem/issues/1477), [#1649](https://github.com/steemit/steem/issues/1649)

```bash
--validate-database-invariants
```

### `database-cfg`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

The database configuration file location  **MIRA only.**

```bash
--database-cfg=database.cfg
```

### `memory-replay`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Replay with state in memory instead of on disk.  **MIRA only.**

See: [#3307](https://github.com/steemit/steem/issues/3307)

```bash
--memory-replay
```

### `chain-id`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Chain ID to connect to.  **Testnet only.**

See: [PR#1631](https://github.com/steemit/steem/pull/1631), [#2827](https://github.com/steemit/steem/issues/2827)

```bash
--chain-id=0feb08c380aeb483b61a34cccb7271a3a99c47052bea529c4a891622f2c50d75
```

### `account-history-rocksdb-immediate-import`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Allows to force immediate data import at plugin startup.  By default storage is supplied during reindex process.

See: [#1987](https://github.com/steemit/steem/issues/1987)

```bash
--account-history-rocksdb-immediate-import
```

### `account-history-rocksdb-stop-import-at-block`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Allows you to specify the block number that the data import process should stop at.

See: [#1987](https://github.com/steemit/steem/issues/1987)

```bash
--account-history-rocksdb-stop-import-at-block=1234
```
