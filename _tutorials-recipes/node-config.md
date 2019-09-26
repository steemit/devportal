---
title: Steem Node Config
position: 1
description: All `config.ini` options available to `steemd`
exclude: true
layout: full
---

When running `steemd` for the first time, once the startup banner appears, press `Ctrl+C` to exit.  Running `steemd` like this will generate a data directory and a pristine copy of `config.ini`.

Also refer to:

* [example_config.ini](https://github.com/steemit/steem/blob/master/doc/example_config.ini)
* [fullnode.config.ini](https://github.com/steemit/steem/blob/master/contrib/fullnode.config.ini)
* [config-for-ahnode.ini](https://github.com/steemit/steem/blob/master/contrib/config-for-ahnode.ini)
* [config-for-docker.ini](https://github.com/steemit/steem/blob/master/contrib/config-for-docker.ini)
* [config-for-broadcaster.ini](https://github.com/steemit/steem/blob/master/contrib/config-for-broadcaster.ini)
* [fullnode.opswhitelist.config.ini](https://github.com/steemit/steem/blob/master/contrib/fullnode.opswhitelist.config.ini)

### Sections

* [`state-format`](#state-format)
* [`from-state`](#from-state)
* [`to-state`](#to-state)
* [`log-appender`](#log-appender)
* [`log-console-appender`](#log-console-appender)
* [`log-file-appender`](#log-file-appender)
* [`log-logger`](#log-logger)
* [`backtrace`](#backtrace)
* [`plugin`](#plugin)
* [`account-history-track-account-range`](#account-history-track-account-range)
* ~~[`track-account-range`](#track-account-range)~~
* [`account-history-whitelist-ops`](#account-history-whitelist-ops)
* ~~[`history-whitelist-ops`](#history-whitelist-ops)~~
* [`account-history-blacklist-ops`](#account-history-blacklist-ops)
* ~~[`history-blacklist-ops`](#history-blacklist-ops)~~
* [`history-disable-pruning`](#history-disable-pruning)
* [`account-history-rocksdb-path`](#account-history-rocksdb-path)
* [`account-history-rocksdb-track-account-range`](#account-history-rocksdb-track-account-range)
* [`account-history-rocksdb-whitelist-ops`](#account-history-rocksdb-whitelist-ops)
* [`account-history-rocksdb-blacklist-ops`](#account-history-rocksdb-blacklist-ops)
* [`block-data-export-file`](#block-data-export-file)
* [`block-log-info-print-interval-seconds`](#block-log-info-print-interval-seconds)
* [`block-log-info-print-irreversible`](#block-log-info-print-irreversible)
* [`block-log-info-print-file`](#block-log-info-print-file)
* [`sps-remove-threshold`](#sps-remove-threshold)
* [`shared-file-dir`](#shared-file-dir)
* [`shared-file-size`](#shared-file-size)
* [`shared-file-full-threshold`](#shared-file-full-threshold)
* [`shared-file-scale-rate`](#shared-file-scale-rate)
* [`checkpoint`](#checkpoint)
* [`flush-state-interval`](#flush-state-interval)
* [`debug-node-edit-script`](#debug-node-edit-script)
* ~~[`edit-script`](#edit-script)~~
* [`follow-max-feed-size`](#follow-max-feed-size)
* [`follow-start-feeds`](#follow-start-feeds)
* [`log-json-rpc`](#log-json-rpc)
* [`market-history-bucket-size`](#market-history-bucket-size)
* [`market-history-buckets-per-size`](#market-history-buckets-per-size)
* [`p2p-endpoint`](#p2p-endpoint)
* [`p2p-max-connections`](#p2p-max-connections)
* ~~[`seed-node`](#seed-node)~~
* [`p2p-seed-node`](#p2p-seed-node)
* [`p2p-parameters`](#p2p-parameters)
* [`p2p-user-agent`](#p2p-user-agent)
* [`rc-skip-reject-not-enough-rc`](#rc-skip-reject-not-enough-rc)
* [`rc-compute-historical-rc`](#rc-compute-historical-rc)
* [`rc-start-at-block`](#rc-start-at-block)
* [`rc-account-whitelist`](#rc-account-whitelist)
* [`statsd-endpoint`](#statsd-endpoint)
* [`statsd-batchsize`](#statsd-batchsize)
* [`statsd-whitelist`](#statsd-whitelist)
* [`statsd-blacklist`](#statsd-blacklist)
* [`tags-start-promoted`](#tags-start-promoted)
* [`tags-skip-startup-update`](#tags-skip-startup-update)
* [`transaction-status-block-depth`](#transaction-status-block-depth)
* [`transaction-status-track-after-block`](#transaction-status-track-after-block)
* [`webserver-http-endpoint`](#webserver-http-endpoint)
* [`webserver-ws-endpoint`](#webserver-ws-endpoint)
* [`webserver-unix-endpoint`](#webserver-unix-endpoint)
* ~~[`rpc-endpoint`](#rpc-endpoint)~~
* [`webserver-thread-pool-size`](#webserver-thread-pool-size)
* [`enable-stale-production`](#enable-stale-production)
* [`required-participation`](#required-participation)
* [`witness`](#witness)
* [`private-key`](#private-key)
* [`witness-skip-enforce-bandwidth`](#witness-skip-enforce-bandwidth)
* [`account-stats-bucket-size`](#account-stats-bucket-size)
* [`account-stats-history-per-bucket`](#account-stats-history-per-bucket)
* [`account-stats-tracked-accounts`](#account-stats-tracked-accounts)
* [`trusted-node`](#trusted-node)
* [`pm-account-range`](#pm-account-range)
* [`chain-stats-bucket-size`](#chain-stats-bucket-size)
* [`chain-stats-history-per-bucket`](#chain-stats-history-per-bucket)

### `from-state`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Load from state, then replay subsequent blocks.

```ini
# default
from-state = 
```

### `to-state`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

File to save state after `--stop-replay-at-block` option.

```ini
# default
to-state = 
```

### `state-format`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

State file save format `(binary|json)`.

```ini
# default
state-format = binary
```

```ini
# example, portable state format
state-format = json
```

### `log-appender`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Appender definition JSON: `{"appender", "stream", "file"}`.  Each appender can only specify a file *or* a stream.

```ini
# default
log-appender = {"appender":"stderr","stream":"std_error"} {"appender":"p2p","file":"logs/p2p/p2p.log"}
```

### `log-console-appender`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Console appender definition JSON: `{"appender", "stream"}`.

```ini
# example
log-console-appender = {"appender":"stderr","stream":"std_error"}
```

```ini
# default
log-console-appender =
```

### `log-file-appender`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

File appender definition JSON: `{"appender", "file"}`.

```ini
# example
log-file-appender = {"appender":"p2p","file":"logs/p2p/p2p.log"}
```

```ini
# default
log-file-appender =
```

### `log-logger`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Logger definition JSON: `{"name", "level", "appender"}`.

```ini
# default
log-logger = {"name":"default","level":"info","appender":"stderr"} {"name":"p2p","level":"warn","appender":"p2p"}
```

### `backtrace`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Whether or not to print a backtrace on SIGSEGV (segmentation fault).

See: [#1542](https://github.com/steemit/steem/issues/1542)

```ini
# default
backtrace = yes
```

### `plugin`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Plugin(s) to enable, may be specified multiple times.

See: [Plugin & API List]({{ '/tutorials-recipes/plugin-and-api-list' | relative_url }})

```ini
# default
plugin = witness account_by_key account_by_key_api condenser_api
```

### `account-history-track-account-range`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Defines a range of accounts to track as a JSON pair `["from","to"]`.  Can be specified multiple times.

See: [`exchangequickstart.md`](https://github.com/steemit/steem/blob/970f599655465b65bbe939b78db348a21af982e0/doc/exchangequickstart.md#configuration-files-when-not-using-a-docker-image), [#862](https://github.com/steemit/steem/issues/862#issuecomment-285432626)

```ini
# examples
account-history-track-account-range = ["blocktrades", "blocktrades"]
account-history-track-account-range = ["c", "f"]
```

```ini
# default
account-history-track-account-range =
```

### `track-account-range`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Defines a range of accounts to track as a JSON pair `["from","to"]`.  Can be specified multiple times.

**Deprecated in favor of:** `account-history-track-account-range`

```ini
# default
track-account-range =
```

### `account-history-whitelist-ops`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Defines a list of operations which will be explicitly logged.

See: [#301](#https://github.com/steemit/steem/issues/301), [#521](https://github.com/steemit/steem/issues/521)

```ini
# default
account-history-whitelist-ops =
```

```ini
# example, defines a list of operations which will be explicitly logged.
account-history-whitelist-ops = transfer_operation transfer_to_vesting_operation withdraw_vesting_operation interest_operation transfer_to_savings_operation transfer_from_savings_operation cancel_transfer_from_savings_operation escrow_transfer_operation escrow_approve_operation escrow_dispute_operation escrow_release_operation fill_convert_request_operation fill_order_operation claim_reward_balance_operation author_reward_operation curation_reward_operation fill_vesting_withdraw_operation fill_transfer_from_savings_operation delegate_vesting_shares_operation return_vesting_delegation_operation comment_benefactor_reward_operation
```

### `history-whitelist-ops`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Defines a list of operations which will be explicitly logged.

**Deprecated in favor of:** `account-history-whitelist-ops`

```ini
# default
history-whitelist-ops =
```

### `account-history-blacklist-ops`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Defines a list of operations which will be explicitly ignored.

See: [#301](#https://github.com/steemit/steem/issues/301), [#521](https://github.com/steemit/steem/issues/521)

```ini
# default
account-history-blacklist-ops =
```

### `history-blacklist-ops`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Defines a list of operations which will be explicitly ignored.

**Deprecated in favor of:** `account-history-blacklist-ops`

```ini
# 
history-blacklist-ops =
```

### `history-disable-pruning`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Disables automatic account history trimming.

See: [#1671](https://github.com/steemit/steem/issues/1671)

```ini
# default
history-disable-pruning = 0
```

### `account-history-rocksdb-path`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

The location of the rocksdb database for account history.  By default it is `$DATA_DIR/blockchain/account-history-rocksdb-storage`.

See: [#2066](https://github.com/steemit/steem/issues/2066)

```ini
# default
account-history-rocksdb-path = "blockchain/account-history-rocksdb-storage"
```

### `account-history-rocksdb-track-account-range`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Defines a range of accounts to track as a JSON pair `["from","to"]`.  Can be specified multiple times.

See: [#2066](https://github.com/steemit/steem/issues/2066)

```ini
# default
account-history-rocksdb-track-account-range =
```

### `account-history-rocksdb-whitelist-ops`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Defines a list of operations which will be explicitly logged.

See: [#2066](https://github.com/steemit/steem/issues/2066)

```ini
# default
account-history-rocksdb-whitelist-ops =
```

### `account-history-rocksdb-blacklist-ops`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Defines a list of operations which will be explicitly ignored.

See: [#2066](https://github.com/steemit/steem/issues/2066)

```ini
# default
account-history-rocksdb-blacklist-ops =
```

### `block-data-export-file`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Where to export data (NONE to discard).

See: [#2244](https://github.com/steemit/steem/issues/2244), [#2326](https://github.com/steemit/steem/pull/2326)

Used by plugins: `block_data_export`, `stats_export`

```ini
# default
block-data-export-file = NONE
```

### `block-log-info-print-interval-seconds`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

How often to print out block_log_info (default 1 day).

Example output (if set to output every minute on a testnet):

```
block_num=2   size=143   hash=5a22d010d890d2463cd9c82417f8286cdbd1f9ed01c686aceb4d81da65787c7a
block_num=10   size=89593   hash=6009f4626ed5581851d0d2bca57e1eb92e77e68304f586253bb3cd44c0db0080
block_num=30   size=311238   hash=8379b697f4b6a7306d2313721107ac76997f159a74656cd88da97452c1a70f18
block_num=50   size=533390   hash=cee168b76a2a8c382377e644c263e7cce43014f10d68afabb9b57c7ee0345a20
block_num=70   size=851264   hash=f665b7067c836aeb9e8e8e746d2e5f03395e2662ded7aa5e12429161d92d70db
block_num=90   size=1192756   hash=64f992b4e3716ff444c4cb85a6b8f4b61f8c3902514723991271717fff5fad73
block_num=106   size=1383514   hash=7161fb618e7caf496a8869f1938f69c75f0247558bfc3623b53fd389751dc7db
block_num=119   size=1385342   hash=ca0853f8e9a6179402637efe3f27240ffda63c6a742c4dbe027517cc1276e04d
block_num=139   size=1387982   hash=466b42461d5d433f54053e61387dd0422c0461fb4bb5835b2cd751a476b8a59b
block_num=159   size=1390514   hash=1152740a6a5cd651d11219bbbdf9170f312a96652ed385346eb784c1c14dd8dc
block_num=179   size=1393044   hash=51e5bdd1e0b3f07b064c184dd0e0174f678910079e9fc1463d98977a2f73b191
block_num=199   size=1395575   hash=7a49e2d67522b5204574d33e4b4f479e7c23c5358d8567d87aaf727d819ecd05
```

Used by plugin: `block_log_info`

See: [#1893](https://github.com/steemit/steem/issues/1893)

```ini
# default
block-log-info-print-interval-seconds = 86400
```

### `block-log-info-print-irreversible`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Whether to defer printing out `block_log_info` until block is irreversible.

Used by plugin: `block_log_info`

See: [#1893](https://github.com/steemit/steem/issues/1893)

```ini
# default
block-log-info-print-irreversible = 1
```

### `block-log-info-print-file`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Where to print out `block_log_info` (filename or special sink `ILOG`, `STDOUT`, `STDERR`).

Used by plugin: `block_log_info`

See: [#1893](https://github.com/steemit/steem/issues/1893)

```ini
# default
block-log-info-print-file = ILOG
```

### `sps-remove-threshold`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Maximum numbers of proposals/votes which can be removed in the same cycle.

See: [blocktradesdevs#76](https://github.com/blocktradesdevs/steem/issues/76)

```ini
# default
sps-remove-threshold = 200
```

### `shared-file-dir`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

The location of the chain shared memory files (absolute path or relative to application data dir)

```ini
# default
shared-file-dir = "blockchain"
```

### `shared-file-size`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Size of the shared memory file.  Default: 54G.  If running a full node, increase this value to 200G or greater.  Always make sure that you have enough resources available.  Set it to at least 25% more than current size.

*Provided values are expected to grow significantly over time.*

* **Full Node** - Shared memory file for full node uses over 300GB
* **Exchange Node** - Shared memory file for exchange node users over 65GB (tracked history for single account)
* **Seed Node** - Shared memory file for seed node uses over 5.5GB
* **Other Use Cases** - Shared memory file size varies, depends on your specific configuration but it is expected to be somewhere between "seed node" and "full node" usage.

See: [#1891](https://github.com/steemit/steem/issues/1891), [#2478](https://github.com/steemit/steem/issues/2478)

```ini
# default
shared-file-size = 54G
```

### `shared-file-full-threshold`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

A 2 precision percentage (0-10000) that defines the threshold for when to autoscale the shared memory file.  Setting this to 0 disables autoscaling.  Recommended value for consensus node is 9500 (95%).  Full node is 9900 (99%)

See: [#1891](https://github.com/steemit/steem/issues/1891)

```ini
# default
shared-file-full-threshold = 0
```

### `shared-file-scale-rate`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

A 2 precision percentage (0-10000) that defines how quickly to scale the shared memory file.  When autoscaling occurs the file's size will be increased by this percent.  Setting this to 0 disables autoscaling.  Recommended value is between 1000-2000 (10-20%)

See: [#1891](https://github.com/steemit/steem/issues/1891)

```ini
# default
shared-file-scale-rate = 0
```

### `checkpoint`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Pairs of `[BLOCK_NUM,BLOCK_ID]` that should be enforced as checkpoints.  Multiple allowed.

```ini
# examples
checkpoint = [12439757, "00bdd0cd8b0009c9c6d1141e8c8d416e390d594f"]
checkpoint = [12439657, "00bdd0696ff40d273108bb2b3b7bb6b2dfdd896a"]
checkpoint = [12439557, "00bdd0054f59ca947f7b2951f62d69bc035571d4"]
checkpoint = [12439457, "00bdcfa1a54e14a143524d4b0607cbeae440dac8"]
checkpoint = [12439357, "00bdcf3d0aeffa03400ffe5ac8e27c856cedf1d2"]
checkpoint = [12439257, "00bdced9cefcd952b840ad3b3a79ae2a503c96e4"]
checkpoint = [12439157, "00bdce75995276b84fbcaa3a287dd3dbef7a2c25"]
checkpoint = [12439057, "00bdce1146bd85b5ec4c138bdffb69efb314d5e0"]
checkpoint = [12438957, "00bdcdade9993f796749e860f2c63c9b5e67a2a5"]
checkpoint = [12438857, "00bdcd49e0291cf3f68e8ee9a61cad5b69bf5313"]
checkpoint = [12438757, "00bdcce50f5c26c8b6e863aa13ce07db9e9c0300"]
checkpoint = [12438657, "00bdcc819a899a18c0b76e62ff3d107e306d4ae8"]
checkpoint = [12438557, "00bdcc1d5498ca51b2cdf4d588cfd664a2f8f2e9"]
checkpoint = [12438457, "00bdcbb9b92e87106b3eb4986ff4fe2186bd9f01"]
checkpoint = [12438357, "00bdcb550cf00311e5098800179b9bc885183b5f"]
checkpoint = [12438257, "00bdcaf1df703bae09f0929917d04b1e174d3979"]
checkpoint = [12438157, "00bdca8d98d1b9376212c8b01362468d6f6b3f22"]
checkpoint = [12438057, "00bdca29957ec15ac5a0dd0fcbd956d65dbda842"]
checkpoint = [12437957, "00bdc9c5c4309e5a6922eace238e84ff85439264"]
checkpoint = [12437857, "00bdc96100272690f75862fee1457653c4697ff0"]
checkpoint = [12437757, "00bdc8fd8e030c1f7f89633455ad36b52ff4fd01"]
checkpoint = [12437657, "00bdc8999eb864e9d324173cd000cba4a69f2aea"]
checkpoint = [12437557, "00bdc835304577900c29a66c777eab07b68f0be3"]
checkpoint = [12437457, "00bdc7d1ab93d17f248d2b58dade646d6f6dbd67"]
checkpoint = [12437357, "00bdc76dde43f8c8c239bd07ccac5b9606f959a0"]
checkpoint = [12437257, "00bdc7094ab0a86720ef7daaaf57b71d617f5f19"]
checkpoint = [12437157, "00bdc6a5cf4ec87a0d3b41e0593c6a62c28baa81"]
checkpoint = [12437057, "00bdc6416cf37d9d57f3ae753f00de1ddccc9144"]
checkpoint = [12436957, "00bdc5dd9805658513a02da5f8d17745398dbb6c"]
checkpoint = [12436857, "00bdc57979995a2d317d7fea63e734637f684dd7"]
checkpoint = [12436757, "00bdc515aa33e5d069afeb305d96a64144a1e208"]
checkpoint = [12436657, "00bdc4b1e935b9a20e7bdc9153c97872015c3a9a"]
checkpoint = [12436557, "00bdc44d0a4ad08b85a76b1ca18f9f272920abd2"]
checkpoint = [12436457, "00bdc3e929ebdd7f77ee6ad1147e24a064cd2ded"]
checkpoint = [12436357, "00bdc385f57a7caea58b3b2c2b60a6df59b3741f"]
checkpoint = [12436257, "00bdc321dab7a45cfd7fc01f50415b4fbd75e7e2"]
checkpoint = [12436157, "00bdc2bd3117958481ce6deff5c8e06e43685aae"]
checkpoint = [12436057, "00bdc25904da6f31102f70fbbd27bd1663ccac5b"]
checkpoint = [12435957, "00bdc1f5129bb9725634e6b25d4e3fa0a68d8369"]
checkpoint = [12435857, "00bdc1916c86cd1f490c72451101ab8515c56f6f"]
checkpoint = [12435757, "00bdc12dacf2f86cac1b09d123930a2ca36b75ce"]
checkpoint = [12435657, "00bdc0c97099678a6fb5f31fb2e23ef8d421ec94"]
checkpoint = [12435557, "00bdc065ef8bfe29cfb1709244d66b4508efbe0a"]
checkpoint = [12435457, "00bdc001891acee8628f18330e23c6277368e408"]
checkpoint = [12435357, "00bdbf9d56ead7639338ee2b1a78f1fa04bf1dde"]
checkpoint = [12435257, "00bdbf394a869f133e06cac8b63605fd6115ee30"]
checkpoint = [12435157, "00bdbed5e00a6bc245420895a2e3ed86786bf338"]
checkpoint = [12435057, "00bdbe71d759ca79870a7b069a15913da3fbe9ae"]
checkpoint = [12434957, "00bdbe0dd64ad3450fddcd3300d3412676053a6b"]
checkpoint = [12434857, "00bdbda93de3b7ea1748004f4ad2f5b667baef0b"]
checkpoint = [12434757, "00bdbd45290e2651201b69af95c254dd8c70edce"]
checkpoint = [12434657, "00bdbce15ff203f407c861023d806ca3e17aac02"]
checkpoint = [12434557, "00bdbc7dcdc716e9292f59fe8a4652219469b478"]
checkpoint = [12434457, "00bdbc1913cf29d76ffa5bedf279a52f62acf3e1"]
checkpoint = [12434357, "00bdbbb53880ee3275fd860aace205d1fa0367f1"]
checkpoint = [12434257, "00bdbb5165958fb8e2c6be56c2e92cbbdd52eb57"]
checkpoint = [12434157, "00bdbaed48d017f36690b0d4e80f8325ff66c9ad"]
checkpoint = [12434057, "00bdba89872a25ce767beb94ee211d1d34621282"]
checkpoint = [12433957, "00bdba254f3ce47ec619f026822787ea0c6f4dd7"]
checkpoint = [12433857, "00bdb9c1ff1be1682d34afe8db6a3d267f62a84d"]
checkpoint = [12433757, "00bdb95d19ab1e979ae172b1bbf83fa9db7b3cb9"]
checkpoint = [12433657, "00bdb8f9bf68973dde5b6c9a0a9ab3489a9c0464"]
checkpoint = [12433557, "00bdb895b842b18d8afe6fc00357f5bc3c51cda2"]
checkpoint = [12433457, "00bdb831a45551f6297ddf939a170c2d8091f13d"]
checkpoint = [12433357, "00bdb7cd710d8b4a59acbf6b50cd5d6b612cca49"]
checkpoint = [12433257, "00bdb76975ca115d67df7e06f51a034b2f2daad2"]
checkpoint = [12433157, "00bdb70539df1619d5fca9694d59f1a1071eccde"]
checkpoint = [12433057, "00bdb6a1a8148f64a319fc81470506ea10dd79f1"]
checkpoint = [12432957, "00bdb63d66db2284cb39de37314c7a8f6dbe715e"]
checkpoint = [12432857, "00bdb5d9bab4d8846c6d3dc278e90fc1ecd247eb"]
checkpoint = [12432757, "00bdb575fd832b4515fe53b00575c1aa9508f4d4"]
checkpoint = [12432657, "00bdb511545d76db85e1c82f80ce4d74d2a4dbab"]
checkpoint = [12432557, "00bdb4ad10fe0feef6c55d1a7001142535c2ea8d"]
checkpoint = [12432457, "00bdb449621cd686afea35e18d7fdef2310ea90b"]
checkpoint = [12432357, "00bdb3e592363774414322b5aa141b8f0f7ebfbf"]
checkpoint = [12432257, "00bdb3818e2c19f06d4ffd781d922b39a9519717"]
checkpoint = [12432157, "00bdb31dbde094951313d6a73089655b11561df3"]
checkpoint = [12432057, "00bdb2b94f71a3a08048cfe95b2f39950f77530e"]
checkpoint = [12431957, "00bdb255b31681189ad7749f0f35a25ee33143b0"]
checkpoint = [12431857, "00bdb1f17b41fefeaf7c4855a8064a54862981dd"]
checkpoint = [12431757, "00bdb18d9f66ec21ba074421bf97327890d428a1"]
checkpoint = [12431657, "00bdb12953b909cb6f448b1bbf84d81923b48a2f"]
checkpoint = [12431557, "00bdb0c561d35d3fd1a6d7a420151224dd3aff80"]
checkpoint = [12431457, "00bdb061d9f94e7f57750b7fa0870531a0f33ce6"]
checkpoint = [12431357, "00bdaffdd5252711a494b2bb03a59aa5ac723860"]
checkpoint = [12431257, "00bdaf994b1cd8ab92fea9262161226c6f3fddf3"]
checkpoint = [12431157, "00bdaf35718ee199a4c07c2553c11afcfbbeaa3c"]
checkpoint = [12431057, "00bdaed12ebbb375f8181d483535a8966251dd32"]
checkpoint = [12430957, "00bdae6d53fe8abb9a78d160a255c728e25e0ede"]
checkpoint = [12430857, "00bdae091399110a237fd04fd1d495a14828194c"]
checkpoint = [12430757, "00bdada51163cbad6c9599a6b95af2267750dfb7"]
checkpoint = [12430657, "00bdad41bb2205fa620434c4e7c8731c3dd6b976"]
checkpoint = [12430557, "00bdacdd9d9685650a2cf1607b77978c091f70df"]
checkpoint = [12430457, "00bdac795263ac1866f922ec63ffb81e3d4ea9b4"]
checkpoint = [12430357, "00bdac157f2d826461aaac195276217fc40cdad6"]
checkpoint = [12430257, "00bdabb17a43fc18f2c42c2800a99231b3e669fa"]
checkpoint = [12430157, "00bdab4d2b0baef1b25760c09a8261f93e2016b3"]
checkpoint = [12430057, "00bdaae9bee41d4133a37c137b4fabe1ee9c04f8"]
checkpoint = [12429957, "00bdaa85201d63ce8fe0ac5582e2bed1d2eb1dcf"]
checkpoint = [12429857, "00bdaa21f50e0b51906a8a844d5a54b4e187da4a"]
checkpoint = [12429757, "00bda9bd6da9751f41948e20011242e841372916"]
```

### `flush-state-interval`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Flush shared memory changes to disk every *n* blocks.

```ini
# default
flush-state-interval = 10000
```

```ini
# disabled
flush-state-interval =
```

### `debug-node-edit-script`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Database edits to apply on startup (may specify multiple times).

See: [`debug_node_plugin.md`](https://github.com/steemit/steem/blob/master/doc/devs/debug_node_plugin.md)

```ini
debug-node-edit-script =
```

### `edit-script`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Database edits to apply on startup (may specify multiple times).

**Deprecated in favor of:** `debug-node-edit-script`, see: [#1297](https://github.com/steemit/steem/issues/1297)

```ini
edit-script =
```

### `follow-max-feed-size`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Set the maximum size of cached feed for an account.

See: [Plugin & API List]({{ '/tutorials-recipes/plugin-and-api-list#follow_api' | relative_url }}), [#192](https://github.com/steemit/steem/issues/192)

```ini
# default
follow-max-feed-size = 500
```

### `follow-start-feeds`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Block time (in epoch seconds) when to start calculating feeds.

See: [Plugin & API List]({{ '/tutorials-recipes/plugin-and-api-list#follow_api' | relative_url }}), [#1162](https://github.com/steemit/steem/issues/1162)

```ini
# default
follow-start-feeds = 0
```

### `log-json-rpc`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

json-rpc log directory name.

Used by plugin: `jsonrpc`

See: [#1986](https://github.com/steemit/steem/issues/1986)

```ini
# default (no dump)
log-json-rpc =
```

### `market-history-bucket-size`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Track market history by grouping orders into buckets of equal size measured in seconds specified as a JSON array of numbers.

```ini
# default
market-history-bucket-size = [15,60,300,3600,86400]
```

### `market-history-buckets-per-size`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

How far back in time to track history for each bucket size, measured in the number of buckets.

```ini
# default
market-history-buckets-per-size = 5760
```

### `p2p-endpoint`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

The local IP address and port to listen for incoming connections.

```ini
# default
p2p-endpoint = 127.0.0.1:9876
```

```ini
# example, enable only local requests on port 2001
p2p-endpoint = 127.0.0.1:2001
```

```ini
# example, enable all requests from anyone on port 2001
p2p-endpoint = 0.0.0.0:2001
```

### `p2p-max-connections`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Maxmimum number of incoming connections on P2P endpoint.

```ini
p2p-max-connections =
```

### `seed-node`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

The IP address and port of a remote peer to sync with.

**Deprecated in favor of:** `p2p-seed-node`, see: [#1314](https://github.com/steemit/steem/issues/1314)

```ini
seed-node =
```

### `p2p-seed-node`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

The IP address and port of a remote peer to sync with.  Multiple allowed.

* If no seeds are specified, the compiled in seeds are used.
* If any other seeds are specified, only those seeds are used.
* If a blank seed is specified (i.e `p2p-seed-node = `) then no seeds are used.

See: [seednodes.txt](https://github.com/steemit/steem/blob/master/doc/seednodes.txt)

```ini
# example, override compiled seeds
p2p-seed-node = seed-east.steemit.com:2001 seed-central.steemit.com:2001 seed-west.steemit.com:2001 steem-seed1.abit-more.com:2001 52.74.152.79:2001 seed.steemd.com:34191 anyx.co:2001 seed.xeldal.com:12150 seed.steemnodes.com:2001 seed.liondani.com:2016 gtg.steem.house:2001 seed.jesta.us:2001 steemd.pharesim.me:2001 5.9.18.213:2001 lafonasteem.com:2001 seed.rossco99.com:2001 steem-seed.altcap.io:40696 seed.roelandp.nl:2001 steem.global:2001 seed.esteem.ws:2001 94.23.33.61:2001 104.199.118.92:2001 192.99.4.226:2001 seed.bhuz.info:2001 seed.steemviz.com:2001 steem-seed.lukestokes.info:2001 seed.blackrift.net:2001 seed.followbtcnews.com:2001 node.mahdiyari.info:2001 seed.jerrybanfield.com:2001 seed.windforce.farm:2001 seed.curiesteem.com:2001 seed.riversteem.com:2001 steem-seed.furion.me:2001 148.251.237.104:2001 seed1.blockbrothers.io:2001 
```

```ini
# example, multiple override compiled seeds
p2p-seed-node = 46.252.27.1:1337
p2p-seed-node = 52.62.24.225:2001
p2p-seed-node = 192.99.4.226:2001
p2p-seed-node = 45.55.217.111:2001
p2p-seed-node = 81.89.101.133:2001
p2p-seed-node = 52.4.250.181:39705
p2p-seed-node = 104.199.157.70:2001
p2p-seed-node = 104.236.82.250:2001
p2p-seed-node = 212.47.249.84:40696
p2p-seed-node = 162.213.199.171:34191
p2p-seed-node = steem.kushed.com:2001
p2p-seed-node = steemd.pharesim.me:2001
p2p-seed-node = seed.steemed.net:2001
p2p-seed-node = steem.clawmap.com:2001
p2p-seed-node = seed.steemnodes.com:2001
p2p-seed-node = seed.steemwitness.com:2001
p2p-seed-node = steem-seed1.abit-more.com:2001
```

```ini
# example, no seeds used
p2p-seed-node =
```

### `p2p-parameters`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

P2P network parameters.  Default:

```json
{
  "listen_endpoint": "0.0.0.0:0",
  "accept_incoming_connections": true,
  "wait_if_endpoint_is_busy": true,
  "private_key": "0000000000000000000000000000000000000000000000000000000000000000",
  "desired_number_of_connections": 20,
  "maximum_number_of_connections": 200,
  "peer_connection_retry_timeout": 30,
  "peer_inactivity_timeout": 5,
  "peer_advertising_disabled": false,
  "maximum_number_of_blocks_to_handle_at_one_time": 200,
  "maximum_number_of_sync_blocks_to_prefetch": 2000,
  "maximum_blocks_per_peer_during_syncing": 200,
  "active_ignored_request_timeout_microseconds": 6000000
}
```

See: [#1713](https://github.com/steemit/steem/issues/1713)

```ini
p2p-parameters =
```

### `p2p-user-agent`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

User agent to advertise to peers.

```ini
# example
p2p-user-agent = Graphene Reference Implementation
```

### `rc-skip-reject-not-enough-rc`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Skip rejecting transactions when account has insufficient RCs. This is not recommended.

See: [Plugin & API List]({{ '/tutorials-recipes/plugin-and-api-list#rc_api' | relative_url }}), [#3168](https://github.com/steemit/steem/issues/3168)

```ini
# default
rc-skip-reject-not-enough-rc = 0
```

### `rc-compute-historical-rc`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Generate historical resource credits.

See: [Plugin & API List]({{ '/tutorials-recipes/plugin-and-api-list#rc_api' | relative_url }}), [#3168](https://github.com/steemit/steem/issues/3168)

```ini
# default
rc-compute-historical-rc = 0
```

### `rc-start-at-block`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Start calculating RCs at a specific block.  **Testnet only.**

See: [Plugin & API List]({{ '/tutorials-recipes/plugin-and-api-list#rc_api' | relative_url }}), [#3168](https://github.com/steemit/steem/issues/3168)

```ini
# default
rc-start-at-block = 0
```

### `rc-account-whitelist`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Ignore RC calculations for the whitelist.  **Testnet only.**

See: [Plugin & API List]({{ '/tutorials-recipes/plugin-and-api-list#rc_api' | relative_url }}), [#3168](https://github.com/steemit/steem/issues/3168)

```ini
# default
rc-account-whitelist =
```

### `statsd-endpoint`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Endpoint to send statsd messages to when `statsd_plugin` is enabled.

Used by plugin: `statsd`

See: [#3168](https://github.com/steemit/steem/issues/3168)

```ini
# default
# statsd-endpoint =
```

### `statsd-batchsize`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Size to batch statsd messages when `statsd_plugin` is enabled.

Used by plugin: `statsd`

See: [#2276](https://github.com/steemit/steem/issues/2276)

```ini
# default
statsd-batchsize = 1
```

### `statsd-whitelist`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Whitelist of statistics to capture when `statsd_plugin` is enabled.

Used by plugin: `statsd`

See: [#2276](https://github.com/steemit/steem/issues/2276)

```ini
# default
statsd-whitelist =
```

### `statsd-blacklist`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Blacklist of statistics to capture when `statsd_plugin` is enabled.

Used by plugin: `statsd`

See: [#2276](https://github.com/steemit/steem/issues/2276)

```ini
# default
statsd-blacklist =
```

### `tags-start-promoted`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Block time (in epoch seconds) when to start calculating promoted content. Should be 1 week prior to current time.

See: [Plugin & API List]({{ '/tutorials-recipes/plugin-and-api-list#tags_api' | relative_url }}), See: [#1612](https://github.com/steemit/steem/issues/1612)

```ini
# default
tags-start-promoted = 0
```

### `tags-skip-startup-update`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Skip updating tags on startup. Can safely be skipped when starting a previously running node. Should not be skipped when reindexing.

See: [Plugin & API List]({{ '/tutorials-recipes/plugin-and-api-list#tags_api' | relative_url }}), See: [#1612](https://github.com/steemit/steem/issues/1612)

```ini
# default
tags-skip-startup-update = 0
```

### `transaction-status-block-depth`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Defines the number of blocks from the head block that transaction statuses will be tracked.

```cpp
/*
 *                             window of uncertainty              trackable
 *                          .-------------------------. .---------------------------.
 *                         |                           |                             |
 *   <- - - - - - - - - - [*] - - - - - - - - - - - - [*] - - - - - - - - - - - - - [*]
 *                        /                            |                              \
 *               actual block depth            nominal block depth                head block
 *
 * - Within the window of uncertainy, if the transaction is found we will return the status
 *      If the transaction is not found and an expiration is provided, we will return `too_old`
 *
 * - Within the trackable range, if the transaction is found we will return the status
 *      If the transaction is not found and an expiration is provided we will return the expiration status
 *
 * - Nominal values are values provided by the user
 *
 * - Actual values are calculated and used to determine when tracking needs to begin
 *      see `plugin_initialize`
 */
```

See: [Plugin & API List]({{ '/tutorials-recipes/plugin-and-api-list#transaction_status_api' | relative_url }}), [#2458](https://github.com/steemit/steem/issues/2458)
 
```ini
transaction-status-block-depth = 64000
```

### `transaction-status-track-after-block`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Defines the block number the transaction status plugin will begin tracking.

Used by plugin: `transaction_status`

See: [Plugin & API List]({{ '/tutorials-recipes/plugin-and-api-list#transaction_status_api' | relative_url }}), See: [#2458](https://github.com/steemit/steem/issues/2458)
 
```ini
transaction-status-track-after-block = 0
```

### `webserver-http-endpoint`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Local http endpoint for webserver requests.

See: [#1347](https://github.com/steemit/steem/issues/1347)

```ini
# example, enable only local requests on port 8751
webserver-http-endpoint = 127.0.0.1:8751
```

```ini
# example, enable all requests from anyone on port 8751
webserver-http-endpoint = 0.0.0.0:8751
```

### `webserver-ws-endpoint`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Local websocket endpoint for webserver requests.

See: [#1347](https://github.com/steemit/steem/issues/1347)

```ini
# example, enable only local requests on port 8752
webserver-ws-endpoint = 127.0.0.1:8752
```

```ini
# example, enable all requests from anyone on port 8752
webserver-ws-endpoint = 0.0.0.0:8752
```

### `webserver-unix-endpoint`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Unix http endpoint for webserver requests (in addition to http and ws).

Intended for node operators who use nginx or jussi on their front ends and `steemd` running on the same box.  Since TCP over localhost is inefficient, the ability to use unix-sockets was added.

Example usage (assuming option set to `/tmp/steemd.sock`):

```bash
curl -s --data '{
  "jsonrpc": "2.0",
  "method": "condenser_api.get_account_count",
  "params": [],
  "id": 1
}' --unix-socket /tmp/steemd.sock http:
```

See: [#3205](https://github.com/steemit/steem/pull/3205)

```ini
# example
webserver-unix-endpoint = /tmp/steemd.sock
```

### `rpc-endpoint`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Local http and websocket endpoint for webserver requests.

**Deprecated in favor of:** `webserver-http-endpoint` and `webserver-ws-endpoint`, see: [#1297](https://github.com/steemit/steem/issues/1297)

```ini
rpc-endpoint =
```

### `webserver-thread-pool-size`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Number of threads used to handle queries.  Default: 32.

* must be greater than 0

See: [#1347](https://github.com/steemit/steem/issues/1347)

```ini
# default
webserver-thread-pool-size = 32
```

### `enable-stale-production`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Enable block production, even if the chain is stale.  Leaving this `false` will keep `steemd` from producing blocks until we receive a recent block.

```ini
# default
enable-stale-production = 0
```

### `required-participation`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Percent of witnesses (0-99) that must be participating in order to produce blocks.

```ini
# default
required-participation = 33
```

Often, when starting a custom testnet that has a single block signer, it is acceptable to set `required-participation` to zero.

```ini
# initial custom testnet with low witness count
required-participation = 0
```

### `witness`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Name of witness controlled by this node (e.g. `initwitness`).

```ini
witness =
```

### `private-key`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

WIF PRIVATE KEY to be used by one or more witnesses or miners.

```ini
private-key = 
```

### `witness-skip-enforce-bandwidth`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Skip enforcing bandwidth restrictions. Default is `true` in favor of `rc_plugin`.

See: [#2648](https://github.com/steemit/steem/issues/2648), [#2703](https://github.com/steemit/steem/issues/2703)

```ini
witness-skip-enforce-bandwidth = 1
```

### `account-stats-bucket-size`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Track account statistics by grouping orders into buckets of equal size measured in seconds specified as a JSON array of numbers.

Used by plugin: `account_statistics`

See: [#79](https://github.com/steemit/steem/issues/79)

```ini
# default
account-stats-bucket-size = [60,3600,21600,86400,604800,2592000]
```

### `account-stats-history-per-bucket`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

How far back in time to track history for each bucker size, measured in the number of buckets.

Used by plugin: `account_statistics`

See: [#79](https://github.com/steemit/steem/issues/79)

```ini
# default
account-stats-history-per-bucket = 100
```

### `account-stats-tracked-accounts`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Which accounts to track the statistics of.  Empty list tracks all accounts.

Used by plugin: `account_statistics`

See: [#79](https://github.com/steemit/steem/issues/79)

```ini
# default
account-stats-tracked-accounts = []
```

### `trusted-node`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

RPC endpoint of a trusted validating node (required if `delayed_node` plugin enabled).

Used by plugin: `delayed_node`

```ini
# default
trusted-node =
```

### `pm-account-range`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Defines a range of accounts to private messages to/from as a JSON pair `["from","to"]`.

Used by plugin: `private_message`

```ini
# default
pm-account-range =
```

### `chain-stats-bucket-size`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Track blockchain statistics by grouping orders into buckets of equal size measured in seconds specified as a JSON array of numbers.

Used by plugin: `blockchain_statistics`

See: [#79](https://github.com/steemit/steem/issues/79)

```ini
# default
chain-stats-bucket-size = [60,3600,21600,86400,604800,2592000]
```

### `chain-stats-history-per-bucket`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

How far back in time to track history for each bucket size, measured in the number of buckets.

Used by plugin: `blockchain_statistics`

See: [#79](https://github.com/steemit/steem/issues/79)

```ini
# default
chain-stats-history-per-bucket = 100
```
